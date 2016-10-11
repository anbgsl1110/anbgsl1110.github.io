using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.Model;
using Weetop.DAL;
namespace Weetop.Web
{
    public partial class Answers : System.Web.UI.Page
    {
        public List<News> dxyzm = new List<News>();
        public List<News> yyyzm = new List<News>();
        public List<News> yxdx = new List<News>();
        public List<News> tzdx = new List<News>();
        public List<News> gjdx = new List<News>();
        public List<News> dxjk = new List<News>();
        public List<News> dxpt = new List<News>();
        public List<News> dxtd = new List<News>();
        public List<News> dxyzmpt = new List<News>();
        public List<News> dxyzmjk = new List<News>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dxyzm = SiteNews.GetListTop(21, 6);
                yyyzm = SiteNews.GetListTop(22, 6);
                yxdx = SiteNews.GetListTop(23, 6);
                tzdx = SiteNews.GetListTop(24, 6);
                gjdx = SiteNews.GetListTop(25, 6);
                dxjk = SiteNews.GetListTop(26, 6);
                dxpt = SiteNews.GetListTop(27, 6);
                dxtd = SiteNews.GetListTop(28, 6);
                dxyzmpt = SiteNews.GetListTop(29, 6);
                dxyzmjk = SiteNews.GetListTop(30, 6);
                this.aPosition.HRef = "/Answers";
                this.aPosition.InnerText = "全部分类";

            }
        }

        public string GetNameById(int id)
        {
            switch (id)
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