<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Weetop.Web.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>示远科技官网 - 短信验证码,语音验证码,通知短信,短信营销首选平台</title>
    <metahttp-equiv="X-UA-Compatible"content="IE=8" />
    <metahttp-equiv="X-UA-Compatible"content="IE=7" />
    <meta name="keywords" content="短信验证码,语音验证码,短信营销,通知短信,国际短信,短信验证码平台,短信验证码接口,短信通道,短信平台,短信接口">
    <meta name="description" content="示远信息科技有限公司具有5年通信产业3年短信验证码通道运营服务经验，我们提供短信验证码，语音验证码，短信平台，短信接口，短信营销，通知短信，国际短信，短信验证码平台，短信验证码接口，短信通道等产品，坚持5秒必达、短信到达率100%的原则，持续为客户提供最优质短信通道，咨询热线：400-776-1818">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="sy_banner">
        <div class="imgBox bd">
            <ul>
                <li><a style="background: url(images/sy_banner01.jpg) no-repeat top center; background-size: cover;">
                    <div style="width: 1160px; height: 450px; margin: 0 auto;">
                        <div class="NYbannerBox" style="margin-left: 438px; padding-top: 315px;">
                            <input type="button" value="" onclick="javascript: location = '/member/Recharge.aspx'" style="width:129px; height: 44px;  cursor: pointer;background:none;margin-right:22px ">
                            <input type="button" value="" onclick="javascript: location = '/Activity'" style="width:129px; height: 44px;  cursor: pointer;background:none; ">
                        </div>
                            
                    </div>
                </a></li>
                <li><a style="background: url(images/sy_banner02.jpg) no-repeat top center; background-size: cover;">
                    <div style="width: 1160px; height: 450px; margin: 0 auto;">
                        <div style="margin-left: 480px; padding-top: 349px;">
                            <input type="button" value="立即充值" onclick="javascript: location = '/member/Recharge.aspx'" style="width: 218px; height: 56px; background: #fff; color: #460070; cursor: pointer; font-size: 25px;">
                        </div>
                    </div>
                </a></li>
                <li><a style="background: url(images/sy_banner03.jpg) no-repeat top center; background-size: cover;">
                    <div style="width: 1160px; height: 450px; margin: 0 auto;">
                        <div style="margin-left: 105px; padding-top: 300px;">
                            <input type="button" value="立即加入我们" onclick="javascript: location = '/member/Recharge.aspx'" style="width: 182px; height: 39px; background: none; border: 1px solid #fff; color: #fff; cursor: pointer; font-size: 18px;">
                        </div>
                    </div>
                </a></li>
                <li><a style="background: url(images/sy_banner04.jpg) no-repeat top center; background-size: cover;">
                    <div style="width: 1160px; height: 450px; margin: 0 auto;">
                        <div class="NYbannerBox1" style="padding-top: 300px; margin-left: 100px;">
                            <input type="button" value="立即开启" onclick="javascript: location = '/member/Recharge.aspx'">
                            <input class="current" type="button" value="快速了解" onclick="javascript: location = 'Sms.aspx'">
                        </div>
                    </div>
                    <script type="text/javascript">
                        $(function () {
                            $(".NYbannerBox1 input").hover(function () {
                                var i = $(".NYbannerBox1 input").index(this);
                                $(".NYbannerBox1 input").eq(i).stop(false, true).addClass("current")
                                $(".NYbannerBox1 input").eq(i).siblings().stop(false, true).removeClass("current")
                            })
                        })
                    </script>
                </a></li>
            </ul>
            
        </div>
        <div class="dot hd">
            <ul></ul>
        </div>
        <a href="javascript:void(0);" class="prev"></a>
        <a href="javascript:void(0);" class="next"></a>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".sy_banner").hover(function () {
                $(".sy_banner .prev,.sy_banner .next").stop(true, false).css("opacity", "0.5");
            }, function () {
                $(".sy_banner .prev,.sy_banner .next").stop(true, false).css("opacity", "0");
            });
            $(".sy_banner").slide({
                titCell: ".hd ul",
                mainCell: ".bd ul",
                effect: "fold",
                interTime: 3500,
                delayTime: 500,
                autoPlay: true,
                autoPage: true,
                trigger: "click"
            });

        });
    </script>
    <div class="column01">
        <div class="title">
            <h1>示远产品</h1>
            <em></em>
            <span>PRODUCT ADVANTAGE</span>
        </div>
        <ul>
            <li>
                <div class="pro_icon pro_icon01"></div>
                <h2>短信验证码</h2>
                <p>
                    三网合一，正规通道<br />
                    5秒极速响应<br />
                    平台稳定&nbsp;快速到达.
                </p>
                <a href="Sms.aspx">了解详情</a>
            </li>
            <li>
                <div class="pro_icon pro_icon02"></div>
                <h2>会员通知短信</h2>
                <p>
                    速度快<br />
                    免费测试<br />
                    确保发送&nbsp;保质保量
                </p>
                <a href="VipSms.aspx">了解详情</a>
            </li>
            <li>
                <div class="pro_icon pro_icon03"></div>
                <h2>会员营销短信</h2>
                <p>
                    专享独立通道<br />
                    “一路”畅通到达<br />
                    最大化提升用户体验
                </p>
                <a href="MarketSms.aspx">了解详情</a>
            </li>
            <li>
                <div class="pro_icon pro_icon04"></div>
                <h2>国际短信验证码</h2>
                <p>
                    媲美国内速度<br />
                    覆盖全球70亿用户<br />
                    支持自定义模板和签名
                </p>
                <a href="InterSms.aspx">了解详情</a>
            </li>
            <li>
                <div class="pro_icon pro_icon05"></div>
                <h2>语音验证码</h2>
                <p>
                    发送稳定快速<br />
                    声音清晰<br />
                    提升用户验证率100%
                </p>
                <a href="Audio.aspx">了解详情</a>
            </li>
        </ul>
    </div>
    <div class="column02">
        <div class="title">
            <h1>场景应用</h1>
            <em></em>
            <span>SPECTACLE APPLIANCE</span>
        </div>
        <div class="scene">
            <div class="imgBox bd">
                <ul>
                    <li>
                        <div class="clearfix">
                            <span class="fr">
                                <h2 class="Btitle"><em>网站、APP会员注册</em><br />
                                    <i>用于网站、手机APP应用的会员手机注册验证，有利于客户管理</i></h2>
                                <h3 class="subtitle"><a href="Sms.aspx" class="btn">了解更多</a>&nbsp;&nbsp;&nbsp;<a href="/Register">立即开始</a></h3>
                            </span>
                            <b class="fl">
                                <img src="images/neiyePhone01.png" /></b>
                        </div>
                    </li>
                    <li>
                        <div class="clearfix">
                            <span class="fr">
                                <h2 class="Btitle"><em>商家促销、广告推广</em><br />
                                    <i>针对某一新的产品或者服务，希望会员用户和潜在用户知道了解，进行推广</i></h2>
                                <h3 class="subtitle"><a href="MarketSms.aspx" class="btn">了解更多</a>&nbsp;&nbsp;&nbsp;<a href="/Register">立即开始</a></h3>
                            </span>
                            <b class="fl">
                                <img src="images/neiyePhone21.png" /></b>
                        </div>
                    </li>
                    <li>
                        <div class="clearfix">
                            <span class="fr">
                                <h2 class="Btitle"><em>会员通知</em><br />
                                    <i>针对客户对某一件事情的告知和通知，无任何营销推广性质的，用于提醒和通知用户</i></h2>
                                <h3 class="subtitle"><a href="VipSms.aspx" class="btn">了解更多</a>&nbsp;&nbsp;&nbsp;<a href="/Register">立即开始</a></h3>
                            </span>
                            <b class="fl">
                                <img src="images/neiyePhone16.png" /></b>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="dot hd">
                <ul class="sequence-pagination">
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </div>
            <a class="prev" href="javascript:void(0);"></a>
            <a class="next" href="javascript:void(0);"></a>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".scene").hover(function () {
                $(".scene .prev,.scene .next").stop(true, false).css("opacity", "1");
            }, function () {
                $(".scene .prev,.scene .next").stop(true, false).css("opacity", "0");
            });
            $(".scene").slide({
                titCell: ".hd li",
                mainCell: ".bd ul",
                effect: "fold",
                interTime: 3500,
                delayTime: 1500,
                autoPlay: true,
                autoPage: false,
                trigger: "click"
            });
        });
    </script>
    <script type="text/javascript">
        $(function () {
            $(".subtitle a").hover(function () {
                var i = $(".subtitle a").index(this);
                $(".subtitle a").eq(i).stop(false, true).addClass("btn")
                $(".subtitle a").eq(i).siblings().stop(false, true).removeClass("btn")
            })
        })
    </script>
    <div class="column03">
        <div class="title">
            <h1>示远优势</h1>
            <em></em>
            <span>COMPANY ADVANTAGE</span>
        </div>
        <ul>
            <li>
                <div class="ysList">
                    <div class="img img01"></div>
                    <div class="text">
                        <h1>三网合一</h1>
                        <p>
                            与中国移动、联通和电信<br />
                            三大运营商强强联合。
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="ysList">
                    <div class="img img02"></div>
                    <div class="text">
                        <h1>及时解决问题</h1>
                        <p>
                            不管是何时何地5分钟内为<br />
                            客户解决技术疑难。
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="ysList">
                    <div class="img img03"></div>
                    <div class="text">
                        <h1>10690专属通道</h1>
                        <p>
                            10690行业专属短信验证码通<br />
                            道，工信部颁发资质证书。
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="ysList">
                    <div class="img img04"></div>
                    <div class="text">
                        <h1>7*24小时服务</h1>
                        <p>
                            7*24小时全天候服务于每个<br />
                            客户，极致是我们的态度。
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="ysList">
                    <div class="img img05"></div>
                    <div class="text">
                        <h1>客户回访</h1>
                        <p>
                            对客户进行专访报道，提升<br />
                            品牌知名度及个人形象。
                        </p>
                    </div>
                </div>
            </li>
            <li>
                <div class="ysList">
                    <div class="img img06"></div>
                    <div class="text">
                        <h1>举办沙龙</h1>
                        <p>
                            举办座谈会，构建互联、互<br />
                            助、互通的移动互联网平台。
                        </p>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <div class="column04">
        <div class="title">
            <h1>合作伙伴</h1>
            <em></em>
            <span>COOPERATIVE PARTNER</span>
        </div>
        <div id="zzsc">
            <div id="wai_box">
                <div class="zzsc_box bd">
                    <ul>
                        <li>
                            <ul>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/index_01.png) no-repeat center center; background-size: 65%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/lagou.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/index_03.png) no-repeat center center; background-size: 65%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/changba.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/uber.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zhongcai.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zgrs.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/tuniu.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/dd.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/yiqixiu.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/miqu.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/kuwo.png) no-repeat center center; background-size: 80%;"></a></li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zuji.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/mzxj.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zgqx.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/gjdw.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/ydyc.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/jiuzhou.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/wnzx.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/dbtc.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/hbjj.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/xxb.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/yzf.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/qqaqzx.png) no-repeat center center; background-size: 80%;"></a></li>
                            </ul>
                        </li>
                        <li>
                            <ul>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/syxj.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/qqbb.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/bdly.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/hdjt.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zssh.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/jmyp.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/zhixing.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/renren.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/huaban.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/dgms.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/qcbj.png) no-repeat center center; background-size: 80%;"></a></li>
                                <li><a href="javascript:void(0);" style="display: block; width: 175px; height: 80px; background: url(images/58dj.png) no-repeat center center; background-size: 80%;"></a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <a href="javascript:;" class="prev"></a>
                <a href="javascript:;" class="next"></a>
                <div class="nav hd">
                    <ul></ul>
                </div>
            </div>
        </div>
        <script type="text/javascript">

            $(document).ready(function () {
                $("#wai_box").hover(function () {
                    $("#wai_box .prev,#wai_box .next").stop(true, false).css("display", "block");
                }, function () {
                    $("#wai_box .prev,#wai_box .next").stop(true, false).css("display", "none");
                });

                $("#wai_box").slide({
                    titCell: ".hd ul",
                    mainCell: ".bd>ul",
                    effect: "leftLoop",
                    interTime: 3500,
                    delayTime: 1500,
                    autoPlay: true,
                    autoPage: true,
                    trigger: "click"
                });
                $(".Report").hover(function () {
                    $(".Review").removeClass("choose");
                    $(".FAQ").removeClass("choose");
                    $(".Report").addClass("choose");
                    $(".view").removeClass("show").addClass("hide");
                    $(".answer").removeClass("show").addClass("hide");
                    $(".news").removeClass("hide").addClass("show");

                    
                    $("#khhf").hide();
                    $("#dwdzx").hide();
                    $("#dmtbd").show();
                    $("#gds").attr("href", "CompanyNews");

                    

                    $("#imgmt").attr("src", "images/mediasign.png");

                    $("#imgwd").attr("src", "images/answerSign.png");
                    $("#imgkh").attr("src", "images/custmerSign.png");
                });
                $(".Review").hover(function () {
                    $(".Report").removeClass("choose");
                    $(".FAQ").removeClass("choose");
                    $(".Review").addClass("choose");
                    $(".news").removeClass("show").addClass("hide");
                    $(".answer").removeClass("show").addClass("hide");
                    $(".view").removeClass("hide").addClass("show");
                    $("#dmtbd").hide();
                    $("#dwdzx").hide();
                    $("#khhf").show();
                    $("#gds").attr("href", "Feedback");

                    
                    $("#imgkh").attr("src", "images/kh_icon.png");

                    $("#imgmt").attr("src", "images/mt.png");
                    $("#imgwd").attr("src", "images/answerSign.png");
                });
                $(".FAQ").hover(function () {
                    $(".Report").removeClass("choose");
                    $(".Review").removeClass("choose");
                    $(".FAQ").addClass("choose");
                    $(".view").removeClass("show").addClass("hide");
                    $(".news").removeClass("show").addClass("hide");
                    $(".answer").removeClass("hide").addClass("show");
                    $("#dmtbd").hide();
                    $("#khhf").hide();
                    $("#dwdzx").show();
                    $("#gds").attr("href", "Answers"); //这里设置链接地址
                    $("#imgwd").attr("src", "images/wd_icon.png");


                    $("#imgmt").attr("src", "images/mt.png");
                    $("#imgkh").attr("src", "images/custmerSign.png");
                });
            });
        </script>
    </div>
    <div class="mediaCenterBg">
       <div class="columnChoose">
            <div class="item">
                <div>
                    <img id="imgmt" src="images/mediasign.png"/>
                    <span class="choose Report" >媒体报道</span>
                </div>
            </div >
           <div class="item">
               <div>
                    <img id="imgkh" src="images/custmerSign.png"/>
                    <span class="Review">客户回访</span>
               </div>
           </div>
           <div class="item">
               <div>
                    <img id="imgwd" src="images/answerSign.png"/>
                    <span class="FAQ">问答中心</span>
               </div>
           </div>
           <div class="more">
               <span><a href="CompanyNews" id="gds">更多></a></span>
           </div>
        </div>
        <div class="news show" id="dmtbd">
            <li><a href=""></a></li>
            <div class="newsLeft">
            <img src="images/mtbd.jpg"/>
            <span>
                <b class="NLtitle"><a href="NewsDetails.aspx?catid=<%= news1.CateId %>&id=<%= news1.Id %>" style="color:#3a3a3a;"><%= news1.Title %></a> </b>
                <b class="NLcontent"><%=news1.Content.ToString().RemoveHtmlTag(140) %>........</b>
                <div class="sourcebox">
                <b class="source"><%= news1.Source %></b>
                <b class="source"><%= news1.PostDate %></b>
                </div>
            </span>
        </div>
        <div class="newsRight">
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                        <div class="newsItem">
                    <%--<img src=""/>--%>
                        <span>
                            <b class="Itemtitle" style="padding-bottom:20px">
                                <a href="NewsDetails.aspx?catid=<%# Eval("CateId") %>&id=<%# Eval("Id") %>"  ><%# Eval("Title").ToString().RemoveHtmlTag(20) %></b></a> 
                            <b class="Itemcontent" style="float:right"><%# ((DateTime)Eval("PostDate")).ToString("yyyy-MM-dd") %>
                           <%-- <b class="Itemcontent"><%# Eval("Content").ToString().RemoveHtmlTag(50) %>--%>
                        </b>
                        </span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
                
            
       <div class="view hide"> </div>
       <div class="answer hide"> </div>
    </div>

        <div class="news show" id="khhf" style="display:none;">
                <li><a href=""></a></li>
                <div class="newsLeft">
                <img src="images/kh.jpg"/>
               <span>
                   <b class="NLtitle"><a href="NewsDetails.aspx?catid=<%= news2.CateId %>&id=<%= news2.Id %>" style="color:#3a3a3a;"><%= news2.Title %></a> </b>
                   <b class="NLcontent"><%= news2.Content.ToString().RemoveHtmlTag(120) %>........</b>
                   <div class="sourcebox">
                    <b class="source"><%= news2.Source %></b>
                   <b class="source"><%= news2.PostDate %></b>
                   </div>
               </span>
           </div>
            <div class="newsRight">
                <asp:Repeater ID="Repeater2" runat="server">
                    <ItemTemplate>
                        <div class="newsItem" style="overflow:hidden">
                       <%-- <img src=""/>--%>
                            <span>
                            <b class="Itemtitle"  style="padding-bottom:18px">
                                <a href="NewsDetails.aspx?catid=<%# Eval("CateId") %>&id=<%# Eval("Id") %>"  ><%# Eval("Title").ToString().RemoveHtmlTag(20) %></b></a> 
                                <b class="Itemcontent" style="float:right"><%# ((DateTime)Eval("PostDate")).ToString("yyyy-MM-dd") %>
                            
                            </b>
                            </span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
          </div>
                
            
       <div class="view hide"> </div>
       <div class="answer hide"> </div>
    </div>

        <div class="news show" id="dwdzx" style="display:none">
                <li><a href=""></a></li>
                <div class="newsLeft">
                <img src="images/wdzx.jpg"/>
               <span>
                   <%if (news3 != null)
                     {%>
                         <b class="NLtitle"><a href="AnswersDetail/dxsms/<%= news3.Id %>"  style="color:#3a3a3a;"><%= news3.Title %></a> </b>
                         <b class="NLcontent"><%= news3.Content.ToString().RemoveHtmlTag(140) %>........</b>
                         <div class="sourcebox">
                         <b class="source"><%= news3.Source %></b>
                         <b class="source"><%= news3.PostDate %></b>
                         </div>
                  <%   } %>
                   
               </span>
           </div>
            <div class="newsRight">
                <asp:Repeater ID="Repeater3" runat="server">
                    <ItemTemplate>
                        <div class="newsItem" style="overflow:hidden">
<%--                        <img src=""/>--%>
                            <span>
                            <b class="Itemtitle"  style="padding-bottom:18px">
                                <a href="AnswersDetail/<%#GetCateName(long.Parse(Eval("CateId").ToString()))%>/<%# Eval("Id") %>" ><%# Eval("Title").ToString().RemoveHtmlTag(20) %></b></a> 
                           <b class="Itemcontent" style="float:right"><%# ((DateTime)Eval("PostDate")).ToString("yyyy-MM-dd") %>
                           <%-- <b class="Itemcontent"><%# Eval("Content").ToString().RemoveHtmlTag(50) %>--%>
                            </b>
                            </span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
          </div>
                
            
       <div class="view hide"> </div>
       <div class="answer hide"> </div>
    </div>
     </div>
      
    <!-- WPA Button Begin -->
    <style type="text/css">
        /* suspend */
        .suspend {
            width: 40px;
            height: 198px;
            position: fixed;
            top: 400px;
            right: 0;
            overflow: hidden;
            z-index: 9999;
        }

            .suspend dl {
                width: 120px;
                height: 198px;
                border-radius: 25px 0 0 25px;
                padding-left: 40px;
                box-shadow: 0 0 5px #e4e8ec;
            }

                .suspend dl dt {
                    width: 40px;
                    height: 198px;
                    background: url(images/suspend.png);
                    position: absolute;
                    top: 0;
                    left: 0;
                    cursor: pointer;
                }

                .suspend dl dd.suspendQQ {
                    width: 120px;
                    height: 85px;
                    background: #ffffff;
                }

                    .suspend dl dd.suspendQQ a {
                        width: 120px;
                        height: 85px;
                        display: block;
                        background: url(images/suspend.png) -40px 0;
                        overflow: hidden;
                    }

                .suspend dl dd.suspendTel {
                    width: 120px;
                    height: 112px;
                    background: #ffffff;
                    border-top: 1px solid #e4e8ec;
                }

                    .suspend dl dd.suspendTel a {
                        width: 120px;
                        height: 112px;
                        display: block;
                        background: url(images/suspend.png) -40px -86px;
                        overflow: hidden;
                    }

        * html .suspend {
            position: absolute;
            left: expression(eval(document.documentElement.scrollRight));
            top: expression(eval(document.documentElement.scrollTop+400));
        }
    </style>

</asp:Content>
