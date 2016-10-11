<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="InterSms.aspx.cs" Inherits="Weetop.Web.InterSms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>国际验证码_国际短信验证码_国际短信验证码平台-示远科技</title>
    <meta name="keywords" content="国际验证码,国际短信验证码,国际短信验证码平台">
    <meta name="description" content="国际验证码栏目展示了示远国际验证码，国际短信验证码产品的优势、价格、应用场景等内容，示远科技是一家专业的国际短信验证码平台服务商并且坚持5秒必达原则，值得客户信赖。">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="NYbanner" style="background: url(images/products02_02.jpg) no-repeat top center; background-size: cover; width: 100%; min-width: 1200px; height: 450px;">
        <div class="ny_products_banner">
            <div class="NY_pro02_text" style="padding-top:320px; margin-left:60px;">
                <!--<h1>国际短信验证码</h1>
                <h2>覆盖全球用户、响应速度快<br />
                    支持自定义模板与签名。</h2>-->
                <!--<input class="current" type="button" value="快速开始" onclick="javascript: location = 'member/Recharge.aspx'">
                <input type="button" value="开通产品" onclick="javascript: location = 'member/Recharge.aspx'">-->
                <input class="current" type="button" value="快速开始" onclick="javascript: location = '/member/Account'">
                <input type="button" value="开通产品" onclick="javascript: location = '/member/Account'">
            </div>
            <script type="text/javascript">
                $(function () {
                    $(".NY_pro02_text input").hover(function () {
                        var i = $(".NY_pro02_text input").index(this);
                        $(".NY_pro02_text input").eq(i).stop(false, true).addClass("current")
                        $(".NY_pro02_text input").eq(i).siblings().stop(false, true).removeClass("current")
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
                    <div class="NYicon NYicon05"></div>
                    <div class="shuoMing">
                        <h1>全球覆盖</h1>
                        <p>
                            覆盖全球用户<br />
                            支持全球200多个国家和地区用户
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon06"></div>
                    <div class="shuoMing">
                        <h1>极速响应</h1>
                        <p>
                            响应速度快<br />
                            短信瞬间到达
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon07"></div>
                    <div class="shuoMing">
                        <h1>安全保障</h1>
                        <p>
                            可绑定ip<br />
                            防止盗号
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon08"></div>
                    <div class="shuoMing">
                        <h1>实时预警</h1>
                        <p>
                            发送记录实时分析<br />
                            账户异常发送实时预警
                        </p>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <div class="ny_pro02">
        <div class="title">
            <h1>产品价格</h1>
            <em></em>
            <span>PRODUCT PRICE</span>
        </div>
        <div class="pro02_price">
            <h1>0.80<b></b></h1>
            <i></i>
            <p><span>国际短信验证码</span>全国统一低价，无地域限制，最低起充数量1万条。</p>
            <input type="button" value="立即购买" onclick="javascript: location = 'prepare.aspx'">
        </div>
    </div>
    <div class="ny_pro03">
        <div class="title">
            <h1>场景应用</h1>
            <em></em>
            <span>SPECTACLE APPLIANCE</span>
        </div>
        <div class="NYscene">
            <div class="scene_details bd">
                <ul>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone14.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>订单通知短信</h1>
                            <h2>适用于同电子商务网站、企业内部管理系统进行整合；可应用于手机验证、订单通知、快递跟踪、会员提醒等</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone19.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>物流提醒短信</h1>
                            <h2>用于网站、手机APP的用户找回密码验证</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone20.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>资金变动提醒短信</h1>
                            <h2>用于电商网站、APP的用户银行卡绑定</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone15.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>后台操作提醒短信</h1>
                            <h2>用于用户在网上购物时的支付验证</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone17.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>用户身份确认短信</h1>
                            <h2>用于管理员或用户登录后台及重要操作安全提醒</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/neiyePhone18.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>其他验证短信</h1>
                            <h2>用于用户身份确认和实名认证的提醒</h2>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="scene_contral hd">
                <ul>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon07"></div>
                        订单通知短信</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon08"></div>
                        物流提醒短信</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon09"></div>
                        资金变动提醒短信</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon10"></div>
                        后台操作提醒短信</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon11"></div>
                        用户身份确认短信</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon12"></div>
                        其他验证短信</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!--scene-->
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

    <!--scene-->
    <div class="NYcolumn04">
        <div class="ny_slider">
            <div class="bd">
                <ul>
                    <li><a href="" style="background: url(images/ny_slide04.png) no-repeat top center; background-size: cover;"></a></li>
                    <li><a href="" style="background: url(images/ny_slide05.png) no-repeat top center; background-size: cover;"></a></li>
                    <li><a href="" style="background: url(images/ny_slide06.png) no-repeat top center; background-size: cover;"></a></li>
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
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/kuaipan.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/yitao.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/lhdt.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/szzc.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/tuniu.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/hbgj.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/tqt.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/jdb.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/jtyh.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/dd.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/ccj.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/cgtz.png) no-repeat center center; background-size: 80%;"></a></li>
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
    <div class="ny_pro04">
        <div class="title">
            <h1>运作原理</h1>
            <em></em>
            <span>OPERATION PRINCIPLE</span>
        </div>
        <div class="ny_yzyl">
            <ul>
                <li class="ny_yz01" style="margin-right:47px;">
                    <i></i>
                    <h1>手机APP <em>+</em> 网页web</h1>
                </li>
                <li class="ny_yz02" style="margin-right:47px;">
                    <i></i>
                    <h1>应用服务器</h1>
                </li>
                <li class="ny_yz03" style="margin-right:47px;">
                    <i></i>
                    <h1>示远科技HTTP</h1>
                </li>
                <li class="ny_yz04" style="margin-right:47px;">
                    <i></i>
                    <h1>三大运营商</h1>
                </li>
                <li class="ny_yz05" style="margin-right:47px;">
                    <i></i>
                    <h1>海外运营商</h1>
                </li>
                <li class="ny_yz06" style="margin-right:47px;">
                    <i></i>
                    <h1>用户手机</h1>
                </li>
            </ul>
            <span class="line001"></span>
            <span class="line002">发送请求<br />
                回调通知</span>
            <span class="line003"></span>
            <span class="line004"></span>
            <span class="line005">短信发送</span>
        </div>
    </div>



</asp:Content>
