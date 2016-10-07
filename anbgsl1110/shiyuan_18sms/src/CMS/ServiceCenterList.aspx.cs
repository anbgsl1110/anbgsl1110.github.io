using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OctoLib;
using Weetop.BLL;
using Weetop.DAL;
using Weetop.Model;
using Weetop.Web.member;
using Wuqi.Webdiyer;
using System.Text.RegularExpressions;

namespace Weetop.Web.CMS
{
    public partial class ServiceCenterList : CmsBase
    {
        protected long CategoryID = 0;
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

        public List<ModulePrivilege> list = new List<ModulePrivilege>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("ZXFWGL"))
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
                        //Add();
                        break;
                    case "2":
                        UpLoadImg();
                        break;
                    case "3"://del
                        Delete();
                        break;
                    case "4":
                        Toggle();
                        break;
                    case "5":
                        GetJson();
                        break;
                    case "6":
                        modifyImg();
                        break;
                    case "7":
                        UpdateConsultingService();
                        break;
                    default:
                        GetModulePrivilegeByRoleId();

                        Dictionary<int, string> dic2 = new Dictionary<int, string>();
                        dic2.Add(-1, "");//chosen 留空
                        dic2.Add(0, "查看全部");
                        dic2.Add(1, "客服");
                        dic2.Add(2, "商务");
                        dic2.Add(3, "运维");


                        ddlOrderStatus.DataSource = dic2;
                        ddlOrderStatus.DataTextField = "Value";
                        ddlOrderStatus.DataValueField = "Key";
                        ddlOrderStatus.DataBind();
                        break;
                }

            }
        }

        //把修改后的服务人员信息同步到数据库
        private void UpdateConsultingService()
        {
            Response.ContentType = "application/json";

            Model.ConsultingService entity = SiteConsultingService.GetOne(Int32.Parse(Request["Id"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            entity.id = Int32.Parse(Request["Id"]);
            entity.cateId = Int32.Parse(Request["cateid"]);
            //验证格式字符串
            string nameParttern = @"^(([\u4e00-\u9fa5]{2,8})|([a-zA-Z]{2,16}))$";
            string phoneParttern = @"^[0-9]{11}$";
            string weChatParttern = @"^[a-zA-Z0-9-_]{2,16}$";
            string QQParttern = @"^[0-9]{5,15}$";
            string emailParttern = @"^([a-zA-Z0-9])+@([a-zA-Z0-9_-])+(\.)([a-zA-Z0-9_-])+$";
            //对输入姓名格式做验证
            if (!(Regex.IsMatch(Request["Name"], nameParttern)))
            {
                Response.Write(Common.Json("Err", "输入姓名格式有误，请输入中文或者英文名"));
                Response.End();
            }
            //对输入手机号格式做验证
            if (!(Regex.IsMatch(Request["Phone"], phoneParttern)))
            {
                Response.Write(Common.Json("Err", "输入手机号格式有误，请输入11位三网手机号码"));
                Response.End();
            }
            //对输入微信格式做验证
            if (!(Regex.IsMatch(Request["WeChat"], weChatParttern)))
            {
                Response.Write(Common.Json("Err", "输入微信格式有误，请输入格式正确的微信号"));
                Response.End();
            }
            //对输入QQ格式做验证
            if (!(Regex.IsMatch(Request["QQNumber"], QQParttern)))
            {
                Response.Write(Common.Json("Err", "输入QQ格式有误，请输入格式正确的QQ号码"));
                Response.End();
            }
            //对输入邮箱格式做验证
            if (!(Regex.IsMatch(Request["mailBox"], emailParttern)))
            {
                Response.Write(Common.Json("Err", "输入邮箱格式有误,请输入格式正确的邮箱名称"));
                Response.End();
            }
            entity.Name = Request["Name"];
            entity.Phone = Request["Phone"];
            entity.WeChat = Request["WeChat"];
            entity.QQNumber = Request["QQNumber"];
            entity.mailBox = Request["mailBox"];

            SiteConsultingService.UpdateEntity(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }

        //删除服务人员信息
        private void Delete()
        {
            Response.ContentType = "application/json";

            int tid = Convert.ToInt32(Request["id"]);
            SiteConsultingService.Delete(tid);
            Response.Write(Common.Json("OK", "删除成功"));
            Response.End();
        }

        private void GetModulePrivilegeByRoleId()
        {
            if (Admin != null)
            {
                Role rInfo = SiteRole.GetRoleByAccountCode(Admin.AccountCode);
                List<ModulePrivilege> list2 = SiteModulePrivilege.GetListModulePrivilege("ZXFWGL");
                list.Clear();
                foreach (var item in list2)
                {
                    if (SiteRole.CheckRolePriv(rInfo.RoleId, item.ModPrivId))
                    {
                        list.Add(item);
                    }
                }
            }
        }

        //上传图片
        private void UpLoadImg()
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

                try { file.SaveAs(path + "/" + newFileName); }
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

        //获取选中id对应SiteConsultingService对象
        private void GetJson()
        {
            Response.ContentType = "application/json";


            var item = SiteConsultingService.GetOne(Common.ToInt(Request["id"]));

            if (item == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var temp = new
            {
                content = item.ImgUrl,
                name = item.Name,
            };

            Response.Write(Common.Json("OK", "操作成功", temp));
            Response.End();
        }

        //修改人员图片
        private void modifyImg()
        {
            Response.ContentType = "application/json";

            Model.ConsultingService entity = SiteConsultingService.GetOne(Int32.Parse(Request["hidRoleId"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            //判断是否有上传头像
            if (!("true".Equals(Request["isImgUrl"])))
            {
                Response.Write(Common.Json("Err", "未上传人员图片"));
                Response.End();
            }

            entity.ImgUrl = Session["dbPathName"].ToString();
            SiteConsultingService.UpdateEntity(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }

        //修改分类信息
        private void Toggle()
        {
            Response.ContentType = "application/json";

            var id = Request["id"];
            if (string.IsNullOrEmpty(id))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            var entity = SiteConsultingService.GetOne(Common.ToInt(Request["id"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            if ("1".Equals(Request["rolecode"]))
            {
                entity.cateId = Common.ToInt(Request["rolecode"]);
                entity.CategroyName = "客服";
                SiteConsultingService.UpdateEntity(entity);
                Response.Write(Common.Json("OK", "分类修改成功"));
                Response.End();
            }
            if ("2".Equals(Request["rolecode"]))
            {
                entity.cateId = Common.ToInt(Request["rolecode"]);
                entity.CategroyName = "商务";
                SiteConsultingService.UpdateEntity(entity);
                Response.Write(Common.Json("OK", "分类修改成功"));
                Response.End();
            }
            if ("3".Equals(Request["rolecode"]))
            {
                entity.cateId = Common.ToInt(Request["rolecode"]);
                entity.CategroyName = "运维";
                SiteConsultingService.UpdateEntity(entity);
                Response.Write(Common.Json("OK", "分类修改成功"));
                Response.End();
            }
            else
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
        }

        //绑定数据
        private void BindData()
        {
            GetModulePrivilegeByRoleId();
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex, 9);

            int servicePersonType;
            switch (ddlOrderStatus.SelectedValue)
            {
                case "-1"://查看全部
                    servicePersonType = -1;
                    break;
                case "1"://客服
                    servicePersonType = 1;
                    break;
                case "2"://商务
                    servicePersonType = 2;
                    break;
                case "3"://运维
                    servicePersonType = 3;
                    break;
                default:
                    servicePersonType = -1;
                    break;
            }
            string searchText = txtSearch.Value.Trim();

            //SiteConsultingService.GetList();
            var list = SiteConsultingService.GetList(ref pp, servicePersonType, searchText);
            //转变分类ID方便前端呈现
            //foreach (var item in list)
            //{
            //    if (item.cateId == 1)
            //    {
            //        item.CategroyName = "客服";
            //    }
            //    if (item.cateId == 2)
            //    {
            //        item.CategroyName = "商务";
            //    }
            //    if (item.cateId == 3)
            //    {
            //        item.CategroyName = "运维";
            //    }
            //}
            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;

            Repeater1.DataSource = list;
            Repeater1.DataBind();
        }

        protected void AspNetPager1_PageChanging(object src, PageChangingEventArgs e)
        {
            //第三执行
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            BindData();
        }

        //可用于前端JS调用PostBack时执行
        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            //不管是不是PostBack都会执行，第二执行
            BindData();
        }

        protected void Repeater1_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Repeater rep = e.Item.FindControl("Repeater2") as Repeater;
            if (rep != null)
            {
                var dic2 = new Dictionary<int, string>();
                dic2.Add((int)ServicePersonType.客服, ServicePersonType.客服.ToString());
                dic2.Add((int)ServicePersonType.商务, ServicePersonType.商务.ToString());
                dic2.Add((int)ServicePersonType.运维, ServicePersonType.运维.ToString());
                rep.DataSource = dic2;
                rep.DataBind();
            }
        }
    }
}