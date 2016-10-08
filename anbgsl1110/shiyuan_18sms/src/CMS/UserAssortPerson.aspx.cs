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
                    case "1":
                        break;
                    case "2":
                        AssortServicePerson();
                        break;
                    default:
                        Dictionary<int, string> dic = new Dictionary<int, string>();
                        dic.Add(0, "查看全部");
                        dic.Add(1, "客服");
                        dic.Add(2, "商务");
                        dic.Add(3, "运维");
                        ddlCategroy.DataSource = dic;
                        ddlCategroy.DataTextField = "Value";
                        ddlCategroy.DataValueField = "Key";
                        ddlCategroy.DataBind();
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

        //分配咨询服务服务人员
        private void AssortServicePerson()
        {
            Response.ContentType = "application/json";

            Response.Write(Common.Json("Err", "参数错误"));
            Response.End();
        }

        private void BindData()
        {
            //从url加载参数，方便从详情页跳回列表
            var pg = Common.ToInt(Request["page"]);
            if (pg != 0) AspNetPager1.CurrentPageIndex = pg;
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex,5);
            int cType = Common.ToInt(ddlCategroy.SelectedValue);
            //string aSaler = ddlAdminList.SelectedValue;
            List<UserInfo> list = SiteUser.GetAllUserInfoList(ref pp, cType);
            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;
            Repeater1.DataSource = list;
            Repeater1.DataBind();
            Repeater2.DataSource = list;
            Repeater2.DataBind();
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
    }
}