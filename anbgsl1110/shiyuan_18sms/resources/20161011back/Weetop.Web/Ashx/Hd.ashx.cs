using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.Ashx
{
    /// <summary>
    /// Summary description for Hd
    /// </summary>
    public class Hd : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {

            string action = context.Request["ac"];
            switch (action)
            {
                case "1"://验证码图片
                    GenVarifyCode(context);
                    break;
                case "2"://下载文件
                    DownloadFile(context);
                    break;
                case "3"://验证注册邮箱
                    CheckEmail(context);
                    break;
                case "4"://用户中心更新头像
                    UploadAvatar(context);
                    break;
                case "5"://用户中心更新信息
                    UpdateInfo(context);
                    break;
                case "6"://用户中心更新密码
                    UpdatePwd(context);
                    break;
                case "7"://余额预警
                    YeAlert(context);
                    break;
                default:
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("Hello Gay");
                    break;
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        #region TUser

        private string imageTypes = Common.IfNullOrWhiteThen(Common.AppSettings["ImageTypes"], ".gif|.png|.jpg|.jpeg|.bmp");
        private int maxImageByte = Common.ToInt(Common.AppSettings["MaxImageByte"], 2 * 1024 * 1024);

        private string cookieName = Common.IfNullOrWhiteThen(Common.AppSettings["CookieName"], "UserInfo");
        private UserInfo TUser
        {
            get
            {
                HttpSessionState Session = HttpContext.Current.Session;
                HttpRequest Request = HttpContext.Current.Request;

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
                HttpContext.Current.Session[cookieName] = value;
            }
        }

        #endregion TUser

        #region 验证码图片

        private void GenVarifyCode(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            HttpSessionState Session = context.Session;

            OctoLib.VryImgGen gen = new OctoLib.VryImgGen();
            string verifyCode = gen.CreateVerifyCodeByType(2, 4);
            Session["verifycode"] = verifyCode.ToUpper();
            System.Drawing.Bitmap bitmap = gen.CreateImage(verifyCode);
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            bitmap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
            Response.Clear();
            Response.ContentType = "image/png";
            Response.BinaryWrite(ms.GetBuffer());
            bitmap.Dispose();
            ms.Dispose();
            ms.Close();
            Response.End();
        }

        #endregion 验证码图片

        #region 下载文件

        private string basePath = Common.IfNullOrWhiteThen(Common.AppSettings["UploadImagePath"], "File/CpImages/");
        protected string baseFilePath = Common.IfNullOrWhiteThen(Common.AppSettings["UploadFilePath"], "File/CpFiles/");
        private void DownloadFile(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            HttpSessionState Session = context.Session;
            HttpServerUtility Server = context.Server;

            if (!string.IsNullOrWhiteSpace(Request["filename"]))
            {
                var file = Common.ToLong(Request["filename"]);
                var entity = SiteDevDoc.GetOne(Common.ToLong(file));
                if (entity != null)
                {
                    string path = Server.MapPath("~" + baseFilePath + entity.Remark);
                    string name = entity.Title;
                    Response.ContentType = "application/x-zip-compressed";
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + name);
                    Response.TransmitFile(path);
                }
                else
                {
                    Response.ContentType = "application/x-zip-compressed";
                    Response.AddHeader("Content-Disposition", "attachment;filename=err.zip");
                    Response.TransmitFile("err.zip");
                }
            }
        }

        #endregion 下载文件

        #region 验证注册邮箱

        private string SiteUrl = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Host; //Common.AppSettings["SiteUrl"];

        /// <summary>
        /// 用于注册邮箱验证
        /// </summary>
        /// <param name="context"></param>
        private void CheckEmail(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            HttpSessionState Session = context.Session;
            HttpServerUtility Server = context.Server;

            string email = Request["email"];
            string verify = Request["varify"];

            bool check = OctoLib.MD5Crypto.Verify(email, verify, OctoLib.MD5Crypto.KEY);
            if (!check)
            {
                Response.Write("参数无效");
            }
            else
            {
                //using (DataClassesDataContext db = new DataClassesDataContext())
                //{
                //    var temp = db.TempReg.SingleOrDefault(w => w.PhoneNumber == email && w.SMSCode == verify);
                //    if (temp != null)
                //    {
                //        var temp2 = db.UserInfo.SingleOrDefault(s => s.Email == email);
                //        temp2.EmailValid = true;

                //        db.TempReg.DeleteOnSubmit(temp);
                //        db.SubmitChanges();

                //        Response.Write("验证成功，请<a href='" + SiteUrl + "/login.aspx'>登陆</a>");
                //        Response.End();
                //        Server.Transfer("/regvalid.aspx?ac=1");
                //    }
                //    else
                //    {
                //        Response.Write("无效验证，如果您已验证或未在本站注册，请忽略");
                //        Response.End();
                //        Server.Transfer("/regvalid.aspx?ac=2");
                //    }
                //}


                Response.Write("验证成功");
            }

            Response.End();
        }

        #endregion 验证注册邮箱

        #region 用户中心更新头像

        /// <summary>
        /// 用户中心修改头像
        /// </summary>
        /// <param name="context"></param>
        private void UploadAvatar(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            HttpSessionState Session = context.Session;
            HttpServerUtility Server = context.Server;

            Response.ContentType = "application/json";

            HttpPostedFile file = Request.Files["file"];
            string dbPathName = null;//图片存在数据库中的路径

            if (file == null || file.ContentLength <= 0)
            {
                Response.Write(Common.Json("Err", "请选择文件"));
                Response.End();
            }

            if (file.ContentLength > maxImageByte)
            {
                Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
                Response.End();
            }
            if (!file.ContentType.ToLower().StartsWith("image"))
            {
                Response.Write(Common.Json("Err", "文件格式不正确"));
                Response.End();
            }
            string fileExt = Path.GetExtension(file.FileName);
            string[] imgExts = imageTypes.Split('|');
            if (!imgExts.Contains(fileExt))
            {
                Response.Write(Common.Json("Err", "文件格式不正确"));
                Response.End();
            }
            //保存文件
            string dirPath = DateTime.Now.ToString("yyyyMM");
            string path = HttpContext.Current.Server.MapPath("~/" + basePath + dirPath);
            if (!Directory.Exists(path))
            {
                try
                {
                    Directory.CreateDirectory(path);
                }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", ex.Message));
                    Response.End();
                }
            }
            string newFileName = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(1000, 9999).ToString() + fileExt;

            try
            {
                file.SaveAs(path + "/" + newFileName);
                dbPathName = dirPath + "/" + newFileName;
            }
            catch (Exception ex)
            {
                Response.Write(Common.Json("Err", ex.Message));
                Response.End();
            }


            var entity = SiteUser.GetUserInfo(TUser.UserId);

            string imgfile = Server.MapPath("~/" + basePath + entity.Avatar);
            if (File.Exists(imgfile)) File.Delete(imgfile);
            entity.Avatar = dbPathName;

            SiteUser.UpdateUserInfo(entity);
            TUser = entity;
            Response.Write(Common.Json("OK", basePath + dbPathName));
            Response.End();


        }

        #endregion 用户中心更新头像

        #region 用户中心更新信息

        /// <summary>
        /// 用户中心更新信息
        /// </summary>
        /// <param name="context"></param>
        private void UpdateInfo(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            HttpSessionState Session = context.Session;
            HttpServerUtility Server = context.Server;

            Response.ContentType = "application/json";

            if (string.IsNullOrWhiteSpace(Request["uname"]) || string.IsNullOrWhiteSpace(Request["cmpname"]))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            UserInfo entity = SiteUser.GetUserInfo(TUser.UserId);
            if (entity != null)
            {
                entity.NickName = Request["uname"];
                entity.CompanyName = Request["cmpname"];
                entity.Sex = Common.ToInt(Request["sex"]);
                //entity.Phone = Request["phone"];
                //entity.Email = Request["email"];
                entity.UpdateDate = DateTime.Now;

                SiteUser.UpdateUserInfo(entity);
                TUser = entity;
                Response.Write(Common.Json("OK", "修改成功"));
                Response.End();
            }
            else
            {
                Response.Write(Common.Json("Err", "修改失败，请稍后再试"));
                Response.End();
            }

        }

        #endregion 用户中心更新信息

        #region 更新用户密码

        private void UpdatePwd(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            HttpSessionState Session = context.Session;
            HttpServerUtility Server = context.Server;

            Response.ContentType = "application/json";

            if (string.IsNullOrWhiteSpace(Request["pwd1"]) || string.IsNullOrWhiteSpace(Request["pwd2"]))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            UserInfo entity = SiteUser.GetUserInfo(TUser.UserId);
            if (entity != null)
            {
                if (entity.Pwd == Request["pwd1"])
                {
                    entity.Pwd = Request["pwd2"];
                    entity.UpdateDate = DateTime.Now;

                    SiteUser.UpdateUserInfo(entity);
                    Response.Write(Common.Json("OK", "修改成功"));
                }
                else
                {
                    Response.Write(Common.Json("Err", "旧密码错误"));
                }
            }
            else
            {
                Response.Write(Common.Json("Err", "修改失败，请稍后再试"));
            }

            Response.End();
        }

        #endregion 更新用户密码

        #region 余额预警

        private void YeAlert(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            HttpSessionState Session = context.Session;
            HttpServerUtility Server = context.Server;

            Response.ContentType = "application/json";
            var mm = Common.ToDecimal(Request["mm"]);
            if (string.IsNullOrWhiteSpace(Request["mm"]) || mm <= 0)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var entity = SiteFund.GetFunds(TUser.UserId);
            if (entity != null)
            {
                entity.EarlyWarningVal = mm;
                entity.EarlyWarningFirst = false;//修改预警值后重置 是否为首次预警

                var obj = new
                {
                    isSafe = entity.EarlyWarningEnable.Value ? entity.Available.Value >= mm : true
                };

                SiteFund.Update(entity);
                Response.Write(Common.Json("OK", "修改成功", obj));
            }
            else
            {
                Response.Write(Common.Json("Err", "修改失败，请稍后再试"));
            }

            Response.End();
        }

        #endregion 余额预警

    }
}