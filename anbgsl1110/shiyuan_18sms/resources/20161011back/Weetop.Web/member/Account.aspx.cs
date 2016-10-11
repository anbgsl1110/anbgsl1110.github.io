using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OctoLib;
using Weetop.BLL;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.member
{
    public partial class Account : FrontBasic
    {

        //拓展码指针查询标识
        private const string extnoId = "api.UserManage().extno.Index";


        //系统产品服务是否启用
        protected bool Pro1Enabled = false;//短信验证码/通知
        protected bool Pro2Enabled = false;//会员营销短信
        protected bool Pro3Enabled = false;//国际短信验证码
        protected bool Pro4Enabled = false;//语音验证码
        protected bool Pro5Enabled = false;//手机流量推广

        //当前用户对应产品服务是否已开通
        protected bool Pro1Opened = false;
        protected bool Pro2Opened = false;
        protected bool Pro3Opened = false;
        protected bool Pro4Opened = false;
        protected bool Pro5Opened = false;

        //用户的5个产品
        protected ProductFunds entity1, entity2, entity3, entity4, entity5;


        //产品可用余额
        protected decimal totalAvaiMoney = 0m, avaiMoney1 = 0m, avaiMoney2 = 0m, avaiMoney3 = 0m, avaiMoney4 = 0m, avaiMoney5 = 0m;
        //各产品额度
        protected long balance1 = 0, balance2 = 0, balance3 = 0, balance4 = 0, balance5 = 0;


        //当月各服务短信发送量
        protected long monthCount1 = 0, monthCount2 = 0, monthCount3 = 0, monthCount4 = 0, monthCount5 = 0;
        //当月各服务使用金额
        protected decimal totalMonthMoney = 0m, monthMoney1 = 0m, monthMoney2 = 0m, monthMoney3 = 0m, monthMoney4 = 0m, monthMoney5 = 0m;


        //余额预警
        protected string alertStatus = "", alertMoney = "";

        //认证状态
        protected int validState = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            validState = SiteUserAuth.GetValidState(TUser.UserId) ?? 0;

            if (!IsPostBack)
            {
                int op = Common.ToInt(Request["op"]);
                switch (op)
                {
                    case 1:
                        OpenProduct();//开通产品服务
                        break;
                    case 2:
                        SearchQueryJson();//当月数据使用查询
                        break;
                    default:
                        InitData();//初始化页面数据
                        break;
                }
            }

        }





        /// <summary>
        /// 初始化
        /// </summary>
        private void InitData()
        {
            //系统产品服务是否启用
            Pro1Enabled = SiteProduct.CheckStatue(1);
            Pro2Enabled = SiteProduct.CheckStatue(2);
            Pro3Enabled = SiteProduct.CheckStatue(3);
            Pro4Enabled = SiteProduct.CheckStatue(4);
            Pro5Enabled = SiteProduct.CheckStatue(5);

            //当前用户对应产品服务是否已开通
            Pro1Opened = SiteFund.CheckProOpened(TUser.UserId, 1);
            Pro2Opened = SiteFund.CheckProOpened(TUser.UserId, 2);
            Pro3Opened = SiteFund.CheckProOpened(TUser.UserId, 3);
            Pro4Opened = SiteFund.CheckProOpened(TUser.UserId, 4);
            Pro5Opened = SiteFund.CheckProOpened(TUser.UserId, 5);

            //初始化年份
            ddlYear.DataSource = Common.GetYear(TUser.CreateDate.Value.Year);//从注册年份算起
            ddlYear.DataTextField = "Value";
            ddlYear.DataValueField = "Key";
            ddlYear.DataBind();
            //ddlYear.Items.Insert(0, new ListItem("选择年份", "0"));
            ddlYear.SelectedValue = DateTime.Now.Year.ToString();
            //初始化月份
            ddlMonth.DataSource = Common.GetMonth();
            ddlMonth.DataTextField = "Value";
            ddlMonth.DataValueField = "Key";
            ddlMonth.DataBind();
            //ddlMonth.Items.Insert(0, new ListItem("选择月份", "0"));
            ddlMonth.SelectedValue = DateTime.Now.Month.ToString();

            //余额预警
            var entity = SiteFund.GetFunds(TUser.UserId);
            alertMoney = string.Format("{0:F0}", entity.EarlyWarningVal.Value);
            if (entity.EarlyWarningEnable.Value)
            {
                alertStatus = (entity.Available.Value >= entity.EarlyWarningVal.Value)
                    ? "正常"
                    : "余额不足";
            }
            else
            {
                alertStatus = "正常";
            }



            #region 从接口更新资金，若成功，则更新到数据库缓存起来，若失败，则使用数据库的缓存数据

            

            if (Pro1Opened)
            {
                entity1 = SiteFund.GetProductFunds(TUser.UserId, 1);
                balance1 = GetBalance(1);//获得剩余短信条数
                avaiMoney1 = CalcAvaiMoney(1, balance1);//获得产品剩余金额
            }
            if (Pro2Opened)
            {
                entity2 = SiteFund.GetProductFunds(TUser.UserId, 2);
                balance2 = GetBalance(2);
                avaiMoney2 = CalcAvaiMoney(2, balance2);
            }
            if (Pro3Opened)
            {
                entity3 = SiteFund.GetProductFunds(TUser.UserId, 3);
                balance3 = GetBalance(3);
                avaiMoney3 = CalcAvaiMoney(3, balance3);
            }
            if (Pro4Opened)
            {
                entity4 = SiteFund.GetProductFunds(TUser.UserId, 4);
                balance4 = GetBalance(4);
                avaiMoney4 = CalcAvaiMoney(4, balance4);
            }
            if (Pro5Opened)
            {
                entity5 = SiteFund.GetProductFunds(TUser.UserId, 5);
                balance5 = GetBalance(5);
                avaiMoney5 = CalcAvaiMoney(5, balance5);
            }

            var totalBalance = balance1 + balance2 + balance3 + balance4 + balance5;//暂无用处
            totalAvaiMoney = avaiMoney1 + avaiMoney2 + avaiMoney3 + avaiMoney4 + avaiMoney5;
            //var funds = SiteFund.GetFunds(TUser.UserId);
            //funds.Available = totalAvaiMoney;
            //SiteFund.Update(funds);

            #endregion


            #region 从接口查询数据汇总

            DateTime nowDate = DateTime.Now;
            string startDate = new DateTime(nowDate.Year, nowDate.Month, 1).ToString("yyyyMMdd");
            string endDate = new DateTime(nowDate.AddMonths(1).Year, nowDate.AddMonths(1).Month, 1).AddDays(-1).ToString("yyyyMMdd");


            if (Pro1Opened)
            {
                monthCount1 = GetQueryReportByMonth(1, startDate, endDate);//获得当月短信总发送量
                monthMoney1 = CalcUsedMoney(1, monthCount1);//获得产品使用金额
            }
            if (Pro2Opened)
            {
                monthCount2 = GetQueryReportByMonth(2, startDate, endDate);
                monthMoney2 = CalcUsedMoney(2, monthCount2);
            }
            if (Pro3Opened)
            {
                monthCount3 = GetQueryReportByMonth(3, startDate, endDate);
                monthMoney3 = CalcUsedMoney(3, monthCount3);
            }
            if (Pro4Opened)
            {
                monthCount4 = GetQueryReportByMonth(4, startDate, endDate);
                monthMoney4 = CalcUsedMoney(4, monthCount4);
            }
            if (Pro5Opened)
            {
                monthCount5 = GetQueryReportByMonth(5, startDate, endDate);
                monthMoney5 = CalcUsedMoney(5, monthCount5);
            }

            totalMonthMoney = monthMoney1 + monthMoney2 + monthMoney3 + monthMoney4 + monthMoney5;

            #endregion


        }

        /// <summary>
        /// 开户
        /// </summary>
        private void OpenProduct()
        {
            Response.ContentType = "application/json";

            int pid = Common.ToInt(Request["proId"]);
            if (pid <= 0 || pid > 5)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            switch (pid)
            {
                case 1:
                    if (Pro1Opened)
                    {
                        Response.Write(Common.Json("Err", "您已开通此服务"));
                        Response.End();
                    }
                    break;
                case 2:
                    if (Pro2Opened)
                    {
                        Response.Write(Common.Json("Err", "您已开通此服务"));
                        Response.End();
                    }
                    break;
                case 3:
                    if (Pro3Opened)
                    {
                        Response.Write(Common.Json("Err", "您已开通此服务"));
                        Response.End();
                    }
                    break;
                case 4:
                    if (Pro4Opened)
                    {
                        Response.Write(Common.Json("Err", "您已开通此服务"));
                        Response.End();
                    }
                    break;
                case 5:
                    if (Pro5Opened)
                    {
                        Response.Write(Common.Json("Err", "您已开通此服务"));
                        Response.End();
                    }
                    break;
            }

            var product_list = SiteProduct.GetPCode(pid) ?? "";//获取要开通的产品代码
            if (string.IsNullOrEmpty(product_list))
            {
                Response.Write(Common.Json("Err", "服务暂不可用"));
                Response.End();
            }

            var account = "";//要开通的帐号名，验证码通知M，国际G，语音V，后随机6位小写字母加数字
            string rdmStr = Common.RandomStr(6, true, false, true, false);
            switch (pid)
            {
                case 1://短信验证码/通知
                    account = "M" + rdmStr;
                    break;
                case 2://会员营销短信
                    account = "H" + rdmStr;
                    break;
                case 3://国际短信验证码
                    account = "G" + rdmStr;
                    break;
                case 4://语音验证码
                    account = "V" + rdmStr;
                    break;
                case 5://手机流量推广
                    account = "S" + rdmStr;
                    break;
            }

            var ac_password = Common.RandomStr(10, true, false, true, true);//帐号密码，随机10位大小写字母加数字
            var true_name = TUser.CompanyName;//企业名称
            var contact_mobile = TUser.Phone;//联系人电话

            var extnoIdxStr = SiteSettings.Get(extnoId);
            var extnoIdx = Common.ToLong(extnoIdxStr);
            var extno = SiteRdmNum.Get(extnoIdx++).PadLeft(4, '0');//扩展码

            if (extno == null)//extno用完了
            {
                Logg.Error(typeof(Account), "extno用完了，extnoIdx=" + extnoIdx);
                Response.Write(Common.Json("Err", "服务开通失败，请稍后再试(extno)"));
                Response.End();
            }


            //开户接口调用
            var api = new ShiYuanAPI();
            var result = api.UserManage(typeof(Account), account, ac_password, true_name, contact_mobile, extno, product_list);
            var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
            var str = sr.ReadLine();
            int value = -1;
            try
            {
                value = Common.ToInt(str.Split(',')[1], -1);
            }
            catch (Exception ex)
            {
                Response.Write(Common.Json("Err", str));
                Response.End();
            }

            if (value == 0)
            {
                //保存自增后的extno指针
                SiteSettings.Update(extnoId, extnoIdx.ToString());
                Logg.Info(typeof(Account), "开户成功，更新extnoIdx=" + extnoIdx);

                //保存开户信息
                ProductFunds entity = SiteFund.GetProductFunds(TUser.UserId, pid);
                entity.IsOpen = true;
                entity.SyAccount = account;
                entity.SyAccPwd = ac_password;
                entity.ExtNo = extno;
                entity.OpenDate = DateTime.Now;//add: 20160715-添加开通时间


                //开户即送N条测试短信
                var smscount = 20;
                result = api.Recharge(typeof(Account), account, smscount, 1, product_list);
                sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
                str = sr.ReadLine();

                value = -1;//重置
                try
                {
                    value = Common.ToInt(str.Split(',')[1], -1);
                    if (value == 0) //充值成功
                    {
                        var mo = smscount * 0.063m;
                        entity.ProTotalIn = mo;
                        entity.ProTotalCount = smscount;
                        entity.ProAvailable = mo;
                    }
                }
                catch (Exception ex)
                {
                    Logg.Error(typeof(Account), "开户即送" + smscount + "条测试短信，充值接口调用失败");
                }
                finally
                {
                    SiteFund.Update(entity);

                    //TODO 记录开户充值日志 FundsHistory

                    Response.Write(Common.Json("OK", "服务已开通"));
                    Response.End();
                }
            }
            else if (value == 303)
            {
                var msg = str.Split(',')[2];
                if (msg == "扩展码已存在")
                {
                    var newIdx = extnoIdx + 1;
                    SiteSettings.Update(extnoId, newIdx.ToString());
                    Logg.Debug(typeof(Account), "开户扩展码已存在，更新extnoIdx=" + newIdx);
                }
            }
            else
            {
                Response.Write(Common.Json("Err", "服务开通失败，请稍后再试(" + value + ")"));
                Response.End();
            }
        }

        /// <summary>
        /// 按月查询数据
        /// </summary>
        private void SearchQueryJson()
        {
            Response.ContentType = "application/json";

            DateTime nowMonth = DateTime.Now;

            try
            {
                var date = Request["date"];
                var dateArr = date.Split(',');
                nowMonth = new DateTime(Common.ToInt(dateArr[0]), Common.ToInt(dateArr[1]), 1);
            }
            catch
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            string startDate = new DateTime(nowMonth.Year, nowMonth.Month, 1).ToString("yyyyMMdd");
            string endDate = new DateTime(nowMonth.AddMonths(1).Year, nowMonth.AddMonths(1).Month, 1).AddDays(-1).ToString("yyyyMMdd");

            //当前用户对应产品服务是否已开通
            Pro1Opened = SiteFund.CheckProOpened(TUser.UserId, 1);
            Pro2Opened = SiteFund.CheckProOpened(TUser.UserId, 2);
            Pro3Opened = SiteFund.CheckProOpened(TUser.UserId, 3);
            Pro4Opened = SiteFund.CheckProOpened(TUser.UserId, 4);
            Pro5Opened = SiteFund.CheckProOpened(TUser.UserId, 5);

            var obj = new
            {
                pro1 = new string[2],
                pro2 = new string[2],
                pro3 = new string[2],
                pro4 = new string[2],
                pro5 = new string[2]
            };

            if (Pro1Opened)
            {
                monthCount1 = GetQueryReportByMonth(1, startDate, endDate);//获得当月短信总发送量
                monthMoney1 = CalcUsedMoney(1, monthCount1);//获得产品使用金额

                obj.pro1[0] = monthCount1.ToString();
                obj.pro1[1] = string.Format("{0:F}", monthMoney1);
            }
            if (Pro2Opened)
            {
                monthCount2 = GetQueryReportByMonth(2, startDate, endDate);
                monthMoney2 = CalcUsedMoney(2, monthCount2);

                obj.pro2[0] = monthCount2.ToString();
                obj.pro2[1] = string.Format("{0:F}", monthMoney2);
            }
            if (Pro3Opened)
            {
                monthCount3 = GetQueryReportByMonth(3, startDate, endDate);
                monthMoney3 = CalcUsedMoney(3, monthCount3);

                obj.pro3[0] = monthCount3.ToString();
                obj.pro3[1] = string.Format("{0:F}", monthMoney3);
            }
            if (Pro4Opened)
            {
                monthCount4 = GetQueryReportByMonth(4, startDate, endDate);
                monthMoney4 = CalcUsedMoney(4, monthCount4);

                obj.pro4[0] = monthCount4.ToString();
                obj.pro4[1] = string.Format("{0:F}", monthMoney4);
            }
            if (Pro5Opened)
            {
                monthCount5 = GetQueryReportByMonth(5, startDate, endDate);
                monthMoney5 = CalcUsedMoney(5, monthCount5);

                obj.pro5[0] = monthCount5.ToString();
                obj.pro5[1] = string.Format("{0:F}", monthMoney5);
            }

            Response.Write(Common.Json("OK", "操作成功", obj));
            Response.End();

        }



        /// <summary>
        /// 查询一个月之内的帐号数据汇总
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="startDate">yyyyMMdd</param>
        /// <param name="endDate">yyyyMMdd</param>
        /// <returns>读取失败返回-1，成功则>=0</returns>
        private long GetQueryReportByMonth(int pid, string startDate, string endDate)
        {
            var api = new ShiYuanAPI();

            var temp = SiteFund.GetProductFunds(TUser.UserId, pid);
            var account = temp.SyAccount;
            var result = api.QueryReportSys(typeof(Account), account ?? "", startDate, endDate);
            var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
            var str = sr.ReadLine();
            int value = -1;
            try
            {
                value = Common.ToInt(str.Split(',')[1], -1);//第一行判断操作是否成功
            }
            catch (Exception ex)
            {
                return value;
            }

            if (value == 0)
            {
                long monthCount = 0;//产品当月短信
                while (!sr.EndOfStream)
                {
                    str = sr.ReadLine();
                    monthCount += Common.ToLong(str.Split(',')[1], -1);
                }
                return monthCount;
            }
            return -1;
        }

        /// <summary>
        /// 计算产品已发短信金额
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="count"></param>
        /// <returns></returns>
        private decimal CalcUsedMoney(int pid, long count)
        {
            decimal money = 0m;
            var temp = SiteFund.GetProductFunds(TUser.UserId, pid);
            if (count >= 0)
            {
                var price = temp.ProTotalIn / temp.ProTotalCount; //计算产品单价
                money = Common.ToDecimal(count * price);
            }
            return money;
        }




        /// <summary>
        /// 获取已开通产品帐号的额度
        /// </summary>
        /// <param name="pid"></param>
        /// <returns>读取失败返回-1，成功则>=0</returns>
        private long GetBalance(int pid)
        {
            var api = new ShiYuanAPI();

            var temp = SiteFund.GetProductFunds(TUser.UserId, pid);
            var account = temp.SyAccount;
            var result = api.QueryAccountBalance(typeof(Account), account ?? "");
            var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
            var str = sr.ReadLine();
            int value = -1;
            try
            {
                value = Common.ToInt(str.Split(',')[1], -1);//第一行判断操作是否成功
            }
            catch (Exception ex)
            {
                return value;
            }

            if (value == 0)
            {
                str = sr.ReadLine();//再读一行是具体数据
                value = Common.ToInt(str.Split(',')[1], -1);
                return value;
            }
            return -1;
        }

        /// <summary>
        /// 根据产品额度计算剩余金额
        /// </summary>
        /// <param name="pid"></param>
        /// <param name="balance">产品额度</param>
        /// <returns></returns>
        private decimal CalcAvaiMoney(int pid, long balance)
        {
            decimal avaim = 0m;//剩余金额
            var temp = SiteFund.GetProductFunds(TUser.UserId, pid);
            if (balance >= 0)
            {
                var price = temp.ProTotalIn / temp.ProTotalCount; //计算产品单价
                avaim = Common.ToDecimal(balance * price); //计算剩余金额

                //保存同步信息
                temp.ProAvailable = avaim;
                temp.LastSync = DateTime.Now;
                SiteFund.Update(temp);
            }
            else
            {
                avaim = temp.ProAvailable ?? 0m;
            }
            return avaim;
        }


    }
}