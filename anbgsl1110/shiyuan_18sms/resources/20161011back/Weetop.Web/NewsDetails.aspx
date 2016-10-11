<%@ Page Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="NewsDetails.aspx.cs" Inherits="Weetop.Web.NewsDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="keywords" content="短信验证码,网站验证码,APP验证码,语音验证码,短信验证码平台,短信验证接口,手机短信验证码,会员通知短信">
    <meta name="Description" content="<%= Description %>">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="NYbanner" style="background: url(images/news_banner.png) no-repeat top center; background-size: cover; width: 100%; min-width: 1200px; height: 450px;"></div>
    <div class="ny_news">
        <div class="newsBtn" style="background-color: #f9f9f9;">
            <ul>
                <li><a href="CompanyNews.aspx" class="zxqyBtn">媒体报道</a></li>
                <li><a href="TradeNews.aspx" class="hydtBtn">行业动态</a></li>
                <li><a href="Feedback.aspx" class="khhfBtn">客户回访</a></li>
            </ul>
        </div>

        <div class="newsContent clearfix">
            <div class="newsText fl">
                <div class="newsText1">
                    <h1>
                        <asp:Literal ID="LitTitle" runat="server"></asp:Literal></h1>
                    <span>
                        <asp:Literal ID="LitPostDate" runat="server"></asp:Literal>&nbsp;&nbsp;&nbsp;浏览次数：<asp:Literal ID="LitViewCount" runat="server"></asp:Literal>
                        <%--&nbsp;&nbsp;&nbsp;点赞次数：6--%></span>
                </div>
                <div class="newsText2">
                    <asp:Literal ID="LitContent" runat="server"></asp:Literal>
                </div>
                <div class="change">
                    <p>
                        上一篇：
                        <asp:HyperLink ID="linkPrev" runat="server"></asp:HyperLink>
                    </p>
                    <p>
                        下一篇：
                        <asp:HyperLink ID="linkNext" runat="server"></asp:HyperLink>
                    </p>
                </div>
            </div>
            <div class="newsRecommend fr">
                <em>
                    <img src="images/newsRecommend.png" alt=""></em>
                <ul>
                    <li>
                        <h1>相关阅读</h1>
                    </li>
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <li><a href="NewsDetails.aspx?catid=<%# Eval("CateId") %>&id=<%# Eval("Id") %>"><%# Eval("Title") %></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
                <ul>
                    <li>
                        <h1>热点推荐</h1>
                    </li>
                    <asp:Repeater ID="Repeater2" runat="server">
                        <ItemTemplate>
                            <li><a href="NewsDetails.aspx?catid=<%# Eval("CateId") %>&id=<%# Eval("Id") %>"><%# Eval("Title") %></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>


    <script type="text/javascript">

        switch ('<%= CateId %>') {
            case "5":
                $('.newsBtn ul li').eq(0).find('a').addClass('zxqyBtn02');
                break;
            case "6":
                $('.newsBtn ul li').eq(1).find('a').addClass('hydtBtn02');
                break;
            case "7":
                $('.newsBtn ul li').eq(2).find('a').addClass('khhfBtn02');
                break;
        }

    </script>

</asp:Content>
