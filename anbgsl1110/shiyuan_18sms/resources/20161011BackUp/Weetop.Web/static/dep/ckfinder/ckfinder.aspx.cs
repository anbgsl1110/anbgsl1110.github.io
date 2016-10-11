using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;

public partial class ckfinder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //网站后台上传权限验证
        if (Request.UrlReferrer == null || (Request.UrlReferrer.AbsoluteUri.ToLower().Contains("/cms/") && Session["AdminInfo"] == null))
        {
            Response.Write("403");
            Response.End();
        }
    }
}