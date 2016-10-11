<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="PayRes.aspx.cs" Inherits="Weetop.Web.PayRes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>充值成功 - 示远科技</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 style="font-size: 36px; color: #ff6b08; text-align: center; padding-top: 280px; margin-bottom: 20px;">充值成功，订单号：<%= OrderId %></h1>
    <div style="text-align: center; margin-bottom: 80px;"><a href="/member/">返回用户中心</a></div>

</asp:Content>
