using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Com.Alipay;
using OctoLib;
using Weetop.BLL;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web
{
    public partial class PayRes : System.Web.UI.Page
    {
        protected string OrderId = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            SortedDictionary<string, string> sPara = GetRequestGet();

            if (sPara.Count > 0)//判断是否有带返回参数
            {
                Notify aliNotify = new Notify();
                bool verifyResult = aliNotify.Verify(sPara, Request.QueryString["notify_id"], Request.QueryString["sign"]);

                if (verifyResult)//验证成功
                {
                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    //请在这里加上商户的业务逻辑程序代码


                    //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                    //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表

                    //商户订单号

                    string out_trade_no = Request.QueryString["out_trade_no"];

                    //支付宝交易号

                    string trade_no = Request.QueryString["trade_no"];

                    //交易状态
                    string trade_status = Request.QueryString["trade_status"];


                    if (Request.QueryString["trade_status"] == "TRADE_FINISHED" || Request.QueryString["trade_status"] == "TRADE_SUCCESS")
                    {
                        //判断该笔订单是否在商户网站中已经做过处理
                        //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                        //如果有做过处理，不执行商户的业务程序

                        if (SiteFundsHistory.GetOrderStatus(out_trade_no) == (int)OrderStatus.未支付)//未支付
                        {
                            //SiteFundsHistory.PaySuccess(out_trade_no);//交易成功

                            using (DataClassesDataContext db = new DataClassesDataContext())
                            {
                                //更新订单状态
                                var temp = db.FundsHistory.SingleOrDefault(s => s.OrderId == out_trade_no);
                                temp.OrderStatus = (int)OrderStatus.支付成功;
                                temp.PayDate = DateTime.Now;

                                var fund = db.Funds.SingleOrDefault(s => s.UserId == temp.UserId);
                                var profunds = db.ProductFunds.SingleOrDefault(s => s.UserId == temp.UserId && s.IsOpen && s.ProId == temp.ProId);
                                var pro = db.ProductInfo.SingleOrDefault(s => s.Id == temp.ProId);

                                //接口充值
                                var api = new ShiYuanAPI();
                                var result = api.Recharge(typeof(PayRes), profunds.SyAccount ?? "", temp.FCount.Value, 1, pro.ProductId ?? "");
                                var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
                                var str = sr.ReadLine();
                                int value = -1;
                                try
                                {
                                    value = Common.ToInt(str.Split(',')[1], -1);//第一行判断操作是否成功
                                }
                                catch (Exception ex)
                                {
                                    Logg.Error(typeof(PayRes), "接口充值失败，订单号：" + out_trade_no);
                                }
                                finally
                                {
                                    if (value == 0)//充值成功
                                    {
                                        Logg.Info(typeof(PayRes), "接口充值成功，订单号：" + out_trade_no);

                                        #region 充值超一万抽奖
                                        int ReNum = (int)(temp.FMoney / 10000);
                                        if (ReNum > 0)
                                        {
                                            if (SiteUserRecharge.IsRecharge(temp.UserId))
                                            {
                                                UserRecharge URentity = SiteUserRecharge.GetOne(temp.UserId);
                                                URentity.LotteryNumber += ReNum;
                                                SiteUserRecharge.Update(URentity);
                                            }
                                            else
                                            {
                                                UserRecharge URentity = new UserRecharge()
                                                {
                                                    UserId = temp.UserId,
                                                    LotteryNumber = ReNum
                                                };
                                                SiteUserRecharge.Add(URentity);
                                            }
                                        }
                                        #endregion
                                    }

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
                                    db.SubmitChanges();
                                }
                            }
                        }
                        else
                        {
                            //其他
                        }

                        OrderId = out_trade_no;
                    }
                    else
                    {
                        //Response.Write("trade_status=" + Request.QueryString["trade_status"]);
                    }

                    //打印页面
                    //Response.Write("验证成功<br />");
                    //ClientScript.RegisterStartupScript(this.GetType(), "alipay", "<script>alert('交易成功。');</script>");

                    //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                }
                else//验证失败
                {
                    //Response.Write("验证失败");
                    ClientScript.RegisterStartupScript(this.GetType(), "alipay", "<script>alert('验证失败，交易已成功？');</script>");
                }
            }
            else
            {
                Response.Write("无返回参数");
            }
        }




        /// <summary>
        /// 获取支付宝GET过来通知消息，并以“参数名=参数值”的形式组成数组
        /// </summary>
        /// <returns>request回来的信息组成的数组</returns>
        public SortedDictionary<string, string> GetRequestGet()
        {
            int i = 0;
            SortedDictionary<string, string> sArray = new SortedDictionary<string, string>();
            NameValueCollection coll;
            //Load Form variables into NameValueCollection variable.
            coll = Request.QueryString;

            // Get names of all forms into a string array.
            String[] requestItem = coll.AllKeys;

            for (i = 0; i < requestItem.Length; i++)
            {
                sArray.Add(requestItem[i], Request.QueryString[requestItem[i]]);
            }

            return sArray;
        }

    }
}