using Newtonsoft.Json.Linq;
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
using OctoLib;
using System.IO;

namespace Weetop.Web.CMS
{
    public partial class LogList : CmsBase
    {
        protected string ClientIP = " ";//客户端IP
        protected string ClientMAC = " ";//客户端MAC

        protected void Page_Load(object sender, EventArgs e)
        {
            ClientIP = SiteLog.GetClientIP();
            ClientMAC = SiteLog.GetClientMAC();
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        private void BindData()
        {
            var pg = Common.ToInt(Request["page"]);
            if (pg !=0) AspNetPager1.CurrentPageIndex = pg;
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);
            string searchText = txtSearch.Value.Trim();
            string timeRange = txtDateRange.Value.Trim();
            List<Log> list = new List<Log>();
            list = SiteLog.GetList(ref pp,searchText,timeRange);
            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;
            Repeater1.DataSource = list;
            Repeater1.DataBind();
        }

        /// <summary>
        /// 加载Panel时
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void UpdatePanel1_Load(object sender,EventArgs e)
        {
            BindData();
        }

        /// <summary>
        /// 页码发生改变时
        /// </summary>
        /// <param name="src"></param>
        /// <param name="e"></param>
        protected void AspNetPager1_PageChanging(object src,PageChangingEventArgs e)
        {
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            BindData();
        }
    }
}