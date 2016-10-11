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
    public partial class AwardList : CmsBase
    {
        public List<ModulePrivilege> list = new List<ModulePrivilege>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("ZJXXGL"))
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
                       
                        break;
                    case "2"://edit
                        Update();
                        break;
                    case "3"://del
                        Delete();
                        break;
                    case "4"://toggle
                        Toggle();
                        break;
                    default:
                         GetModulePrivilegeByRoleId();
                        Dictionary<int, string> dic2 = new Dictionary<int, string>();
                        dic2.Add(-1, "");//chosen 留空
                        dic2.Add(0, "未发货");
                        dic2.Add(1, "待发货");
                        dic2.Add(2,"已发货");


                        ddlOrderStatus.DataSource = dic2;
                        ddlOrderStatus.DataTextField = "Value";
                        ddlOrderStatus.DataValueField = "Key";
                        ddlOrderStatus.DataBind();
                        break;
                }
            }
        }
        private void GetModulePrivilegeByRoleId()
        {
            if (Admin != null)
            {
                Role rInfo = SiteRole.GetRoleByAccountCode(Admin.AccountCode);
                List<ModulePrivilege> list2 = SiteModulePrivilege.GetListModulePrivilege("ZJXXGL");
                list.Clear();
                foreach (var item in list2)
                {
                    if (SiteRole.CheckRolePriv(rInfo.RoleId, item.ModPrivId))
                    {
                        list.Add(item);
                    }
                }
            }
        }

        private void Toggle()
        {
            Response.ContentType = "application/json";

            var id = Request["id"];
            if (string.IsNullOrEmpty(id))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            var entity = SiteUserWinningInfo.GetOne(int.Parse(id));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            entity.Status = Common.ToInt(Request["rolecode"]);
            SiteUserWinningInfo.Update(entity,Guid.Parse(entity.OnlyLable.ToString()));
            GetModulePrivilegeByRoleId();
            Response.Write(Common.Json("OK", "状态更改成功"));

            Response.End();
        }
        public void Delete()
        {
            Response.ContentType = "application/json";
            var id = Request["id"];
            if (string.IsNullOrEmpty(id))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            SiteUserWinningInfo.Delete(int.Parse(id));
            Response.Write(Common.Json("OK", "删除成功"));
            Response.End();
        }
        private void Update() 
        {

            Response.ContentType = "application/json";
            UserWinningInfo entity = new UserWinningInfo();
            var name = Request["name"].ToString();
            var ph= Request["ph"].ToString();
            var add=Request["add"].ToString();
            var com=Request["com"].ToString();
            var pos=Request["pos"].ToString();
            int id = int.Parse(Request["id"].ToString());
            UserWinningInfo ui = SiteUserWinningInfo.GetOne(id);
            ui.ConsigneePhone = ph;
            ui.ConsigneeName = name;
            ui.ConsigneeAddr = add;
            ui.ConsigneeCompany = com;
            ui.ConsigneePosition = pos;
            Guid gid = Guid.Parse(ui.OnlyLable.ToString());
            SiteUserWinningInfo.Update(ui, gid);
            Response.Write(Common.Json("OK", "修改成功"));
            Response.End();
        }



        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            int oType = Common.ToInt(ddlOrderStatus.SelectedValue);
            string searchText = txtSearch.Value.Trim();
            string timeRange = txtDateRange.Value.Trim();

            var list3 = SiteUserWinningInfo.GetList(ref pp, oType, searchText, timeRange);


            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;

            Repeater1.DataSource = list3;
            GetModulePrivilegeByRoleId();
            Repeater1.DataBind();
        }

        protected void AspNetPager1_PageChanging(object src, PageChangingEventArgs e)
        {
            //第三执行
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            BindData();
        }

        //可用于前端JS调用PostBack时执行
        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            //不管是不是PostBack都会执行，第二执行
            BindData();
        }

        protected void Repeater1_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            var entity = e.Item.DataItem as UserWinningInfo;
            if (entity != null)
            {
                Repeater rep = e.Item.FindControl("Repeater2") as Repeater;
                if (rep != null)
                {
                    var dic2 = new Dictionary<int, string>();
                    dic2.Add(0, "未发货");
                    dic2.Add(1, "待发货");
                    dic2.Add(2, "已发货");

                    rep.DataSource = dic2;
                    rep.DataBind();
                }

            }
        }

        public static string GetColor(string name)
        {
            string color = name.Substring(1, 1);
            if (color != "色")
            {
                return "";
            }
            else
            {
                return name;
            }
        }

        public static string GetStatus(int num)
        {
            switch (num)
            { 
                case 0:
                    return "未发货";
                case 1:
                    return "待发货";
                case 2:
                    return "已发货";
                default:
                    return "已发货";
            }
        }

        protected void ExportFile_Click(object sender, EventArgs e)
        {
            //指定Templete文档Text.xlsx
            FileInfo newFile = new FileInfo("C:" + @"\test-site\CMS\upload\zjxx.xlsx");
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
                            //复制Temp这个Sheet同时命名为《清单》
                            ExcelWorksheet currentWorksheet = workBook.Worksheets.Copy("Temp", "中奖信息");
                            //可以设定保护Sheet的密码
                            //currentWorksheet.Protection.SetPassword("1234");
                            int StartRow = 4;
                            var list4 = SiteUserWinningInfo.GetList();
                            int i = 0;
                            foreach (var info in list4)
                            {
                                currentWorksheet.Cells[StartRow + i, 1].Value = Convert.ToString(info.Id);
                                currentWorksheet.Cells[StartRow + i, 2].Value = Convert.ToString(info.WinningPrizeName).Substring(0,info.WinningPrizeName.Length-2);
                                currentWorksheet.Cells[StartRow + i, 3].Value = Convert.ToString(info.ConsigneeName);
                                currentWorksheet.Cells[StartRow + i, 4].Value = Convert.ToString(info.ConsigneePhone);
                                currentWorksheet.Cells[StartRow + i, 5].Value = Convert.ToString(info.ConsigneeCompany);
                                currentWorksheet.Cells[StartRow + i, 6].Value = Convert.ToString(info.ConsigneePosition);
                                currentWorksheet.Cells[StartRow + i, 7].Value = Convert.ToString(info.ConsigneeAddr);
                                if (info.WinningPrizeName.ToString().Substring(info.WinningPrizeName.Length - 1, 1) == "色")
                                {
                                    currentWorksheet.Cells[StartRow + i, 8].Value = Convert.ToString(info.WinningPrizeName.ToString().Substring(info.WinningPrizeName.Length - 2, 2));
                                }
                                currentWorksheet.Cells[StartRow + i, 9].Value = Convert.ToString(info.WinningDate);
                                currentWorksheet.Cells[StartRow + i, 10].Value = Convert.ToString(GetStatus((int)info.Status));
                                i++;
                            }
                            //将Temp 这个Sheet删除
                            workBook.Worksheets.Delete("Temp");
                        }
                    }
                    //存至Text4.xlsx
                    pck.SaveAs(new FileInfo("C:" + @"\test-site\CMS\upload\zjxx-xz.xlsx"));


                    string fileName = "中奖信息.xlsx";//客户端保存的文件名 
                    string filePath = Server.MapPath("~/cms/upload/zjxx-xz.xlsx");//路径

                    //以字符流的形式下载文件 
                    FileStream fs = new FileStream(filePath, FileMode.Open);
                    byte[] bytes = new byte[(int)fs.Length];
                    fs.Read(bytes, 0, bytes.Length);
                    fs.Close();
                    Response.ContentType = "application/octet-stream";
                    //通知浏览器下载文件而不是打开 
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
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