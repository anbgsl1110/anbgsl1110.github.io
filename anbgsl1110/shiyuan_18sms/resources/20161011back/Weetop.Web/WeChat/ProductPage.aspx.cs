using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TenPay.business;
using TenPay.lib;

namespace Weetop.Web.WeChat
{
    public partial class ProductPage : System.Web.UI.Page
    {
        JsApiPay jsApiPay = new JsApiPay();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string action = Request["ac"] == null ? "" : Request["ac"].ToString();
                switch (action)
                {
                    case "getCode":
                        getCode();
                        break;
                    case "getWxInfo":
                        getWxInfo();
                        break;
                    case "postCharge":
                        MeterRecharge();
                        break;
                    default:
                        if (Session["openid"] == null)
                        {
                            try
                            {
                                //调用【网页授权获取用户信息】接口获取用户的openid和access_token
                                GetOpenidAndAccessToken();

                            }
                            catch (Exception ex)
                            {
                                //Response.Write(ex.ToString());
                                //throw;
                            }
                        }
                        break;
                }
            }
        }

        /**
        * 
        * 网页授权获取用户基本信息的全部过程
        * 详情请参看网页授权获取用户基本信息：http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html
        * 第一步：利用url跳转获取code
        * 第二步：利用code去获取openid和access_token
        * 
        */
        public void GetOpenidAndAccessToken()
        {
            if (Session["code"] != null)
            {
                //获取code码，以获取openid和access_token
                string code = Session["code"].ToString();
                jsApiPay.GetOpenidAndAccessTokenFromCode(code);
            }
            else
            {
                //构造网页授权获取code的URL
                string host = Request.Url.Host;
                string path = Request.Path;
                string redirect_uri = HttpUtility.UrlEncode("http://" + host + path);
                //string redirect_uri = HttpUtility.UrlEncode("http://gzh.lmx.ren");
                WxPayData data = new WxPayData();
                data.SetValue("appid", WxPayConfig.APPID);
                data.SetValue("redirect_uri", redirect_uri);
                data.SetValue("response_type", "code");
                data.SetValue("scope", "snsapi_base");
                data.SetValue("state", "STATE" + "#wechat_redirect");
                string url = "https://open.weixin.qq.com/connect/oauth2/authorize?" + data.ToUrl();
                Session["url"] = url;
            }
        }


        /// <summary>
        /// 获取code
        /// </summary>
        /// <returns></returns>
        public void getCode()
        {
            if (Session["url"] != null)
            {
                Response.Write(Common.Json("0", Session["url"].ToString()));
            }
            else
            {
                Response.Write(Common.Json("1", "请重新页面后重试!!!"));
            }
            Response.End();
        }


        /// <summary>
        /// 通过code换取网页授权access_token和openid的返回数据
        /// </summary>
        /// <returns></returns>
        public void getWxInfo()
        {
            try
            {
                object objResult = "";
                string strCode = Request.Form["code"];
                if (Session["access_token"] == null || Session["openid"] == null)
                {
                    jsApiPay.GetOpenidAndAccessTokenFromCode(strCode);
                }
                string strAccess_Token = Session["access_token"].ToString();
                string strOpenid = Session["openid"].ToString();
                objResult = new { openid = strOpenid, access_token = strAccess_Token };
                Response.Write(Common.Json("0", "dataInfo", objResult));
                Response.End();
            }
            catch (Exception)
            {
                throw;
            }
        }




        /// <summary>
        /// 充值
        /// </summary>
        /// <returns></returns>
        public void MeterRecharge()
        {
            object objResult = "";
            string strTotal_fee = Request.Form["totalfee"];
            string strFee = (double.Parse(strTotal_fee) * 100).ToString();

            //若传递了相关参数，则调统一下单接口，获得后续相关接口的入口参数
            jsApiPay.openid = Session["openid"].ToString();
            jsApiPay.total_fee = int.Parse(strFee);

            //JSAPI支付预处理
            try
            {
                string strBody = "测试微信支付";//商品描述
                WxPayData unifiedOrderResult = jsApiPay.GetUnifiedOrderResult(strBody);
                WxPayData wxJsApiParam = jsApiPay.GetJsApiParameters();//获取H5调起JS API参数

                ModelForOrder aOrder = new ModelForOrder()
                {
                    appId = wxJsApiParam.GetValue("appId").ToString(),
                    nonceStr = wxJsApiParam.GetValue("nonceStr").ToString(),
                    packageValue = wxJsApiParam.GetValue("package").ToString(),
                    paySign = wxJsApiParam.GetValue("paySign").ToString(),
                    timeStamp = wxJsApiParam.GetValue("timeStamp").ToString(),
                    msg = "成功下单,正在接入微信支付."
                };
                objResult = aOrder;
            }
            catch (Exception ex)
            {
                ModelForOrder aOrder = new ModelForOrder()
                {
                    appId = "",
                    nonceStr = "",
                    packageValue = "",
                    paySign = "",
                    timeStamp = "",
                    msg = "下单失败，请重试,多次失败,请联系管理员."
                };
                objResult = aOrder;
            }
            Response.Write(Common.Json("0", "dataInfo", objResult));
            Response.End();
        }
    }
}