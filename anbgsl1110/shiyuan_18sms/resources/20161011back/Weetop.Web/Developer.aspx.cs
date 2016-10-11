﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web
{
    public partial class Developer : System.Web.UI.Page
    {
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    Repeater1.DataSource = SiteDevDoc.GetList(4);
        //    Repeater1.DataBind();
        //}

        protected long CateId = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            string cateId = "4";
            string conId = "8";

            if (!string.IsNullOrEmpty(conId))
            {

                CateId = Common.ToLong(cateId);

                var entity = SiteDevDoc.GetOne(Common.ToLong(conId));
                if (entity != null)
                {
                    LitTitle.Text = entity.Title;
                    LitContent.Text = entity.Content;
                }
            }
            else
            {
                Response.Write("参数错误");
                Response.End();
            }
        }
    }
}