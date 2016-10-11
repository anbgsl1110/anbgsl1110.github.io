using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;
using BLL = Weetop.BLL;

namespace Weetop.Web.CMS
{
    public partial class BasePage : System.Web.UI.MasterPage
    {
        protected string DisplayName = "管理员";
        protected string CMS = Common.AppSettings["CMS"];
        protected string basePath = Common.AppSettings["UploadImagePath"];


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
            if (Admin == null)
            {
                string isAjax = HttpContext.Current.Request.Headers.Get("X-Requested-With");//判断是否为AJAX请求
                string msAjax = HttpContext.Current.Request.Headers.Get("X-MicrosoftAjax");
                if (string.IsNullOrEmpty(isAjax))
                {
                    Response.Redirect(CMS + "login.aspx");
                }
                else
                {
                    //PostBack
                    if (IsPostBack && !string.IsNullOrEmpty(msAjax))
                    {
                        Response.Redirect(CMS + "login.aspx");
                    }
                    else
                    {
                        Response.ContentType = "application/json";
                        Response.Write(Common.Json("Err", "会话超时或已失效，操作无效，请刷新页面重新登陆"));
                    }
                    Response.End();
                }
            }
            else
            {
                DisplayName = Common.IfNullOrWhiteThen(Admin.RealName, Admin.UserName);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Write(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
            //Response.Write(Session.SessionID);
        }
    }
}