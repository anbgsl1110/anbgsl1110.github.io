<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Sms.aspx.cs" Inherits="Weetop.Web.Sms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>短信验证码_短信验证码平台_短信验证码接口_手机验证码平台-示远科技</title>
<meta name="keywords" content="短信验证码,短信验证码平台,短信验证码接口,手机验证码平台,验证码短信平台,手机短信验证码平台">
<meta name="description" content="短信验证码栏目展示了示远短信验证码，短信验证码平台，短信验证码接口，手机验证码平台产品的优势、价格、应用场景等内容，帮助客户更快更好的了解示远短信验证产品。">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="NYbanner" style="background: url(images/ny_banner01.jpg) no-repeat top center; background-size:cover; width:100%; min-width:1200px;">
        <div class="ny_products_banner">
            <div class="NYbannerBox" style="padding-top:320px; margin-left:100px;">
                <!--<h1>短信验证码</h1>
                <h2>三网合一&nbsp;&nbsp;&nbsp;正规通道&nbsp;&nbsp;&nbsp;5秒必达</h2>-->
                <!--<input class="current" type="button" value="快速开始" onclick="javascript: location = 'member/Recharge.aspx'">
                <input type="button" value="开通产品" onclick="javascript: location = 'member/Recharge.aspx'">-->
                <input class="current" type="button" value="快速开始" onclick="javascript: location = 'member/Recharge'" />
                <input type="button" value="开通产品" onclick="javascript: location = 'member/Recharge'" />
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
                    <div class="NYicon NYicon01"></div>
                    <div class="shuoMing">
                        <h1>五秒必达</h1>
                        <p>
                            一触即发，极速体验。<br />
                            给客户极致的体验，短时间内留住用<br />
                            户量，减少用户量的流失。
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon02"></div>
                    <div class="shuoMing">
                        <h1>100%到达率</h1>
                        <p>
                            保证每条验证码100%的到达率<br />
                            除客户端出现空号、停机、关机、信<br />
                            号差等特殊情况外。
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon03"></div>
                    <div class="shuoMing">
                        <h1>VIP真独享通道</h1>
                        <p>
                            专享VIP独立通道，发送量至少500条/<br />
                            秒，一客一签，确保私密数据安全。
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon04"></div>
                    <div class="shuoMing">
                        <h1>三网畅游</h1>
                        <p>
                            中国移动、中国联通、中国电信三大<br />
                            巨头运行商三网合一，直连通道，支<br />
                            持上下行双向收发。
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
                    <h1>短信验证码优惠包</h1>
                    <h2><span>0.058</span> 元/条</h2>
                    <p><span>5</span> 万&lt;<span>使用量</span>&le; <span>10</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = '/member/Account'">
                </li>
                <li class="price">
                    <h1>短信验证码特惠包</h1>
                    <h2><span>0.053</span> 元/条</h2>
                    <p><span>10</span> 万&lt;<span>使用量</span>&le; <span>20</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = '/member/Account'">
                </li>
                <li class="price">
                    <h1>短信验证码超值包</h1>
                    <h2><span>0.048</span> 元/条</h2>
                    <p><span>20</span> 万&lt;<span>使用量</span>&le; <span>30</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = '/member/Account'">
                </li>
            </ul>
            <div class="price shangwu chatgt">
                <h1>短信验证码至尊包</h1>
                <p><span>使用量</span>&gt; <i>30</i> 万</p>
                <h3>请联系客服或商务</h3>
                <a href="javascript:;" style="background: url(images/kefu_06.png);"></a>
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
                            <h1>网站 / APP会员注册</h1>
                            <h2>用于网站、手机APP应用的会员手机注册验证</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone15.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>用户找回密码</h1>
                            <h2>用于网站、手机APP的用户找回密码验证</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone22.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>银行卡绑定</h1>
                            <h2>用于电商网站、APP的用户银行卡绑定</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone13.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>网上支付验证</h1>
                            <h2>用于用户在网上购物时的支付验证</h2>
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
                        <div class="CHJPic" style="background: url(images/neiyePhone24.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>用户身份确认短信</h1>
                            <h2>用于用户身份确认和实名认证的提醒</h2>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="scene_contral hd">
                <ul>
                    <li><a href="javascript:void(0);">
                        <div class="nyc2_icon nyc2_icon01"></div>
                        会员注册</a></li>
                    <li><a href="javascript:void(0);">
                        <div class="nyc2_icon nyc2_icon02"></div>
                        找回密码</a></li>
                    <li><a href="javascript:void(0);">
                        <div class="nyc2_icon nyc2_icon03"></div>
                        银行卡绑定</a></li>
                    <li><a href="javascript:void(0);">
                        <div class="nyc2_icon nyc2_icon04"></div>
                        网上验证</a></li>
                    <li><a href="javascript:void(0);">
                        <div class="nyc2_icon nyc2_icon05"></div>
                        安全提醒</a></li>
                    <li><a href="javascript:void(0);">
                        <div class="nyc2_icon nyc2_icon06"></div>
                        身份确认</a></li>
                </ul>
            </div>
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

    <div class="NYcolumn04">
        <div class="ny_slider">
            <div class="bd">
                <ul>
                    <li><a href="" style="background:url(images/ny_slide01.png) no-repeat top center;background-size:cover;"></a></li>
                    <li><a href="" style="background:url(images/ny_slide02.png) no-repeat top center;background-size:cover;"></a></li>
                    <li><a href="" style="background:url(images/ny_slide03.png) no-repeat top center;background-size:cover;"></a></li>
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
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/index_03.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/index_01.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/lagou.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/changba.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/uber.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/miqu.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/kuwo.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/yiqixiu.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zuji.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/mzxj.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zgqx.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/gjdw.png) no-repeat center center; background-size: 80%;"></a></li>
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
        <a href="Register.aspx">
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
