using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json.Linq;
using Weetop.BLL;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.member
{
    public partial class RechargeList : FrontBasic
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SiteFundsHistory.UpdateOrderStatus(TUser.UserId);//更新订单状态

                var op = Request["op"];
                switch (op)
                {
                    case "1":
                        GetPage();
                        break;
                    case "2":
                        Pay();
                        break;
                }
            }
        }


        private void GetPage()
        {
            Response.ContentType = "application/json";

            var page = Common.ToInt(Request["page"], 1);
            PageParams pp = new PageParams(page);

            var list = SiteFundsHistory.GetList(TUser.UserId, ref pp);

            var tempList = new List<object>();

            foreach (var item in list)
            {
                var temp = new
                {
                    orderId = item.OrderId,
                    date = item.CreateDate.Value.ToString("yyyy-MM-dd"),
                    money = item.FMoney,
                    pro = SiteProduct.GetPName(item.ProId.Value),
                    status = item.OrderStatus.Value,
                    statusTxt = ((OrderStatus)item.OrderStatus.Value).ToString(),
                    typeTxt = item.FPayTypeText
                };
                tempList.Add(temp);
            }

            var obj = new
            {
                pages = pp.Pages,
                list = tempList
            };

            Response.Write(Common.Json("OK", "操作成功", obj));
            Response.End();
        }


        private void Pay()
        {
            var oid = Request["oid"];

            if (string.IsNullOrEmpty(oid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var entity = SiteFundsHistory.GetOne(oid);
            if (entity != null)
            {
                SiteFundsHistory.AliPay(entity.OrderId, string.Format("{0:F}", entity.FMoney));
            }
            else
            {
                Response.Write(Common.Json("Err", "参数错误"));
            }
            Response.End();

        }
    }
}