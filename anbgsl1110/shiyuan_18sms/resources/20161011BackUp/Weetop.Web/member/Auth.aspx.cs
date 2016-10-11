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
    public partial class Auth : FrontBasic
    {

        protected UserAuth authInfo = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string action = Request["ac"];
                switch (action)
                {
                    case "1": //add
                        Add();
                        break;
                    case "2"://search
                        //GetPage();
                        break;
                    default:
                        SetInfo();
                        break;
                }

            }
        }

        public void SetInfo()
        {
            authInfo = SiteUserAuth.GetOne(TUser.UserId);
            if (authInfo != null && (AuthValidState)authInfo.ValidState.Value == AuthValidState.已认证)
            {
                var imgHeight = 100;
                this.litAccEmail.Text = TUser.Email;
                string Atype = (AuthType)authInfo.AuthType.Value == AuthType.个人开发者 ? "个人开发者" : "企业开发者";
                this.litAuthType.Text = Atype;
                if (Atype == "企业开发者")
                {
                    this.Panel2.Visible = false;
                    this.litCName.Text = authInfo.AuthCName;
                    this.litCAddr.Text = authInfo.AuthCAddr;
                    string Ctype = (AuthCType)authInfo.AuthCType.Value == AuthCType.普通证件 ? "普通证件" : "三证合一";
                    this.litAuCType.Text = Ctype;
                    if (Ctype == "三证合一")
                    {
                        this.trCFileZ.Visible = false;
                        this.trCFileS.Visible = false;
                        this.trCFileY.Visible = false;
                        this.ImgCFile3in1.ImageUrl = basePath + authInfo.AuthCFile3in1;
                        this.ImgCFile3in1.Height = imgHeight;

                        this.lnkCFile3in1.NavigateUrl = this.ImgCFile3in1.ImageUrl;
                        this.lnkCFile3in1.Target = "";
                    }
                    else
                    {
                        this.trCFile3in1.Visible = false;
                        this.ImgCFileZ.ImageUrl = basePath + authInfo.AuthCFileZ;
                        this.ImgCFileZ.Height = imgHeight;


                        this.ImgCFileS.ImageUrl = basePath + authInfo.AuthCFileS;
                        this.ImgCFileS.Height = imgHeight;

                        this.ImgCFileY.ImageUrl = basePath + authInfo.AuthCFileY;
                        this.ImgCFileY.Height = imgHeight;
                    }
                    this.litCLegalPeo.Text = authInfo.AuthCLegalPeo;
                    this.litCPhone.Text = authInfo.AuthCPhone;
                    this.litCPeoName.Text = authInfo.AuthCPeoName;
                    if (authInfo.AuthCPeoPic != null)
                    {
                        this.ImgPeoPic.ImageUrl = basePath + authInfo.AuthCPeoPic;
                        this.ImgPeoPic.Height = imgHeight;
                    }
                    else
                    {
                        this.trCPeoPic.Visible = false;
                    }
                }
                else
                {
                    this.Panel1.Visible = false;
                    this.litPName.Text = authInfo.AuthPName;
                    this.litPType.Text = Enum.GetName(typeof(AuthPType), authInfo.AuthPType);
                    this.litPFileNum.Text = authInfo.AuthPFileNum;
                    if (authInfo.AuthPFile != null)
                    {
                        this.ImgPeoPic.ImageUrl = basePath + authInfo.AuthPFile;
                        this.ImgPeoPic.Height = imgHeight;
                    }
                }
            }
        }
        private void Add()
        {
            Response.ContentType = "application/json";

            authInfo = SiteUserAuth.GetOne(TUser.UserId);
            bool IsValidState = false;
            if (authInfo != null)
            {
                var sta = (AuthValidState)authInfo.ValidState.Value;
                switch (sta)
                {
                    case AuthValidState.待认证:
                        Response.Write(Common.Json("Err", "您已提交，请等待审核"));
                        Response.End();
                        break;
                    case AuthValidState.已认证:
                        IsValidState = true;
                        break;
                }
            }
            
            var authType = Common.ToInt(Request["rzlx"]);//认证类型
            if (authType != (int)AuthType.企业开发者 && authType != (int)AuthType.个人开发者)
            {
                Response.Write(Common.Json("Err", "无效参数"));
                Response.End();
            }


            var cname = Request["cname"];//公司名称
            var caddr = Request["caddr"];//公司注册地址
            var ctype = Request["zjlx"];//证件类型
            string dbPathName1 = null;//组织机构证件
            string dbPathName2 = null;//税务登记证件
            string dbPathName3 = null;//营业执照证件
            var clegalpeo = Request["clegalpeo"];//法定代表人
            var cphone = Request["cphone"];//公司电话
            var cpeoname = Request["cpeoname"];//申请人真实姓名
            string dbPathName4 = null;//申请人证件照片，非必填


            var pname = Request["pname"];//pname
            var ptype = Request["ptype"];//证件类型
            var pfilenum = Request["pfilenum"];//证件号码
            string dbPathName5 = null;//证件照片


            if (authType == (int)AuthType.企业开发者)
            {
                if ((string.IsNullOrEmpty(cname)) ||
                    (string.IsNullOrEmpty(caddr)) ||
                    string.IsNullOrEmpty(ctype) ||
                    string.IsNullOrEmpty(clegalpeo) ||
                    (string.IsNullOrEmpty(cphone)))
                {
                    Response.Write(Common.Json("Err", "无效参数"));
                    Response.End();
                }

                #region 上传文件

                string dirPath = DateTime.Now.ToString("yyyyMM");
                string path = HttpContext.Current.Server.MapPath("~/" + basePath + dirPath);
                if (Convert.ToInt32(ctype) == (int)AuthCType.普通证件)
                {
                    #region 文件验证

                    HttpPostedFile file1 = Request.Files["cfilez"];//组织机构证件
                    HttpPostedFile file2 = Request.Files["cfiles"];//税务登记证件
                    HttpPostedFile file3 = Request.Files["cfiley"];//营业执照证件
                    HttpPostedFile file4 = Request.Files["cpeopic"];//申请人证件照片，非必填

                    if ((file1 == null || file1.ContentLength <= 0) || (file2 == null || file2.ContentLength <= 0) || (file3 == null || file3.ContentLength <= 0))
                    {
                        Response.Write(Common.Json("Err", "请上传证件(size>0)"));
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

                    string fileExt4 = null;
                    if (file4 != null && file4.ContentLength > 0)
                    {
                        if (file4.ContentLength > maxImageByte)
                        {
                            Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
                            Response.End();
                        }
                        if (!file4.ContentType.ToLower().StartsWith("image"))
                        {
                            Response.Write(Common.Json("Err", "文件格式不正确"));
                            Response.End();
                        }
                        fileExt4 = Path.GetExtension(file4.FileName);
                        if (!imgExts.Contains(fileExt4))
                        {
                            Response.Write(Common.Json("Err", "文件格式不正确"));
                            Response.End();
                        }
                    }

                    #endregion 文件验证

                    #region 保存文件

                    //批量时注意随机文件名可能相同，使用不同的种子
                    var newFileName1 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(1000, 2998).ToString() + fileExt1;
                    var newFileName2 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(2999, 4998).ToString() + fileExt2;
                    var newFileName3 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(4999, 6998).ToString() + fileExt3;

                    string newFileName4 = null;
                    if (fileExt4 != null)
                        newFileName4 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(6999, 8998).ToString() + fileExt4;

                    try
                    {
                        file1.SaveAs(path + "/" + newFileName1);
                        dbPathName1 = dirPath + "/" + newFileName1;
                        file2.SaveAs(path + "/" + newFileName2);
                        dbPathName2 = dirPath + "/" + newFileName2;
                        file3.SaveAs(path + "/" + newFileName3);
                        dbPathName3 = dirPath + "/" + newFileName3;

                        if (newFileName4 != null)
                        {
                            file4.SaveAs(path + "/" + newFileName4);
                            dbPathName4 = dirPath + "/" + newFileName4;
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(Common.Json("Err", ex.Message));
                        Response.End();
                    }

                    #endregion 保存文件
                }
                else if (Convert.ToInt32(ctype) == (int)AuthCType.三证合一)
                {
                    #region 文件验证

                    HttpPostedFile file1 = Request.Files["cfile3in1"];//三证合一照片
                    HttpPostedFile file2 = Request.Files["cpeopic"];  //申请人证件照片，非必填

                    if (file1 == null || file1.ContentLength <= 0)
                    {
                        Response.Write(Common.Json("Err", "请上传证件(size>0)"));
                        Response.End();
                    }

                    string[] imgExts = imageTypes.Split('|');

                    //文件验证
                    if (file1.ContentLength > maxImageByte)
                    {
                        Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
                        Response.End();
                    }
                    if (!file1.ContentType.ToLower().StartsWith("image"))
                    {
                        Response.Write(Common.Json("Err", "文件格式不正确"));
                        Response.End();
                    }
                    string fileExt1 = Path.GetExtension(file1.FileName);
                    if (!imgExts.Contains(fileExt1))
                    {
                        Response.Write(Common.Json("Err", "文件格式不正确"));
                        Response.End();
                    }

                    string fileExt4 = null;
                    if (file2 != null && file2.ContentLength > 0)
                    {
                        if (file2.ContentLength > maxImageByte)
                        {
                            Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
                            Response.End();
                        }
                        if (!file2.ContentType.ToLower().StartsWith("image"))
                        {
                            Response.Write(Common.Json("Err", "文件格式不正确"));
                            Response.End();
                        }
                        fileExt4 = Path.GetExtension(file2.FileName);
                        if (!imgExts.Contains(fileExt4))
                        {
                            Response.Write(Common.Json("Err", "文件格式不正确"));
                            Response.End();
                        }
                    }



                    #endregion 文件验证

                    #region 保存文件

                    //批量时注意随机文件名可能相同，使用不同的种子
                    var newFileName1 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(1000, 2998).ToString() + fileExt1;

                    string newFileName2 = null;
                    if (fileExt4 != null)
                        newFileName2 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(6999, 8998).ToString() + fileExt4;

                    try
                    {
                        file1.SaveAs(path + "/" + newFileName1);
                        dbPathName1 = dirPath + "/" + newFileName1;

                        if (newFileName2 != null)
                        {
                            file2.SaveAs(path + "/" + newFileName2);
                            dbPathName4 = dirPath + "/" + newFileName2;
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(Common.Json("Err", ex.Message));
                        Response.End();
                    }

                    #endregion 保存文件
                }

                //创建目录
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




                #endregion 上传文件

            }
            if (authType == (int)AuthType.个人开发者)
            {
                if ((string.IsNullOrEmpty(pname)) ||
                    string.IsNullOrEmpty(ptype) ||
                    (string.IsNullOrEmpty(pfilenum)))
                {
                    Response.Write(Common.Json("Err", "无效参数"));
                    Response.End();
                }

                #region 上传文件


                #region 文件验证

                HttpPostedFile file4 = Request.Files["pfile"];//证件照片

                string[] imgExts = imageTypes.Split('|');

                string fileExt4 = null;
                if (file4 != null && file4.ContentLength > 0)
                {
                    if (file4.ContentLength > maxImageByte)
                    {
                        Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
                        Response.End();
                    }
                    if (!file4.ContentType.ToLower().StartsWith("image"))
                    {
                        Response.Write(Common.Json("Err", "文件格式不正确"));
                        Response.End();
                    }
                    fileExt4 = Path.GetExtension(file4.FileName);
                    if (!imgExts.Contains(fileExt4))
                    {
                        Response.Write(Common.Json("Err", "文件格式不正确"));
                        Response.End();
                    }
                }
                else
                {
                    Response.Write(Common.Json("Err", "请上传证件(size>0)"));
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
                string newFileName4 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(6999, 8998).ToString() + fileExt4;

                try
                {
                    file4.SaveAs(path + "/" + newFileName4);
                    dbPathName5 = dirPath + "/" + newFileName4;
                }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", ex.Message));
                    Response.End();
                }

                #endregion 保存文件


                #endregion 上传文件

            }

            UserAuth entity; ;
            if (IsValidState)
            {
                entity = authInfo;
                entity.UpdateDate = DateTime.Now;
                entity.AuthType = authType;
            }
            else
            {
                entity = new UserAuth()
                {
                    CreateDate = DateTime.Now,
                    UpdateDate = DateTime.Now,
                    UserId = TUser.UserId,
                    ValidMsg = "",
                    AuthType = authType
                };
            }
            entity.ValidState = (int)AuthValidState.待认证;
            if (authType == (int)AuthType.企业开发者)
            {
                entity.AuthCName = cname;
                entity.AuthCAddr = caddr;
                entity.AuthCType = Common.ToInt(ctype);
                if (Convert.ToInt32(ctype) == (int)AuthCType.普通证件)
                {
                    if (!string.IsNullOrEmpty(dbPathName1)) entity.AuthCFileZ = dbPathName1;
                    if (!string.IsNullOrEmpty(dbPathName2)) entity.AuthCFileS = dbPathName2;
                    if (!string.IsNullOrEmpty(dbPathName3)) entity.AuthCFileY = dbPathName3;
                }
                else if (Convert.ToInt32(ctype) == (int)AuthCType.三证合一)
                {
                    if (!string.IsNullOrEmpty(dbPathName1)) entity.AuthCFile3in1 = dbPathName1;
                }
                entity.AuthCLegalPeo = clegalpeo;
                entity.AuthCPhone = cphone;
                entity.AuthCPeoName = cpeoname;
                if (!string.IsNullOrEmpty(dbPathName4)) entity.AuthCPeoPic = dbPathName4;
            }
            if (authType == (int)AuthType.个人开发者)
            {
                entity.AuthPName = pname;
                entity.AuthPType = Common.ToInt(ptype);
                entity.AuthPFileNum = pfilenum;
                if (!string.IsNullOrEmpty(dbPathName5)) entity.AuthPFile = dbPathName5;
            }
            if (IsValidState)
            {
                SiteUserAuth.Update(entity);
            }
            else
            {
                SiteUserAuth.Add(entity);
                UserInfo usr = SiteUser.GetUserInfo(TUser.UserId);
                string emailTitle = "用户: " + usr.Phone + "申请账户认证!";
                string emailContent = "用户" + usr.Phone + "申请账户认证.<br/>开发者账号: " + usr.Email + "<br/>公司名称为: " + entity.AuthCName + "<br/>公司地址为: " + entity.AuthCAddr + "<br/>法定代表人: " +
                    entity.AuthCLegalPeo + "<br/>公司电话: " + entity.AuthCPhone;
                EmailHp.SendEmail("1935388026@qq.com", emailTitle, emailContent);

            }
            Response.Write(Common.Json("OK", "提交成功"));
            Response.End();
        }

    }
}