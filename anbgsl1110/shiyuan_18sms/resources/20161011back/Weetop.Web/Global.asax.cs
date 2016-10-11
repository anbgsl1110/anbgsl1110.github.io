using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using OctoLib;
using Weetop.BLL;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            Logg.Info(typeof(Global), "###网站启动###");

            RouteConfig.RegisterRoutes(RouteTable.Routes);

            //定义定时器
            //TODO 改成根据当前时间来触发
            System.Timers.Timer myTimer = new System.Timers.Timer(4 * 60 * 60 * 1000);//每隔4小时检查一次
            myTimer.Elapsed += new System.Timers.ElapsedEventHandler(myTimer_Elapsed);
            myTimer.Enabled = true;
            myTimer.AutoReset = true;
        }

        void Application_End(object sender, EventArgs e)
        {
            Logg.Info(typeof(Global), "###网站停止###");

            //关键代码，可解决IIS应用程序池自动回收的问题
            System.Threading.Thread.Sleep(1000);

            //这里设置你的web地址，可以随便指向你的任意一个aspx页面甚至不存在的页面，目的是要激发Application_Start
            string url = "http://localhost";
            System.Net.HttpWebRequest myReq = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(url);
            System.Net.HttpWebResponse myRes = (System.Net.HttpWebResponse)myReq.GetResponse();
            System.IO.Stream receiveStream = myRes.GetResponseStream();//得到回写字节流
        }

        void myTimer_Elapsed(object source, System.Timers.ElapsedEventArgs e)
        {
            try
            {
                MyTask();
            }
            catch (Exception ex)
            {
                Logg.Error(typeof(Global), ex);
            }
        }


        void MyTask()
        {
            Logg.Info(typeof(Global), "Global.MyTask");
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var funds = db.Funds.Where(w => w.EarlyWarningEnable.Value && !w.EarlyWarningFirst.Value && w.Available.Value < w.EarlyWarningVal.Value);

                foreach (var item in funds)
                {
                    var usr = db.UserInfo.SingleOrDefault(s => s.UserId == item.UserId.Value);
                    if (usr != null)
                    {
                        //var csn = db.ConsultingServiceNexus.SingleOrDefault(s => s.cid == 2 && s.UserId == usr.UserId);
                        //var cs = db.ConsultingService.SingleOrDefault(s => s.id == csn.id);
                        //发短信
                        SendMessage(usr.Phone, item.Available.Value);

                        var fund = db.Funds.SingleOrDefault(s => s.UserId == usr.UserId);
                        string title = "用户: " + usr.Phone + "余额预警,请联系其充值!！！";
                        string content = "用户" + usr.Phone + "的可用余额为 " + fund.Available + "已经低于预警金额 " + fund.EarlyWarningVal;
                        EmailHp.SendEmail("1935388026@qq.com", title, content);
                        //SendMessage(cs.Phone, item.Available.Value);
                        //var phone = usr.Phone;
                        //var msg = string.Format(Common.AppSettings["SMSALERT"], "", ShiYuanAPI.MoneyToSms(item.Available.Value));
                        //string res = ShiYuanSMS.SendSMS(phone, msg);
                        //var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(res ?? "")));
                        //var str = sr.ReadLine();
                        //int value = -1;
                        //try
                        //{
                        //    value = Common.ToInt(str.Split(',')[1], -1);//第一行判断操作是否成功
                        //    if (value == 0)
                        //    {
                        //        item.EarlyWarningFirst = true;//首次预警
                        //    }
                        //}
                        //catch (Exception ex)
                        //{
                        //    Logg.Error(typeof(Global), ex);
                        //}
                    }
                }

                db.SubmitChanges();
            }
        }

        bool SendMessage(string phone, decimal Available)
        {
            var msg = string.Format(Common.AppSettings["SMSALERT"], "", ShiYuanAPI.MoneyToSms(Available));
            string res = ShiYuanSMS.SendSMS(phone, msg);
            var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(res ?? "")));
            var str = sr.ReadLine();
            int value = -1;
            try
            {
                value = Common.ToInt(str.Split(',')[1], -1);//第一行判断操作是否成功
                if (value == 0)
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                Logg.Error(typeof(Global), ex);
            }
            return false;
        }
    }
}