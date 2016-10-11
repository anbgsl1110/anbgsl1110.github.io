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
    public partial class PrivList : System.Web.UI.Page
    {
        protected List<View_ModPrivilege> ModPrivList = null;

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
                        Add();
                        break;
                    case "2"://edit
                        Update();
                        break;
                    case "3"://del
                        Delete();
                        break;
                    case "4"://enabled
                        ToggleState();
                        break;
                    case "5":
                        PrivJson();
                        break;
                    default:
                        //BindData();
                        ModPrivList = SiteRole.GetModPriv().Where(w => w.ModuleCode != "QXGL").ToList();
                        break;
                }


            }
        }



        private void Add()
        {
            Response.ContentType = "application/json";

            if (string.IsNullOrEmpty(Request["rolename"]))
            {
                Response.Write(Common.SmartMsg("参数错误"));
                Response.End();
            }

            if (SiteRole.CheckRoleName(Request["rolename"]))
            {
                Response.Write(Common.Json("Err", "角色名称已存在，请重新选择"));
                Response.End();
            }

            Role entity = new Role();
            entity.RoleCode = DateTime.Now.ToString("yyyyMMddhhmmss") + new Random().Next(100, 999);
            entity.RoleName = Request["rolename"];
            entity.CreateDate = DateTime.Now;
            entity.UpdateDate = DateTime.Now;
            entity.IsDeleted = false;
            entity.Enabled = true;
            entity.Sort = 0;

            SiteRole.AddRole(entity);

            Response.Write(Common.Json("OK", "角色添加成功"));
            Response.End();
        }

        private void Update()
        {
            Response.ContentType = "application/json";

            if (string.IsNullOrWhiteSpace(Request["hidRoleId"]))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            long roleId = Common.ToLong(Request["hidRoleId"]);

            //删除所有相关权限
            SiteRole.DeleteAllRolePriv(roleId);

            if (Request["CkModPrivId"] != null)
            {
                List<string> IdList = Request["CkModPrivId"].Split(',').ToList();

                List<RolePrivilege> rplist = new List<RolePrivilege>();
                foreach (string id in IdList)
                {
                    RolePrivilege rp = new RolePrivilege();
                    rp.RoleId = roleId;
                    rp.ModPrivId = Convert.ToInt64(id);
                    rplist.Add(rp);
                }

                SiteRole.InsertRolePriv(rplist);
            }
            Response.Write(Common.Json("OK", "权限保存成功，即时生效"));
            Response.End();
        }

        private void Delete()
        {
            Response.ContentType = "application/json";

            long id = Common.ToLong(Request["id"]);
            if (id == 0)
            {
                Response.Write(Common.SmartMsg("参数错误"));
                Response.End();
            }

            if (!SiteRole.CheckRoleNoAccount(id))
            {
                Response.Write(Common.Json("Err", "当前角色拥有用户，请先删除此角色下所有用户再来删除角色"));
                Response.End();
            }

            SiteRole.DeleteRole(id);

            Response.Write(Common.Json("OK", "角色删除成功"));
            Response.End();
        }

        private void ToggleState()
        {
            Response.ContentType = "application/json";

            var entity = SiteRole.GetRoleInfo(Common.ToLong(Request["id"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            if (entity.RoleCode != "SUPER_ADMIN")
            {
                entity.Enabled = Convert.ToBoolean(Request["checked"]);
                SiteRole.ToggleRole(entity);
                Response.Write(Common.Json("OK", "角色 " + entity.RoleName + (entity.Enabled ? " 已 <b>启用</b>" : " 已 <b>禁用</b>") + "，即时生效"));
            }
            else
            {
                Response.Write(Common.Json("Err", "您不能修改<b>总管理员</b>的状态"));
            }
            Response.End();
        }

        private void PrivJson()
        {
            Response.ContentType = "application/json";
            string jsonArr = SiteRole.GetRolePrivJson(Common.ToLong(Request["id"]));
            Response.Write(jsonArr);
            Response.End();
        }

        //绑定数据
        private void BindData()
        {
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            List<Role> list = SiteRole.GetRoleList(ref pp);

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