using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web
{
    public class FrontBasic : System.Web.UI.Page
    {
        public FrontBasic() { }


        protected string basePath = Common.IfNullOrWhiteThen(Common.AppSettings["UploadImagePath"], "File/CpImages/");
        protected string baseFilePath = Common.IfNullOrWhiteThen(Common.AppSettings["UploadFilePath"], "File/CpFiles/");
        protected string imageTypes = Common.IfNullOrWhiteThen(Common.AppSettings["ImageTypes"], ".gif|.png|.jpg|.jpeg|.bmp");
        protected string denyTypes = Common.IfNullOrWhiteThen(Common.AppSettings["DenyTypes"], ".exe|.msi|.php|.asp|.aspx");
        protected int maxImageByte = Common.ToInt(Common.AppSettings["MaxImageByte"], 2 * 1024 * 1024);
        protected int maxFileByte = Common.ToInt(Common.AppSettings["MaxFileByte"], 10 * 1024 * 1024);


        protected string cookieName = Common.IfNullOrWhiteThen(Common.AppSettings["CookieName"], "UserInfo");
        protected UserInfo TUser
        {
            get
            {
                UserInfo usrInfo = null;
                if (Session[cookieName] != null)
                {
                    usrInfo = Session[cookieName] as UserInfo;
                }
                else if (Request.Cookies[cookieName] != null)
                {
                    HttpCookie cookie = Request.Cookies[cookieName];
                    if (OctoLib.MD5Crypto.Verify(cookie["nnd"], cookie["sgr"], OctoLib.MD5Crypto.KEY))
                    {
                        usrInfo = SiteUser.GetUserInfo(Guid.Parse(cookie["nnd"]));
                        Session[cookieName] = usrInfo;
                    }
                }
                return usrInfo;
            }
            set
            {
                Session[cookieName] = value;
            }
        }
    }
}