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
    public partial class CaseList : CmsBase
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("XWGL"))
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

            List<Model.News> list = SiteNews.GetList(8, ref pp);

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