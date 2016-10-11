using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Wuqi.Webdiyer;

namespace Weetop.Web.CMS
{
    public partial class AnswerCenterList : CmsBase
    {
        protected long CategoryID = 0;

        protected string MenuId
        {
            get
            {
                string menu = "menu";
                switch (CategoryID)
                {
                    case 21:
                        return menu + "65";
                    case 22:
                        return menu + "66";
                    case 23:
                        return menu + "67";
                    case 24:
                        return menu + "68";
                    case 25:
                        return menu + "69";
                    case 26:
                        return menu + "70";
                    case 27:
                        return menu + "71";
                    case 28:
                        return menu + "72";
                    case 29:
                        return menu + "73";
                    case 30:
                        return menu + "74";
                    default:
                        return "errid";
                }
            }
        }
        public string GetPageTitle(int catid)
        {
            switch (catid)
            {
                case 21:
                    return "短信验证码";
                case 22:
                    return "语音验证码";
                case 23:
                    return "营销短信";
                case 24:
                    return "通知短信";
                case 25:
                    return "国际短信";
                case 26:
                    return "短信接口";
                case 27:
                    return "短信平台";
                case 28:
                    return "短信通道";
                case 29:
                    return "短信验证码平台";
                case 30:
                    return "短信验证码接口";
                default:
                    return "";
                    break;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string catid = Request["catid"];
            if (string.IsNullOrWhiteSpace(catid))
            {
                Response.Write(Common.SmartMsg("无效参数"));
                Response.End();
            }
            else
            {
                //问答中心管理权限
                if (!BLL.PrivManager.HasPrivFWForModule("WDZX"))
                {
                    //直接使用IIS自定义错误捕捉
                    Response.StatusCode = (int)HttpStatusCode.Forbidden;
                    //强制输出自定义消息
                    //Response.TrySkipIisCustomErrors = true;
                    //Response.Write(Common.SmartMsg("您没有访问权限"));
                    Response.End();
                }


                hidCateId.Value = catid;

                CategoryID = Common.ToLong(Request["catid"]);
                string title = GetPageTitle(Convert.ToInt32(Request["catid"]));
                
                if (IsPostBack)
                    Page.Title += title + " - 网站后台管理系统";
                    this.lblTitle.InnerText = title;
            }

            if (!IsPostBack)
            {
                string ac = Request["action"];
                switch (ac)
                {
                    case "3"://del
                        Delete();
                        break;
                    default:
                        //BindData();
                        break;
                }

            }
        }





        public void Delete()
        {
            Response.ContentType = "application/json";

            if (!string.IsNullOrWhiteSpace(Request["conid"]))
            {
                SiteNews.Delete(Common.ToInt(Request["conid"]));
                Response.Write(Common.Json("OK", "删除成功"));
            }
            else
            {
                Response.Write(Common.Json("Err", "无效参数"));
            }
            Response.End();
        }



        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            List<Model.News> list = SiteNews.GetList(Common.ToInt(hidCateId.Value), ref pp);

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


        protected void UpdatePanel1_OnLoad(object sender, EventArgs e)
        {
            BindData();
        }
    }
}