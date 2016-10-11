using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.BLL;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.member
{
    public partial class Recharge : FrontBasic
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string op = Request["op"];
            switch (op)
            {
                case "1":
                    CalcSmsCount();
                    break;
                case "2":
                    Pay();
                    break;
            }

        }

        //根据金额计算短信条数
        private void CalcSmsCount()
        {
            Response.ContentType = "application/json";

            var chargeMy = Common.ToDecimal(Request["m"]);
            var pid = Common.ToDecimal(Request["pid"]);
            var result = ShiYuanAPI.MoneyToSms(chargeMy, Convert.ToInt32(pid));
            Response.Write(Common.Json("OK", result.ToString()));
            Response.End();
        }

        //当前用户对应产品服务是否已开通
        protected bool Pro1Opened = false;
        protected bool Pro2Opened = false;
        protected bool Pro3Opened = false;
        protected bool Pro4Opened = false;
        protected bool Pro5Opened = false;

        //下单支付
        private void Pay()
        {
            var pid = Common.ToLong(Request["pid"]);
            var money = Common.ToDecimal(Request["m"]);
            var payType = Common.ToInt(Request["pt"]);

            if ((pid <= 0 || pid > 5) || (money <= 0) || payType <= 0)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            //当前用户对应产品服务是否已开通
            Pro1Opened = SiteFund.CheckProOpened(TUser.UserId, 1);
            Pro2Opened = SiteFund.CheckProOpened(TUser.UserId, 2);
            Pro3Opened = SiteFund.CheckProOpened(TUser.UserId, 3);
            Pro4Opened = SiteFund.CheckProOpened(TUser.UserId, 4);
            Pro5Opened = SiteFund.CheckProOpened(TUser.UserId, 5);

            var isOpened = false;
            switch (pid)
            {
                case 1:
                    isOpened = Pro1Opened;
                    break;
                case 2:
                    isOpened = Pro2Opened;
                    break;
                case 3:
                    isOpened = Pro3Opened;
                    break;
                case 4:
                    isOpened = Pro4Opened;
                    break;
                case 5:
                    isOpened = Pro5Opened;
                    break;
            }

            if (!isOpened)
            {
                Response.Write(Common.Json("Err", "所选应用尚未开通，请先开通"));
                Response.End();
            }

            Random rd = new Random();
            FundsHistory entity = new FundsHistory()
            {
                OrderId = DateTime.Now.ToString("yyMMddhhmmss") + rd.Next(1000, 9999).ToString(),
                ProId = pid,
                UserId = TUser.UserId,
                FMoney = money,
                FCount = ShiYuanAPI.MoneyToSms(money),
                FPayType = payType,
                FPayTypeText = ((PayType)payType).ToString(),
                FRemark = "",
                OrderStatus = (int)OrderStatus.未支付,
                EffectiveTime = 24, //hour
                CreateDate = DateTime.Now,
                IsDeleted = false
            };

            SiteFundsHistory.Add(entity);


            SiteFundsHistory.AliPay(entity.OrderId, string.Format("{0:F}", entity.FMoney));
            Response.End();

        }
    }
}