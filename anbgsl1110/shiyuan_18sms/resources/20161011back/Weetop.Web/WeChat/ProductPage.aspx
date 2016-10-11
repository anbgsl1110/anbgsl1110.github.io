﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductPage.aspx.cs" Inherits="Weetop.Web.WeChat.ProductPage" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>电表充值服务</title>
    <link href="/js/jquery-easyui-1.4.5/themes/bootstrap/easyui.css" rel="stylesheet" />
    <link href="/js/jquery-easyui-1.4.5/themes/mobile.css" rel="stylesheet" />
    <link href="/js/jquery-easyui-1.4.5/themes/icon.css" rel="stylesheet" />
    <style type="text/css">
        body{
            margin:0;
            padding:0;
        }
        .logo {
            width: 100%;
            height: 70px;
            background: url(/Images/EleLogo.png) 0 0 no-repeat;
            background-size: 100% 100%;
            padding: 0;
            margin: 0;
        }

        .line {
            width: 100%;
            float: left;
            height: auto;
            text-align: center;
            margin-top: 10px;
        }

        .lineText {
            width: 100%;
            float: left;
            height: auto;
            text-indent: 5%;
            text-align: left;
            font-size: x-large;
            margin: 0;
        }

        .function {
            height: 60pt;
            line-height: 60pt;
            width: 45%;
            float: left;
            border-radius: 10px;
            background-color: #990000;
            margin-left: 8pt;
        }

        .title {
            font-family: "微软雅黑";
            font-size: x-large;
            color: white;
        }

        a {
            text-decoration: none;
            color: white;
        }

        input {
            vertical-align: central;
        }

        label {
            vertical-align: central;
        }

        .lbBlock {
            border: 1px solid #808080;
            background-color: grey;
            width: 90%;
            margin-left: 5%;
            font-size: x-large;
            border-radius: 10px;
            text-align: left;
            text-indent: 10pt;
            height: 30pt;
            padding-top: 5pt;
        }

        .btn {
            width: 90%;
            height: 35pt;
            font-size: x-large;
            background-color: #990000;
            color: white;
            background: url(/Images/red.png) 0 0 repeat;
            border: none;
            border-radius: 10px;
            margin: 10px 0 0 0;
        }

        .input {
            height: 30pt;
            width: 90%;
            font-size: x-large;
            border-radius: 10px;
            margin: 0;
            padding: 0;
        }
    </style>

</head>
<body>
    <div class="logo">
    </div>
    <form id="ChargeForm">        
        <div class="line">
            <div class="lineText">
                充值金额:
            </div>
        </div>
        <div class="line">
            <input type="number" id="ChargeVal" name="ChargeVal" class="input" placeholder="单位:元" />
        </div>       
    </form>
    <div class="line">
        <input type="button" class="btn" value="立即充值" onclick="fCharge()" style="margin-top: 20px;" />
    </div>
    <div class="line">
        <input type="button" id="btnHome" class="btn" value="返回主页" onclick="fBackHome()" />
    </div>
    <script src="/js/jquery.js"></script>
    <script src="/js/jquery-easyui-1.4.5/jquery.easyui.min.js"></script>
    <script src="/js/jquery-easyui-1.4.5/jquery.easyui.mobile.js"></script>
    <script src="/js/jquery-easyui-1.4.5/easyloader.js"></script>
    <script type="text/javascript">
        $(function () {
            var vCode = getQueryString("code");
            if (vCode != "" && vCode != null) {
                $.ajax({
                    type: 'post',
                    data: {
                        ac: "getWxInfo",
                        code: vCode
                    },
                    url: '/WeChat/ProductPage',
                    success: function (sjson) {
                        var parsedJson = jQuery.parseJSON(sjson);
                        console.log(parsedJson.data.openid);
                        console.log(parsedJson.data.access_token);
                    }
                })
            }
            else {
                $.ajax({
                    type: 'post',
                    data: {
                        ac: "getCode",
                    },
                    url: '/WeChat/ProductPage',
                    success: function (sjson) {
                        var parsedJson = jQuery.parseJSON(sjson);
                        if (parsedJson.code == 0) {
                            location.href = parsedJson.message;
                        }
                        else {
                            alert(parsedJson.message)
                        }
                    }
                })
            }
        })
        //获取url的参数
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }





        //初始化微信支付环境
        function fCharge() {
            if (typeof WeixinJSBridge == "undefined") {
                if (document.addEventListener) {
                    document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
                } else if (document.attachEvent) {
                    document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
                    document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
                }
            } else {
                fPostCharge();
            }
        }
        //提交充值数据
        function fPostCharge() {
            var vChargeVal = $("#ChargeVal").val();
            vChargeVal = parseFloat(vChargeVal);
            if (vChargeVal > 0) {
                $.messager.progress({
                    title: "",
                    msg: "正在调用微信支付接口,请稍后..."
                });
                $.ajax({
                    type: "post",
                    data: {
                        ac: "postCharge",
                    },
                    data: "totalfee=" + vChargeVal,
                    url: "/WeChat/ProductPage",
                    success: function (json) {
                        $.messager.progress('close');//记得关闭
                        //var json = eval("(" + msg + ")");//转换后的JSON对象
                        alert(json);
                        var parsedJson = jQuery.parseJSON(json);
                        alert(parsedJson);
                        onBridgeReady(parsedJson);
                    },
                    error: function () {
                        $.messager.progress('close');//记得关闭
                        $.messager.alert("提示", '调用微信支付模块失败，请稍后再试。', 'info')
                    }
                })
            }
            else {
                alert("房间名或者充值金额不可以为空或者为负数,请确认后再试.")
            }
        }
        //调用微信支付模块
        function onBridgeReady(json) {
            WeixinJSBridge.invoke(
           'getBrandWCPayRequest', {
               "appId": json.data.appId,     //公众号名称，由商户传入
               "timeStamp": json.data.timeStamp,         //时间戳，自1970年以来的秒数
               "nonceStr": json.data.nonceStr, //随机串
               "package": json.data.packageValue,
               "signType": "MD5",         //微信签名方式:
               "paySign": json.data.paySign //微信签名
           },
           function (res) {
               if (res.err_msg == "get_brand_wcpay_request:ok") {
                   //alert("支付成功,请稍后查询余额,如有疑问,请联系管理员.");
                   fAlreadyPay();
               }     // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
           }
            );
        }
        function fBackHome() {
            location.href = "/";
        }
    </script>
</body>
</html>
