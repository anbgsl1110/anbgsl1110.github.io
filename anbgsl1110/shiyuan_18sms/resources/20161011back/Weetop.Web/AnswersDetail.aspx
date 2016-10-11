<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="AnswersDetail.aspx.cs" Inherits="Weetop.Web.AnswersDetail" %>

<%@ Import Namespace="Weetop.DAL" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title><%=content_title %></title>
    <link href="/css/answers.css" rel="stylesheet" />
    <meta name="keywords" content="<%=content_keywords %>">
    <meta name="description" content="<%=content_Value120%>">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="NYbanner As_banner" style="background: url(/images/answers_banner.png) no-repeat center center; width: 100%; min-width: 1200px; height: 397px;">
    </div>
    <div class="as_center">
        <div class="position">
            <span>当前位置：</span>
            <span><a href="/Answers">问答中心></a></span>
            <span><a href="javascript:void(0)" id="aPosition" runat="server"></a></span>
        </div>
        <div class="content_box clearfix">
            <div class="con_left clearfix">
                <div class="title_text">
                    <h1>
                        <asp:Literal ID="awTitle" runat="server"></asp:Literal>

                    </h1>
                    <div>
                        <span>
                            <asp:Literal ID="awPostDate" runat="server" /></span>
                        <span>浏览次数：<asp:Literal ID="LitViewCount" runat="server"></asp:Literal></span>
                    </div>
                </div>
                <div class="article">
                <asp:Literal ID="awContent" runat="server"></asp:Literal>

                </div>
                <div class="sxp">
                    <div class="sp navbox">
                        <span>上一篇：</span>
                        <asp:HyperLink ID="linkPrev" runat="server"></asp:HyperLink>
                    </div>
                    <div class="xp navbox">
                        <span>下一篇：</span>
                        <asp:HyperLink ID="linkNext" runat="server"></asp:HyperLink>
                    </div>
                </div>
                <div class="xhyd_box">
                    <span>相关阅读</span>
                    <ul class="xg_left">
                        <%for (int i = 0; i < list2.Count; i++)
                          {
                              if (i < 3)
                              { %>

                        <li><a href="/AnswersDetail/<%=url[0] %>/<%=list2[i].Id %>"><%=list2[i].Title %></a>  </li>

                        <%}
                              else 
                              {
                                  break;
                              }
                      } %>
                    </ul>
                    <ul class="xg_right">
                        <%for (int i=3; i < list2.Count; i++)
                          {
                              if (i > 2)
                              { %>

                        <li><a href="/AnswersDetail/<%=url[0] %>/<%=list2[i].Id %>"><%=list2[i].Title %></a>  </li>

                        <%}
                      } %>
                    </ul>
                </div>
            </div>
            <div class="con_right">
                <div class="box01 fr">
                    <img src="/images/xq.png" alt="" />
                </div>
                <div class="box02 fr">
                    <asp:Repeater ID="Repeater2" runat="server">
                        <ItemTemplate>
                            <li><a href="AnswersDetail/<%=url[0] %>/<%# Eval("Id") %>"><%# Eval("Title") %></a></li>
                        </ItemTemplate>
                    </asp:Repeater>

                    <ul class="fl gjc01">
                        <li><a class="nav01" href="/ask/dxsms">短信验证码</a></li>
                        <li><a class="nav03" href="/ask/smsjk">短信验证码接口</a></li>
                        <li><a class="nav05" href="/ask/smsjog">短信接口</a></li>
                        <li><a class="nav07" href="/ask/insms">国际短信验证码</a></li>
                    </ul>
                    <ul class="fr gjc02">
                        <li><a class="nav02" href="/ask/smspt">短信验证平台</a></li>
                        <li><a class="nav04" href="/ask/msms">短信营销</a></li>
                        <li><a class="nav06" href="/ask/vovc">语音验证码</a></li>
                        <li><a class="nav08" href="/ask/notsms">通知短信</a></li>
                    </ul>
                </div>
                <ul class="box03 fr clearfix">
                    <li><span>推荐阅读</span></li>
                    <%for (int i = 0; i < list3.Count; i++)
                        {%>
                                    
                            <li><a href="/AnswersDetail/<%=GetCateName(long.Parse(list3[i].CateId.ToString()))%>/<%=list3[i].Id %>"><%=list3[i].Title.Length > 19 ? list3[i].Title.Substring(0,19) : list3[i].Title %></a></li>

                     <%   } %>
                </ul>
            </div>
        </div>
    </div>


</asp:Content>
