<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Audio.aspx.cs" Inherits="Weetop.Web.Audio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>语音验证码_语音验证码平台_语音验证码接收平台_手机语音验证码-示远科技</title>
<meta name="keywords" content="语音验证码,语音验证码平台,语音验证码接收平台,手机语音验证码">
<meta name="description" content="语音验证码栏目展示了手机语音验证码的各种优势及价格，示远科技作为优秀的语音验证码服务商，秉承为客户提供最专业的语音验证码服务，示远一直努力中。">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="NYbanner" style="background: url(images/ny_banner06.jpg) no-repeat top center; background-size:cover; width:100%; min-width:1200px; height: 450px;">
        <div class="ny_yyyz_banner">
            <div class="NYbannerBox" style="padding-top:320px; margin-left:100px;">
                <!--<h1>语音验证码</h1>
                <h2>发送稳定快速，声音清晰<br />
                    提升用户验证率100%。</h2>-->
                <!--<input class="current" type="button" value="快速开始" onclick="javascript: location = 'member/Recharge.aspx'">
                <input type="button" value="开通产品" onclick="javascript: location = 'member/Recharge.aspx'">-->
                <input class="current" type="button" value="快速开始" onclick="javascript: location = 'member/Recharge'">
                <input type="button" value="开通产品" onclick="javascript: location = 'member/Recharge'">
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
                    <div class="NYicon NYicon09"></div>
                    <div class="shuoMing">
                        <h1>效率高</h1>
                        <p>
                            可直接影响到最有消费力的<br />
                            一族，以求最大限度提高客<br />
                            户的购买欲
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon10"></div>
                    <div class="shuoMing">
                        <h1>灵活性</h1>
                        <p>
                            发布时间极具灵活性<br />
                            广告主可以根据产品特性选择<br />
                            广告投放的具体时间段
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon11"></div>
                    <div class="shuoMing">
                        <h1>速度快</h1>
                        <p>
                            传播不受时间和地域的限制<br />
                            具有很强的散播性<br />
                            速度快，及时发送
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon12"></div>
                    <div class="shuoMing">
                        <h1>互动性</h1>
                        <p>
                            可以让机主与销售终端互动<br />
                            与大众媒体互动<br />
                            使人们参与互动的机会大增
                        </p>
                    </div>
                </div>
            </li>
        </ul>
    </div>

    <div class="NYcolumn002">
        <div class="title">
            <h1>产品价格</h1>
            <em></em>
            <span>PRODUCT PRICE</span>
        </div>
        <div class="YHBox">
            <ul>
                <li class="price">
                    <h1>语音验证码优惠包</h1>
                    <h2><span>0.060</span> 元/条</h2>
                    <p><span>1</span> 万&lt;<span>使用量</span>&le; <span>5</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = '/member/Account'">
                </li>
                <li class="price">
                    <h1>语音验证码特惠包</h1>
                    <h2><span>0.058</span> 元/条</h2>
                    <p><span>5</span> 万&lt;<span>使用量</span>&le; <span>10</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = '/member/Account'">
                </li>
                <li class="price">
                    <h1>语音验证码超值包</h1>
                    <h2><span>0.055</span> 元/条</h2>
                    <p><span>10</span> 万&lt;<span>使用量</span>&le; <span>30</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = '/member/Account'">
                </li>
                <li class="price NYcurrentYH">
                    <h1>语音验证码钻石包</h1>
                    <h2><span>0.050</span> 元/条</h2>
                    <p><span>30</span> 万&lt;<span>使用量</span>&le; <span>50</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = '/member/Account'">
                </li>
            </ul>
            <div class="price shangwu">
                <h1>语音验证码至尊包</h1>
                <p><span>使用量</span>&gt; <i>50</i> 万</p>
                <h3>请联系客服或商务</h3>
                <a href="javascript:;" class="chatgt" style="background: url(images/kefu_06.png);"></a>
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
                        <div class="CHJPic" style="background: url(images/yy01.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>会员注册</h1>
                            <h2>用于网站、手机APP应用的会员手机注册验证</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yy02.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>用户找回密码</h1>
                            <h2>用于网站、手机APP的用户找回密码验证</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yy03.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>银行卡绑定</h1>
                            <h2>用于电商网站、APP的用户银行卡绑定</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yy04.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>网上支付验证</h1>
                            <h2>用于用户在网上购物时的支付验证</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yy05.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText wow">
                            <h1>后台操作安全提醒</h1>
                            <h2>用于管理员或用户登录后台及重要操作安全提醒</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yy06.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>用户身份确认短信</h1>
                            <h2>用于用户身份确认和实名认证的提醒</h2>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="scene_contral hd">
                <ul>
                    <li><a href="javascript:;">
                        <div class=" nyc2_icon nyc2_icon01"></div>
                        会员注册</a></li>
                    <li><a href="javascript:;">
                        <div class=" nyc2_icon nyc2_icon02"></div>
                        找回密码</a></li>
                    <li><a href="javascript:;">
                        <div class=" nyc2_icon nyc2_icon03"></div>
                        银行卡绑定</a></li>
                    <li><a href="javascript:;">
                        <div class=" nyc2_icon nyc2_icon04"></div>
                        网上验证</a></li>
                    <li><a href="javascript:;">
                        <div class=" nyc2_icon nyc2_icon05"></div>
                        安全提醒</a></li>
                    <li><a href="javascript:;">
                        <div class=" nyc2_icon nyc2_icon06"></div>
                        身份确认</a></li>
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
                    <li><a href="" style="background: url(images/ny_slide16.png) no-repeat top center; background-size: cover;"></a></li>
                    <li><a href="" style="background: url(images/ny_slide17.png) no-repeat top center; background-size: cover;"></a></li>
                    <li><a href="" style="background: url(images/ny_slide18.png) no-repeat top center; background-size: cover;"></a></li>
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
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zhongcai.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/ydyc.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/jiuzhou.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/wnzx.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/dbtc.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/hbjj.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/xxb.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/yzf.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/qqaqzx.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/syxj.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/qqbb.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/bdly.png) no-repeat center center; background-size: 80%;"></a></li>
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
            <span class="line04">语音发送</span>
        </div>
    </div>


</asp:Content>
