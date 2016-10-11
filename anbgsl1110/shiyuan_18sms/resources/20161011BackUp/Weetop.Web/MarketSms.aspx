<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="MarketSms.aspx.cs" Inherits="Weetop.Web.MarketSms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>会员营销短信_营销短信_短信营销_短信营销平台-示远科技</title>
<meta name="keywords" content="会员营销短信,营销短信,短信营销,短信营销平台">
<meta name="description" content="会员营销短信栏目展示了示远科技在营销短信方面的强大优势，几年来示远深耕短信营销，势必要做中国最好的营销短信服务商。">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="NYbanner" style="background: url(images/ny_banner05.jpg) no-repeat top center; background-size:cover; width:100%; min-width:1200px; height: 450px;">
        <div class="ny_yxdx_banner">
            <div class="NYbannerBox" style="padding-top:320px; margin-left:100px;">
                <!--<h1>会员营销短信</h1>
                <h2>专享独立通道，“一路”畅通到达<br />
                    最大化提升用户体验度。</h2>-->
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

    <div class="NYcolumn02">
        <div class="title">
            <h1>产品价格</h1>
            <em></em>
            <span>PRODUCT PRICE</span>
        </div>
        <div class="YHBox">
            <ul>
                <li class="price">
                    <h1>会员营销短信优惠包</h1>
                    <h2><span>0.058</span> 元/条</h2>
                    <p><span>5</span> 万&lt;<span>使用量</span>&le; <span>12</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = 'prepare.aspx'">
                </li>
                <li class="price">
                    <h1>会员营销短信特惠包</h1>
                    <h2><span>0.053</span> 元/条</h2>
                    <p><span>10</span> 万&lt;<span>使用量</span>&le; <span>20</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = 'prepare.aspx'">
                </li>
                <li class="price">
                    <h1>会员营销短信超值包</h1>
                    <h2><span>0.048</span> 元/条</h2>
                    <p><span>20</span> 万&lt;<span>使用量</span>&le; <span>30</span>万 </p>
                    <input type="button" value="立即购买" onclick="javascript: location = 'prepare.aspx'">
                </li>
            </ul>
            <div class="price shangwu">
                <h1>会员营销短信至尊包</h1>
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
                        <div class="CHJPic" style="background: url(images/yx01.png) no-repeat left bottom;"></div>
                        <div class="CHJText">
                            <h1>电商行业</h1>
                            <h2>用于电商平台进行商品及活动促销</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yx02.png) no-repeat left bottom;"></div>
                        <div class="CHJText">
                            <h1>汽车行业</h1>
                            <h2>用于汽车行业进行商品及活动促销</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yx03.png) no-repeat left bottom;"></div>
                        <div class="CHJText">
                            <h1>教育行业</h1>
                            <h2>用于教育行业进行商品及活动促销</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yx04.png) no-repeat left bottom;"></div>
                        <div class="CHJText">
                            <h1>地产金融</h1>
                            <h2>用于地产金融业进行商品及活动促销</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yx05.png) no-repeat left bottom;"></div>
                        <div class="CHJText">
                            <h1>旅游行业</h1>
                            <h2>用于旅游行业进行商品及活动促销</h2>
                        </div>
                    </li>
                    <li class="NYsceneList">
                        <div class="CHJPic" style="background: url(images/yx06.png) no-repeat left bottom;"></div>
                        <div class="CHJText">
                            <h1>餐饮行业</h1>
                            <h2>用于餐饮行业进行商品及活动促销</h2>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="scene_contral hd">
                <ul>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon20"></div>
                        电商行业</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon21"></div>
                        汽车行业</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon22"></div>
                        教育行业</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon23"></div>
                        地产金融</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon24"></div>
                        旅游行业</a></li>
                    <li><a href="javascript:void(0);">
                        <div class=" nyc2_icon nyc2_icon25"></div>
                        餐饮行业</a></li>
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
                    <li><a href="" style="background: url(images/ny_slide13.png) no-repeat top center; background-size: cover;"></a></li>
                    <li><a href="" style="background: url(images/ny_slide14.png) no-repeat top center; background-size: cover;"></a></li>
                    <li><a href="" style="background: url(images/ny_slide15.png) no-repeat top center; background-size: cover;"></a></li>
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
        <!-- <a class="pre"></a>-->
        <div id="wai_box">
            <div class="zzsc_box">
                <ul>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/hdgf.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/wacai.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/dkyd.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zgrs.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zqzx.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/kbwm.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/yyb.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/hdf.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/edj.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/rrd.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/bhw.png) no-repeat center center; background-size: 80%;"></a></li>
                    <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/tzg.png) no-repeat center center; background-size: 80%;"></a></li>
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
