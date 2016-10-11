using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.member
{
    public partial class Award : FrontBasic
    {
        public List<UserWinningInfo> dt1 = new List<UserWinningInfo>();
        public List<UserWinningInfo> dt2 = new List<UserWinningInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetWinInfo();
                string action = Request["ac"];
                switch (action)
                {
                    case "1": //update
                        update();
                        
                        break;
                    default:
                        break;
                }
            }
        }
        public  void GetWinInfo()
        {
            if (SiteUserWinningInfo.GetCount(TUser.UserId))
            {
                dt1 = SiteUserWinningInfo.GetListByUserIdF(TUser.UserId, 3);
                dt2 = SiteUserWinningInfo.GetListByUserIdT(TUser.UserId, 4);
            }
        }

        public void update() 
        {
            Response.ContentType = "application/json";
            UserWinningInfo entity = new UserWinningInfo();
            string ConsigneeName = Request["name"].ToString();
            string ConsigneePhone = Request["phone"].ToString();
            string ConsigneeAddr = Request["address"].ToString();
            string ConsigneeCompany = Request["company"].ToString();
            string ConsigneePosition = Request["position"].ToString();
            int id = int.Parse(Request["id"].ToString());
            UserWinningInfo ui = SiteUserWinningInfo.GetOne(id);
            ui.ConsigneePhone = ConsigneePhone;
            ui.ConsigneeName = ConsigneeName;
            ui.ConsigneeAddr = ConsigneeAddr;
            ui.ConsigneeCompany = ConsigneeCompany;
            ui.ConsigneePosition = ConsigneePosition;
            Guid gid = Guid.Parse(ui.OnlyLable.ToString());
            SiteUserWinningInfo.Update(ui, gid);
            Response.Write(Common.Json("OK", "修改成功"));
            Response.End();
            
        }
        public static string GetStatus(int num)
        {
            switch (num)
            {
                case 0:
                    return "未发货";
                case 1:
                    return "待发货";
                case 2:
                    return "已发货";
                default:
                    return "已发货";
            }
        }
    }
}