using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web.CMS
{
    public partial class CaseEdit : CmsBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("XWGL"))
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
                int ContentId = Common.ToInt(Request["conid"]);
                hidId.Value = ContentId.ToString();

                if (ContentId != 0)
                {
                    Model.News entity = SiteNews.GetOne(ContentId);
                    if (entity != null)
                    {
                        txtTitle.Value = entity.Title;
                        txtContent.Text = entity.Content;
                        txtSrc.Value = entity.Source;
                        //txtSrcVal.Value = entity.SourceUrl;
                        //txtDate.Value = entity.PostDate.Value.ToString("yyyy-MM-dd");
                        txtSort.Value = entity.Sort.ToString();
                        txtName.Value = entity.UsrName;
                        HyperLink1.NavigateUrl = basePath + entity.UsrImage;
                        HyperLink1.Text = Path.GetFileName(HyperLink1.NavigateUrl);
                    }
                }
            }
            else
            {
                AddOrSave();
            }

        }




        protected void AddOrSave()
        {
            Response.ContentType = "application/json";

            //string CategoryID = hidCateId.Value;
            string ContentId = hidId.Value;

            #region 上传图片

            HttpPostedFile file = Request.Files["inputImg"];
            string dbPathName = null;//图片存在数据库中的路径

            if (file != null && file.ContentLength > 0)
            {

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

                dbPathName = dirPath + "/" + newFileName;

                try { file.SaveAs(path + "/" + newFileName); }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", ex.Message));
                    Response.End();
                }
            }

            #endregion 上传图片

            if (!string.IsNullOrWhiteSpace(ContentId))
            {
                if (ContentId == "0")
                {
                    //添加

                    Model.News entity = new Model.News()
                    {
                        Title = txtTitle.Value.Trim(),
                        Content = txtContent.Text.Trim(),
                        Source = txtSrc.Value.Trim(),
                        PostDate = DateTime.Now,//添加日期
                        UpdateDate = DateTime.Now,
                        Sort = Common.ToInt(txtSort.Value),
                        CateId = 8,//分类
                        UsrName = txtName.Value.Trim(),
                        UsrImage = dbPathName
                    };

                    SiteNews.Add(entity);

                    Response.Write(Common.Json("OK", "添加成功"));
                    Response.End();
                }
                else
                {
                    //修改

                    Model.News entity = SiteNews.GetOne(Common.ToLong(ContentId));
                    entity.Title = txtTitle.Value.Trim();
                    entity.Content = txtContent.Text.Trim();
                    entity.Source = txtSrc.Value.Trim();
                    entity.UpdateDate = DateTime.Now;
                    entity.Sort = Common.ToInt(txtSort.Value);
                    entity.UsrName = txtName.Value.Trim();
                    if (!string.IsNullOrEmpty(dbPathName))
                    {
                        var imgfile = Server.MapPath("~/" + basePath + entity.UsrImage);
                        if (File.Exists(imgfile)) File.Delete(imgfile);
                        entity.UsrImage = dbPathName;
                    }

                    SiteNews.Update(entity);

                    Response.Write(Common.Json("OK", "更新成功"));
                    Response.End();
                }
            }
            else
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

        }


    }
}