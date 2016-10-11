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
    public partial class UserAssortPerson : CmsBase
    {
        public List<ModulePrivilege> list = new List<ModulePrivilege>();

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
                    case "1"://去除服务人员
                        DeleteServicePerson();
                        break;
                    case "2"://添加服务人员
                        AddServicePerson();
                        break;
                    default:
                        Dictionary<int, string> dic = new Dictionary<int, string>();
                        dic.Add(0, "查看全部");
                        dic.Add(1, "客服");
                        dic.Add(2, "商务");
                        ddlCategroy.DataSource = dic;
                        ddlCategroy.DataTextField = "Value";
                        ddlCategroy.DataValueField = "Key";
                        ddlCategroy.DataBind();
                        break;
                }
            }
            else
            {
                //第一次post时执行
            }
        }

        /// <summary>
        /// 去除咨询服务人员
        /// </summary>
        private void DeleteServicePerson()
        {
            Response.ContentType = "application/json";

            int id = int.Parse(Request["id"]);
            if (!(string.IsNullOrWhiteSpace((id.ToString()))))
            {
                ConsultingService cs = SiteConsultingService.GetConsultingServiceInfo(id);
                if (cs != null) //判断是否能取出数据
                {
                    string userID = Request["userId"] == null ? "" : Request["userId"].ToString();
                    if (userID == "")
                    {
                        Response.Write(Common.Json("Err", "userId为空!"));
                        Response.End();
                    }
                    SiteConsultingServiceNexus.Delete(id, Guid.Parse(Request["userId"]));
                    Response.Write(Common.Json("OK", "去除成功"));
                    Response.End();
                }
                else
                {
                    Response.Write(Common.Json("Err", "参数错误！"));
                    Response.End();
                }
            }
            else
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
        }

        /// <summary>
        /// 添加咨询服务人员
        /// </summary>
        private void AddServicePerson()
        {
            Response.ContentType = "application/json";

            int id = int.Parse(Request["id"]);
            if (!(string.IsNullOrWhiteSpace((id.ToString()))))
            {
                ConsultingService cs = SiteConsultingService.GetConsultingServiceInfo(id);
                if (cs != null) //判断是否能取出数据
                {
                    string userID = Request["userId"] == null ? "" : Request["userId"].ToString();
                    if (userID == "")
                    {
                        Response.Write(Common.Json("Err", "userId为空!"));
                        Response.End();
                    }
                    ConsultingServiceNexus cn = new ConsultingServiceNexus();
                    cn.cid = cs.id;
                    cn.UserId = new Guid(userID);
                    SiteConsultingServiceNexus.AddByEntity(cn);
                    Response.Write(Common.Json("OK", "添加成功"));
                    Response.End();
                }
                else
                {
                    Response.Write(Common.Json("Err", "参数错误！"));
                    Response.End();
                }
            }
            else
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        private void BindInitData()
        {
            var pg = Common.ToInt(Request["page"]);
            if (pg != 0) AspNetPager1.CurrentPageIndex = pg;
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex, 5);
            int cType = Common.ToInt(ddlCategroy.SelectedValue);
            Guid userGuid = Guid.Parse(Request["userId"]);
            List<ConsultingService> list1 = SiteConsultingService.GetByBoundListUserId(userGuid, cType);
            List<ConsultingService> list2 = SiteConsultingService.GetBoundListByUserId(ref pp, userGuid, cType);
            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;
            Repeater1.DataSource = list1;
            Repeater1.DataBind();
            Repeater2.DataSource = list2;
            Repeater2.DataBind();
        }

        /// <summary>
        /// 第三执行
        /// </summary>
        /// <param name="src"></param>
        /// <param name="e"></param>
        protected void AspNetPager1_PageChanging(object src, PageChangingEventArgs e)
        {
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            BindInitData();
        }

        /// <summary>
        /// 可用于前端JS调用PostBack时执行
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            BindInitData();
        }

    }
}