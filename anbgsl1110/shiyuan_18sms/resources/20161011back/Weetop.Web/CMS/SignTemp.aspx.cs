using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json.Linq;
using Weetop.DAL;
using Weetop.Model;
using Wuqi.Webdiyer;

namespace Weetop.Web.CMS
{
    public partial class SignTemp : CmsBase
    {
        public List<ModulePrivilege> list = new List<ModulePrivilege>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("QMMBGL"))
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
                        Update();
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
                    default:
                        GetModulePrivilegeByRoleId();

                        Dictionary<int, string> dic2 = new Dictionary<int, string>();
                        dic2.Add(-1, "");//chosen 留空
                        dic2.Add((int)TempCheckStatus.等待审核, TempCheckStatus.等待审核.ToString());
                        dic2.Add((int)TempCheckStatus.通过审核, TempCheckStatus.通过审核.ToString());
                        dic2.Add((int)TempCheckStatus.驳回审核, TempCheckStatus.驳回审核.ToString());
                        ddlOrderStatus.DataSource = dic2;
                        ddlOrderStatus.DataTextField = "Value";
                        ddlOrderStatus.DataValueField = "Key";
                        ddlOrderStatus.DataBind();
                        break;
                }

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
                        list.Add(item);
                    }
                }
            }
        }

        private void Update()
        {
            Response.ContentType = "application/json";

            var entity = SiteSignTemp.GetOne(Common.ToLong(Request["hidRoleId"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            entity.Feedback = Request["remark"];
            SiteSignTemp.Update(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }




        private void Delete()
        {
            Response.ContentType = "application/json";

            var tid = Common.ToLong(Request["id"]);
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



        private void Toggle()
        {
            Response.ContentType = "application/json";

            var id = Request["id"];
            if (string.IsNullOrEmpty(id))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            var entity = SiteSignTemp.GetOne(Common.ToLong(id));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            entity.CheckStatus = Common.ToInt(Request["rolecode"]);
            SiteSignTemp.Update(entity);
            Response.Write(Common.Json("OK", "状态更改成功"));

            Response.End();
        }


        private void GetJson()
        {
            Response.ContentType = "application/json";


            var item = SiteSignTemp.GetOne(Common.ToLong(Request["id"]));

            if (item == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var temp = new
            {
                //id = item.Id,
                //title = item.Title,
                //content = item.Content,
                //extno = item.ExtNo,
                //useage = ((TempSignUseage)item.Useage.Value).ToString(),
                remark = item.Remark,
                file1 = item.File1 == null ? "" : basePath + item.File1,
                file2 = item.File2 == null ? "" : basePath + item.File2,
                file3 = item.File3 == null ? "" : basePath + item.File3
                //date = item.CreateDate.Value.ToString("yyyy-MM-dd hh:mm"),
                //status = item.CheckStatus,
                //statusTxt = ((TempCheckStatus)item.CheckStatus.Value).ToString(),
                //feedback = item.Feedback
            };

            Response.Write(Common.Json("OK", "操作成功", temp));
            Response.End();
        }


        private void BindData()
        {
            GetModulePrivilegeByRoleId();
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            int oType = Common.ToInt(ddlOrderStatus.SelectedValue);
            string searchText = txtSearch.Value.Trim();
            string timeRange = txtDateRange.Value.Trim();

            var list = SiteSignTemp.GetList(ref pp, oType, searchText, timeRange);

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
            var entity = e.Item.DataItem as TemplateSign;
            if (entity != null)
            {
                var usr = SiteUser.GetUserInfo(entity.UserId.Value);
                var pro = SiteFund.GetProductFunds(entity.UserId.Value, entity.ProId ?? 0);

                var lit1 = e.Item.FindControl("Literal1") as Literal;
                var lit2 = e.Item.FindControl("Literal2") as Literal;
                var lit3 = e.Item.FindControl("Literal3") as Literal;

                lit1.Text = usr.Phone;
                lit2.Text = usr.CompanyName;
                lit3.Text = pro.ExtNo + entity.ExtNo;

                Repeater rep = e.Item.FindControl("Repeater2") as Repeater;
                if (rep != null)
                {
                    var dic2 = new Dictionary<int, string>();
                    dic2.Add((int)TempCheckStatus.等待审核, TempCheckStatus.等待审核.ToString());
                    dic2.Add((int)TempCheckStatus.通过审核, TempCheckStatus.通过审核.ToString());
                    dic2.Add((int)TempCheckStatus.驳回审核, TempCheckStatus.驳回审核.ToString());

                    rep.DataSource = dic2;
                    rep.DataBind();
                }

            }
        }

    }
}