using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Weetop.Web
{
    public partial class Activity : FrontBasic
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string ac = Request["action"] == null ? "" : Request["action"].ToString();
                switch (ac)
                {
                    case "lt":
                        IsLogin();
                        break;
                    default:
                        break;
                }
            }
        }
        public void IsLogin()
        {
            if (TUser == null)
            {
                Response.Write(Common.Json("Err", "请登录后再抽奖哦!"));
                Response.End();
            }
            else
            {
                Response.Write(Common.Json("OK", "ok"));
                Response.End();
            }
        }
    }
}