<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Flow.aspx.cs" Inherits="Weetop.Web.Flow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>手机流量推广_手机流量营销_手机流量营销平台_流量营销平台-示远科技</title>
<meta name="keywords" content="手机流量推广,手机流量营销,手机流量营销平台,流量营销平台">
<meta name="description" content="手机流量推广栏目展示了作为示远科技的全新产品是为了帮助企业个人在营销推广环节更快更好的达到产品营销推广的效果，帮助企业产品实现更多的用户转化。">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="NYbanner" style="background: url(images/lltg.jpg) no-repeat top center; background-size:cover; width:100%; min-width:1200px; height: 450px;">
        <div class="ny_lltg_banner">
            <div class="NYbannerBox" style="padding-top:320px; margin-left:100px;">
                <!--<h1>手机流量推广</h1>
                <h2>圈层裂变式营销，病毒式传播，<br />
                    直接有效。</h2>-->
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
                    <div class="NYicon NYicon17"></div>
                    <div class="shuoMing">
                        <h1>多平台应用</h1>
                        <p>
                            帮助APP、游戏、电商<br />
                            在营销推广的环节根据用户<br />
                            的手机号码进行流量赠送
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon18"></div>
                    <div class="shuoMing">
                        <h1>裂变式传播</h1>
                        <p>
                            通过微信朋友圈<br />
                            一传十十传百的裂变式传播<br />
                            拓宽了传播面
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon19"></div>
                    <div class="shuoMing">
                        <h1>高转化率</h1>
                        <p>
                            帮助产品快速实现营销推广<br />
                            效率的提升和用户在关键<br />
                            环节的转化
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="listYSH">
                    <div class="NYicon NYicon20"></div>
                    <div class="shuoMing">
                        <h1>用户信息真实</h1>
                        <p>
                            通过移动流量包<br />
                            诱导新用户注册<br />
                            后台则自动记录信息
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
        <div class="lltg_price">
            <table>
                <tr>
                    <th>流量值</th>
                    <th>移动/面值（元）</th>
                    <th>联通/面值（元）</th>
                    <th>电信/面值（元）</th>
                    <th>示远价格（元）</th>
                </tr>
                <tr>
                    <td>10M</td>
                    <td>3</td>
                    <td>/</td>
                    <td>2</td>
                    <td>2.85 / 1.90</td>
                </tr>
                <tr>
                    <td>20M</td>
                    <td>/</td>
                    <td>3</td>
                    <td>/</td>
                    <td>2.94</td>
                </tr>
                <tr>
                    <td>30M</td>
                    <td>5</td>
                    <td>/</td>
                    <td>5</td>
                    <td>4.75</td>
                </tr>
                <tr>
                    <td>50M</td>
                    <td>/</td>
                    <td>6</td>
                    <td>7</td>
                    <td>5.88 / 6.65</td>
                </tr>
                <tr>
                    <td>70M</td>
                    <td>10</td>
                    <td>/</td>
                    <td>/</td>
                    <td>9.5</td>
                </tr>
                <tr>
                    <td>100M</td>
                    <td>/</td>
                    <td>10</td>
                    <td>10</td>
                    <td>9.8 / 9.5</td>
                </tr>
                <tr>
                    <td>150M</td>
                    <td>20</td>
                    <td>/</td>
                    <td>/</td>
                    <td>19</td>
                </tr>
                <tr>
                    <td>200M</td>
                    <td>/</td>
                    <td>15</td>
                    <td>15</td>
                    <td>14.70 / 14.25</td>
                </tr>
                <tr>
                    <td>500M</td>
                    <td>30</td>
                    <td>30</td>
                    <td>30</td>
                    <td>28.5 / 29.4 / 28.5</td>
                </tr>
                <tr>
                    <td>1G</td>
                    <td>50</td>
                    <td>/</td>
                    <td>50</td>
                    <td>47.5</td>
                </tr>
            </table>
            <div class="beizhu">
                <p>备注：以上均为含税价。</p>
            </div>
            <div class="caozuo">
                <input class="btn02" type="button" value="联系客服开通流量业务 " onclick="javascript: location = 'prepare.aspx'">
                <input class="btn03" type="button" value="立即购买" onclick="javascript: location = 'prepare.aspx'">
            </div>
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
                        <div class="CHJPic" style="background: url(images/guanzhu.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>关注送</h1>
                            <h2>扫描二维码，并关注，则送流量</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/fenxiang.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>分享送</h1>
                            <h2>针对某一活动或产品进行分享，获取种子用户，提升产品活跃度</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yaoqing.png) no-repeat 68px bottom;"></div>
                        <div class="CHJText">
                            <h1>邀请送</h1>
                            <h2>邀请好友送流量，激活用户行为，增加用户粘性</h2>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="scene_contral lltg_scene hd">
                <ul>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon13"></div>
                        用户互动</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon14"></div>
                        产品推广</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon15"></div>
                        线下活动</a></li>
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
                    <li><a href="" style="background: url(images/ny_slide08.png) no-repeat top center; background-size: cover;"></a></li>
                </ul>
            </div>
            <!--<div class="hd"><ul></ul></div>-->
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $(".ny_slider").slide({
                    titCell: ".hd ul",
                    mainCell: ".bd ul",
                    effect: "fold",
                    interTime: 3500,
                    delayTime: 500,
                    autoPlay: false,
                    autoPage: true,
                    trigger: "mouseover"
                });

            });
        </script>
    </div>
    <!--<div class="NYcolumn05">
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
    </div>-->
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
    <!--<div class="sxTitle">
    <i></i>
    <h1>优秀企业的首选</h1>
</div>
<div id="zzsc">
    <a class="pre"></a>
    <div id="wai_box">
        <div class="zzsc_box">
            <ul>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_01.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_02.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_03.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_04.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_05.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_06.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_01.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_02.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_03.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_04.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_05.png) no-repeat center center;"></a></li>
                <li><a href="" style="display:block;width:175px; height:80px; background:url(images/index_06.png) no-repeat center center;"></a></li>
            </ul>
        </div>
    </div>
    <a class="next"></a>
</div>-->
    <div class="qdTitle">
        <i></i>
        <!--<a href="Register.aspx">
            <h1>期待您的加入...</h1>
        </a>-->
        <a href="prepare.aspx">
            <h1>期待您的加入...</h1>
        </a>
    </div>
    <!--<div class="NYcolumn06">
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
    </div>-->


</asp:Content>
