using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web
{
    public partial class Index : System.Web.UI.Page
    {
        public News news1 = new News();
        public News news2 = new News();
        public News news3 = new News();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var listDate1 = SiteNews.GetListTop(5, 6);
                news1 = listDate1.Take(1).FirstOrDefault();
                Repeater1.DataSource = listDate1.Where(p => p.Id != news1.Id).ToList();
                Repeater1.DataBind();

                var listDate2 = SiteNews.GetListTop(7, 6);
                news2 = listDate2.Take(1).FirstOrDefault();
                Repeater2.DataSource = listDate2.Where(p => p.Id != news2.Id).ToList();
                Repeater2.DataBind();


                var listDate3 = SiteNews.GetListTopIncateId(21, 30,6);
                news3 = listDate3.Take(1).FirstOrDefault();
                Repeater3.DataSource = listDate3.Where(p => p.Id != news3.Id).ToList();
                Repeater3.DataBind();
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