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
    public partial class smspt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IList<string> url = Request.GetFriendlyUrlSegments();
                this.aPosition.InnerText = "短信验证码平台";
                BindData();
            }
        }

        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex, 10);
            hidCateId.Value = "29";
            List<Model.News> list = SiteNews.GetList(Common.ToInt(29), ref pp);


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