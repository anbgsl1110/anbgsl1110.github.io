<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="Weetop.Web.Feedback" %>

<%@ Import Namespace="Weetop.DAL" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>客户回访_客户案例_客户服务案例_成功案例-示远科技</title>
    <meta name="keywords" content="客户回访,客户案例,客户服务案例,成功案例">
    <meta name="description" content="客户回访栏目展示了示远目前服务客户对示远短信验证码，通知短信，营销短信的评价。">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="NYbanner" style="background: url(images/news_banner.png) no-repeat top center; background-size: cover; width: 100%; min-width: 1200px; height: 450px;"></div>
    <div class="ny_news">
        <div class="newsBtn">
            <ul>
                <li><a href="CompanyNews.aspx" class="zxqyBtn">媒体报道</a></li>
                <li><a href="TradeNews.aspx" class="hydtBtn">行业动态</a></li>
                <li><a href="Feedback.aspx" class="khhfBtn khhfBtn02">客户回访</a></li>
            </ul>
        </div>
        <div class="newsList">
            <ul class="khhf">
                <li>

                    <form runat="server">
                        <ul>

                            <asp:Repeater ID="Repeater1" runat="server">
                                <ItemTemplate>
                                    <li class="clearfix">
                                        <div class="listL fl">
                                            <span><%# Convert.ToDateTime( Eval("PostDate")).ToString("dd") %></span>
                                            <em><%# Convert.ToDateTime( Eval("PostDate")).ToString("yyyy-MM") %></em>
                                            <p><%# Eval("Source") %></p>
                                            <i></i>
                                            <p><%# SiteCategory.GetNameById(Common.ToLong( Eval("CateId"))) %></p>
                                        </div>
                                        <div class="listR fr">
                                            <h1><%# Eval("Title") %></h1>
                                            <p><%# Server.HtmlDecode( Eval("Content").ToString()).RemoveHtmlTag(200) %>...</p>
                                            <span>浏览次数：<%# Eval("ViewCount") %><%--&nbsp;&nbsp;&nbsp;点赞次数：6--%></span>
                                            <a href="NewsDetails.aspx?catid=<%# Eval("CateId") %>&id=<%# Eval("Id") %>" class="fr">查看更多>></a>
                                        </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </ul>
                        <!--分页-->
                        <div class="sabrosus">
                            <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
                                NextPageText="下一页" OnPageChanging="AspNetPager1_PageChanging" AlwaysShow="true" CurrentPageButtonClass="current"
                                PrevPageText="上一页" TextAfterPageIndexBox="页" TextBeforePageIndexBox="跳转到第">
                            </webdiyer:AspNetPager>
                        </div>
                        <!--分页-->

                    </form>

                </li>
            </ul>
        </div>
    </div>


</asp:Content>
