using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web.CMS
{
    public partial class DocEdit : CmsBase
    {
        protected long CategoryID = 0;

        protected string MenuId
        {
            get
            {
                string menu = "menu";
                switch (CategoryID)
                {
                    case 1:
                        return menu + "51";
                    case 2:
                        return menu + "52";
                    case 3:
                        return menu + "53";
                    case 4:
                        return menu + "54";
                    default:
                        return "errid";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string catid = Request["catid"];
            if (string.IsNullOrWhiteSpace(catid))
            {
                Response.Write(Common.SmartMsg("无效参数"));
                Response.End();
            }
            else
            {
                //新闻管理权限
                if (!BLL.PrivManager.HasPrivFWForModule("XWGL"))
                {
                    //直接使用IIS自定义错误捕捉
                    Response.StatusCode = (int)HttpStatusCode.Forbidden;
                    //强制输出自定义消息
                    //Response.TrySkipIisCustomErrors = true;
                    //Response.Write(Common.SmartMsg("您没有访问权限"));
                    Response.End();
                }


                hidCateId.Value = catid;

                CategoryID = Common.ToLong(catid);

                Page.Title = SiteCategory.GetNameById(CategoryID);

                if (IsPostBack)
                    Page.Title += " - 网站后台管理系统";
            }

            if (!IsPostBack)
            {
                int ContentId = Common.ToInt(Request["conid"]);
                hidId.Value = ContentId.ToString();

                if (ContentId != 0)
                {
                    Model.DevDoc entity = SiteDevDoc.GetOne(ContentId);
                    if (entity != null)
                    {
                        txtTitle.Value = entity.Title;
                        txtContent.Text = entity.Content;
                        txtRemark.Value = entity.Remark;
                        txtSort.Value = entity.Sort.ToString();
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

            string CategoryID = hidCateId.Value;
            string ContentId = hidId.Value;

            #region 上传图片

            //HttpPostedFile file = Request.Files["inputImg"];
            //string dbPathName = null;//图片存在数据库中的路径

            //if (file != null && file.ContentLength > 0)
            //{

            //    if (file.ContentLength > maxImageByte)
            //    {
            //        Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
            //        Response.End();
            //    }
            //    if (!file.ContentType.ToLower().StartsWith("image"))
            //    {
            //        Response.Write(Common.Json("Err", "文件格式不正确"));
            //        Response.End();
            //    }
            //    string fileExt = Path.GetExtension(file.FileName);
            //    string[] imgExts = imageTypes.Split('|');
            //    if (!imgExts.Contains(fileExt))
            //    {
            //        Response.Write(Common.Json("Err", "文件格式不正确"));
            //        Response.End();
            //    }
            //    //保存文件
            //    string dirPath = DateTime.Now.ToString("yyyyMM");
            //    string path = HttpContext.Current.Server.MapPath("~/" + basePath + dirPath);
            //    if (!Directory.Exists(path))
            //    {
            //        try { Directory.CreateDirectory(path); }
            //        catch (Exception ex)
            //        {
            //            Response.Write(Common.Json("Err", ex.Message));
            //            Response.End();
            //        }
            //    }
            //    string newFileName = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(1000, 9999).ToString() + fileExt;

            //    dbPathName = dirPath + "/" + newFileName;

            //    try { file.SaveAs(path + "/" + newFileName); }
            //    catch (Exception ex)
            //    {
            //        Response.Write(Common.Json("Err", ex.Message));
            //        Response.End();
            //    }
            //}

            #endregion 上传图片

            if (!string.IsNullOrWhiteSpace(ContentId))
            {
                if (ContentId == "0")
                {
                    //添加

                    Model.DevDoc entity = new Model.DevDoc()
                    {
                        Title = txtTitle.Value,
                        Content = txtContent.Text,
                        Remark = txtRemark.Value.Trim(),
                        CreateDate = DateTime.Now,
                        UpdateDate = DateTime.Now,
                        Sort = Common.ToInt(txtSort.Value),
                        CateId = Common.ToLong(CategoryID)
                    };

                    SiteDevDoc.Add(entity);

                    Response.Write(Common.Json("OK", "添加成功"));
                    Response.End();
                }
                else
                {
                    //修改

                    Model.DevDoc entity = SiteDevDoc.GetOne(Common.ToLong(ContentId));
                    entity.Title = txtTitle.Value;
                    entity.Content = txtContent.Text;
                    entity.Remark = txtRemark.Value.Trim();
                    entity.UpdateDate = DateTime.Now;
                    entity.Sort = Common.ToInt(txtSort.Value);

                    SiteDevDoc.Update(entity);

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