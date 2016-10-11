using System;
using System.Collections.Generic;
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
    public partial class AdminList : CmsBase
    {
        protected List<Role> RoleList = new List<Role>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("QXGL"))
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
                        AddAdmin();
                        break;
                    case "2"://edit
                        Update();
                        break;
                    case "3"://del
                        Delete();
                        break;
                    case "4"://toggle
                        ToggleState();
                        break;
                    case "5"://reset
                        ResetPwd();
                        break;
                    default:
                        //BindData();//有UpdatePanel的OnLoad方法时不需要这个，会重复执行
                        RoleList = SiteRole.GetRoleList().Where(w => w.RoleCode != "SUPER_ADMIN").ToList();
                        RoleList.Insert(0, new Role { RoleName = "", RoleCode = "0" });
                        break;
                }
            }
        }

        private void AddAdmin()
        {
            Response.ContentType = "application/json";

            if (string.IsNullOrWhiteSpace(Request["userName"]) || string.IsNullOrWhiteSpace(Request["pwd"]) || string.IsNullOrWhiteSpace(Request["role"]))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            if (SiteAdmin.CheckName(Request["userName"]))
            {
                Response.Write(Common.Json("Err", "用户名已经存在，请重试"));
                Response.End();
            }

            View_AdminInfo entity = new View_AdminInfo();
            entity.UserId = Guid.NewGuid();
            entity.AccountCode = DateTime.Now.ToString("yyyyMMddhhmmss");
            entity.Avatar = "";
            entity.UserName = Request["userName"];
            entity.RealName = Request["realName"];
            entity.UserPwd = Common.MD5(Request["pwd"]);//md5
            entity.Phone = Request["phone"];
            entity.Email = Request["email"];
            entity.Remark = Request["remark"];
            entity.RegDate = DateTime.Now;
            entity.UpdateDate = DateTime.Now;
            entity.Enabled = true;
            entity.IsDeleted = false;
            entity.Sort = 0;
            entity.Language = "zh-CN";
            entity.RoleCode = Request["role"];

            bool result = SiteAdmin.AddAdminInfo(entity);
            if (result)
            {
                Response.Write(Common.Json("OK", "添加帐号成功"));
            }
            else if (!result)
            {
                Response.Write(Common.Json("Err", "用户名已经存在，请重试"));
            }

            Response.End();
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
            var entity = SiteAdmin.GetAdminView(guid);
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            if (guid != Admin.UserId)
            {
                entity.RoleCode = Request["rolecode"];
                SiteAdmin.UpdateAdminRole(entity);
                Response.Write(Common.Json("OK", "帐号 " + entity.UserName + " 角色更改成功，即时生效"));
            }
            else
            {
                Response.Write(Common.Json("Err", "您不能修改自己的角色"));
            }
            Response.End();
        }

        private void Delete()
        {
            Response.ContentType = "application/json";

            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            if (guid != Admin.UserId)
            {
                SiteAdmin.DeleteAdminInfo(guid);//TODO 删除用户头像？
                Response.Write(Common.Json("OK", "删除成功"));
            }
            else
            {
                Response.Write(Common.Json("Err", "您不能删除自己"));
            }
            Response.End();
        }

        private void ToggleState()
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

            if (guid != Admin.UserId)
            {
                entity.Enabled = Convert.ToBoolean(Request["checked"]);
                SiteAdmin.UpdateAdminInfo(entity);
                Response.Write(Common.Json("OK", "帐号 " + entity.UserName + (entity.Enabled ? " 已 <b>启用</b>" : " 已 <b>禁用</b>") + "，下次登陆时生效"));
            }
            else
            {
                Response.Write(Common.Json("Err", "您不能修改自己的状态"));
            }
            Response.End();
        }

        private void ResetPwd()
        {
            Response.ContentType = "application/json";

            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            if (guid != Admin.UserId)
            {
                SiteAdmin.ResetPwd(guid);
                Response.Write(Common.Json("OK", "密码重置成功，重置后密码为：<br/><b class='middle label label-yellow'>" + Common.AppSettings["ResetPwd"] + "</b>"));
            }
            else
            {
                Response.Write(Common.Json("Err", "您不能重置自己的密码"));
            }
            Response.End();
        }

        //绑定数据
        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            List<View_AdminInfo> list = SiteAdmin.GetAllAdminViewList(ref pp);

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


        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Repeater rep = e.Item.FindControl("Repeater2") as Repeater;
            if (rep != null)
            {
                rep.DataSource = SiteRole.GetRoleList().Where(w => w.RoleCode != "SUPER_ADMIN").ToList();
                rep.DataBind();
            }
        }
    }
}