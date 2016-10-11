using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.CMS
{
    public partial class Profile : CmsBase
    {
        protected View_AdminInfo VAdmin = null;//包含角色信息

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string ac = Request["action"];
                switch (ac)
                {
                    case "2"://edit
                        Update();
                        break;
                    case "3"://avatar
                        UpdateImg();
                        break;
                    case "4"://pwd
                        UpdatePwd();
                        break;
                    default:
                        VAdmin = SiteAdmin.GetAdminView(Admin.UserId);
                        break;
                }
            }
        }



        private void Update()
        {
            Response.ContentType = "application/json";

            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            var entity = SiteAdmin.GetAdminInfo(guid);
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            entity.RealName = Request["name"];
            entity.Email = Request["email"];
            entity.Phone = Request["phone"];
            entity.Remark = Request["remark"];
            SiteAdmin.UpdateAdminInfo(entity);

            Session["AdminInfo"] = entity;

            Response.Write(Common.Json("OK", "保存成功"));
            Response.End();
        }



        private void UpdateImg()
        {
            Response.ContentType = "application/json";

            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            var entity = SiteAdmin.GetAdminInfo(guid);
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }


            HttpPostedFile file = Request.Files["file"];
            //验证长度和格式
            if (file == null || file.ContentLength <= 0 || string.IsNullOrEmpty(file.FileName))
            {
                Response.Write(Common.Json("Err", "请选择上传文件"));
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
                try { Directory.CreateDirectory(path); }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", ex.Message));
                    Response.End();
                }
            }
            string newFileName = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(1000, 9999).ToString() + fileExt;

            try { file.SaveAs(path + "/" + newFileName); }
            catch (Exception ex)
            {
                Response.Write(Common.Json("Err", ex.Message));
                Response.End();
            }


            //表单保存
            string imgfile = Server.MapPath("~/" + basePath + entity.Avatar);
            //await Task.Factory.StartNew(() => {
            if (File.Exists(imgfile)) File.Delete(imgfile);
            //});

            entity.Avatar = dirPath + "/" + newFileName;
            SiteAdmin.UpdateAdminInfo(entity);


            Session["AdminInfo"] = entity;

            Response.Write(Common.Json("OK", basePath + entity.Avatar));
            Response.End();
        }



        private void UpdatePwd()
        {
            Response.ContentType = "application/json";

            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            string oldpwd = Request["oldpwd"];
            string newpwd = Request["newpwd"];
            if (string.IsNullOrWhiteSpace(oldpwd) || string.IsNullOrWhiteSpace(newpwd))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var entity = SiteAdmin.GetAdminInfo(guid);
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            if (entity.UserPwd == oldpwd)
            {
                entity.UserPwd = newpwd;
                SiteAdmin.UpdateAdminInfo(entity);
                //Session["AdminInfo"] = null;//退出重新登陆
                Response.Write(Common.Json("OK", "密码修改成功"));
            }
            else
            {
                Response.Write(Common.Json("Err", "原密码错误，修改失败"));
            }
            Response.End();

        }

    }
}