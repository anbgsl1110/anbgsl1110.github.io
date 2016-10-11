using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.CMS
{
    public class CmsBase : System.Web.UI.Page
    {

        protected string basePath = Common.IfNullOrWhiteThen(Common.AppSettings["UploadImagePath"], "File/CpImages/");
        protected string baseFilePath = Common.IfNullOrWhiteThen(Common.AppSettings["UploadFilePath"], "File/CpFiles/");
        protected string imageTypes = Common.IfNullOrWhiteThen(Common.AppSettings["ImageTypes"], ".gif|.png|.jpg|.jpeg|.bmp");
        protected string denyTypes = Common.IfNullOrWhiteThen(Common.AppSettings["DenyTypes"], ".exe|.msi|.php|.asp|.aspx");
        protected int maxImageByte = Common.ToInt(Common.AppSettings["MaxImageByte"], 2 * 1024 * 1024);
        protected int maxFileByte = Common.ToInt(Common.AppSettings["MaxFileByte"], 10 * 1024 * 1024);
        protected string baseConsultingServiceImagePath = Common.IfNullOrWhiteThen(Common.AppSettings["UploadConsultingServiceImagePath"], "File/ConsultingServiceImages/");


        //protected AdminInfo Admin => (HttpContext.Current.Session["AdminInfo"] as AdminInfo);
        private string cookieName = "AdminInfo";
        protected AdminInfo Admin
        {
            get
            {
                AdminInfo admInfo = null;
                if (Session[cookieName] != null)
                {
                    admInfo = Session[cookieName] as AdminInfo;
                }
                else if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie cookie = Request.Cookies[cookieName];
                    if (OctoLib.MD5Crypto.Verify(cookie["nnd"], cookie["sgr"], OctoLib.MD5Crypto.KEY))
                    {
                        admInfo = SiteAdmin.GetAdminInfo(Guid.Parse(cookie["nnd"]));
                        Session[cookieName] = admInfo;
                    }
                }
                return admInfo;
            }
            set
            {
                Session[cookieName] = value;
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            if (IsPostBack)//例如 UpdatePanel 回发刷新，会影响到 Title
                Page.Title = base.Title + " - 网站后台管理系统";
        }

    }
}