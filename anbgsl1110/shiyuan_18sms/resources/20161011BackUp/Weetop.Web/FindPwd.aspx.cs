using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GeetestSDK;
using Weetop.BLL;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web
{
    public partial class FindPwd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string op = Request["op"];
            if (!string.IsNullOrWhiteSpace(op))
            {
                switch (op)
                {
                    case "1":
                        GetCaptcha();
                        break;
                    case "2":
                        ChangePwd();
                        break;
                    case "3":
                        SendValiCode();
                        break;
                }
            }
        }



        private void GetCaptcha()
        {
            Response.ContentType = "application/json";
            Response.Write(GeeLib.GetCaptcha());
            Response.End();
        }


        private void ChangePwd()
        {
            Response.ContentType = "application/json";


            string phoneNum = Request["phone"];
            string valiCode = Request["valicode"];
            string pwd = Request["pwd"];


            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                //判断手机号是否存在
                var temp = db.UserInfo.SingleOrDefault(w => !w.IsDeleted && w.Phone == phoneNum);
                if (temp == null)
                {
                    Response.Write(Common.Json("1", "手机号码未注册"));
                    Response.End();
                }

                //TODO 检查并修改验证码有效性，写在这里并不是好方法，但这样比较简便
                SiteUser.UpdateValiCodeState();

                //判断验证码
                var temp2 = db.TempReg.SingleOrDefault(w => w.PhoneNumber == phoneNum && w.SMSCode == valiCode && (w.IsOutDate == 0 || ((DateTime)w.UpdateDate).AddMinutes(Convert.ToDouble(w.EffectiveTime)) <= DateTime.Now));
                if (temp2 == null)
                {
                    Response.Write(Common.Json("2", "验证码无效，请重新获取"));
                    Response.End();
                }

                //修改密码
                temp.Pwd = pwd;

                //使验证码无效
                var temp3 = db.TempReg.SingleOrDefault(w => w.PhoneNumber == phoneNum && w.SMSCode == valiCode);
                if (temp3 != null)
                {
                    db.TempReg.DeleteOnSubmit(temp3);//直接删除
                }

                db.SubmitChanges();


                Response.Write(Common.Json("3", "修改密码成功"));
                Response.End();

            }

        }




        private void SendValiCode()
        {
            Response.ContentType = "application/json";

            GeetestLib geetest = new GeetestLib(GeetestConfig.publicKey, GeetestConfig.privateKey);
            Byte gt_server_status_code = (Byte)Session[GeetestLib.gtServerStatusSessionKey];
            int result = 0;
            String challenge = Request.Form.Get(GeetestLib.fnGeetestChallenge);
            String validate = Request.Form.Get(GeetestLib.fnGeetestValidate);
            String seccode = Request.Form.Get(GeetestLib.fnGeetestSeccode);
            result = gt_server_status_code == 1 ? geetest.enhencedValidateRequest(challenge, validate, seccode) : geetest.failbackValidateRequest(challenge, validate, seccode);
            //if (result == 1) Response.Write("success");
            //else Response.Write("fail");

            if (result == 1)
            {
                string phoneNum = Request["phone"];
                Regex reg = new Regex(@"^1[3-9]\d{9}$");//手机号正则

                if (string.IsNullOrWhiteSpace(phoneNum) || !reg.IsMatch(phoneNum))
                {
                    Response.Write(Common.Json("1", "手机号码格式错误"));
                    Response.End();
                }

                using (DataClassesDataContext db = new DataClassesDataContext())
                {
                    //判断手机号是否存在
                    var temp = db.UserInfo.SingleOrDefault(w => !w.IsDeleted && w.Phone == phoneNum);
                    if (temp == null)
                    {
                        Response.Write(Common.Json("1", "手机号码未注册"));
                        Response.End();
                    }

                    //6位验证码
                    string guid = new Random().Next(100000, 999999).ToString();

                    //调用短信发送接口
                    var msg = string.Format(Common.AppSettings["SMSPWD"], guid);
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
                        var temp2 = db.TempReg.SingleOrDefault(w => w.PhoneNumber == phoneNum);
                        if (temp2 != null)
                        {
                            temp2.SMSCode = guid;
                            temp2.UpdateDate = DateTime.Now;
                            temp2.IsOutDate = 0;
                        }
                        else
                        {
                            TempReg treg = new TempReg
                            {
                                PhoneNumber = phoneNum,
                                SMSCode = guid,
                                EffectiveTime = 10,//分钟
                                RegDate = DateTime.Now,
                                UpdateDate = DateTime.Now,
                                IsOutDate = 0
                            };

                            db.TempReg.InsertOnSubmit(treg);
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

            else
            {
                Response.Write(Common.Json("3", "请完成滑块验证"));
                Response.End();
            }

        }
    }
}