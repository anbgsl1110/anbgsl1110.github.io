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
                    case "3"://重置更改
                        Reset();
                        break;
                    case "4"://保存确定
                        Save();
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

        //去除咨询服务人员
        private void DeleteServicePerson()
        {
            Response.ContentType = "application/json";

            List<ConsultingService> list1 = (List<ConsultingService>)Session["AssignedListTemp"];
            List<ConsultingService> list2 = (List<ConsultingService>)Session["NotAssignedListTemp"];

            List<ConsultingService> listTemp1 = new List<ConsultingService>();
            List<ConsultingService> listTemp2 = new List<ConsultingService>();
            foreach (ConsultingService cs1 in list1)
            {
                listTemp1.Add(cs1);
            }
            foreach (ConsultingService cs2 in list2)
            {
                listTemp2.Add(cs2);
            }
            Repeater1.DataSource = null;
            Repeater2.DataSource = null;
            Repeater1.DataSource = listTemp1.ToList();
            Repeater2.DataSource = listTemp2.ToList();
            //数据逻辑处理
            int id = int.Parse(Request["id"]);
            if (!(string.IsNullOrWhiteSpace((id.ToString()))))
            {
                ConsultingService cs = SiteConsultingService.GetConsultingServiceInfo(id);
                //因为刚刚获得的ConsultingService cs是个新的对象，不能使用Remove()方法进行移除，故采用RemoveAt()方法;
                int index = 0;
                foreach(ConsultingService cs3 in listTemp1)
                {
                    if (cs3.id == id)
                    {
                        break;
                    }
                    index++;
                }
                listTemp1.RemoveAt(index);
                listTemp2.Add(cs);
            }
            else
            {
                Response.Write(Common.Json("Err","参数错误"));
                Response.End();
            }
            Session["AssignedListTemp"] = listTemp1;
            Session["NotAssignedListTemp"] = listTemp2;
            Response.Write(Common.Json("OK","去除成功"));
            Response.End();
        }

        //添加咨询服务人员
        private void AddServicePerson()
        {
            Response.ContentType = "application/json";

            List<ConsultingService> listTemp1 = (List<ConsultingService>)Session["AssignedListTemp"];
            List<ConsultingService> listTemp2 = (List<ConsultingService>)Session["NotAssignedListTemp"];
            //数据逻辑处理
            int id = int.Parse(Request["id"]);
            if (!(string.IsNullOrWhiteSpace((id.ToString()))))
            {
                ConsultingService cs = SiteConsultingService.GetConsultingServiceInfo(id);
                listTemp1.Add(cs);
                int index = 0;
                foreach (ConsultingService cs1 in listTemp2)
                {
                    if (cs1.id == id)
                    {
                        break;
                    }
                    index++;
                }
                listTemp2.RemoveAt(index);
            }
            else
            {
                Response.Write(Common.Json("Err","参数错误"));
                Response.End();
            }
            Session["AssignedListTemp"] = listTemp1;
            Session["NotAssignedListTemp"] = listTemp2;         
            BindTempData();
            Response.Write(Common.Json("OK", "添加成功"));
            Response.End();
        }

        //保存确定
        private void Save()
        {
            Response.ContentType = "application/json";

            //删除原始分配人员，增加最新分配人员
            List<ConsultingService> list1 = (List<ConsultingService>)Session["AssignedList"];
            List<ConsultingService> listTemp1 = (List<ConsultingService>)Session["AssignedListTemp"];
            foreach (ConsultingService cs1 in list1)
            {
                SiteConsultingServiceNexus.DeleteNexusBycid(cs1.id);
            }
            foreach (ConsultingService cs2 in listTemp1)
            {
                Model.ConsultingServiceNexus entity = new Model.ConsultingServiceNexus()
                {
                    cid = cs2.id,
                    UserId = Guid.Parse(Request["userId"]),
                };
                SiteConsultingServiceNexus.AddConsultingServiceNexus(entity);
            }
            //分配完成删除关联的Session数据
            Session["AssignedList"] = null;
            Session["NotAssignedList"] = null;
            Session["AssignedListTemp"] = null;
            Session["NotAssignedListTemp"] = null;
            BindInitData();
            Response.Write(Common.Json("OK", "保存确定成功！"));
            Response.End();
        }

        //重置更改
        private void Reset()
        {
            Response.ContentType = "application/json";
                     
            //重置更改之后删除临时Seesion中的数据
            Session["AssignedList"] = null;
            Session["NotAssignedList"] = null;
            Session["AssignedListTemp"] = null;
            Session["NotAssignedListTemp"] = null;
            BindInitData();
            Response.Write(Common.Json("OK", "重置更改成功！"));
            Response.End();
        }

        //绑定初始数据
        private void BindInitData()
        {
            var pg = Common.ToInt(Request["page"]);
            if (pg != 0) AspNetPager1.CurrentPageIndex = pg;
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex, 5);
            int cType = Common.ToInt(ddlCategroy.SelectedValue);
            Guid userGuid = Guid.Parse(Request["userId"]);
            List<ConsultingService> list1 = SiteConsultingService.GetAssignedConsultingServiceListByUserId(userGuid, cType);
            List<ConsultingService> list2 = SiteConsultingService.GetNotAssignedConsultingServiceListByUserId(ref pp, userGuid, cType);
            //获取已分配和未分配人员list3,list保存在Session中
            List<ConsultingService> list3 = list1;
            //list2未分配服务人员中因为存在分页数据不全，故重新获取
            List<ConsultingService> list4 = SiteConsultingService.GetNotAssignedConsultingServiceListByUserId(userGuid, cType);
            Session["AssignedList"] = list3;
            Session["NotAssignedList"] = list4;
            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;
            Repeater1.DataSource = list1;
            Repeater1.DataBind();
            Repeater2.DataSource = list2;
            Repeater2.DataBind();
            //绑定数据到临时listTemp中
            BindListToTemp();
        }

        private void BindTempData()
        {
            var pg = Common.ToInt(Request["page"]);
            if (pg != 0) AspNetPager1.CurrentPageIndex = pg;
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex,5);
            int cType = Common.ToInt(ddlCategroy.SelectedValue);
            Guid userGuid = Guid.Parse(Request["userId"]);
            List<ConsultingService> listTemp1 = (List<ConsultingService>)Session["AssignedListTemp"];
            List<ConsultingService> listTemp2 = (List<ConsultingService>)Session["NotAssignedListTemp"];
            List<ConsultingService> list1 = SiteConsultingService.GetAssignedConsultingServiceListByListTemp(cType,listTemp1);
            List<ConsultingService> list2 = SiteConsultingService.GetNotAssignedConsultingServiceListByListTemp(ref pp, cType,listTemp2);
            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;
            Repeater1.DataSource = list1;
            Repeater1.DataBind();
            Repeater2.DataSource = list2;
            Repeater2.DataBind();
        }

        protected void AspNetPager1_PageChanging(object src, PageChangingEventArgs e)
        {
            //第三执行
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            string ac = Request["action"];
            if("1".Equals(ac))
            {
                BindTempData();
                return;
            }
            if("2".Equals(ac))
            {
                BindTempData();
                return;
            }
            if("3".Equals(ac))
            {
                BindTempData();
                return;
            }
            if("4".Equals(ac))
            {
                BindTempData();
                return;
            }
            else
            {
                BindTempData();
                return;
            }          
        }

        //可用于前端JS调用PostBack时执行
        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            //不管是不是PostBack都会执行，第二执行
            string ac = Request["action"];
            if ("1".Equals(ac))
            {
                BindTempData();
                return;
            }
            if ("2".Equals(ac))
            {
                BindTempData();
                return;
            }
            if ("3".Equals(ac))
            {
                BindInitData();
                return;
            }
            if ("4".Equals(ac))
            {
                BindInitData();
                return;
            }
            else
            {
                BindInitData();
                return;
            } 
        }

        //绑定数据到临时List中
        private void BindListToTemp()
        {
            List<ConsultingService> list1 = (List<ConsultingService>)Session["AssignedList"]; 
            List<ConsultingService> list2 = (List<ConsultingService>)Session["NotAssignedList"];
            List<ConsultingService> listTemp1 = new List<ConsultingService>();
            List<ConsultingService> listTemp2 = new List<ConsultingService>();
            //数据处理逻辑
            foreach(ConsultingService consultingService in list1)
            {
                listTemp1.Add(consultingService);
            }
            foreach(ConsultingService consultingService in list2)
            {
                listTemp2.Add(consultingService);
            }
            Session["AssignedListTemp"] = listTemp1;
            Session["NotAssignedListTemp"] = listTemp2;
        }
    }
}