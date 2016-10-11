using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web.CMS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //注销
            if (!string.IsNullOrWhiteSpace(Request["logout"]) && "1" == Request["logout"].ToString())
            {
                var cookieName = "AdminInfo";;
                Session[cookieName] = null;
                HttpCookie cookie = Request.Cookies[cookieName];
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
                Response.Write("0");
                Response.End();
            }

            //登陆
            string valiCode = Request["valiCode"];
            if (!string.IsNullOrWhiteSpace(valiCode))
            {
                Response.ContentType = "application/json";
                try
                {
                    if (Session["verifycode"] == null || valiCode.ToUpper() != Session["verifycode"].ToString().ToUpper())
                    {
                        Response.Write(Common.Json("Err", "验证码错误或已过期！"));
                    }
                    else
                    {
                        string userName = Request["txtUser"];
                        string userPwd = Request["txtPwd"];

                        string result = SiteAdmin.CheckLogin(userName, userPwd);

                        switch (result)
                        {
                            case "NOTFOUND": //账号不存在
                                Response.Write(Common.Json("Err", "账号不存在或已禁用！"));
                                break;
                            case "PWDERROR": //密码错误
                                Response.Write(Common.Json("Err", "账号或密码错误！"));
                                break;
                            default: //登录成功
                                var temp = SiteAdmin.GetAdminInfo(Guid.Parse(result));
                                Session["AdminInfo"] = temp;

                                //使用cookie保存会话
                                HttpCookie cookie = new HttpCookie("AdminInfo");
                                cookie["nnd"] = temp.UserId.ToString("N");
                                cookie["sgr"] = OctoLib.MD5Crypto.Sign(temp.UserId.ToString("N"), OctoLib.MD5Crypto.KEY);
                                int minutes = Common.ToInt(Common.AppSettings["CmsSessionTime"], 30);//分钟，默30
                                cookie.Expires = DateTime.Now.AddMinutes(minutes);
                                Response.Cookies.Add(cookie);

                                Response.Write(Common.Json("OK", "登陆成功鸟，正在进入系统~"));
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", ex.Message));
                }
                finally
                {
                    Response.End();//在try中会发生“正在中止线程”的错误
                }
            }
        }
    }
}