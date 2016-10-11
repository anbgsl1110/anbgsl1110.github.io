using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web.CMS
{
    public partial class ProductList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("CPYYGL"))
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
                        //Delete();
                        break;
                    case "4"://toggle
                        Toggle();
                        break;
                    default:
                        break;
                }

            }
        }



        private void Update()
        {
            Response.ContentType = "application/json";

            var entity = SiteProduct.GetOne(Common.ToLong(Request["id"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var pcode = Request["pcode"].Trim();
            if (string.IsNullOrEmpty(pcode))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            entity.ProductId = pcode;
            SiteProduct.Update(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }


        private void Toggle()
        {
            Response.ContentType = "application/json";

            var entity = SiteProduct.GetOne(Common.ToLong(Request["id"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            entity.Enabled = Convert.ToBoolean(Request["checked"]);
            SiteProduct.Update(entity);

            Response.Write(Common.Json("OK", entity.ProductIdName + (entity.Enabled ? "已 <b>启用</b>" : "已 <b>禁用</b>")));
            Response.End();
        }

        private void BindData()
        {
            Repeater1.DataSource = SiteProduct.GetList();
            Repeater1.DataBind();
        }


        //可用于前端JS调用PostBack时执行
        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            //不管是不是PostBack都会执行，第二执行
            BindData();
        }

    }
}