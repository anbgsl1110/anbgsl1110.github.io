using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.SessionState;
using Weetop.BLL;
using Weetop.Model;

namespace Weetop.Web.Ashx
{
    /// <summary>
    /// Summary description for PopularizeHd
    /// </summary>
    public class PopularizeHd : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {

            string action = context.Request["ac"];
            switch (action)
            {
                case "1"://推广页获取短信验证码
                    SendValiCode(context);
                    break;
                case "2"://推广页提交数据
                    SubmitPhone(context);
                    break;
                default:
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("Hello Gay");
                    break;
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private int GetHours(DateTime DateTime1, DateTime DateTime2)
        {
            int TotalHours = 0;
            try
            {
                TimeSpan ts1 = new TimeSpan(DateTime1.Ticks);
                TimeSpan ts2 = new TimeSpan(DateTime2.Ticks);
                TimeSpan ts = ts1.Subtract(ts2).Duration();
                //0天1小时9分钟43秒
                if (ts.Days > 0)
                {
                    TotalHours += 24 * ts.Days; //24小时 * 每小时60分钟 * 几天
                }
                if (ts.Hours > 0)
                {
                    TotalHours += ts.Hours;
                }
            }
            catch
            {

            }
            return TotalHours;
        }

        private void SendValiCode(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            HttpSessionState Session = context.Session;
            HttpServerUtility Server = context.Server;


            Response.ContentType = "application/json";

            string phoneNum = Request["phone"];
            Regex reg = new Regex(@"^1[3-9]\d{9}$");//手机号正则

            if (string.IsNullOrWhiteSpace(phoneNum) || !reg.IsMatch(phoneNum))
            {
                Response.Write(Common.Json("1", "手机号码格式错误"));
                Response.End();
            }

            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                string date = DateTime.Now.ToString("yyyy-MM-dd");
                date += " 23:59:59";
                //根据手机号 判断用户是否有记录
                var temp1 = db.Popularize.SingleOrDefault(w => !w.IsDeleted && w.Mobile == phoneNum);
                if (temp1 != null)
                {
                    if (temp1.Valid == true)  //号码已经提交过
                    {
                        Response.Write(Common.Json("1", "你的号码已提交，请勿重复提交"));
                        Response.End();
                    }
                    //当用户获取验证码 但是不提交数据 会出现 temp1 ！= null  Valid == false的情况  这种情况要限制用户获取次数
                    int Hours = GetHours(Convert.ToDateTime(temp1.PostDate), Convert.ToDateTime(date)); //获取用户第一次发送短信到今天夜晚24点59分59秒 的 小时数
                    if (Hours > 24) //用户上次发送短信距离今天 超过24小时
                    {
                        temp1.PostDate = DateTime.Now;
                        temp1.SendTimes = 0; 
                        db.SubmitChanges();  //更改用户发送时间为今天 次数为0
                    }
                    else if (temp1.SendTimes >= 5 && Hours <= 24)//一天内的发送次数大于等于5时
                    {
                        Response.Write(Common.Json("1", "24小时内最多获取5次短信验证码，请勿重复获取!"));
                        Response.End();
                    }
                }
                //6位验证码
                string guid = new Random().Next(100000, 999999).ToString();

                //调用短信发送接口
                var msg = string.Format(Common.AppSettings["SMSREG"], guid);
                string res = ShiYuanSMS.SendSMS(phoneNum, msg);
                var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(res ?? "")));
                var str = sr.ReadLine();
                int value = -1;
                try
                {
                    value = Common.ToInt(str.Split(',')[1], -1);//第一行判断操作是否成功
                }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("3", str));
                    Response.End();
                }

                if (value == 0)
                {

                    //判断验证信息是否存在
                    var temp2 = db.Popularize.SingleOrDefault(w => !w.IsDeleted && w.Mobile == phoneNum);
                    if (temp2 != null)
                    {
                        temp2.SmsCode = guid;
                        temp2.SendTimes += 1;
                    }
                    else
                    {
                        var tmp = new Popularize()
                        {
                            Mobile = phoneNum,
                            SrcPath = "",
                            PostDate = DateTime.Now,
                            Remark = "",
                            SmsCode = guid,
                            Valid = false,
                            IsDeleted = false,
                            SendTimes = 1
                        };

                        db.Popularize.InsertOnSubmit(tmp);
                    }

                    db.SubmitChanges();

                    Response.Write(Common.Json("2", "短信已发送，请注意查收"));
                    Response.End();
                }
                else
                {
                    //发送失败消息
                    Response.Write(Common.Json("3", "短信发送失败，请稍后再试(" + value + ")"));
                    Response.End();
                }
            }
        }


        private void SubmitPhone(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            HttpSessionState Session = context.Session;
            HttpServerUtility Server = context.Server;


            Response.ContentType = "application/json";


            string phoneNum = Request["phone"];
            string valiCode = Request["valicode"];
            string src = Request["src"];


            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                //判断手机号是否存在
                var temp1 = db.Popularize.SingleOrDefault(w => !w.IsDeleted && w.Mobile == phoneNum && w.Valid);
                if (temp1 != null)
                {
                    Response.Write(Common.Json("1", "你的号码已提交，请勿重复提交"));
                    Response.End();
                }


                //判断验证码
                var temp2 = db.Popularize.SingleOrDefault(w => !w.IsDeleted && w.Mobile == phoneNum && w.SmsCode == valiCode);
                if (temp2 == null)
                {
                    Response.Write(Common.Json("1", "验证码无效，请重新获取"));
                    Response.End();
                }

                //更新信息
                temp2.Valid = true;
                temp2.SrcPath = src;

                db.SubmitChanges();


                Response.Write(Common.Json("2", "信息提交成功"));
                Response.End();

            }
        }
    }
}