<%@ Page Title="控制台" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Weetop.Web.CMS.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="page-header">
        <h1>网站后台管理系统指南</h1>
    </div>
    <!-- /.page-header -->

    <ul>
        <li>考虑到系统的扩展性，CMS系统对很多分类保留了增加的接口，但由于页面设计美化的缘故，请不要删除或者添加新的栏目（包括新闻、课程、下载），如需添加，请先和我们联系。</li>
        <li>为了您的系统安全，请不要使用简单的密码，例如：123456、admin、admin888等常用密码。</li>
        <li>首页flash图片切换必须是jpg格式的图片，所以添加新闻的图片必须是jpg格式，才会出现在flash的轮换里。</li>
        <li>资源下载的文件请统一使用压缩包zip或者rar的格式，如果文件超过2M，建议使用ftp的方式上传（服务器有上传单个文件大小限制，而且大文件容易超时）。</li>
        <li>普通的管理员可以创建多个，系统高级管理员只有一个，不能删除或者禁用。</li>
        <li>为了保证图片的清晰度，在上传图片信息的时候尽量上传一张小图用于列表，和大图用于展示。</li>
        <li>欢迎登录我们的网站：<a href="http://www.weetop.com" target="_blank">www.weetop.com</a></li>
    </ul>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">
    <script type="text/javascript">
        SetSecondCrumb('指南');
    </script>
</asp:Content>
