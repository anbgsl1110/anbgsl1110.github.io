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
    public partial class RechargeList : CmsBase
    {
       
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

            SiteFundsHistory.UpdateOrderStatus();//更新订单状态

            if (!IsPostBack)
            {
                string ac = Request["action"];
                switch (ac)
                {
                    case "1"://add
                        //Add();
                        break;
                    case "2":
                        //Update();
                        break;
                    case "3"://del
                        //Delete();
                        break;
                    default:
                        Dictionary<int, string> dic = new Dictionary<int, string>();
                        dic.Add(-1, "");//chosen 留空
                        dic.Add((int)ProductType.短信验证码, ProductType.短信验证码.ToString());
                        dic.Add((int)ProductType.会员营销短信, ProductType.会员营销短信.ToString());
                        dic.Add((int)ProductType.国际短信验证码, ProductType.国际短信验证码.ToString());
                        dic.Add((int)ProductType.语音验证码, ProductType.语音验证码.ToString());
                        dic.Add((int)ProductType.手机流量推广, ProductType.手机流量推广.ToString());

                        ddlCheckStatus.DataSource = dic;
                        ddlCheckStatus.DataTextField = "Value";
                        ddlCheckStatus.DataValueField = "Key";
                        ddlCheckStatus.DataBind();


                        Dictionary<int, string> dic2 = new Dictionary<int, string>();
                        dic2.Add(-1, "");//chosen 留空
                        dic2.Add((int)OrderStatus.未支付, OrderStatus.未支付.ToString());
                        dic2.Add((int)OrderStatus.支付成功, OrderStatus.支付成功.ToString());
                        dic2.Add((int)OrderStatus.已取消, OrderStatus.已取消.ToString());

                        ddlOrderStatus.DataSource = dic2;
                        ddlOrderStatus.DataTextField = "Value";
                        ddlOrderStatus.DataValueField = "Key";
                        ddlOrderStatus.DataBind();
                        break;
                }

            }
        }



        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            int oType = Common.ToInt(ddlOrderStatus.SelectedValue);
            int cType = Common.ToInt(ddlCheckStatus.SelectedValue);
            string searchText = txtSearch.Value.Trim();
            string timeRange = txtDateRange.Value.Trim();

            var list = SiteFundsHistory.GetList(ref pp, oType, cType, searchText, timeRange);

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
            var entity = e.Item.DataItem as FundsHistory;
            if (entity != null)
            {
                var usr = SiteUser.GetUserInfo(entity.UserId.Value);

                var lit1 = e.Item.FindControl("Literal1") as Literal;
                var lit2 = e.Item.FindControl("Literal2") as Literal;

                lit1.Text = usr.CompanyName;
                lit2.Text = usr.Phone;
            }
        }


        protected void ExportFile_Click(object sender, EventArgs e)
        {
            //指定Templete文档Text.xlsx
            FileInfo newFile = new FileInfo("C:" + @"\test-site\CMS\upload\czgl.xlsx");
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
                            var list4 = SiteFundsHistory.GetListALL();
                            int i = 0;
                            foreach (var info in list4)
                            {
                                currentWorksheet.Cells[StartRow + i, 1].Value = Convert.ToString(info.Id);
                                currentWorksheet.Cells[StartRow + i, 2].Value = Convert.ToString(GetCompanyName(Guid.Parse(info.UserId.ToString())));
                                currentWorksheet.Cells[StartRow + i, 3].Value = Convert.ToString(GetPhone(Guid.Parse(info.UserId.ToString())));
                                currentWorksheet.Cells[StartRow + i, 4].Value = Convert.ToString(info.OrderId);
                                currentWorksheet.Cells[StartRow + i, 5].Value = Convert.ToString(info.CreateDate);
                                currentWorksheet.Cells[StartRow + i, 6].Value = Convert.ToString(info.PayDate);
                                currentWorksheet.Cells[StartRow + i, 7].Value = Convert.ToString(((ProductType)Common.ToInt(info.ProId)));
                                currentWorksheet.Cells[StartRow + i, 8].Value = Convert.ToString(info.FPayTypeText);
                                currentWorksheet.Cells[StartRow + i, 9].Value = Convert.ToString(string.Format("{0:C0}", info.FMoney));
                                currentWorksheet.Cells[StartRow + i, 10].Value = Convert.ToString(((OrderStatus)Common.ToInt(info.OrderStatus)));
                                i++;
                            }
                            //将Temp 这个Sheet删除
                            workBook.Worksheets.Delete("Temp");
                        }
                    }
                    //存至czgl-xz.xlsx
                    pck.SaveAs(new FileInfo("C:" + @"\test-site\CMS\upload\czgl-xz.xlsx"));

                    string fileName = "充值信息.xlsx";//客户端保存的文件名 
                    string filePath = Server.MapPath("~/cms/upload/czgl-xz.xlsx");//路径


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