<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="/ask/smspt.aspx.cs" Inherits="Weetop.Web.ask.smspt" %>

<%@ Import Namespace="Weetop.DAL" %>
<%@ Import Namespace="Microsoft.AspNet.FriendlyUrls" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Register Src="~/NavTop.ascx" TagPrefix="uc1" TagName="NavTop" %>
<%@ Register Src="~/NavBottom.ascx" TagPrefix="uc1" TagName="NavBottom" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=1160, initial-scale=0.9" />
    <meta name="baidu-site-verification" content="gJTHLLuVcg" />

    <link rel="stylesheet" href="/css/public.css">
    <link rel="stylesheet" href="/css/style.css">

    <link rel="stylesheet" href="/css/animate.min.css">
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script src="/js/jquery.SuperSlide.2.1.1.js"></script>
    
    <script src="/static/dep/layer-v2.2/layer/layer.js"></script>
    <script src="/js/lay.js"></script>

   

    <title>短信验证码平台_短信验证平台_短信发送验证码平台_短信验证码接口平台-示远科技|极致短信验证码</title>
    <link href="../css/answers.css" rel="stylesheet" />
    <script src="../js/ask.js"></script>
    <meta name="keywords" content="短信验证码平台,短信验证平台,短信发送验证码平台,短信验证码接口平台">
    <meta name="description" content="短信验证码平台问答栏目展示了示远短信验证码平台，短信验证平台，短信发送验证码平台，短信验证码接口平台的优势、价格、应用场景等内容，示远科技作为国内顶级短信验证码平台，追求极致用户体验永远是我们的目标。">
</head>
<body>
    <uc1:NavTop runat="server" ID="NavTop" />

     <div class="NYbanner As_banner" style="background: url(../images/answers_banner.png) no-repeat center center; width: 100%; min-width: 1200px; height: 397px;">
    </div>
    <div class="as_center">
        <div class="position">
            <span>当前位置：</span>
            <span><a href="/Answers">问答中心></a></span>
            <span><a href="#" id="aPosition" runat="server"></a></span>
        </div>
        <div class="aslist_box clearfix">
            <a name="sms" href="#" style="position:absolute;top:350px;"></a>
      <ul class="as_fl">
                <li class="all"><a href="/Answers">全部分类</a></li>
                <li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/dxsms">短信验证码</a>
                </li>
                <li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/vovc">语音验证码</a>
                </li>
                <li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/msms">短信营销</a>
                </li>
                <li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/notsms">通知短信</a>
                </li>
                <li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/insms">国际短信</a>
                </li>
                <li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/smsjog">短信接口</a>
                </li>
                <li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/smsroof">短信平台</a>
                </li><li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/smsentry">短信通道</a>
                </li><li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/smspt">短信验证码平台</a>
                </li>
                <li class="nav">
                    <span class="as_icon"><img src="/images/as_icon.png" alt="" /></span>
                     <a class="as_nav" href="/ask/smsjk">短信验证码接口</a>
                </li>
            </ul>
            <form runat="server" class="aslist_fr clearfix">
                <asp:HiddenField ID="hidCateId" runat="server" />
                <ul >
                    <asp:Repeater ID="Repeater1" runat="server">

                         <ItemTemplate>
                            <li class="list_box clearfix">
                                <div class="list_top">
                                    <span class="sline"></span>
                                   <a href="/AnswersDetail/smspt/<%# Eval("Id") %>"><%# Eval("Title") %></a>
                                    <span class="list_date"><em><%# Convert.ToDateTime( Eval("PostDate")).ToString("yyyy-MM-dd") %></em></span>
                                </div>
                                <div class="list_bottom">
                                    <%# Server.HtmlDecode( Eval("Content").ToString()).RemoveHtmlTag(100).Trim() %>...
                                </div>
                                <a class="btn_more fr" href="/AnswersDetail/smspt/<%# Eval("Id") %>">更多>></a>
                            </li>
                        </ItemTemplate>

                    </asp:Repeater>
                </ul>

                <!--分页-->
                <div class="as_page">
                     <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
                        NextPageText="" OnPageChanging="AspNetPager1_PageChanging" AlwaysShow="true" CurrentPageButtonClass="current"
                        PrevPageText="" TextAfterPageIndexBox="页" TextBeforePageIndexBox="跳转到第">
                    </webdiyer:AspNetPager>

                    <input type="button"  />
                </div>
                <!--分页-->
            </form>
        </div>
    </div>
        
        <div class="slide_right">
            <ul>
                <li class="chatgt">
                    <a class="chat" href="javascript:;">
                        <i class="chat_icon"></i>
                        <div class="u_chat">在线业务咨询</div>
                    </a>
                </li>
                <li>
                    <div class="tel">
                        <a href="javascript:;"></a>
                        <div class="u_tel">0571-88024252</div>
                    </div>
                </li>
                <li>
                    <div class="top_rim">
                        <a href="javascript:;"></a>
                        <div class="u_top">返回顶部</div>
                    </div>
                </li>
            </ul>
        </div>

        <!--backTop js-->
        <script>
            $(window).scroll(function () {
                //获取滚动条的滑动距离
                var scroH = $("body").scrollTop();
                //滚动条的滑动距离大于等于定位元素距离浏览器顶部的距离，就固定，反之就不固定
                if (scroH > 0) {
                    $(".top_rim").css({ "display": "block" });
                }
            })
            $(".top_rim").click(function () {
                $("html,body").animate({ scrollTop: 0 }, 400)
            })
        </script>
    
    <uc1:NavBottom runat="server" ID="NavBottom" />

        <script>
            $(".chatgt").click(function () {
                window.open('http://tb.53kf.com/code/client/10140387/1][img]http://tb.53kf.com/kfimg.php?arg=10140387&style=1[/img]超酷签名，点击这里和我直接沟通', "_blank", "width=720,height=550,top=80,left=80,scrollbars=yes,resizable=1,modal=false,alwaysRaised=yes");
            });

    </script>
</body>
</html>