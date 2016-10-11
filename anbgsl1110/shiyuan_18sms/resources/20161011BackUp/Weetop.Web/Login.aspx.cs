using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GeetestSDK;
using Weetop.BLL;
using Weetop.Model;

namespace Weetop.Web
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string op = Request["op"];
            if (!string.IsNullOrWhiteSpace(op))
            {
                switch (op)
                {
                    case "1":
                        GetCaptcha();
                        break;
                    case "2":
                        CheckLogin();
                        break;
                    case "3":
                        Logout();
                        break;
                }
            }
        }


        private void GetCaptcha()
        {
            Response.ContentType = "application/json";
            Response.Write(GeeLib.GetCaptcha());
            Response.End();
        }


        private void CheckLogin()
        {
            Response.ContentType = "application/json";

            GeetestLib geetest = new GeetestLib(GeetestConfig.publicKey, GeetestConfig.privateKey);
            Byte gt_server_status_code = (Byte)Session[GeetestLib.gtServerStatusSessionKey];
            int result = 0;
            String challenge = Request.Form.Get(GeetestLib.fnGeetestChallenge);
            String validate = Request.Form.Get(GeetestLib.fnGeetestValidate);
            String seccode = Request.Form.Get(GeetestLib.fnGeetestSeccode);
            if (gt_server_status_code == 1) result = geetest.enhencedValidateRequest(challenge, validate, seccode);
            else result = geetest.failbackValidateRequest(challenge, validate, seccode);
            //if (result == 1) Response.Write("success");
            //else Response.Write("fail");

            if (result == 1)
            {
                string yhm = Request["yhm"];
                string pwd = Request["pwd"];


                using (DataClassesDataContext db = new DataClassesDataContext())
                {
                    var temp = db.UserInfo.SingleOrDefault(w => (w.Phone == yhm || w.Email == yhm) && !w.IsDeleted);
                    if (temp != null)
                    {
                        if (!temp.Enabled)
                        {
                            Response.Write(Common.Json("2", "您的帐号已禁用，请联系客服"));
                        }
                        else if (temp.Pwd == pwd)
                        {
                            temp.LastLogin = DateTime.Now;
                            db.SubmitChanges();

                            //保存会话信息
                            var cookieName = Common.AppSettings["CookieName"];
                            Session[cookieName] = temp;
                            HttpCookie cookie = new HttpCookie(cookieName);
                            cookie["nnd"] = temp.UserId.ToString("N");
                            cookie["sgr"] = OctoLib.MD5Crypto.Sign(temp.UserId.ToString("N"), OctoLib.MD5Crypto.KEY);
                            cookie.Expires = DateTime.Now.AddDays(7);
                            Response.Cookies.Add(cookie);

                            Response.Write(Common.Json("4", "登陆成功"));
                        }
                        else
                        {
                            Response.Write(Common.Json("3", "帐号或密码错误"));
                        }
                    }
                    else
                    {
                        Response.Write(Common.Json("3", "帐号或密码错误"));
                    }
                }
                Response.End();
            }
            else
            {
                Response.Write(Common.Json("2", "请完成滑块验证"));
                Response.End();
            }

        }




        private void Logout()
        {
            var cookieName = Common.AppSettings["CookieName"];
            Session[cookieName] = null;
            HttpCookie cookie = Request.Cookies[cookieName];
            cookie.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(cookie);

            //Response.Redirect("/index.aspx");

            Response.ContentType = "application/json";
            Response.Write(Common.Json("1", "成功"));
            Response.End();
        }
    }
}