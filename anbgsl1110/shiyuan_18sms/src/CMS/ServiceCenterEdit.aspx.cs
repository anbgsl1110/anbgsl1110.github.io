using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web.CMS
{
    public partial class ServiceCenterEdit : CmsBase
    {
        protected long CategoryID = 0;
        protected string servicePersonType = "";
        protected string servicePersonImgUrl;
        protected string MenuId
        {
            get
            {
                string menu = "menu";
                switch (CategoryID)
                {
                    case 5:
                        return menu + "75";
                    default:
                        return "errid";
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string catid = Request["catid"];
            Dictionary<int, string> dic2 = new Dictionary<int, string>();
            dic2.Add(1, "客服");
            dic2.Add(2, "商务");
            dic2.Add(3, "运维");
            //ddlOrderStatus.DataSource = dic2;
            //ddlOrderStatus.DataTextField = "Value";
            //ddlOrderStatus.DataValueField = "Key";
            //ddlOrderStatus.DataBind();

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

                CategoryID = Common.ToLong(Request["catid"]);

                Page.Title = SiteCategory.GetNameById(CategoryID);

                if (IsPostBack)
                    Page.Title += " - 网站后台管理系统";
            }

            if (!IsPostBack)
            {
                int ContentId = Common.ToInt(Request["conid"]);
                hidId.Value = ContentId.ToString();   
                string ac = Request["action"];
                switch (ac)
                {
                    case "1":
                        AddOrSave();
                        break;
                    case "2":
                        ddlOrderStatus_SelectedIndexChanged();
                        break;
                    case "3":
                        UploadImg();
                        break;
                    default:
                        break;
                }
            }
            else
            {
                AddOrSave();
            }
        }

        /// <summary>
        /// 上传图片
        /// </summary>
        private void UploadImg()
        {
            #region 上传图片
            HttpPostedFile file = Request.Files["file"];
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
                string path = HttpContext.Current.Server.MapPath("~/" + baseConsultingServiceImagePath + dirPath);
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

                try { file.SaveAs(path + "/" + newFileName);}
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", ex.Message));
                    Response.End();
                }

                //保存信息
                string imgfile = Server.MapPath("~/" + baseConsultingServiceImagePath + dbPathName);
                //await Task.Factory.StartNew(() => {
                //if (File.Exists(imgfile)) File.Delete(imgfile);
                //});
                Session["dbPathName"] = baseConsultingServiceImagePath + dirPath + "/" + newFileName;

                Response.Write(Common.Json("OK", baseConsultingServiceImagePath + dirPath + "/" + newFileName));
                Response.End();
            }
            #endregion 上传图片
        }
        
        /// <summary>
        /// 保存服务人员信息到数据库
        /// </summary>
        protected void AddOrSave()
        {
            Response.ContentType = "application/json";

            string CategoryID = hidCateId.Value;
            string ContentId = hidId.Value;

            //验证格式字符串
            string nameParttern = @"^(([\u4e00-\u9fa5]{2,8})|([a-zA-Z]{2,16}))$";
            string phoneParttern = @"^[0-9]{11}$";
            string weChatParttern = @"^[a-zA-Z0-9-_]{2,16}$";
            string QQParttern = @"^[0-9]{5,15}$";
            string emailParttern = @"^([a-zA-Z0-9])+@([a-zA-Z0-9_-])+(\.)([a-zA-Z0-9_-])+$";
            //对输入姓名格式做验证
            if (!(Regex.IsMatch(txtName.Value, nameParttern)))
            {
                Response.Write(Common.Json("Err", "输入姓名格式有误，请输入中文或者英文名"));
                Response.End();
            }
            //对输入手机号格式做验证
            if (!(Regex.IsMatch(txtPhone.Value, phoneParttern)))
            {
                Response.Write(Common.Json("Err", "输入手机号格式有误，请输入11位三网手机号码"));
                Response.End();
            }
            //对输入微信格式做验证
            if (!(Regex.IsMatch(txtWeChat.Value, weChatParttern)))
            {
                Response.Write(Common.Json("Err", "输入微信格式有误，请输入格式正确的微信号"));
                Response.End();
            }
            //对输入QQ格式做验证
            if (!(Regex.IsMatch(txtQQNumber.Value, QQParttern)))
            {
                Response.Write(Common.Json("Err", "输入QQ格式有误，请输入格式正确的QQ号码"));
                Response.End();
            }
            //对输入邮箱格式做验证
            if (!(Regex.IsMatch(txtEmail.Value, emailParttern)))
            {
                Response.Write(Common.Json("Err", "输入邮箱格式有误,请输入格式正确的邮箱名称"));
                Response.End();
            }

            if (!string.IsNullOrWhiteSpace(ContentId))
            {
                //添加
                int cateIdTemp = 1;
                if ((!"".Equals(Request["ServiceType"])) || string.IsNullOrWhiteSpace(Request["ServiceType"]))
                {
                    if (Request["ServiceType"].Equals("客服"))
                    {
                        cateIdTemp = 1;
                    }
                    if (Request["ServiceType"].Equals("商务"))
                    {
                        cateIdTemp = 2;
                    }
                    if (Request["ServiceType"].Equals("运维"))
                    {
                        cateIdTemp = 3;
                    }
                }

                //判断是否有上传头像
                if ("true".Equals(Request["isImgUrl"]))
                {
                    servicePersonImgUrl = Session["dbPathName"].ToString();
                }
                else
                {
                    servicePersonImgUrl = "";
                }
                //string servicePersonImgUrl = HidImgUrl.Value;
                //string servicePersonImgUrl = imgUrl;
                Model.ConsultingService entity = new Model.ConsultingService()
                {
                    Name = txtName.Value,
                    Phone = txtPhone.Value,
                    WeChat = txtWeChat.Value,
                    QQNumber = txtQQNumber.Value,
                    mailBox = txtEmail.Value,                   
                    cateId = cateIdTemp,
                    ImgUrl = servicePersonImgUrl,
                    CategroyName = Request["ServiceType"],
                };
                SiteConsultingService.Add(entity);
                //插入日志
                //Model.Log log = new Model.Log()
                //{
                //    UserName = Admin.UserName,
                //    RealName = Admin.RealName,
                //    ClientIP = SiteLog.GetClientIP(),
                //    ClientMAC = SiteLog.GetClientMAC(),
                //    ModuletId = int.Parse(""),
                //    ModuleName = "咨询服务管理",
                //    ModuleObject = "咨询服务管理",
                //    Action = "添加",
                //    ActionTime = DateTime.Now,
                //};
                //SiteLog.Add(log);

                Response.Write(Common.Json("OK", "添加成功"));
                Response.End();
            }
            else
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
        }

        protected void ddlOrderStatus_SelectedIndexChanged()
        {
            servicePersonType = Request["ServiceType"];
        }

    }
}