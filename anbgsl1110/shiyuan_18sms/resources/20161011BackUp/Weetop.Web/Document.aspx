<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Document.aspx.cs" Inherits="Weetop.Web.Document" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>开发文档管理_验证码接口文档-示远科技</title>
<meta name="keywords" content="开发文档,短信验证码接口文档,接口文档">
<meta name="description" content="杭州示远信息科技有限公司具有5年通信产业3年短信验证码通道运营服务经验，我们提供短信验证码，短信验证码接口，手机短信验证码，语音验证码，国际短信验证码，通知短信，短信营销等产品，坚持5秒必达、短信到达率100%的原则持续为客户提供最优质短信通道，咨询热线：400-0571-363。">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<script language="JavaScript" type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var pretime = $('#pretime').html();
            $('#btnSearch').click(function () {
                $('#pretime').html(pretime);
                var searchText = $('#txtKey').val();
                if (searchText.length == 0) {
                    alert('请输入搜索关键词!');
                    $('#txtKey').focus();
                    return false;
                }
                var regExp = new RegExp(searchText, 'g');
                $('#pretime p').each(function () {
                    var html = $(this).html();
                    var reg = new RegExp("<[^<]*>", "gi");    // 标签的正则表达式
                    html = html.replace(reg, "");          // 替换所有标签为空
                    var _time = $(this).parent().find("strong").text();;
                    var newHtml = html.replace(regExp, '<span class="highlight">' + searchText + '</span>');
                    $(this).html(newHtml);
                    flag = 1;

                })
                if (flag) {
                    if ($(".highlight").size() > 1) {
                        var _top = $(".highlight").eq(0).offset().top;
                        $("html,body").animate({
                            "scrollTop": _top
                        }, 500)
                    }
                }
            });
        });
    </script>
    <style type="text/css">
        .highlight { background: yellow; color: red; }
    </style>
    <div class="wd_banner">
        <p>
           <input type="text" id="txtKey" class="wdSearchTx" placeholder="代码查询"><input type="button" class="wdSearchBtn" value="" id="btnSearch">
        </p>
        <div class="xts wow fadeInUp">
            <p>申请流程：提供开户申请基本资料 > 提交申请资料 >资料审核 > 提供相应的账号，密码，产品ID > 等待通道审核通知切换介入</p>
        </div>
    </div>
    <div class="wdListBg">
        <div class="wdList">
            <div class="selectBar">
                <ul class=" clearfix">
                    <li><a href="Download.aspx" class="wd_xz">测试DEMO下载</a></li>
                    <li><a href="Document.aspx" class="wd_gl wd_gl02">开发文档管理</a></li>
                    <li><a href="FAQ.aspx" class="wd_sl">常见问题示例</a></li>
                    <li><a href="Developer.aspx" class="wd_lc">开发者使用流程</a></li>
                </ul>
            </div>
            <div class="ny_line" style="height: 2px; background-color: #0d8dbd;"></div>
            <%--<div class="listPart">
                <ul>

                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <li>
                                <a href="wd_details.aspx?catid=<%# Eval("CateId") %>&id=<%# Eval("Id") %>">
                                    <h1><%# Eval("Title") %></h1>
                                    <p><%# Eval("Remark") %></p>
                                </a>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>

                </ul>
            </div>--%>
            <div class="listDetails" id="pretime">
                <div class="listDetails1">
                    <h1>
                        <asp:Literal ID="LitTitle" runat="server"></asp:Literal></h1>
                </div>
                <div class="listDetails2">
                    <asp:Literal ID="LitContent" runat="server"></asp:Literal>
                </div>
            </div>

        </div>
    </div>
    <!--elements animation js-->
    <script src="js/wow.min.js"></script>
    <script>
        new WOW().init();
    </script>

</asp:Content>
