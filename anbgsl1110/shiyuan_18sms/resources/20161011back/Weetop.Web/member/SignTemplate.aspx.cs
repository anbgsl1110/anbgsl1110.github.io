using OctoLib;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.member
{
    public partial class SignTemplate : FrontBasic
    {
        protected int validState = 0;

        protected List<ProductFunds> proList = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            validState = SiteUserAuth.GetValidState(TUser.UserId) ?? 0;

            if (!IsPostBack)
            {
                string action = Request["ac"];
                switch (action)
                {
                    case "1": //add
                        Add();
                        break;
                    case "2"://search
                        GetPage();
                        break;
                    case "3":
                        Del();
                        break;
                    default:
                        proList = SiteFund.GetProductOpenedList(TUser.UserId);
                        break;
                }
            }
        }



        private void Add()
        {
            Response.ContentType = "application/json";

            var list = SiteSignTemp.GetAvailableExtno(TUser.UserId);
            if (list.Count >= 10)
            {
                Response.Write(Common.Json("Err", "只能添加10条签名"));
                Response.End();
            }

            int ext = 0;
            var newlist = list.Select(s => Common.ToInt(s)).OrderBy(o => o).ToList();
            while (ext <= 9)
            {
                if (newlist.Contains(ext))
                    ext++;
                else break;
            }



            var title = Request["title"];
            var content = Request["cont"];
            var useage = Request["Useage"];
            var pro = Request["pro"];

            if ((string.IsNullOrEmpty(title) || title.Length > 30) ||
                (string.IsNullOrEmpty(content) || content.Length < 3 || content.Length > 8) ||
                string.IsNullOrEmpty(useage))
            {
                Response.Write(Common.Json("Err", "无效参数"));
                Response.End();
            }


            #region 上传文件


            string dbPathName1 = null;
            string dbPathName2 = null;
            string dbPathName3 = null;

            //若未认证，则需要上传证明图片
            if (validState != (int)AuthValidState.已认证)
            {

                #region 文件验证

                HttpPostedFile file1 = Request.Files["file1"];
                HttpPostedFile file2 = Request.Files["file2"];
                HttpPostedFile file3 = Request.Files["file3"];
                if ((file1 == null || file1.ContentLength <= 0) || (file2 == null || file2.ContentLength <= 0) || (file3 == null || file3.ContentLength <= 0))
                {
                    Response.Write(Common.Json("Err", "请上传证明文件(size>0)"));
                    Response.End();
                }


                string[] imgExts = imageTypes.Split('|');

                //文件验证
                if (file1.ContentLength > maxImageByte || file2.ContentLength > maxImageByte || file3.ContentLength > maxImageByte)
                {
                    Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
                    Response.End();
                }
                if (!file1.ContentType.ToLower().StartsWith("image") || !file2.ContentType.ToLower().StartsWith("image") || !file3.ContentType.ToLower().StartsWith("image"))
                {
                    Response.Write(Common.Json("Err", "文件格式不正确"));
                    Response.End();
                }
                string fileExt1 = Path.GetExtension(file1.FileName);
                string fileExt2 = Path.GetExtension(file2.FileName);
                string fileExt3 = Path.GetExtension(file3.FileName);
                if (!imgExts.Contains(fileExt1) || !imgExts.Contains(fileExt2) || !imgExts.Contains(fileExt3))
                {
                    Response.Write(Common.Json("Err", "文件格式不正确"));
                    Response.End();
                }

                #endregion 文件验证

                //创建目录
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

                #region 保存文件


                //批量时注意随机文件名可能相同，使用不同的种子
                var newFileName1 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(1000, 3998).ToString() + fileExt1;
                var newFileName2 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(3999, 6998).ToString() + fileExt2;
                var newFileName3 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(6999, 9998).ToString() + fileExt3;

                try
                {
                    file1.SaveAs(path + "/" + newFileName1);
                    dbPathName1 = dirPath + "/" + newFileName1;
                    file2.SaveAs(path + "/" + newFileName2);
                    dbPathName2 = dirPath + "/" + newFileName2;
                    file3.SaveAs(path + "/" + newFileName3);
                    dbPathName3 = dirPath + "/" + newFileName3;
                }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", ex.Message));
                    Response.End();
                }

                #endregion 保存文件

            }


            #endregion 上传文件


            var entity = new TemplateSign()
            {
                UserId = TUser.UserId,
                Title = title,
                Content = content,
                Useage = Common.ToInt(useage),
                ProId = Common.ToLong(pro),
                ExtNo = ext.ToString(),
                CheckStatus = (int)TempCheckStatus.等待审核,
                CreateDate = DateTime.Now,
                UpdateDate = DateTime.Now
            };

            if (!string.IsNullOrEmpty(dbPathName1)) entity.File1 = dbPathName1;
            if (!string.IsNullOrEmpty(dbPathName2)) entity.File2 = dbPathName2;
            if (!string.IsNullOrEmpty(dbPathName3)) entity.File3 = dbPathName3;

            SiteSignTemp.Add(entity);

            UserInfo usr = SiteUser.GetUserInfo(TUser.UserId);
            string emailTitle = "用户: " + usr.Phone + "申请新增签名模板!";
            string emailContent = "用户" + usr.Phone + "申请新增签名模板.<br/>模板名称为: " + entity.Title + "<br/>内容为: " + entity.Content + "<br/>";
            EmailHp.SendEmail("1743165047@qq.com", emailTitle, emailContent);
            Response.Write(Common.Json("OK", "添加成功"));
            Response.End();

        }


        private void GetPage()
        {
            Response.ContentType = "application/json";

            var searchText = Request["st"];

            var page = Common.ToInt(Request["page"], 1);
            PageParams pp = new PageParams(page);

            var list = SiteSignTemp.GetList(ref pp, TUser.UserId, searchText);

            var tempList = new List<object>();

            foreach (var item in list)
            {
                var temp = new
                {
                    id = item.Id,
                    title = item.Title,
                    content = item.Content,
                    extno = item.ExtNo,
                    useage = ((TempSignUseage)item.Useage.Value).ToString(),
                    //remark = item.Remark,
                    date = item.CreateDate.Value.ToString("yyyy-MM-dd hh:mm"),
                    status = item.CheckStatus,
                    statusTxt = ((TempCheckStatus)item.CheckStatus.Value).ToString(),
                    feedback = item.Feedback
                };
                tempList.Add(temp);
            }

            var obj = new
            {
                pages = pp.Pages,
                list = tempList
            };

            Response.Write(Common.Json("OK", "操作成功", obj));
            Response.End();
        }


        private void Del()
        {
            Response.ContentType = "application/json";

            var tid = Common.ToLong(Request["tid"]);
            var entity = SiteSignTemp.GetOne(tid);
            if (entity == null)
            {
                Response.Write(Common.Json("OK", "无效参数"));
                Response.End();
            }

            SiteSignTemp.Delete(tid);
            Response.Write(Common.Json("OK", "删除成功"));
            Response.End();

        }


    }
}