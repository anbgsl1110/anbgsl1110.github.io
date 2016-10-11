<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="ConsultSrv.aspx.cs" Inherits="Weetop.Web.member.ConsultSrv" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">

    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />服务中心 &gt; 咨询服务</div>
        <div class="hy_fwzx_kefu clearfix">
            <div class="kefu_left fl">
                <h1>专属客服</h1>
                <ul>
                    <%if (consultingService.Count == 0 || customerService == null) 
                      {%>
                        <li id="CustomerService1" >
                            <em>
                                <img src="../images/kefutx_03.png" alt=""></em>
                            <h2>羽墨</h2>
                            <p>
                                电话：13335818673<br>
                                邮箱：188692959@qq.com<br>
                                QQ： 188692959<br>
                                微信：sy13335818673
                            </p>
                            <a href="http://wpa.qq.com/msgrd?v=3&uin=188692959&site=qq&menu=yes" target="_blank">立即沟通</a>
                        </li>
                        <li id="CustomerService2">
                            <em>
                                <img src="../images/kefutx_05.png" alt=""></em>
                            <h2>林海</h2>
                            <p>
                                电话：13858142824<br>
                                邮箱：2712472956@qq.com<br>
                                QQ： 2712472956<br>
                                微信：hai_1314_qin
                            </p>
                            <a href="http://wpa.qq.com/msgrd?v=3&uin=2712472956&site=qq&menu=yes" target="_blank">立即沟通</a>
                        </li>
                    <%} %>
                    <%else 
                      { %>
                        <li id="CustomerService3" style="margin-left:120px">
                            <em>
                                <img id="CustomerService3-img" src="<% = customerImgUrl%>" alt=""></em>
                            <h2 id="CustomerService3-h2"><% = customerService.Name%></h2>
                            <p id="CustomerService3-p" >
                                <span>电话：</span><span><% = customerService.Phone %></span><br>
                                <span>邮箱：</span><span><% = customerService.mailBox %></span><br>
                                <span>QQ： </span><span><% = customerService.QQNumber %></span><br>
                                <span>微信：</span><span><% = customerService.WeChat %></span>
                            </p>
                            <a id="CustomerService3-a" href="<% = customerHref %>" target="_blank">立即沟通</a>
                        </li>
                    <%} %>
                </ul>
            </div>
            <i class="fl" style="display: block; width: 1px; height: 475px; background-color: #e0e0e0;"></i>
            <div class="kefu_right fr">
                <h1>专属商务</h1>
                <ul>
                    <% if(consultingService.Count == 0 || businessService == null) 
                       { %>
                        <li id="BusinessService1">
                            <em>
                                <img src="../images/kefutx_07.png" alt=""></em>
                            <h2>萤火虫</h2>
                            <p>
                                电话：18248482563<br>
                                邮箱：727846339@qq.com<br>
                                QQ： 727846339<br>
                                微信：sykj-002
                            </p>
                            <a href="http://wpa.qq.com/msgrd?v=3&uin=727846339&site=qq&menu=yes" target="_blank">立即沟通</a>
                        </li>
                        <li id="BusinessService2">
                            <em>
                                <img src="../images/kefutx_09.png" alt=""></em>
                            <h2>擎天</h2>
                            <p>
                                电话：15824484523<br>
                                邮箱：3256188177@qq.com<br>
                                QQ： 3256188177<br>
                                微信：sykj-008
                            </p>
                            <a href="http://wpa.qq.com/msgrd?v=3&uin=3256188177&site=qq&menu=yes" target="_blank">立即沟通</a>
                        </li>
                    <% } %>
                    <% else
                       { %>
                    <li id="BusinessService3" style="margin-left:120px">
                        <em>
                                <img id="BusinessService3-img" src="<% = businessImgUrl %>" alt=""></em>
                            <h2 id="BusinessService3-h2"><% = businessService.Name%></h2>
                            <p id="BusinessService3-p" >
                                <span>电话：</span><span><% = businessService.Phone %></span><br>
                                <span>邮箱：</span><span><% = businessService.mailBox %></span><br>
                                <span>QQ： </span><span><% = businessService.QQNumber %></span><br>
                                <span>微信：</span><span><% = businessService.WeChat %></span>
                            </p>
                            <a id="BusinessService3-a" href="<% = businessHref %>" target="_blank">立即沟通</a>
                    </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </div>

</asp:Content>
