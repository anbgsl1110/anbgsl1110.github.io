using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OctoLib;
using Weetop.BLL;

namespace Weetop.Web.member
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            Logg.Info(typeof(Index), "###登陆成功，进入用户中心###");
            Response.Redirect("Account.aspx");
        }
    }
}