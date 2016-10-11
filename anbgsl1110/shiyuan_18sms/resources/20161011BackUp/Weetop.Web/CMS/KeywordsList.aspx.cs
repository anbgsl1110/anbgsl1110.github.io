using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;
using Wuqi.Webdiyer;

namespace Weetop.Web.CMS
{
    public partial class KeywordsList : CmsBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("MGCGL"))
            {
                //直接使用IIS自定义错误捕捉
                Response.StatusCode = (int)HttpStatusCode.Forbidden;
                //强制输出自定义消息
                //Response.TrySkipIisCustomErrors = true;
                //Response.Write(Common.SmartMsg("您没有访问权限"));
                Response.End();
            }

            if (!IsPostBack)
            {
                string ac = Request["action"];
                switch (ac)
                {
                    case "1"://add
                        Add();
                        break;
                    case "2"://edit
                        Update();
                        break;
                    case "3"://del
                        Delete();
                        break;
                    case "4":
                        Upload();
                        break;
                    default:
                        //BindData();//有UpdatePanel的OnLoad方法时不需要这个，会重复执行
                        break;
                }
            }
        }
        /// <summary>
        /// Excel数据导入Datable
        /// </summary>
        /// <param name="fileUrl"></param>
        /// <param name="table"></param>
        /// <returns></returns>
        public System.Data.DataTable GetExcelDatatable(string fileUrl, string table)
        {
            //office2007之前 仅支持.xls
            //const string cmdText = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties='Excel 8.0;IMEX=1';";
            //支持.xls和.xlsx，即包括office2010等版本的   HDR=Yes代表第一行是标题，不是数据；
            const string cmdText = "Provider=Microsoft.Ace.OleDb.12.0;Data Source={0};Extended Properties='Excel 12.0; HDR=Yes; IMEX=1'";

            System.Data.DataTable dt = null;
            //建立连接
            OleDbConnection conn = new OleDbConnection(string.Format(cmdText, fileUrl));
            try
            {
                //打开连接
                if (conn.State == ConnectionState.Broken || conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                System.Data.DataTable schemaTable = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                //获取Excel的第一个Sheet名称
                string sheetName = schemaTable.Rows[0]["TABLE_NAME"].ToString().Trim();

                //查询sheet中的数据
                string strSql = "select * from [" + sheetName + "]";
                OleDbDataAdapter da = new OleDbDataAdapter(strSql, conn);
                DataSet ds = new DataSet();
                da.Fill(ds, table);
                dt = ds.Tables[0];
                return dt;
            }
            catch (Exception exc)
            {
                throw exc;
            }
            finally
            {
                conn.Close();
                conn.Dispose();
            }

        }

        private void DeleteDirectory(string dir)
        {
            if (Directory.GetDirectories(dir).Length == 0 && Directory.GetFiles(dir).Length == 0)
            {
                Directory.Delete(dir);//删除文件夹，若不删除文件夹则不需要 Directory.Delete(dir)
                return;
            }
            foreach (string var in Directory.GetDirectories(dir))
            {
                DeleteDirectory(var);
            }
            foreach (string var in Directory.GetFiles(dir))
            {
                File.Delete(var);
            }
            Directory.Delete(dir);//删除文件夹，若不删除文件夹则不需要 Directory.Delete(dir)
        }

        private void Upload()
        {
            HttpPostedFile file1 = Request.Files["fileToUpload"];
            if (file1 == null || file1.ContentLength <= 0 || string.IsNullOrEmpty(file1.FileName))
            {
                Response.Write(Common.Json("Err", "文件为空"));
                Response.End();
            }
            string fileSuffix = Path.GetExtension(file1.FileName); //文件后缀名 .txt
            if (fileSuffix == ".txt")
            {
                InsertByTxt(file1);
            }
            else if (fileSuffix == ".xls")
            {
                InsertByExcel(file1, fileSuffix);
            }
            else
            {
                Response.Write(Common.Json("Err", "格式错误!"));
            }
        }

        private void InsertByTxt(HttpPostedFile file1)
        {
            Stream stream = file1.InputStream;
            StreamReader reader = new StreamReader(stream, Encoding.GetEncoding("GB2312"));
            List<string> txtDate = new List<string>();
            while (!reader.EndOfStream)
            {
                txtDate.Add(reader.ReadLine());
            }
            reader.Close();

            if (txtDate.Count > 0)
            {
                Keywords entity;
                foreach (var item in txtDate)
                {
                    if (item != "" && item != null)
                    {
                        entity = new Keywords();
                        if (item.Contains(','))
                        {
                            entity.Sort = Convert.ToInt32(item.Split(',')[1]);
                            entity.KeyName = item.Split(',')[0].ToString();
                            SiteKeywords.Add(entity);
                        }
                        else
                        {
                            entity.Sort = 0;
                            entity.KeyName = item.ToString();
                            SiteKeywords.Add(entity);
                        }

                    }
                }
                Response.Write(Common.Json("OK", "添加成功"));
            }
            else
            {
                Response.Write(Common.Json("Err", "请在txt中添加数据"));
            }
        }
        private void InsertByExcel(HttpPostedFile file1, string fileSuffix)
        {
            var newFileName1 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(1000, 2998).ToString() + fileSuffix;
            string dirPath = DateTime.Now.ToString("yyyyMM");
            string path = HttpContext.Current.Server.MapPath("~/" + basePath + dirPath);
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            file1.SaveAs(path + "/" + newFileName1);
            DataTable dt = GetExcelDatatable(path + "/" + newFileName1, "testTable");
            Keywords entity;
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row[0] != DBNull.Value && row[1] != DBNull.Value)
                    {
                        string ASpace = "", BSpace = "";
                        if ((ASpace = row[0].ToString().Replace(" ", "")) != "" && (BSpace = row[1].ToString().Replace(" ", "")) != "")
                        {
                            entity = new Keywords();
                            entity.Sort = Convert.ToInt32(row[1]);
                            entity.KeyName = row[0].ToString();
                            SiteKeywords.Add(entity);
                        }
                        else if ((ASpace = row[0].ToString().Replace(" ", "")) != "" && (BSpace = row[1].ToString().Replace(" ", "")) == "")
                        {
                            entity = new Keywords();
                            entity.Sort = 0;
                            entity.KeyName = row[0].ToString();
                            SiteKeywords.Add(entity);
                        }
                    }
                }
                DeleteDirectory(path);
                Response.Write(Common.Json("OK", "添加成功"));
            }
            else
            {
                Response.Write(Common.Json("Err", "请在Excel中添加数据"));
            }
        }
        private void Add()
        {
            Response.ContentType = "application/json";
            if (string.IsNullOrWhiteSpace(Request["value"]))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            Keywords entity = new Keywords();
            entity.Sort = Common.ToInt(Request["sort"]);
            entity.KeyName = Request["value"];
            SiteKeywords.Add(entity);
            Response.Write(Common.Json("OK", "添加成功"));
            Response.End();
        }


        private void Update()
        {
            Response.ContentType = "application/json";

            var entity = SiteKeywords.GetOne(Common.ToLong(Request["id"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            entity.KeyName = Request["name"];
            entity.Sort = Common.ToInt(Request["sort"]);
            SiteKeywords.Update(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }


        private void Delete()
        {
            Response.ContentType = "application/json";

            SiteKeywords.Delete(Common.ToInt(Request["id"]));

            Response.Write(Common.Json("OK", "删除成功"));
            Response.End();
        }


        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex,30);

            List<Keywords> list = SiteKeywords.GetList(ref pp, txtSearch.Value.Trim());

            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;

            Repeater1.DataSource = list;
            Repeater1.DataBind();
        }


        protected void AspNetPager1_PageChanging(object src, PageChangingEventArgs e)
        {
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            BindData();
        }


        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            BindData();
        }
    }
}