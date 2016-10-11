using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web
{
    public partial class NewsDetails : System.Web.UI.Page
    {
        protected long CateId = 0;

        protected string Description = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            string cateId = Request["catid"];
            string conId = Request["Id"];

            if (!string.IsNullOrEmpty(conId))
            {

                CateId = Common.ToLong(cateId);
                long ConId = Common.ToLong(conId);

                SiteNews.AddViewCount(ConId);//查看次数

                var entity = SiteNews.GetOne(ConId);
                if (entity != null)
                {
                    Page.Title = entity.Title + " - 示远科技";
                    LitTitle.Text = entity.Title;
                    LitPostDate.Text = entity.PostDate.Value.ToString("yyyy-MM-dd");
                    LitViewCount.Text = entity.ViewCount.ToString();
                    LitContent.Text = entity.Content;

                    Description = entity.Content.RemoveHtmlTag(150).Trim();

                    var nextItem = SiteNews.GetNext(CateId, ConId);
                    if (nextItem != null)
                    {
                        linkNext.NavigateUrl = string.Format("NewsDetails.aspx?catid={0}&id={1}", CateId, nextItem.Id);
                        linkNext.Text = nextItem.Title;
                    }
                    else
                    {
                        linkNext.Text = "没有了";
                    }

                    var prevItem = SiteNews.GetPrev(CateId, ConId);
                    if (prevItem != null)
                    {
                        linkPrev.NavigateUrl = string.Format("NewsDetails.aspx?catid={0}&id={1}", CateId, prevItem.Id);
                        linkPrev.Text = prevItem.Title;
                    }
                    else
                    {
                        linkPrev.Text = "没有了";
                    }

                }

                Repeater1.DataSource = SiteNews.GetListTop(CateId, 5);
                Repeater1.DataBind();

                Repeater2.DataSource = SiteNews.GetListTop(6, 5);
                Repeater2.DataBind();

            }
            else
            {
                Response.Write("参数错误");
                Response.End();
            }
        }
    }
}