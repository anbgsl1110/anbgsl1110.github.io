using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;
using Microsoft.AspNet.FriendlyUrls;
namespace Weetop.Web
{
    public partial class AnswersDetail : System.Web.UI.Page
    {
        public List<News> list1 = new List<News>();
        public List<News> list2 = new List<News>();
        public List<News> list3 = new List<News>();
        protected long CateId = 0;
        public IList<string> url;
        public string content_Value120 = "";
        public string content_title = "";
        public string content_keywords = "";
        protected string Description = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            url = Request.GetFriendlyUrlSegments();
            string cateId = GetCateId(url[0]).ToString();
            string conId = url[1].ToString();
            if (!string.IsNullOrEmpty(conId))
            {
                CateId = Common.ToLong(cateId);
                long ConId = Common.ToLong(conId);

                SiteNews.AddViewCount(ConId);//查看次数

                var entity = SiteNews.GetOne(ConId);
                if (entity != null)
                {
                    content_title = entity.Title + " - 示远科技";
                    awTitle.Text = entity.Title;
                    awPostDate.Text = entity.PostDate.Value.ToString("yyyy-MM-dd");
                    LitViewCount.Text = entity.ViewCount.ToString();
                    awContent.Text = entity.Content;
                    content_Value120 = entity.Content.Substring(0, 20).ToString().RemoveHtmlTag();
                    this.aPosition.InnerText = entity.Title; this.aPosition.InnerText = entity.Title;
                    Description = entity.Content.RemoveHtmlTag(150).Trim();

                    var nextItem = SiteNews.GetNext(CateId, ConId);
                    if (nextItem != null)
                    {
                        linkNext.NavigateUrl = string.Format("AnswersDetail/{0}/{1}", url[0], nextItem.Id);
                        linkNext.Text = nextItem.Title;
                    }
                    else
                    {
                        linkNext.Text = "没有了";
                    }

                    var prevItem = SiteNews.GetPrev(CateId, ConId);
                    if (prevItem != null)
                    {
                        linkPrev.NavigateUrl = string.Format("AnswersDetail/{0}/{1}", url[0], prevItem.Id);
                        linkPrev.Text = prevItem.Title;
                    }
                    else
                    {
                        linkPrev.Text = "没有了";
                    }

                   

                }

                list1 = SiteNews.GetListTop(CateId, 8);
                list2 = SiteNews.GetListTop(CateId, ConId,6);
                list3 = SiteNews.GetListTop();
               

            }
            else
            {
                Response.Write("参数错误");
                Response.End();
            }
        }
        public int GetCateId(string xpathName)
        {
            switch (xpathName)
            {
                case "dxsms":
                    content_keywords = "短信验证码,短信验证码平台,短信验证码接口,手机验证码平台,验证码短信平台,短信验证码提供商";
                    return 21;
                case "vovc":
                    content_keywords = "语音验证码,语音验证码平台,语音验证码接口,app语音验证码,语音验证码公司,语音验证码哪家好";
                    return 22;
                case "msms":
                    content_keywords = "短信营销,营销短信,短信营销平台,短信群发,短信群发平台";
                    return 23;
                case "notsms":
                    content_keywords = "会员通知短信,短信通知,通知短信,订单短信通知,短信提醒";
                    return 24;
                case "insms":
                    content_keywords = "国际短信,国际短信平台,国际短信接口,国际验证码,国际短信验证码,国际短信验证码平台";
                    return 25;
                case "smsjog":
                    content_keywords = "短信接口,短信接口平台,api短信接口,java短信接口,php短信接口,发短信接口,app短信接口";
                    return 26;
                case "smsroof":
                    content_keywords = "短信平台,短信发送平台,短信平台群发,短信验证平台,短信平台哪个好,会员短信平台";
                    return 27;
                case "smsentry":
                    content_keywords = "短信通道,营销短信通道,短信通道提供商,短信通道商,短信通道哪个好,10690短信通道,短信通道购买";
                    return 28;
                case "smspt":
                    content_keywords = "短信验证码平台,短信验证平台,短信发送验证码平台,短信验证码接口平台";
                    return 29;
                case "smsjk":
                    content_keywords = "短信验证码接口,网站短信验证接口,短信验证接口,php短信验证码接口,ios短信验证码接口,网站短信验证码接口";
                    return 30;
                default:
                    content_keywords = "短信验证码,短信验证码平台,短信验证码接口,手机验证码平台,验证码短信平台,短信验证码提供商";
                    return 21;
            }
        }

        //根据id获得url中分类名,前台用----by wzl 2016-10-08
        public static string GetCateName(long xpathId)
        {
            switch (xpathId)
            {
                case 21:
                    return "dxsms";
                case 22:
                    return "vovc";
                case 23:
                    return "msms";
                case 24:
                    return "notsms";
                case 25:
                    return "insms";
                case 26:
                    return "smsjog";
                case 27:
                    return "smsroof";
                case 28:
                    return "smsentry";
                case 29:
                    return "smspt";
                case 30:
                    return "smsjk";
                default:
                    return "dxsms";
            }
        }

    }
}