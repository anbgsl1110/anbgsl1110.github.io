using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.CMS
{
    public partial class PicEdit : CmsBase
    {
        protected string PageSubTitle = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("TPGL"))
            {
                //直接使用IIS自定义错误捕捉
                Response.StatusCode = (int)HttpStatusCode.Forbidden;
                //强制输出自定义消息
                //Response.TrySkipIisCustomErrors = true;
                //Response.Write(Common.SmartMsg("您没有访问权限"));
                Response.End();
            }

            if (!IsPostBack)
            {
                // 默认参数 type=1
                string type = Common.IfNullOrEmptyThen(Request["type"], "1");

                //string type = Request["type"];
                //if (string.IsNullOrWhiteSpace(type))
                //{
                //    Response.Write(Common.SmartMsg("无效参数"));
                //    Response.End();
                //}
                //else
                //{
                hidType.Value = type;
                switch (type)
                {
                    case "1":
                        PageSubTitle = "首页中缝";
                        break;
                    default:
                        Response.Write(Common.SmartMsg("无效参数"));
                        Response.End();
                        break;
                }
                //}

                string ac = Request["action"];
                switch (ac)
                {
                    case "1"://add
                        UpdateImage();
                        break;
                    case "2":
                        UpdateLink();
                        break;
                    default:
                        var list = SiteBanner.GetAllBannerList(type);
                        if (list.Count > 0)
                        {
                            BannerInfo first = list.First();
                            link.Value = first.Link == "#" ? "" : first.Link;
                        }
                        break;
                }
            }
        }



        private void UpdateLink()
        {
            Response.ContentType = "application/json";

            string type = Common.IfNullOrEmptyThen(Request["type"], "1");

            var list = SiteBanner.GetAllBannerList(type);
            BannerInfo first = null;
            if (list.Count > 0)
            {
                first = list.First();
                first.Link = Common.IfNullOrEmptyThen(Request["link"], "#");
                SiteBanner.UpdateBanner(first);
                Response.Write(Common.Json("OK", "保存成功"));
            }
            else
            {
                Response.Write(Common.Json("Err", "图片不存在"));
            }
            Response.End();
        }




        /// <summary>
        /// 更新图片
        /// </summary>
        private void UpdateImage()
        {
            Response.ContentType = "application/json";

            //文件上传

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

            string type = Common.IfNullOrEmptyThen(Request["type"], "1");

            var list = SiteBanner.GetAllBannerList(type);
            BannerInfo first = null;
            if (list.Count > 0)
            {//修改
                first = list.First();
                string imgfile = Server.MapPath("~/" + basePath + first.Image);
                //await Task.Factory.StartNew(() => {
                if (File.Exists(imgfile)) File.Delete(imgfile);
                //});

                first.Image = dirPath + "/" + newFileName;
                SiteBanner.UpdateBanner(first);
            }
            else
            {//添加
                first = new BannerInfo()
                {
                    Image = dirPath + "/" + newFileName,
                    Link = "#",
                    Sort = 0,
                    CreateDate = DateTime.Now,
                    UpdateDate = DateTime.Now,
                    Type = type
                };
                SiteBanner.AddBanner(first);
            }

            Response.Write(Common.Json("OK", "图片上传成功"));
            Response.End();
        }


        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            var list = SiteBanner.GetAllBannerList(hidType.Value);
            if (list.Count > 0)
            {
                bannerImg.Src = basePath + list.First().Image;
            }
        }

    }
}