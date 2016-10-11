using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OctoLib;
using Weetop.BLL;
using Weetop.DAL;
using Weetop.Model;
using Wuqi.Webdiyer;

namespace Weetop.Web.CMS
{
    public partial class UsrProduct : CmsBase
    {
        public List<ModulePrivilege> list = new List<ModulePrivilege>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("HYCPGL"))
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
                    case "4":
                        Rechar();
                        break;
                    default:
                        GetModulePrivilegeByRoleId();
                        Dictionary<int, string> dic = new Dictionary<int, string>();
                        dic.Add(-1, "");//chosen 留空
                        dic.Add((int)ProductType.短信验证码, ProductType.短信验证码.ToString());
                        dic.Add((int)ProductType.会员营销短信, ProductType.会员营销短信.ToString());
                        dic.Add((int)ProductType.国际短信验证码, ProductType.国际短信验证码.ToString());
                        dic.Add((int)ProductType.语音验证码, ProductType.语音验证码.ToString());
                        dic.Add((int)ProductType.手机流量推广, ProductType.手机流量推广.ToString());

                        ddlCheckStatus.DataSource = dic;
                        ddlCheckStatus.DataTextField = "Value";
                        ddlCheckStatus.DataValueField = "Key";
                        ddlCheckStatus.DataBind();
                        break;
                }

            }
        }

        private void GetModulePrivilegeByRoleId()
        {
            if (Admin != null)
            {
                Role rInfo = SiteRole.GetRoleByAccountCode(Admin.AccountCode);
                List<ModulePrivilege> list2 = SiteModulePrivilege.GetListModulePrivilege("HYGL");
                list.Clear();
                foreach (var item in list2)
                {
                    if (SiteRole.CheckRolePriv(rInfo.RoleId, item.ModPrivId))
                    {
                        list.Add(item);
                    }
                }
            }
        }
        private void Update()
        {
            Response.ContentType = "application/json";

            var entity = SiteFund.GetProductFunds(Common.ToLong(Request["id"]));
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var acc = Request["acc"].Trim();
            var pwd = Request["pwd"].Trim();
            var ext = Request["ext"].Trim();

            if (string.IsNullOrEmpty(acc) || string.IsNullOrEmpty(pwd) || string.IsNullOrEmpty(ext))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            entity.SyAccount = acc;
            entity.SyAccPwd = pwd;
            entity.ExtNo = ext;
            SiteFund.Update(entity);

            Response.Write(Common.Json("OK", "更新成功"));
            Response.End();
        }

        /// <summary>
        /// 线下充值
        /// </summary>
        private void Rechar()
        {
            Response.ContentType = "application/json";

            var entity = SiteFund.GetProductFunds(Common.ToLong(Request["hidUserId2"]));
            var money = Convert.ToDecimal(Request["fmoney"]);
            if (entity == null || money <= 0)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }


            using (DataClassesDataContext db = new DataClassesDataContext())
            {

                Random rd = new Random();
                FundsHistory temp = new FundsHistory()
                {
                    OrderId = DateTime.Now.ToString("yyMMddhhmmss") + rd.Next(1000, 9999).ToString(),
                    ProId = entity.ProId,
                    UserId = entity.UserId,
                    FMoney = money,
                    FCount = ShiYuanAPI.MoneyToSms(money),
                    FPayType = (int)PayType.线下,
                    FPayTypeText = PayType.线下.ToString(),
                    FRemark = "",
                    OrderStatus = (int)OrderStatus.未支付,
                    EffectiveTime = 24, //hour
                    CreateDate = DateTime.Now,
                    IsDeleted = false
                };

                db.FundsHistory.InsertOnSubmit(temp);


                var fund = db.Funds.SingleOrDefault(s => s.UserId == temp.UserId);
                var profunds = db.ProductFunds.SingleOrDefault(s => s.UserId == temp.UserId && s.IsOpen && s.ProId == temp.ProId);
                var pro = db.ProductInfo.SingleOrDefault(s => s.Id == temp.ProId);

                //接口充值
                var api = new ShiYuanAPI();
                var result = api.Recharge(typeof(UsrProduct), profunds.SyAccount ?? "", temp.FCount.Value, 1, pro.ProductId ?? "");
                var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
                var str = sr.ReadLine();
                int value = -1;
                try
                {
                    value = Common.ToInt(str.Split(',')[1], -1); //第一行判断操作是否成功
                }
                catch (Exception ex)
                {
                    Logg.Error(typeof(UsrProduct), "接口充值失败(" + str + ")，订单号：" + temp.OrderId);
                }
                finally
                {
                    if (value == 0) //充值成功
                    {
                        temp.OrderStatus = (int)OrderStatus.支付成功;
                        temp.PayDate = DateTime.Now;//支付成功日期

                        //汇总产品帐户
                        profunds.ProTotalIn = temp.FMoney + (profunds.ProTotalIn ?? 0m);
                        profunds.ProTotalCount = temp.FCount + (profunds.ProTotalCount ?? 0);
                        profunds.ProAvailable = temp.FMoney + (profunds.ProAvailable ?? 0m);
                        profunds.LastSync = DateTime.Now;
                        //汇总总帐户
                        fund.TotalIn += temp.FMoney;
                        fund.TotalCount += temp.FCount;
                        fund.Available += temp.FMoney;
                        fund.EarlyWarningEnable = true;

                        Logg.Info(typeof(UsrProduct), "接口充值成功，订单号：" + temp.OrderId);
                        Response.Write(Common.Json("OK", "充值成功，订单号：" + temp.OrderId));
                    }
                    else
                    {
                        temp.OrderStatus = (int)OrderStatus.已取消;

                        Response.Write(Common.Json("Err", "充值失败，接口调用失败(" + value + ")"));
                    }

                    db.SubmitChanges();

                    Response.End();
                }
            }



        }

        private void BindData()
        {
            //从url加载参数，方便从详情页跳回列表
            var pg = Common.ToInt(Request["page"]);
            if (pg != 0) AspNetPager1.CurrentPageIndex = pg;
            //TODO 添加查询条件参数，不然会有bug
            GetModulePrivilegeByRoleId();
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);

            int cType = Common.ToInt(ddlCheckStatus.SelectedValue);
            string searchText = txtSearch.Value.Trim();
            string timeRange = txtDateRange.Value.Trim();

            var list = SiteFund.GetProductFundsList(ref pp, cType, searchText, timeRange);

            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;

            Repeater1.DataSource = list;
            Repeater1.DataBind();
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

        protected void Repeater1_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            var entity = e.Item.DataItem as ProductFunds;
            if (entity != null)
            {
                var usr = SiteUser.GetUserInfo(entity.UserId.Value);

                var lit1 = e.Item.FindControl("Literal1") as Literal;
                var lit2 = e.Item.FindControl("Literal2") as Literal;

                lit1.Text = usr.CompanyName;
                lit2.Text = usr.Phone;
            }
        }
    }
}