<%@ Page Title="活动推广" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="Populist.aspx.cs" Inherits="Weetop.Web.CMS.Populist" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/static/dep/assets/css/bootstrap-datepicker3.css" rel="stylesheet" />
    <link href="/static/dep/assets/css/daterangepicker.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="page-header">
        <h1><%: Page.Title %>
            <small>
                <i class="ace-icon fa fa-angle-double-right"></i>
                信息列表
            </small>
        </h1>
    </div>
    <!-- /.page-header -->


    <div class="row">
        <div class="col-xs-12">
            <form id="Form1" runat="server" autocomplete="off">

                <asp:HiddenField ID="hidType" runat="server" />

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <div class="clearfix">
                    <div class="pull-left tableTools-container">
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input class="form-control" style="width: 300px; max-width: 100%;" id="txtDateRange" placeholder="按时间段筛选：注册日期" runat="server" type="text" name="date-range-picker" />
                            <asp:LinkButton ID="btnDate" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input id="txtSearch" type="text" autocomplete="off" maxlength="150" style="width: 300px;" class="form-control" runat="server" placeholder="输入搜索：手机号，路径来源" />
                            <asp:LinkButton ID="btnSearch" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                    </div>
                    <%--<div class="pull-right tableTools-container">
                        <a href="#modal-form" id="" role="button" class="btn btn-sm btn-success" data-toggle="modal" title="添加"><i class="ace-icon fa fa-plus-circle bigger-130"></i>添加</a>
                    </div>--%>
                     <div class="pull-right tableTools-container" style="margin-right:50px;">
                         <asp:Button ID="ExportFile" runat="server" Text="导出" class="btn btn-sm btn-success" OnClick="ExportFile_Click" />
                    </div>
                </div>


                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtSearch" />
                        <asp:AsyncPostBackTrigger ControlID="btnSearch" />
                        <asp:AsyncPostBackTrigger ControlID="btnDate" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>
                                <table id="mytable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>手机号</th>
                                            <th>路径来源</th>
                                            <th>注册时间</th>
                                            <th>备注</th>
                                            <th class="hidden-xs"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id='<%# Eval("Id") %>'>
                                    <td><%# Eval("Mobile") %></td>
                                    <td><%# Common.ToBool( Eval("Valid"))? Eval("SrcPath"):"未知" %></td>
                                    <td><%# Eval("PostDate") %></td>
                                    <td><%# Eval("Remark") %></td>
                                    <td class="action-buttons hidden-xs center">
                                        <a class="green" href="#modal-form" onclick="javascript:BindPriv('<%# Eval("Id") %>');" data-toggle="modal" title="修改备注">
                                            <i class="ace-icon fa fa-pencil bigger-130"></i>
                                        </a>
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

                    </ContentTemplate>
                </asp:UpdatePanel>
            </form>


            <form id="modal-form" class="modal fade" tabindex="-1" data-backdrop="static" autocomplete="on">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="blue bigger">备注管理</h4>
                        </div>

                        <input type="hidden" id="hidRoleId" name="hidRoleId" />
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-xs-12 col-sm-12">
                                    <div class="form-group">
                                        <label for="form-field-name">备注</label>

                                        <div>
                                            <textarea id="form-field-name" class="form-control" name="remark" maxlength="250" placeholder="250字"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-sm" id="cancelForm" data-dismiss="modal">
                                <i class="ace-icon fa fa-times"></i>
                                取消
                            </button>

                            <button class="btn btn-sm btn-primary" id="submitForm">
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script src="/static/dep/assets/js/date-time/moment.js"></script>
    <script src="/static/dep/assets/js/date-time/bootstrap-datepicker.js"></script>
    <script src="/static/dep/assets/js/date-time/daterangepicker.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveMenu('menu8');


        //textbox无法回车回发
        $('form').on('keydown', '#<%= txtSearch.ClientID %>', function (e) {
            var key = e.which || e.keyCode || 0;
            if (key && key == 13) {
                document.getElementById('<%= btnSearch.ClientID %>').click();
            };
        });

        //日期区间选择控件
        $('#<%= txtDateRange.ClientID %>').daterangepicker({
            'applyClass': 'btn-xs btn-success',
            'cancelClass': 'btn-xs btn-default',
            autoUpdateInput: true,//自动更新值
            showDropdowns: true,
            timePicker: true,
            timePicker24Hour: true,
            timePickerIncrement: 10,
            locale: {
                applyLabel: '确定',
                cancelLabel: '清空',
                format: 'YYYY/MM/DD HH:mm',
                "separator": " - ",
                "fromLabel": "从",
                "toLabel": "到",
                "customRangeLabel": "Custom",
                "daysOfWeek": [
                    "日",
                    "一",
                    "二",
                    "三",
                    "四",
                    "五",
                    "六"
                ],
                "monthNames": [
                    "一月",
                    "二月",
                    "三月",
                    "四月",
                    "五月",
                    "六月",
                    "七月",
                    "八月",
                    "九月",
                    "十月",
                    "十一月",
                    "十二月"
                ],
                "firstDay": 1
            }
        });
        $('#<%= txtDateRange.ClientID %>').val('');//页面加载时清空预设值
        $('#<%= txtDateRange.ClientID %>').on('apply.daterangepicker', function (ev, picker) {
            //$(this).val(picker.startDate.format('YYYY/MM/DD HH:mm') + ' - ' + picker.endDate.format('YYYY/MM/DD HH:mm'));
        });
        $('#<%= txtDateRange.ClientID %>').on('cancel.daterangepicker', function (ev, picker) {
            $(this).val('');
        });


        function BindPriv(id) {
            setTimeout(function () {
                $('#hidRoleId').val(id);//设置id便于post到服务器
            }, 500);

            //$.getJSON('', { action: 5, id: id }, function (data, state, xhr) {
            //    if (state == 'success') {
            //        //console.log(data.toSource());
            //        if (data.length > 0) {
            //            $.each(data, function (idx, item) {
            //                $('#mp' + item.ModPrivId).prop("checked", true);
            //            });
            //        }
            //    }
            //});
        }

               jQuery(function ($) {
            //隐藏后重置，显示前重置，清空自填表
            $('#modal-form')
                .on('hidden.bs.modal show.bs.modal',
                    function (e) {
                        this.reset();
                    });

            $('#modal-form').on('submit',function (e) {
                        e.preventDefault();
                        $('#modal-form button').attr('disabled', 'disabled');

                        $.post('','ac=2&' + $(this).serialize(),function (jdata) {
                                $('#modal-form button').removeAttr('disabled');

                                switch (jdata.code) {
                                    case "OK":
                                        __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                                        showInfo(jdata.message);
                                        $("#modal-form").modal("hide");
                                        break;
                                    case "Err":
                                        showErr(jdata.message);
                                        break;
                                }
                            },
                            'json');

                        return false;
                    });
        });
       
    </script>

</asp:Content>
