using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Wuqi.Webdiyer;
using Microsoft.AspNet.FriendlyUrls;

namespace Weetop.Web.ask
{
    public partial class notsms : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IList<string> url = Request.GetFriendlyUrlSegments();
                this.aPosition.InnerText = "通知短信";
                BindData();
            }
        }

        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex, 10);
            hidCateId.Value = "24";
            List<Model.News> list = SiteNews.GetList(Common.ToInt(24), ref pp);


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
    }
}