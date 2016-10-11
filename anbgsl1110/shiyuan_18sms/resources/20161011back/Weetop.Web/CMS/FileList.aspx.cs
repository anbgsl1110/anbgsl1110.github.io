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
    public partial class FileList : CmsBase
    {
        public List<ModulePrivilege> list = new List<ModulePrivilege>();
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
            string catid = "1";//Request["catid"];
            if (string.IsNullOrWhiteSpace(catid))
            {
                Response.Write(Common.SmartMsg("无效参数"));
                Response.End();
            }
            else
            {
                //文档管理权限
                if (!BLL.PrivManager.HasPrivFWForModule("WDGL"))
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
                GetModulePrivilegeByRoleId();
                if (IsPostBack)
                    Page.Title += " - 网站后台管理系统";
            }

            if (!IsPostBack)
            {
                string ac = Request["action"];
                switch (ac)
                {
                    case "3"://del
                        Delete();
                        break;
                    default:
                        //BindData();
                        break;
                }

            }
        }


        private void GetModulePrivilegeByRoleId()
        {
            if (Admin != null)
            {
                Role rInfo = SiteRole.GetRoleByAccountCode(Admin.AccountCode);
                List<ModulePrivilege> list2 = SiteModulePrivilege.GetListModulePrivilege("WDGL");
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


        public void Delete()
        {
            Response.ContentType = "application/json";

            if (!string.IsNullOrWhiteSpace(Request["conid"]))
            {
                SiteDevDoc.Delete(Common.ToInt(Request["conid"]));
                Response.Write(Common.Json("OK", "删除成功"));
            }
            else
            {
                Response.Write(Common.Json("Err", "无效参数"));
            }
            Response.End();
        }



        private void BindData()
        {
            GetModulePrivilegeByRoleId();
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            List<Model.DevDoc> list = SiteDevDoc.GetList(Common.ToInt(hidCateId.Value), ref pp);

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


        protected void UpdatePanel1_OnLoad(object sender, EventArgs e)
        {
            BindData();
        }
    }
}