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

namespace Weetop.Web.CMS
{
    public partial class SmsTemp : CmsBase
    {
        public List<ModulePrivilege> list = new List<ModulePrivilege>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("DXMBGL"))
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
                    case "6":
                        Update2();
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

            var entity = SiteSmsTemp.GetOne(Common.ToLong(Request["hidRoleId"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            entity.Feedback = Request["remark"];
            SiteSmsTemp.Update(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }


        private void Update2()
        {
            Response.ContentType = "application/json";

            var entity = SiteSmsTemp.GetOne(Common.ToLong(Request["hidRoleId"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            if (string.IsNullOrWhiteSpace(Request["remark"]))
            {
                Response.Write(Common.Json("Err", "模板内容不能为空"));
                Response.End();
            }

            entity.Content = Request["remark"];
            SiteSmsTemp.Update(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }

        private void GetJson()
        {
            Response.ContentType = "application/json";


            var item = SiteSmsTemp.GetOne(Common.ToLong(Request["id"]));

            if (item == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var temp = new
            {
                //id = item.Id,
                //title = item.Title,
                content = item.Content
                //extno = item.ExtNo,
                //useage = ((TempSignUseage)item.Useage.Value).ToString(),
                //remark = item.Remark,
                //date = item.CreateDate.Value.ToString("yyyy-MM-dd hh:mm"),
                //status = item.CheckStatus,
                //statusTxt = ((TempCheckStatus)item.CheckStatus.Value).ToString(),
                //feedback = item.Feedback
            };

            Response.Write(Common.Json("OK", "操作成功", temp));
            Response.End();
        }


        private void Delete()
        {
            Response.ContentType = "application/json";

            var tid = Common.ToLong(Request["id"]);
            var entity = SiteSmsTemp.GetOne(tid);
            if (entity == null)
            {
                Response.Write(Common.Json("OK", "无效参数"));
                Response.End();
            }


            if (entity.CheckStatus.Value == (int)TempCheckStatus.通过审核)
            {
                //TODO 先用API同步删除再删除本地

                //SiteSmsTemp.Delete(tid);
                Response.Write(Common.Json("OK", "删除成功"));
                Response.End();
            }
            else
            {
                //直接删除本地
                SiteSmsTemp.Delete(tid);
                Response.Write(Common.Json("OK", "删除成功"));
                Response.End();
            }

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
            var entity = SiteSmsTemp.GetOne(Common.ToLong(id));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            entity.CheckStatus = Common.ToInt(Request["rolecode"]);

            if (entity.CheckStatus.Value == (int)TempCheckStatus.通过审核)
            {
                //短信模板同步接口调用
                var pf = SiteFund.GetProductFunds(entity.UserId.Value, entity.ProId.Value);

                var api = new ShiYuanAPI();
                var result = api.SmsTemplateSys(typeof(SmsTemp), pf.SyAccount ?? "", entity.Content, 1, 1, 1);
                var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
                var str = sr.ReadLine();
                int value = -1;
                try
                {
                    value = Common.ToInt(str.Split(',')[1], -1);
                }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", str));
                    Response.End();
                }

                if (value == 0)
                {
                    SiteSmsTemp.Update(entity);
                    Response.Write(Common.Json("OK", "状态更改成功(" + value + ")"));
                    Response.End();
                }
                else
                {
                    Response.Write(Common.Json("Err", "状态更改失败，请稍后再试(" + value + ")"));
                    Response.End();
                }
            }
            else
            {
                SiteSmsTemp.Update(entity);
                Response.Write(Common.Json("OK", "状态更改成功"));
                Response.End();
            }
        }




        private void BindData()
        {
            GetModulePrivilegeByRoleId();
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            int oType = Common.ToInt(ddlOrderStatus.SelectedValue);
            string searchText = txtSearch.Value.Trim();
            string timeRange = txtDateRange.Value.Trim();

            var list = SiteSmsTemp.GetList(ref pp, oType, searchText, timeRange);

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
            var entity = e.Item.DataItem as TemplateSms;
            if (entity != null)
            {
                var usr = SiteUser.GetUserInfo(entity.UserId.Value);
                //var pro = SiteFund.GetProductFunds(entity.UserId.Value, entity.ProId ?? 0);

                var lit1 = e.Item.FindControl("Literal1") as Literal;
                var lit2 = e.Item.FindControl("Literal2") as Literal;
                //var lit3 = e.Item.FindControl("Literal3") as Literal;

                lit1.Text = usr.Phone;
                lit2.Text = usr.CompanyName;
                //lit3.Text = pro?.ExtNo + entity.ExtNo;

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