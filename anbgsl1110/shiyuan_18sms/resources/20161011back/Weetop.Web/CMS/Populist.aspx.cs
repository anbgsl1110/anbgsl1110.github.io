using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;
using Wuqi.Webdiyer;
using OfficeOpenXml;
using System.IO;

namespace Weetop.Web.CMS
{
    public partial class Populist : CmsBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("HDTG"))
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
                string ac = Request["ac"];
                switch (ac)
                {
                    case "1"://add
                        //Add();
                        break;
                    case "2"://edit
                        Update();
                        break;
                    case "3"://del
                        //Delete();
                        break;
                    default:
                        //BindData();//有UpdatePanel的OnLoad方法时不需要这个，会重复执行
                        break;
                }
            }
        }

        private void Update()
        {
            Response.ContentType = "application/json";

            var entity = SitePopularize.GetOne(Common.ToLong(Request["hidRoleId"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            entity.Remark = Request["remark"];
            SitePopularize.UpdateEntity(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }


        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            List<Popularize> list = SitePopularize.GetList(ref pp, txtSearch.Value.Trim(), txtDateRange.Value.Trim());

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

        protected void ExportFile_Click(object sender, EventArgs e)
        {
            //指定Templete文档Text.xlsx
            FileInfo newFile = new FileInfo("C:" + @"\test-site\CMS\upload\hdtg.xlsx");

            //开启
            using (ExcelPackage pck = new ExcelPackage(newFile))
            {
                try
                {
                    //设定ExcelWorkBook
                    ExcelWorkbook workBook = pck.Workbook;
                    if (workBook != null)
                    {
                        if (workBook.Worksheets.Count > 0)
                        {
                            //复制Temp这个Sheet同时命名为xxx
                            ExcelWorksheet currentWorksheet = workBook.Worksheets.Copy("Temp", "活动推广信息");
                            //可以设定保护Sheet的密码
                            //currentWorksheet.Protection.SetPassword("1234");
                            int StartRow = 4;
                            var list4 = SitePopularize.GetListALL();
                            int i = 0;
                            foreach (var info in list4)
                            {
                                currentWorksheet.Cells[StartRow + i, 1].Value = Convert.ToString(info.Id);
                                currentWorksheet.Cells[StartRow + i, 2].Value = Convert.ToString(info.Mobile);
                                currentWorksheet.Cells[StartRow + i, 3].Value = Convert.ToString(Common.ToBool(info.Valid)? info.SrcPath:"未知");
                                currentWorksheet.Cells[StartRow + i, 4].Value = Convert.ToString(info.PostDate);
                                currentWorksheet.Cells[StartRow + i, 5].Value = Convert.ToString(info.Remark);
                                i++;
                            }
                            //将Temp 这个Sheet删除
                            workBook.Worksheets.Delete("Temp");
                        }
                    }
                    //存至hdtg-xz.xlsx
                    pck.SaveAs(new FileInfo("C:" + @"\test-site\CMS\upload\hdtg-xz.xlsx"));


                    string fileName = "活动推广信息.xlsx";//客户端保存的文件名 
                    string filePath = Server.MapPath("~/cms/upload/hdtg-xz.xlsx");//路径

                    //以字符流的形式下载文件 
                    FileStream fs = new FileStream(filePath, FileMode.Open);
                    byte[] bytes = new byte[(int)fs.Length];
                    fs.Read(bytes, 0, bytes.Length);
                    fs.Close();
                    Response.ContentType = "application/octet-stream";
                    //通知浏览器下载文件而不是打开
                    if (Request.UserAgent.ToLower().IndexOf("firefox") > -1)
                    {
                        Response.AddHeader("Content-Disposition", "attachment; filename=\"" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8) + "\"");
                    }
                    else
                    {
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
                    }
                    Response.BinaryWrite(bytes);
                    Response.Flush();
                    Response.End();

                }
                catch
                {
                    Response.Write("<script>alert('系统错误，请联系管理员！')</script>");
                    return;
                }
            }
        }
    }
}