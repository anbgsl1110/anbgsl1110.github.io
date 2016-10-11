<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavTop.ascx.cs" Inherits="Weetop.Web.NavTop" %>

<div id="top_bg">
    <div class="top clearfix">
        <a class="logo_l" href="/index.aspx" title="返回首页">
            <img src="/images/neiye_logo.png" alt=""></a>
        <!--导航开始-->
        <div class="nav_z">
            <ul class="cl clearfix">
                <li>
                    <h3><a href="/">首页</a></h3>
                </li>
                <li>
                    <h3><a href="/Sms.aspx">产品</a></h3>
                    <ul class="productNav">
                        <li>
                            <dl>
                                <dt>验证码</dt>
                                <dd><a href="/Sms.aspx">短信验证码</a></dd>
                                <dd><a href="/InterSms.aspx">国际验证码</a></dd>
                                <dd><a href="/Audio.aspx">语音验证码</a></dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>通知短信</dt>
                                <dd><a href="/VipSms.aspx">会员通知短信</a></dd>
                                <dd><a href="/TradeSms.aspx">行业通知短信</a></dd>
                                <dd><a href="/MarketSms.aspx">会员营销短信</a></dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>流量</dt>
                                <dd><a href="/Flow.aspx">手机流量推广</a></dd>
                            </dl>
                        </li>
                    </ul>
                </li>
                <li>
                    <h3><a href="/Case.aspx">客户案例</a></h3>
                </li>
                <li>
                    <h3><a href="/Price.aspx">价格</a></h3>
                </li>
                <li>
                    <h3><a href="/Document.aspx">文档</a></h3>
                </li>
                <li>
                    <h3><a href="/CompanyNews.aspx">新闻中心</a></h3>
                </li>
                <li>
                    <h3><a href="/Answers.aspx">问答中心</a></h3>
                </li>
                <!--可在此处直接添加导航-->
            </ul>
        </div>
        <!--导航结束-->
        <!--js控制-->
        <div class="login">

            <% if (TUser == null)
                { %>
            <input class="fl current" type="button" value="登录" onclick="javascript: location = '/Login.aspx'">
            <input class="fr" type="button" value="注册" onclick="javascript: location = '/Register.aspx'">
            <% }
                else
                { %>
            <a href="/member/Account" style="color:#66B3FF;font-size:16px;">用户中心</a>　|　<a style="color:#66B3FF;font-size:16px;" href="javascript:void(0);" id="lkLogout">退出</a>
            <% } %>
        </div>
        <script type="text/javascript">
            $(function () {
                $(".login input")
                    .hover(function () {
                        var i = $(".login input").index(this);
                        $(".login input").eq(i).stop(false, true).addClass("current");
                        $(".login input").eq(i).siblings().stop(false, true).removeClass("current");
                    });

                //$('#lkLogout').on('click', function () {
                //    $.post('/login.aspx?op=3', {
                //        op: 3
                //    }, function (jdata) {
                //        switch (jdata.code) {
                //            case "1":
                //                window.location = '/Index';
                //                break;
                //            default:
                //                alert(jdata.message);
                //                break;
                //        }
                //    }, 'json');
                //});

                $("#lkLogout").click(function () {
                    $.post('/login.aspx?op=3', {
                        op: 3
                    }, function (jdata) {
                        switch (jdata.code) {
                            case "1":
                                window.location = '/Index';
                                break;
                            default:
                                alert(jdata.message);
                                break;
                        }
                    }, 'json');
                });
            });

        </script>
    </div>
</div>

<section class="scroll"></section>
<%--这一行只用在案例页中--%>

<div class="NYPnav" style="width: 100%; height: 100px;"></div>
