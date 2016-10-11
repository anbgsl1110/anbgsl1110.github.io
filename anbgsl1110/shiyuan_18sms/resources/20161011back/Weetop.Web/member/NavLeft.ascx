<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavLeft.ascx.cs" Inherits="Weetop.Web.member.NavLeft" %>

<style type="text/css">
    .submenu {
        display: none;
    }
</style>

<div class="hy_left">
    <div class="hy_left1" id="hy_left1">
        <ul>
            <li><a href="Account" class="zhgl">用户中心</a></li>
            <li><a href="SignTemplate" class="fwgl">服务管理</a></li>
            <li><a href="SmsCount" class="ywtj">业务统计</a></li>
            <%--<li><a href="javascript:void(0);" class="llgl">流量管理</a></li>--%>
            <li><a href="RechargeList" class="cwgl">财务管理</a></li>
            <li><a href="ConsultSrv" class="fwzx">服务中心</a></li>
            <li><a href="Guide" class="xszy">新手指引</a></li>
        </ul>
    </div>
    <div class="hy_left2">
        <span class="submenu submenu1">
            <h1>用户中心</h1>
            <ul>
                <li><a href="Account">账户管理</a></li>
                <li><a href="Auth">认证信息</a></li>
                <li><a href="Recharge">充值</a></li>
                <li><a href="Invoice">开发票</a></li>
                <li><a href="Award">中奖信息</a></li>
            </ul>
        </span>
        <span class="submenu submenu2">
            <h1>服务管理</h1>
            <ul>
                <%--<li><a href="javascript:void(0);">短信在线发送</a></li>--%>
                <li><a href="SignTemplate">签名模板管理</a></li>
                <li><a href="SmsTemplate">短信模板管理</a></li>
                <li><a href="SensitiveWord">敏感词查询</a></li>
                <%--<li><a href="javascript:void(0);">语音管理</a></li>--%>
            </ul>
        </span>
        <span class="submenu submenu3">
            <h1>业务统计</h1>
            <ul>
                <li><a href="SmsCount">验证码发送统计</a></li>
                <li><a href="InterCount">国际验证码统计</a></li>
                <li><a href="VoiceCount">语音短信统计</a></li>
            </ul>
        </span>
        <span class="submenu submenu4">
            <h1>财务管理</h1>
            <ul>
                <li><a href="RechargeList">充值记录详细单</a></li>
                <li><a href="InvoiceList">发票申请信息</a></li>
                <%--<li><a href="hy_cwgl2">代金卷余额</a></li>--%>
            </ul>
        </span>
        <span class="submenu submenu5">
            <h1>服务中心</h1>
            <ul>
                <li><a href="ConsultSrv">咨询服务</a></li>
            </ul>
        </span>
        <span class="submenu submenu6">
            <h1>新手指引</h1>
            <ul>
                <li><a href="Guide">新手指引</a></li>
            </ul>
        </span>
    </div>
</div>
