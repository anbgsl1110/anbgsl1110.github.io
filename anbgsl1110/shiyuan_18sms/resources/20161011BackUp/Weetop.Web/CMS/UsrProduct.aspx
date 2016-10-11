<%@ Page Title="会员产品管理" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="UsrProduct.aspx.cs" Inherits="Weetop.Web.CMS.UsrProduct" %>

<%@ Import Namespace="Weetop.DAL" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/static/dep/assets/css/chosen.css" rel="stylesheet" />
    <link href="/static/dep/assets/css/bootstrap-datepicker3.css" rel="stylesheet" />
    <link href="/static/dep/assets/css/daterangepicker.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <style type="text/css">
        table tr td input[type="text"], table tr td input[type="number"] {
            width: auto;
            vertical-align: middle;
        }
    </style>


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
            <form runat="server" autocomplete="off">

                <div class="clearfix">
                    <div class="pull-left tableTools-container">
                        <span style="float: left; margin-right: 10px;">
                            <asp:DropDownList ID="ddlCheckStatus" AutoPostBack="true" CssClass="form-control" runat="server"></asp:DropDownList>
                        </span>
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input class="form-control" style="width: 300px; max-width: 100%;" id="txtDateRange" placeholder="按时间段筛选：开通日期" runat="server" type="text" name="date-range-picker" />
                            <asp:LinkButton ID="btnDate" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input id="txtSearch" type="text" autocomplete="off" maxlength="150" style="width: 400px;" class="form-control" runat="server" placeholder="输入搜索：企业名称、电话、产品账号、EXTNO" />
                            <asp:LinkButton ID="btnSearch" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                    </div>
                </div>

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlCheckStatus" />
                        <asp:AsyncPostBackTrigger ControlID="txtSearch" />
                        <asp:AsyncPostBackTrigger ControlID="btnSearch" />
                        <asp:AsyncPostBackTrigger ControlID="btnDate" />
                    </Triggers>
                    <ContentTemplate>

                        <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_OnItemDataBound">
                            <HeaderTemplate>
                                <table id="mytable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>认证企业名称</th>
                                            <th>注册电话</th>
                                            <th>开通日期</th>
                                            <th>产品类型</th>
                                            <th>产品账号</th>
                                            <th>产品密码</th>
                                            <th class="center">开户EXTNO</th>
                                            <th class="hidden-480 hidden-xs"></th>
                                            <th class="hidden-480 hidden-xs"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id="<%# Eval("Id") %>">
                                    <td>
                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal></td>
                                    <td>
                                        <asp:Literal ID="Literal2" runat="server"></asp:Literal></td>
                                    <td><%# Eval("OpenDate") %></td>
                                    <td><%# (ProductType)Common.ToInt(Eval("ProId")) %></td>
                                    <td><%# Eval("SyAccount") %></td>
                                    <td><%# Eval("SyAccPwd") %></td>
                                    <td class="center"><%# Eval("ExtNo") %></td>
                                    <td class="action-buttons hidden-480 hidden-xs center">
                                        <%foreach (var item in list)
                                          {
                                              if (item.PrivilegeCode == "XG")
                                              {%>
                                                  <div class="hidden-xs action-buttons">
                                                <span id="op-normal">
                                                <a class="green" href="javascript:DoEditInline('<%# Eval("Id") %>');" title="编辑">
                                                    <i class="ace-icon fa fa-pencil bigger-130"></i>
                                                </a>
                                                </span>
                                                <span id="op-edit" style="display: none;">
                                                    <a class="green" href="javascript:SaveEdit('<%# Eval("Id") %>');" title="保存">
                                                        <i class="ace-icon fa fa-check bigger-130"></i>
                                                    </a>
                                                <a class="grey" href="javascript:CancelEdit('<%# Eval("Id") %>');" title="取消">
                                                    <i class="ace-icon fa fa-times bigger-130"></i>
                                                </a>
                                                </span>
                                                </div>

                                                <a class="purple" href='#modal-form2' role='button' onclick='javascript:BindInfo("<%# Eval("Id") %>");' data-toggle='modal' title="帐户充值">
                                                <i class="ace-icon fa fa-heartbeat bigger-130"></i>
                                                </a>
                                              <%}
                                          } %>

                                       <%-- <div class="hidden-xs action-buttons">
                                            <span id="op-normal">
                                                <a class="green" href="javascript:DoEditInline('<%# Eval("Id") %>');" title="编辑">
                                                    <i class="ace-icon fa fa-pencil bigger-130"></i>
                                                </a>
                                            </span>
                                            <span id="op-edit" style="display: none;">
                                                <a class="green" href="javascript:SaveEdit('<%# Eval("Id") %>');" title="保存">
                                                    <i class="ace-icon fa fa-check bigger-130"></i>
                                                </a>
                                                <a class="grey" href="javascript:CancelEdit('<%# Eval("Id") %>');" title="取消">
                                                    <i class="ace-icon fa fa-times bigger-130"></i>
                                                </a>
                                            </span>
                                        </div>

                                        <a class="purple" href='#modal-form2' role='button' onclick='javascript:BindInfo("<%# Eval("Id") %>");' data-toggle='modal' title="帐户充值">
                                            <i class="ace-icon fa fa-heartbeat bigger-130"></i>
                                        </a>--%>
                                    </td>
                                   <%-- <td class="action-buttons hidden-480 hidden-xs center">
                                        <a class="purple" href='#modal-form2' role='button' onclick='javascript:BindInfo("<%# Eval("Id") %>");' data-toggle='modal' title="帐户充值">
                                            <i class="ace-icon fa fa-heartbeat bigger-130"></i>
                                        </a>
                                    </td>--%>
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


        </div>
    </div>



    <form id="modal-form2" class="modal fade" tabindex="-1" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="blue bigger">帐户充值</h4>
                </div>
                <input type="hidden" id="hidUserId2" name="hidUserId2" value="" />
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-6">
                            <div class="form-group">
                                <label for="form-field-oldpwd">帐户</label>

                                <div style="padding: 7px 7px 6px 6px; text-decoration: none; font-weight: bold; border: 1px solid #d5d5d5">
                                    <span id="user"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="form-group">
                                <label for="form-field-newpwd">金额</label>

                                <div>
                                    <input type="number" required id="form-field-newpwd" class="form-control" min="1" name="fmoney" placeholder="1" autocomplete="off" />
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-sm" id="cancelForm2" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>

                    <button class="btn btn-sm btn-primary" id="submitForm">
                        <i class="ace-icon fa fa-check"></i>
                        充值
                    </button>
                </div>
            </div>
        </div>
    </form>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script src="/static/dep/assets/js/chosen.jquery.js"></script>
    <script src="/static/dep/assets/js/date-time/moment.js"></script>
    <script src="/static/dep/assets/js/date-time/bootstrap-datepicker.js"></script>
    <script src="/static/dep/assets/js/date-time/daterangepicker.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">


    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveMenu('menu3a');


        //下拉控件
        $('#<%= ddlCheckStatus.ClientID %>').chosen({
            width: '140px',
            placeholder_text_single: "产品类型",
            disable_search_threshold: 10,//小于此值不显示搜索
            allow_single_deselect: true//可清除选择
        });



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


        var tdlist = [4, 5, 6];
        //编辑按钮
        function DoEditInline(id) {
            //替换控件
            var trline = $('#' + id);
            trline.find('td').each(function (idx, item) {
                if (tdlist.indexOf(idx) != -1) {
                    var value = $(this).text();
                    var input = $('<input type="text" maxlength="20" />');
                    input.val(value);
                    input.attr('hidval', value);
                    $(this).empty().append(input);
                }
            });
            trline.find('#op-normal').hide();
            trline.find('#op-edit').show();
        }

        //取消编辑
        function CancelEdit(id) {
            var trline = $('#' + id);
            trline.find('td').each(function (idx, item) {
                if (tdlist.indexOf(idx) != -1) {
                    var value = $(this).find('input').attr('hidval');
                    $(this).empty().text(value);
                }
            });
            trline.find('#op-normal').show();
            trline.find('#op-edit').hide();
        }

        //保存
        function SaveEdit(id) {
            var trline = $('#' + id);

            var formData = {};
            formData.action = 2;
            formData.id = id;
            trline.find('td').each(function (idx, item) {
                var value = $(this).find('input').val();
                switch (idx) {
                    case 4:
                        formData.acc = value;
                        break;
                    case 5:
                        formData.pwd = value;
                        break;
                    case 6:
                        formData.ext = value;
                        break;
                }
            });

            $.post('', formData, function (jdata) {
                switch (jdata.code) {
                    case "OK":
                        trline.find('td').each(function (idx, item) {
                            if (tdlist.indexOf(idx) != -1) {
                                var value = $(this).find('input').val();
                                $(this).empty().text(value);
                            }
                        });
                        trline.find('#op-normal').show();
                        trline.find('#op-edit').hide();
                        showInfo(jdata.message);
                        break;
                    case "Err":
                        showErr(jdata.message);
                        break;
                }
            });

        }




        //帐户充值
        function BindInfo(id) {
            setTimeout(function () {
                $('#hidUserId2').val(id);//要等modal-form显示后才能设置值
                var email = $('#' + id).find('td').eq(1).text();
                var prod = $('#' + id).find('td').eq(3).text();
                $('#user').text(email + "【" + prod + "】");
            }, 300);
        }
        $('#modal-form2').on('hidden.bs.modal', function (e) {
            $('#hidUserId2').val('');
            $('#user').empty();
            $('#modal-form2 input').val('');
        });
        $('#modal-form2').on('submit', function (e) {
            e.preventDefault();

            $('#modal-form2 button').attr('disabled', 'disabled');

            $.post('', 'action=4&' + $(this).serialize(), function (jdata) {
                $('#modal-form2 button').removeAttr('disabled');

                switch (jdata.code) {
                    case "OK":
                        __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                        showInfo(jdata.message);
                        $("#modal-form2").modal("hide");
                        break;
                    case "Err":
                        showErr(jdata.message);
                        break;
                }
            }, 'json');

        });


    </script>


</asp:Content>
