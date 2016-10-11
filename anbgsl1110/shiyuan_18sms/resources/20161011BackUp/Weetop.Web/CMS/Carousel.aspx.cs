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
using Wuqi.Webdiyer;

namespace Weetop.Web.CMS
{
    public partial class Carousel : CmsBase
    {
        protected string PageSubTitle = "网站首页";

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
                string ac = Request["action"];
                switch (ac)
                {
                    case "1"://add
                        Add();
                        break;
                    case "2"://edit
                        Update();
                        break;
                    case "3"://del
                        Delete();
                        break;
                    default:
                        //BindData();//有UpdatePanel的OnLoad方法时不需要这个，会重复执行
                        break;
                }
            }
        }


        private void Add()
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

            BannerInfo ba = new BannerInfo()
            {
                Image = dirPath + "/" + newFileName,
                Link = Common.IfNullOrWhiteThen(Request["link"], "#"),
                Sort = Common.ToInt(Request["sort"]),
                CreateDate = DateTime.Now,
                UpdateDate = DateTime.Now,
                Type = "0"//默认参数type=0，可参考PicEdit中配置
            };

            SiteBanner.AddBanner(ba);

            Response.Write(Common.Json("OK", "图片上传成功"));
            Response.End();

        }

        private void Update()
        {
            Response.ContentType = "application/json";

            var entity = SiteBanner.GetBanner(Common.ToInt(Request["id"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            entity.Sort = Common.ToInt(Request["sort"]);
            entity.Link = Common.IfNullOrWhiteThen(Request["link"], "#");
            entity.UpdateDate = DateTime.Now;
            SiteBanner.UpdateBanner(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }

        private void Delete()
        {
            Response.ContentType = "application/json";

            int id = Common.ToInt(Request["id"]);
            var entity = SiteBanner.GetBanner(id);
            if (entity != null)
            {
                SiteBanner.DeleteBanner(id);
                string file = entity.Image;
                string path = Server.MapPath("~/" + basePath + file);
                //await Task.Factory.StartNew(() => {
                if (File.Exists(path)) File.Delete(path);
                //});
            }
            Response.Write(Common.Json("OK", "删除成功"));
            Response.End();
        }

        //绑定数据
        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            List<BannerInfo> list = SiteBanner.GetAllBannerList(ref pp, "0");

            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;

            Repeater1.DataSource = list;
            Repeater1.DataBind();
        }


        protected void AspNetPager1_PageChanging(object src, PageChangingEventArgs e)
        {
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            BindData();
        }


        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            BindData();
        }

    }
}