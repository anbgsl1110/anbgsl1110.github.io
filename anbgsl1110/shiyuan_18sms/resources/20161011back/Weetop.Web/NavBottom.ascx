<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavBottom.ascx.cs" Inherits="Weetop.Web.NavBottom" %>


<%
    string url = Request.Path.ToLower();
    Regex reg = new Regex(@"^((/member/)|(/Login)|(/Register)|(/FindPwd))");

    if (!reg.IsMatch(url))
    {
%>

<div class="ny_zixun">
    <div class="zixunBox">
        <a href="/Register.aspx">立即免费注册</a>
        <div class="zxPhone">
            <p>有疑问或者想要了解更多，请咨询:</p>
            <span>400-776-1818</span>
        </div>
    </div>
</div>

<% } %>


<div class="ny_downPart">
    <div class="downBox">
        <div class="about">
            <h1>关于我们</h1>
            <dl>
                <dd><a href="/About.aspx#1f" name="#1f">公司简介</a></dd>
                <dd><a href="/About.aspx#2f" name="#2f">发展历程</a></dd>
                <dd><a href="/About.aspx#3f" name="#3f">团队介绍</a></dd>
                <dd><a href="/About.aspx#4f" name="#4f">公司资质</a></dd>
                <dd><a href="/About.aspx#5f" name="#5f">公司地址</a></dd>
            </dl>
        </div>
        <div class="proNav">
            <h1>示远产品</h1>
            <dl>
                <dd><a href="/Sms.aspx">短信验证码</a></dd>
                <dd><a href="/VipSms.aspx">会员通知短信</a></dd>
                <dd><a href="/MarketSms.aspx">会员营销短信</a></dd>
                <dd><a href="/InterSms.aspx">国际短信验证码</a></dd>
                <dd><a href="/Audio.aspx">语音验证码</a></dd>
            </dl>
        </div>
        <div class="slove">
            <h1>解决方案</h1>
            <dl>
                <dd><a href="/Document.aspx">短信发送接口</a></dd>
                <dd><a href="/Document.aspx">语音发送接口</a></dd>
                <dd><a href="/Document.aspx">通道申请细则</a></dd>
                <dd><a href="/Download.aspx">开发文档下载</a></dd>
            </dl>
        </div>
        <div class="contact">
            <h1>联系我们</h1>
            <p>
            <p>
                上海公司：上海市嘉定区嘉好路700号2幢1092室<br>
                杭州公司：杭州市滨江区月明路560号正泰大厦2号楼6楼<br />
                企业官方邮箱：sayen@18sms.com<br />
                电话咨询：400-776-1818<br />
                在线咨询:<a href="javascript:void(0)"><img class="chatgt" src="/images/立即咨询.png"/></a>
            </p>
        </div>
        <div class="ewm ewm02">
            <span>
                <img src="/images/ewm01.png" alt=""></span>
            <p>
                官方微博<br />
                搜索“示远科技”
            </p>
        </div>
        <div class="ewm ewm01">
            <span>
                <img src="/images/ewm02.png" alt=""></span>
            <p>
                微信公众号<br />
                搜索“示远科技”
            </p>
        </div>
    </div>
</div>


<div class="copyright">
    <p>
        Copyright 2016 Sayen Technology 浙公安网安备 1101054456427139浙ICP备 10030443 号-11
    <a href="http://www.18sms.com" alt="示远科技" title="示远科技" target="_blank">DESIGN BY</a> : <a href="http://www.18sms.com" alt="示远科技" title="示远科技" target="_blank">示远科技</a>
        <script>
            var _hmt = _hmt || [];
            (function () {
                var hm = document.createElement("script");
                hm.src = "//hm.baidu.com/hm.js?951c0c8b04b7f1831e0af0cf6b6c6d5c";
                var s = document.getElementsByTagName("script")[0];
                s.parentNode.insertBefore(hm, s);
            })();
        </script>

    </p>
</div>
<style type="text/css">
    .copyright a img {
        display: inline;
        vertical-align: middle;
    }
</style>
