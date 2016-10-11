using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using Weetop.Model;
using Com.Alipay;

namespace Weetop.DAL
{
    public sealed class SiteFundsHistory
    {
        private SiteFundsHistory() { }


        /// <summary>
        /// 获取所有列表
        /// </summary>
        /// <returns></returns>
        public static List<FundsHistory> GetList(ref PageParams pp, int? oType = null, int? cType = null, string searchText = null, string timeRange = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.FundsHistory.Where(w => !w.IsDeleted);

                if (oType.HasValue && oType > 0)
                {
                    temp = temp.Where(w => w.OrderStatus == oType.Value);
                }
                if (cType.HasValue && cType > 0)
                {
                    temp = temp.Where(w => w.ProId == cType.Value);
                }
                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    temp = from tm in temp
                           join ui in db.UserInfo on tm.UserId equals ui.UserId
                           where ui.CompanyName.Contains(searchText) || ui.Phone.Contains(searchText) || tm.OrderId.Contains(searchText)
                           select tm;
                }
                if (!string.IsNullOrWhiteSpace(timeRange))
                {
                    List<DateTime> dt = timeRange.Split('-').Select(s => Convert.ToDateTime(s.Trim())).ToList();
                    temp = temp.Where(w => w.CreateDate.Value >= dt[0] && w.CreateDate.Value < dt[1]);
                }

                if (pp.AllowPaging)
                {
                    pp.TotalCount = temp.Count();

                    return temp.OrderByDescending(o => o.CreateDate).Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp.OrderByDescending(o => o.CreateDate).ToList();
                }
            }
        }

        public static List<FundsHistory> GetList()
        {
            PageParams pp = new PageParams(false);
            return GetList(ref pp);
        }
        public static List<FundsHistory> GetListALL()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.FundsHistory.Where(w => !w.IsDeleted).OrderByDescending(o=>o.CreateDate).ToList();
                return temp;
            }
        }

        /// <summary>
        /// 获取所有列表
        /// </summary>
        /// <returns></returns>
        public static List<FundsHistory> GetList(Guid uid, ref PageParams pp, string searchText = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.FundsHistory.Where(w => !w.IsDeleted && w.UserId == uid);

                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    temp = temp.Where(w => w.OrderId.Contains(searchText));
                }

                if (pp.AllowPaging)
                {
                    pp.TotalCount = temp.Count();

                    return temp.OrderByDescending(o => o.CreateDate).Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp.OrderByDescending(o => o.CreateDate).ToList();
                }
            }
        }

        public static List<FundsHistory> GetList(Guid uid)
        {
            PageParams pp = new PageParams(false);
            return GetList(uid, ref pp);
        }


        /// <summary>
        /// 获取充值成功的金额汇总
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static decimal? GetSuccMoney(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.FundsHistory.Where(w => !w.IsDeleted && w.OrderStatus == (int)OrderStatus.支付成功 && w.UserId == uid).Sum(s => s.FMoney);
            }
        }

        /// <summary>
        /// 获取信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static FundsHistory GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.FundsHistory.SingleOrDefault(w => w.Id == id);
            }
        }

        public static FundsHistory GetOne(string oid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.FundsHistory.SingleOrDefault(w => w.OrderId == oid);
            }
        }

        /// <summary>
        /// 删除信息
        /// </summary>
        /// <param name="id"></param>
        public static void Delete(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.FundsHistory.SingleOrDefault(w => w.Id == id);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.FundsHistory.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 更新信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Update(FundsHistory entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.FundsHistory.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 添加信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Add(FundsHistory entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.FundsHistory.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }





        /// <summary>
        /// 检查并更新订单是否过期
        /// </summary>
        /// <param name="userId"></param>
        public static void UpdateOrderStatus(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var valids = db.FundsHistory.Where(w => w.UserId == uid && w.OrderStatus.Value == (int)OrderStatus.未支付 && ((DateTime)w.CreateDate).AddHours(Convert.ToDouble(w.EffectiveTime)) <= DateTime.Now).ToList();
                if (valids.Count > 0)
                {
                    foreach (var item in valids)
                    {
                        item.OrderStatus = (int)OrderStatus.已取消;
                    }
                    db.SubmitChanges();
                }
            }
        }
        public static void UpdateOrderStatus()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var valids = db.FundsHistory.Where(w => w.OrderStatus.Value == (int)OrderStatus.未支付 && ((DateTime)w.CreateDate).AddHours(Convert.ToDouble(w.EffectiveTime)) <= DateTime.Now).ToList();
                if (valids.Count > 0)
                {
                    foreach (var item in valids)
                    {
                        item.OrderStatus = (int)OrderStatus.已取消;
                    }
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 获得订单状态
        /// </summary>
        /// <param name="oid"></param>
        /// <returns></returns>
        public static int GetOrderStatus(string oid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.FundsHistory.SingleOrDefault(w => w.OrderId == oid);
                return temp.OrderStatus.Value;
            }
        }








        #region 支付宝


        private static string SiteUrl = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Host; //Common.AppSettings["SiteUrl"];

        /// <summary>
        /// 支付
        /// </summary>
        /// <param name="oid">订单号</param>
        /// <param name="money">金额，只能精确到小数点后两位</param>
        public static void AliPay(string oid, string money)
        {
            ////////////////////////////////////////////请求参数////////////////////////////////////////////

            //支付类型
            string payment_type = "1";
            //必填，不能修改
            //服务器异步通知页面路径
            string notify_url = SiteUrl + "/AliNotify";
            //需http://格式的完整路径，不能加?id=123这类自定义参数

            //页面跳转同步通知页面路径
            string return_url = SiteUrl + "/PayRes";
            //需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

            //商户订单号
            string out_trade_no = oid;
            //商户网站订单系统中唯一订单号，必填

            //订单名称
            string subject = "示远科技服务充值";
            //必填

            //付款金额
            string total_fee = money;
            //必填

            //订单描述

            string body = "";
            //商品展示地址
            string show_url = "";
            //需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html

            //防钓鱼时间戳
            string anti_phishing_key = Submit.Query_timestamp();
            //若要使用请调用类文件submit中的query_timestamp函数

            //客户端的IP地址
            string exter_invoke_ip = "";
            //非局域网的外网IP地址，如：221.0.0.1


            ////////////////////////////////////////////////////////////////////////////////////////////////

            //把请求参数打包成数组
            SortedDictionary<string, string> sParaTemp = new SortedDictionary<string, string>();
            sParaTemp.Add("partner", Config.Partner);
            sParaTemp.Add("seller_email", Config.Seller_email);
            sParaTemp.Add("_input_charset", Config.Input_charset.ToLower());
            sParaTemp.Add("service", "create_direct_pay_by_user");
            sParaTemp.Add("payment_type", payment_type);
            sParaTemp.Add("notify_url", notify_url);
            sParaTemp.Add("return_url", return_url);
            sParaTemp.Add("out_trade_no", out_trade_no);
            sParaTemp.Add("subject", subject);
            sParaTemp.Add("total_fee", total_fee);
            sParaTemp.Add("body", body);
            sParaTemp.Add("show_url", show_url);
            sParaTemp.Add("anti_phishing_key", anti_phishing_key);
            sParaTemp.Add("exter_invoke_ip", exter_invoke_ip);

            //建立请求
            string sHtmlText = Submit.BuildRequest(sParaTemp, "get", "确认");
            HttpContext.Current.Response.Write(sHtmlText);

        }


        #endregion 支付宝



    }
}
