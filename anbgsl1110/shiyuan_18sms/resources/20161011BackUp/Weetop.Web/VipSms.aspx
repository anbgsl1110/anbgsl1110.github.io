<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="VipSms.aspx.cs" Inherits="Weetop.Web.VipSms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>会员通知短信_短信通知_通知短信-示远科技</title>
<meta name="keywords" content="会员通知短信,短信通知,通知短信,订单短信通知">
<meta name="description" content="会员通知短信栏目展示了会员通知短信，短信通知，订单短信通知的优势、价格、应用场景等内容，示远科技短信通知坚持5秒必达，让您的网站APP得到更好的用户体验。">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="NYbanner" style="background: url(images/ny_banner04.jpg) no-repeat top center; background-size:cover; width:100%; min-width:1200px; height: 450px;">
        <div class="ny_tzdx_banner">
            <div class="NYbannerBox" style="padding-top:320px; margin-left:100px;">
                <!--<h1>会员通知短信</h1>
                <h2>速度快、免费测试<br />
                    确保发送保质保量</h2>-->
                <!--<input class="current" type="button" value="快速开始" onclick="javascript: location = 'member/Recharge.aspx'">
                <input type="button" value="开通产品" onclick="javascript: location = 'member/Recharge.aspx'">-->
                <input class="current" type="button" value="快速开始" onclick="javascript: location = 'prepare.aspx'">
                <input type="button" value="开通产品" onclick="javascript: location = 'prepare.aspx'">
            </div>
            <script type="text/javascript">
                $(function () {
                    $(".NYbannerBox input").hover(function () {
                        var i = $(".NYbannerBox input").index(this);
                        $(".NYbannerBox input").eq(i).stop(false, true).addClass("current")
                        $(".NYbannerBox input").eq(i).siblings().stop(false, true).removeClass("current")
                    })
                })
            </script>
        </div>
    </div>
    <div class="NYcolumn01">
        <div class="title">
            <h1>产品优势</h1>
            <em></em>
            <span>PRODUCT ADVANTAGE</span>
        </div>
        <ul class="NYYSlist">
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon13"></div>
                    <div class="shuoMing">
                        <h1>三网合一</h1>
                        <p>
                            移动、联通、电信三网合一<br />
                            专属发送通道<br />
                            不堵塞，通道稳定
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon14"></div>
                    <div class="shuoMing">
                        <h1>速度极快</h1>
                        <p>
                            5秒极速送达，发送速度快<br />
                            验证码和通知短信<br />
                            5秒送达不拖延
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon15"></div>
                    <div class="shuoMing">
                        <h1>免费测试</h1>
                        <p>
                            满意才购买提供免费测试接口，购买<br />
                            之前可以测试到满意为止，免除后顾<br />
                            之忧
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon16"></div>
                    <div class="shuoMing">
                        <h1>保质保量</h1>
                        <p>
                            可查看及时发送报告<br />
                            发送过程清晰透明
                        </p>
                    </div>
                </div>
            </li>
        </ul>
    </div>

    <div class="NYcolumn02">
        <div class="title">
            <h1>产品价格</h1>
            <em></em>
            <span>PRODUCT PRICE</span>
        </div>
        <div class="YHBox">
            <ul>
                <li class="price">
                    <h1>通知短信优惠包</h1>
                    <h2><span>0.058</span> 元/条</h2>
                    <p><span>5</span> 万&lt;<span>使用量</span>&le; <span>10</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = 'prepare.aspx'">
                </li>
                <li class="price">
                    <h1>通知短信特惠包</h1>
                    <h2><span>0.053</span> 元/条</h2>
                    <p><span>10</span> 万&lt;<span>使用量</span>&le; <span>20</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = 'prepare.aspx'">
                </li>
                <li class="price">
                    <h1>通知短信超值包</h1>
                    <h2><span>0.048</span> 元/条</h2>
                    <p><span>20</span> 万&lt;<span>使用量</span>&le; <span>30</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = 'prepare.aspx'">
                </li>
            </ul>
            <div class="price shangwu">
                <h1>通知短信至尊包</h1>
                <p><span>使用量</span>&gt; <i>30</i> 万</p>
                <h3>请联系客服或商务</h3>
                <a href="prepare.aspx" style="background: url(images/kefu_06.png);"></a>
            </div>
            <script type="text/javascript">
                $(function () {
                    $(".price").hover(function () {
                        var i = $(".price").index(this);
                        $(".price").eq(i).stop(false, true).addClass("NYcurrentYH")
                        $(".price").eq(i).siblings().stop(false, true).removeClass("NYcurrentYH")
                    })
                })
            </script>
        </div>
        <div class="beizhu">
        	<p>备注：以上均为含税价。</p>
        </div>
    </div>
    <div class="NYcolumn03">
        <div class="title">
            <h1>场景应用</h1>
            <em></em>
            <span>SPECTACLE APPLIANCE</span>
        </div>
        <div class="NYscene">
            <div class="scene_details bd">
                <ul>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone01.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>会员通知</h1>
                            <h2>用于网站、手机APP应用的会员通知</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone14.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>用户订单通知</h1>
                            <h2>用于网站、手机APP的用户订房通知</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone19.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>物流提醒</h1>
                            <h2>用于用户订单物流状态提醒</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone20.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>资金提醒</h1>
                            <h2>用于用户在网上资金变动提醒</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone23.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>后台操作安全提醒</h1>
                            <h2>用于管理员或用户登录后台及重要操作安全提醒</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone16.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>活动通知</h1>
                            <h2>用于用户参与活动的提醒</h2>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="scene_contral hd">
                <ul>
                    <li><a href="javascript:">
                        <div class=" nyc2_icon nyc2_icon01"></div>
                        会员注册</a></li>
                    <li><a href="javascript:">
                        <div class=" nyc2_icon nyc2_icon16"></div>
                        订单通知</a></li>
                    <li><a href="javascript:">
                        <div class=" nyc2_icon nyc2_icon17"></div>
                        物流提醒</a></li>
                    <li><a href="javascript:">
                        <div class=" nyc2_icon nyc2_icon18"></div>
                        资金提醒</a></li>
                    <li><a href="javascript:">
                        <div class=" nyc2_icon nyc2_icon19"></div>
                        后台通知</a></li>
                    <li><a href="javascript:">
                        <div class=" nyc2_icon nyc2_icon06"></div>
                        活动通知</a></li>
                </ul>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $(".NYscene").slide({
                    titCell: ".hd li",
                    mainCell: ".bd ul",
                    effect: "fold",
                    interTime: 1500,
                    delayTime: 500,
                    autoPlay: true,
                    autoPage: false,
                    trigger: "mouseover"
                });

            });
        </script>
    </div>
    <div class="NYcolumn04">
        <div class="ny_slider">
            <div class="bd">
                <ul>
                    <li><a href="" style="background: url(images/ny_slide10.png) no-repeat top center; background-size: cover;"></a></li>
                    <li><a href="" style="background: url(images/ny_slide11.png) no-repeat top center; background-size: cover;"></a></li>
                    <li><a href="" style="background: url(images/ny_slide03.png) no-repeat top center; background-size: cover;"></a></li>
                </ul>
            </div>
            <div class="hd">
                <ul></ul>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $(".ny_slider").slide({
                    titCell: ".hd ul",
                    mainCell: ".bd ul",
                    effect: "fold",
                    interTime: 3500,
                    delayTime: 500,
                    autoPlay: true,
                    autoPage: true,
                    trigger: "mouseover"
                });

            });
        </script>
    </div>
    <div class="NYcolumn05">
        <div class="jieruText">
            <h1><i>5</i><em>分钟</em>轻松接入</h1>
        </div>
        <div class="qsjr">
            <div class="jieruBox bd">
                <ul>
                    <li style="background: url(images/qsjr01.png) no-repeat;"></li>
                    <li style="background: url(images/qsjr02.png) no-repeat;"></li>
                    <li style="background: url(images/qsjr03.png) no-repeat;"></li>
                    <li style="background: url(images/qsjr04.png) no-repeat;"></li>
                </ul>
            </div>
            <div class="hd">
                <ul></ul>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".qsjr").slide({
                titCell: ".hd ul",
                mainCell: ".bd ul",
                effect: "fade",
                interTime: 2500,
                delayTime: 0,
                autoPlay: false,
                autoPage: true,
                trigger: "mouseover"
            });

        });
    </script>
    <div class="sxTitle">
        <i></i>
        <h1>优秀企业的首选</h1>
    </div>
    <div id="zzsc">
        <!--<a class="pre"></a>-->
        <div id="wai_box">
            <div class="zzsc_box">
                <ul>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/hdjt.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zssh.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/jmyp.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zhixing.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/renren.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/huaban.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/dgms.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/qcbj.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/58dj.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/bantang.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zlt.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zgqx.png) no-repeat center center; background-size: 80%;"></a></li>
                </ul>
            </div>
        </div>
        <!--<a class="next"></a>-->
    </div>
    <div class="qdTitle">
        <i></i>
        <!--<a href="Register.aspx">
            <h1>期待您的加入...</h1>
        </a>-->
        <a href="prepare.aspx">
            <h1>期待您的加入...</h1>
        </a>
    </div>
    <div class="NYcolumn06">
        <div class="title">
            <h1>运作原理</h1>
            <em></em>
            <span>OPERATION PRINCIPLE</span>
        </div>
        <div class="ny_yzyl">
            <ul>
                <li class="ny_yz01">
                    <i></i>
                    <h1>手机APP <em>+</em> 网页web</h1>
                </li>
                <li class="ny_yz02">
                    <i></i>
                    <h1>应用服务器</h1>
                </li>
                <li class="ny_yz03">
                    <i></i>
                    <h1>示远科技HTTP</h1>
                </li>
                <li class="ny_yz04">
                    <i></i>
                    <h1>三大运营商</h1>
                </li>
                <li class="ny_yz05">
                    <i></i>
                    <h1>用户手机</h1>
                </li>
            </ul>
            <span class="line01"></span>
            <span class="line02">发送请求<br />
                回调通知</span>
            <span class="line03"></span>
            <span class="line04">短信发送</span>
        </div>
    </div>


</asp:Content>
