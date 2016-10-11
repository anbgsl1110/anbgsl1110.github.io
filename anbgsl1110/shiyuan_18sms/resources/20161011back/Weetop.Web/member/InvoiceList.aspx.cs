using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web.member
{
    public partial class InvoiceList : FrontBasic
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var op = Request["op"];
                switch (op)
                {
                    case "1":
                        GetPage();
                        break;
                    case "2":
                        CancelIt();
                        break;
                }
            }
        }




        private void GetPage()
        {
            Response.ContentType = "application/json";

            var page = Common.ToInt(Request["page"], 1);
            PageParams pp = new PageParams(page);

            var list = SiteApply4Invo.GetList(ref pp, TUser.UserId);

            var tempList = new List<object>();

            foreach (var item in list)
            {
                var temp = new
                {
                    id = item.Id,
                    money = string.Format("{0:C0}", item.FMoney),
                    date = item.CreateDate.Value.ToString("yyyy-MM-dd"),
                    title = item.FTitle,
                    invoTypeTxt = ((InvoType)SiteInvoice.GetOne(item.InvoInfoId.Value).InvoType).ToString(),
                    receiveTxt = ((ReceiveWay)item.ReceiveWay.Value).ToString(),
                    status = item.FStatus.Value,
                    statusTxt = ((InvoStatus)item.FStatus.Value).ToString(),
                    feedback = item.Feedback
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



        private void CancelIt()
        {
            Response.ContentType = "application/json";

            var oid = Request["oid"];
            if (string.IsNullOrEmpty(oid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var entity = SiteApply4Invo.GetOne(Common.ToLong(oid));
            if (entity != null)
            {
                if (entity.FStatus == (int)InvoStatus.待开发票)
                {
                    entity.FStatus = (int)InvoStatus.已作废;
                    SiteApply4Invo.Update(entity);
                    Response.Write(Common.Json("OK", "操作成功"));
                }
                else
                {
                    Response.Write(Common.Json("Err", "操作无效"));
                }
            }
            else
            {
                Response.Write(Common.Json("Err", "参数错误"));
            }
            Response.End();

        }
    }
}