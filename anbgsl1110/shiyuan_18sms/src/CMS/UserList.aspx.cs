using Newtonsoft.Json.Linq;
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
    public partial class UserList : CmsBase
    {
        public List<ModulePrivilege> list = new List<ModulePrivilege>();
        protected View_AdminInfo VAdmin = null;//包含角色信息
        public bool isState = false;
        protected List<View_AdminInfo> VAdminList = new List<View_AdminInfo>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("HYGL"))
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
                            //Edit();
                            break;
                        case "3"://del
                            Delete();
                            break;
                        case "4"://toggle
                            Toggle();
                            break;
                        case "5":
                            GetUserJson();
                            break;
                        case "6":
                            //GetOwner();
                            break;
                        case "7":
                            //Valid();
                            break;
                        default:
                            VAdmin = SiteAdmin.GetAdminView(Admin.UserId);
                            GetModulePrivilegeByRoleId();
                            //VAdminList = SiteAdmin.GetAllAdminViewList();
                            //VAdminList.Insert(0, new View_AdminInfo { RealName = "", UserId = Guid.Empty });
                            //ddlAdminList.DataSource = VAdminList;
                            //ddlAdminList.DataTextField = "RealName";
                            //ddlAdminList.DataValueField = "UserId";
                            //ddlAdminList.DataBind();

                            var entity = SiteUserAuth.GetOne(Admin.UserId);
                            if (entity != null && entity.ValidState != null)
                                {
                                    string ValidState = Enum.GetName(typeof(AuthValidState), entity.ValidState);
                                    if (ValidState == "待认证" || ValidState == "已认证")
                                        {
                                            isState = true;
                                        }
                                    else
                                        {
                                            isState = false;
                                        }
                                }
                            Dictionary<int, string> dic = new Dictionary<int, string>();
                            dic.Add(-1, "");//chosen 留空
                            dic.Add((int)AuthValidState.未认证, AuthValidState.未认证.ToString());
                            dic.Add((int)AuthValidState.待认证, AuthValidState.待认证.ToString());
                            dic.Add((int)AuthValidState.已认证, AuthValidState.已认证.ToString());
                            dic.Add((int)AuthValidState.认证失败, AuthValidState.认证失败.ToString());
                            ddlCheckStatus.DataSource = dic;
                            ddlCheckStatus.DataTextField = "Value";
                            ddlCheckStatus.DataValueField = "Key";
                            ddlCheckStatus.DataBind();
                            //BindData();//有UpdatePanel的OnLoad方法时不需要这个，会重复执行
                            break;
                        }
                }
            else
                {
                    //PostBack时会执行，第一执行
                    //string title = Page.Title;
                }
        }
        
        private void GetModulePrivilegeByRoleId()
        {
            if (Admin != null)
                {
                    Role rInfo = SiteRole.GetRoleByAccountCode(Admin.AccountCode);
                    List<ModulePrivilege> list2 = SiteModulePrivilege.GetListModulePrivilege("HYGL");
                    list.Clear();
                    foreach (var item in list2)
                        {
                            if (SiteRole.CheckRolePriv(rInfo.RoleId, item.ModPrivId))
                                {
                                    if (item.PrivilegeCode == "XG")
                                        {
                                            isState = true;
                                        }
                                    list.Add(item);
                                }
                        }
                }
        }
        
        /// <summary>
        /// 认证信息链接
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="page"></param>
        /// <returns></returns>
        protected string GetLink(Guid uid, int page)
        {
            var entity = SiteUserAuth.GetOne(uid);
            if (entity != null && entity.ValidState != null)
                {
                    if (Admin != null)
                        {
                            Role rInfo = SiteRole.GetRoleByAccountCode(Admin.AccountCode);
                            List<ModulePrivilege> list2 = SiteModulePrivilege.GetListModulePrivilege("HYGL");
                            string ValidState = Enum.GetName(typeof(AuthValidState), entity.ValidState);
                            foreach (var item in list2)
                                {
                                    if (item.PrivilegeCode == "XG")
                                        {
                                            if (SiteRole.CheckRolePriv(rInfo.RoleId, item.ModPrivId))
                                                {
                                                    return "<a title='{标注：" + entity.ValidMsg + "}' href=AuthDetail.aspx?uid=" + uid + "&page=" + page + ">" + ValidState + "</a>";
                                                }
                                        }
                                }
                            return ValidState;
                        }
                }
            return AuthValidState.未认证.ToString();
        }
        #region AJAX

        private void Add()
        {
            Response.ContentType = "application/json";

            if (string.IsNullOrWhiteSpace(Request["userName"]) || string.IsNullOrWhiteSpace(Request["pwd"]))
                {
                    Response.Write(Common.Json("Err", "参数错误"));
                    Response.End();
                }
            string userName = Request["userName"].Trim();
            if (SiteUser.CheckLoginName(userName))
                {
                    Response.Write(Common.Json("Err", "登陆帐户已经存在，请重试"));
                    Response.End();
                }
            var entity = new UserInfo
                {
                    UserId = Guid.NewGuid(),
                        Avatar = "",
                        NickName = userName,
                        RealName = Request["realName"],
                        Pwd = Common.MD5(Request["pwd"]),
                        CompanyName = Request["cmpName"],
                        CompanyAddr = Request["cmpAddr"],
                        CompanyMobile = Request["cmpPhone"],
                        Phone = Request["phone"],
                        QQ = Request["qq"],
                        Email = Request["email"],
                        CreateDate = DateTime.Now,
                        UpdateDate = DateTime.Now,
                        Enabled = true//因为不为null，故必须明确写为true，不然实体默认为false
                        };
            SiteUser.AddUserInfo(entity);
            Response.Write(Common.Json("OK", "添加成功"));
            Response.End();
        }

        private void Edit()
        {
            Response.ContentType = "application/json";

            if (string.IsNullOrWhiteSpace(Request["hidUserId3"]))
                {
                    Response.Write(Common.Json("Err", "参数错误"));
                    Response.End();
                }

            Guid guid;
            if (!Guid.TryParse(Request["hidUserId3"], out guid))
                {
                    Response.Write(Common.Json("Err", "参数错误"));
                    Response.End();
                }
            UserInfo entity = SiteUser.GetUserInfo(guid);
            entity.RealName = Request["realName"];
            if (!string.IsNullOrWhiteSpace(Request["pwd"]))
                entity.Pwd = Common.MD5(Request["pwd"]);
            entity.CompanyName = Request["cmpName"];
            entity.CompanyAddr = Request["cmpAddr"];
            entity.CompanyMobile = Request["cmpPhone"];
            entity.Phone = Request["phone"];
            entity.QQ = Request["qq"];
            entity.Email = Request["email"];
            entity.UpdateDate = DateTime.Now;
            SiteUser.UpdateUserInfo(entity);
            Response.Write(Common.Json("OK", "修改成功"));
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
            SiteUser.DeleteUserInfo(guid);
            Response.Write(Common.Json("OK", "删除成功"));
            Response.End();
        }

        private void Toggle()
        {
            Response.ContentType = "application/json";
            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
                {
                    Response.Write(Common.Json("Err", "参数错误"));
                    Response.End();
                }
            var entity = SiteUser.GetUserInfo(guid);
            if (entity == null)
                {
                    Response.Write(Common.Json("Err", "参数错误"));
                    Response.End();
                }

            entity.Enabled = Convert.ToBoolean(Request["checked"]);
            SiteUser.UpdateUserInfo(entity);
            Response.Write(Common.Json("OK", "帐号" + (entity.Enabled ? "已 <b>启用</b>" : "已 <b>禁用</b>") + "，下次登陆时生效"));
            Response.End();
        }

        private void GetUserJson()
        {
            Response.ContentType = "application/json";
            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
                {
                    Response.Write(Common.Json("Err", "参数错误"));
                    Response.End();
                }
            JObject jo = JObject.FromObject(new
                {
                    code = "OK",
                        user = SiteUser.GetUserInfo(guid)
                        });
            Response.Write(jo.ToString());
            Response.End();
        }

        private void GetOwner()
        {
            if (Request["id"] == "")
                {
                    Response.Write("");
                    Response.End();
                }
            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
                {
                    Response.Write("");
                    Response.End();
                }
            Response.Write(SiteAdmin.GetAdminName(guid));
            Response.End();
        }

        private void Valid()
        {
            //Response.ContentType = "application/json";

            //Guid guid;
            //if (!Guid.TryParse(Request["id"], out guid))
            //{
            //    Response.Write(Common.Json("Err", "参数错误"));
            //    Response.End();
            //}
            //var entity = SiteUser.GetUserInfo(guid);
            //if (entity == null)
            //{
            //    Response.Write(Common.Json("Err", "参数错误"));
            //    Response.End();
            //}

            //entity.InfoValid = Convert.ToBoolean(Request["checked"]);
            //SiteUser.UpdateUserInfo(entity);
            //Response.Write(Common.Json("OK", "帐号" + (entity.InfoValid ? " <b>已认证</b>" : " <b>未认证</b>") + ""));
            //Response.End();
        }
        #endregion AJAX

        private void BindData()
        {
            //从url加载参数，方便从详情页跳回列表
            var pg = Common.ToInt(Request["page"]);
            if (pg != 0) AspNetPager1.CurrentPageIndex = pg;
            //TODO 添加查询条件参数，不然会有bug
            GetModulePrivilegeByRoleId();
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);
            int cType = Common.ToInt(ddlCheckStatus.SelectedValue);
            string searchText = txtSearch.Value.Trim();
            string timeRange = txtDateRange.Value.Trim();
            //string aSaler = ddlAdminList.SelectedValue;
            List<UserInfo> list = SiteUser.GetAllUserInfoList(ref pp, cType, searchText, timeRange);
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

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            //第三执行
        }
    }
}
