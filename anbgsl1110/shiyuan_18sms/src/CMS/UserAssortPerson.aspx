<%@ Page Title="分配服务人员" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="UserAssortPerson.aspx.cs" Inherits="Weetop.Web.CMS.UserAssortPerson" %>

<%@ Import Namespace="Weetop.DAL" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="/static/dep/assets/css/chosen.css" rel="stylesheet" />
    <link href="/static/dep/assets/css/bootstrap-datepicker3.css" rel="stylesheet" />
    <link href="/static/dep/assets/css/daterangepicker.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <div class="page-header">
        <h1><%: Page.Title %> 
            <small>
                <i class="ace-icon fa fa-angle-double-right"></i>
                <span id="assortUserId" style="color:red"><b>
                     <% = Request["phone"] %>
                    </b></span>
            </small>
        </h1>
    </div>
    <!-- /.page-header -->
    <div class="row">
        <div class="col-xs-12">
            <form runat="server" autocomplete="off">
                <input type="hidden" id="hidUserId1" name="hidUserId" />
                <div class="clearfix">
                    <div class="pull-left tableTools-container dropdown">
                        <span style="float: left; margin-right: 10px;">
                            <asp:DropDownList ID="ddlCategroy" AutoPostBack="true" CssClass="form-control" runat="server"></asp:DropDownList>
                        </span>                        
                    </div>  
                    <div class="pull-right tableTools-container">
                        <a role="button" class="btn btn-sm btn-success" title="返回">返回</a> 
                    </div>              
                </div>            
                <div class="row clearfix">
                    <div class="col-md-12 column">
                    <div class="row clearfix">
                        <div class="col-md-6 column">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                            <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlCategroy" />
                            </Triggers>
                            <ContentTemplate>
                            <asp:Repeater ID="Repeater1" runat="server">
                                <HeaderTemplate>
                                    <table id="mytable" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th style="display:none">id</th>
                                                <th style="display:none">cateId</th>
                                                <th>姓名</th>
                                                <th>分类</th>
                                                <th class="center">操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                            <tr id="<%# Eval("id") %>">
                                                <td style="display:none"><%# Eval("id") %></td>
                                                <td style="display:none" ><%# Eval("cateId") %></td>
                                                <td ><%# Eval("Name") %></td>
                                                <td ><%# Eval("CategroyName") %></td>
                                                <td class="action-buttons center" id ="btnDelete">
                                                    <a class="red"  title="去除服务人员">
                                                    <i class="ace-icon fa fa-minus bigger-130"></i>去除</a>
                                                </td>
                                            </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                        </tbody>
                                        </table>
                                </FooterTemplate>
                                </asp:Repeater>    
                            </contenttemplate>
                        </asp:UpdatePanel>
                        <p style="color:red">
                        【注意】请确保分配了一对客服和一对商务!
                        </p>
                        <blockquote class="pull-left">
                            <p><small id="time1"></small></p>
                        </blockquote>
                        </div>
                        <div class="col-md-6 column">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" OnLoad="UpdatePanel1_Load">
                            <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlCategroy" />
                            </Triggers>
                            <ContentTemplate>
                            <asp:Repeater ID="Repeater2" runat="server">
                                <HeaderTemplate>
                                    <table id="mytable2" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th style="display:none">id</th>
                                                <th style="display:none">cateId</th>
                                                <th>姓名</th>
                                                <th>分类</th>
                                                <th class="center">操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr id="<%# Eval("id") %>">
                                        <td style="display:none"><%# Eval("id") %></td>
                                        <td style="display:none" ><%# Eval("cateId") %></td>
                                        <td><%# Eval("Name") %></td>
                                        <td><%# Eval("CategroyName") %></td>
                                        <td class="action-buttons center" id ="btnAdd">
                                            <a class="green" href="javascript:AddServicePerson('<%# Eval("id") %>');" title="添加服务人员">
                                            <i class="ace-icon fa fa-plus bigger-130"></i>添加</a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                        </tbody>
                                    </table>
                                </FooterTemplate>
                                </asp:Repeater>
                                <div class="pagination center">
                                    <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
                                        NextPageText="下一页" OnPageChanging="AspNetPager1_PageChanging" AlwaysShow="true" CurrentPageButtonClass="active"
                                        PrevPageText="上一页" TextAfterPageIndexBox="页" TextBeforePageIndexBox="跳转到第">
                                    </webdiyer:AspNetPager>
                                </div>   
                            </contenttemplate>
                        </asp:UpdatePanel>                                                    
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-sm" href="javascript:Reset('<%# Eval("id") %>');">
                        <i class="ace-icon fa fa-refresh"></i>
                        重置更改
                        </button>
                        <button class="btn btn-sm btn-primary" href="javascript:Save('<%# Eval("id") %>');">
                        <i class="ace-icon fa fa-check"></i>
                        确定
                        </button>
                    </div> 
                    </div> 
                </div> 
            </form>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <script src="/static/dep/assets/js/chosen.jquery.js"></script>
    <script src="/static/dep/assets/js/date-time/moment.js"></script>
    <script src="/static/dep/assets/js/date-time/bootstrap-datepicker.js"></script>
    <script src="/static/dep/assets/js/date-time/daterangepicker.js"></script>
    <script src="/static/dep/jsrender.min.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">
    <script type="text/javascript">
        ActiveMenu('menu3');


        //添加咨询服务人员
        $('#btnDelete').on('click', function (e)
        {
            $.post('', { action: 1, id: 49 }, function (jdata) {
                switch (jdata.code) {
                    case "OK":
                        showInfo(jdata.message);
                        break;
                    case "Err":
                        showErr(jdata.message);
                        break;
                }
            }, 'json');
        });

        //重置更改
        function Reset (id)
        {
            $.getJSON('', { action: 3, id: id }, function (jdata, textStatus, jqXHR) {
                if ('success' == textStatus) {
                    switch (jdata.code) {
                        case "Ok":
                            showInfo(jdata.message);
                            break;
                        case "Err":
                            showErr(jdata.message);
                            break;
                    }
                }
            });
        }

        //保存确定
        function Save (id)
        {
            $.getJSON('', { action: 4, id: id }, function (jdata, textStatus, jqXHR) {
                if ('success' == textStatus) {
                    switch (jdata.code) {
                        case "Ok":
                            showInfo(jdata.message);
                            break;
                        case "Err":
                            showErr(jdata.message);
                            break;
                    }
                }
            });
        }

        jQuery(function ($) {
            var date = new Date();
            $('#time1').text(date.toLocaleString());

        });
    </script>
</asp:Content>

