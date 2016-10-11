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
    public partial class NavTop : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
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