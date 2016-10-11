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
    public partial class InvoiceList : CmsBase
    {
        public List<ModulePrivilege> list = new List<ModulePrivilege>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("CWGL"))
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
                        //Add();
                        break;
                    case "2":
                        Update();
                        break;
                    case "3"://del
                        //Delete();
                        break;
                    case "4":
                        Toggle();
                        break;
                    default:
                        GetModulePrivilegeByRoleId();
                        Dictionary<int, string> dic2 = new Dictionary<int, string>();
                        dic2.Add(-1, "");//chosen 留空
                        dic2.Add((int)InvoStatus.待开发票, InvoStatus.待开发票.ToString());
                        dic2.Add((int)InvoStatus.已开发票, InvoStatus.已开发票.ToString());
                        dic2.Add((int)InvoStatus.已寄出, InvoStatus.已寄出.ToString());
                        dic2.Add((int)InvoStatus.已收到, InvoStatus.已收到.ToString());
                        dic2.Add((int)InvoStatus.已驳回, InvoStatus.已驳回.ToString());
                        dic2.Add((int)InvoStatus.已作废, InvoStatus.已作废.ToString());

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
                List<ModulePrivilege> list2 = SiteModulePrivilege.GetListModulePrivilege("HYGL");
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

        ///// <summary>
        ///// 用在Repeater模板中生成链接，可以使用 Eval() 方法
        ///// </summary>
        ///// <param name="oid"></param>
        ///// <param name="did"></param>
        ///// <param name="page"></param>
        ///// <returns></returns>
        //protected string GetLink(long oid, long did, int page)
        //{
        //    var entity = SiteInvoice.GetOne(did);
        //    //"<a title='{标注：" + entity.ValidMsg + "}' href=AuthDetail.aspx?uid=" + uid + "&page=" + page + ">" + ValidState + "</a>";

        //    //return "<a href='InvoiceDetail.aspx?oid={oid}&did={did}&page={page}'>{Eval('FTitle')}</a>";
        //    return "<a href=InvoiceDetail.aspx?oid=" + oid + "&did=" + did + "&page=" + page + ">" + FTitle + "</a>";
        //}



        private void Toggle()
        {
            Response.ContentType = "application/json";

            var id = Request["id"];
            if (string.IsNullOrEmpty(id))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            var entity = SiteApply4Invo.GetOne(Common.ToLong(id));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            entity.FStatus = Common.ToInt(Request["rolecode"]);
            SiteApply4Invo.UpdateEntity(entity);
            Response.Write(Common.Json("OK", "状态更改成功"));

            Response.End();
        }

        //编辑快递单号
        private void Update()
        {
            Response.ContentType = "application/json";

            var entity = SiteApply4Invo.GetOne(Common.ToLong(Request["id"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var acc = Request["acc"].Trim();


            if (string.IsNullOrEmpty(acc))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            entity.CourierNumber = acc;
            SiteApply4Invo.UpdateEntity(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }


        private void BindData()
        {
            GetModulePrivilegeByRoleId();
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            int oType = Common.ToInt(ddlOrderStatus.SelectedValue);
            string searchText = txtSearch.Value.Trim();
            string timeRange = txtDateRange.Value.Trim();

            var list = SiteApply4Invo.GetList(ref pp, oType, searchText, timeRange);

            
            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;

            Repeater1.DataSource = list;
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
            var entity = e.Item.DataItem as Apply4Invoice;
            if (entity != null)
            {
                var usr = SiteUser.GetUserInfo(entity.UserId.Value);

                var lit1 = e.Item.FindControl("Literal1") as Literal;
                var lit2 = e.Item.FindControl("Literal2") as Literal;

                lit1.Text = usr.CompanyName;
                lit2.Text = usr.Phone;

                Repeater rep = e.Item.FindControl("Repeater2") as Repeater;
                if (rep != null)
                {
                    var dic2 = new Dictionary<int, string>();
                    dic2.Add((int)InvoStatus.待开发票, InvoStatus.待开发票.ToString());
                    dic2.Add((int)InvoStatus.已开发票, InvoStatus.已开发票.ToString());
                    dic2.Add((int)InvoStatus.已寄出, InvoStatus.已寄出.ToString());
                    dic2.Add((int)InvoStatus.已收到, InvoStatus.已收到.ToString());
                    dic2.Add((int)InvoStatus.已驳回, InvoStatus.已驳回.ToString());//后台取消
                    dic2.Add((int)InvoStatus.已作废, InvoStatus.已作废.ToString());//用户取消

                    rep.DataSource = dic2;
                    rep.DataBind();
                }

            }
        }

        protected void ExportFile_Click(object sender, EventArgs e)
        {
            //指定Templete文档Text.xlsx
            FileInfo newFile = new FileInfo("C:" + @"\test-site\CMS\upload\fpgl.xlsx");
            
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
                            ExcelWorksheet currentWorksheet = workBook.Worksheets.Copy("Temp", "充值清单");
                            //可以设定保护Sheet的密码
                            //currentWorksheet.Protection.SetPassword("1234");
                            int StartRow = 4;
                            var list4 = SiteApply4Invo.GetListALL();
                            int i = 0;
                            foreach (var info in list4)
                            {
                                currentWorksheet.Cells[StartRow + i, 1].Value = Convert.ToString(info.Id);
                                currentWorksheet.Cells[StartRow + i, 2].Value = Convert.ToString(GetCompanyName(Guid.Parse(info.UserId.ToString())));
                                currentWorksheet.Cells[StartRow + i, 3].Value = Convert.ToString(GetPhone(Guid.Parse(info.UserId.ToString())));
                                currentWorksheet.Cells[StartRow + i, 4].Value = Convert.ToString(info.CreateDate);
                                currentWorksheet.Cells[StartRow + i, 5].Value = Convert.ToString(string.Format("{0:C0}", info.FMoney));
                                currentWorksheet.Cells[StartRow + i, 6].Value = Convert.ToString(info.FTitle);
                                currentWorksheet.Cells[StartRow + i, 7].Value = Convert.ToString((InvoType)SiteInvoice.GetOne(Common.ToLong(info.InvoInfoId)).InvoType);
                                currentWorksheet.Cells[StartRow + i, 8].Value = Convert.ToString((ReceiveWay)Common.ToInt(info.ReceiveWay));
                                currentWorksheet.Cells[StartRow + i, 9].Value = Convert.ToString(info.CourierNumber);
                                currentWorksheet.Cells[StartRow + i, 10].Value = Convert.ToString(info.Feedback);
                                currentWorksheet.Cells[StartRow + i, 11].Value = Convert.ToString((InvoStatus)Common.ToInt(info.FStatus));
                                i++;
                            }
                            //将Temp 这个Sheet删除
                            workBook.Worksheets.Delete("Temp");
                        }
                    }
                    //存至czgl-xz.xlsx
                    pck.SaveAs(new FileInfo("C:" + @"\test-site\CMS\upload\fpgl-xz.xlsx"));

                    string fileName = "发票信息.xlsx";//客户端保存的文件名 
                    string filePath = Server.MapPath("~/cms/upload/fpgl-xz.xlsx");//路径


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

        protected string GetCompanyName(Guid id)
        {
            var user = SiteUser.GetUserInfo(id);
            return user.CompanyName;
        }
        protected string GetPhone(Guid id)
        {
            var user = SiteUser.GetUserInfo(id);
            return user.Phone;
        }
    }
}