<%@ Page Title="发票管理" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="InvoiceList.aspx.cs" Inherits="Weetop.Web.CMS.InvoiceList" %>

<%@ Import Namespace="Weetop.DAL" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/static/dep/assets/css/chosen.css" rel="stylesheet" />
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
            <form runat="server" autocomplete="off">

                <div class="clearfix">
                    <div class="pull-left tableTools-container">
                        <span style="float: left; margin-right: 10px;">
                            <asp:DropDownList ID="ddlOrderStatus" AutoPostBack="true" CssClass="form-control" runat="server"></asp:DropDownList>
                        </span>
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input class="form-control" style="width: 300px; max-width: 100%;" id="txtDateRange" placeholder="按时间段筛选：索取时间" runat="server" type="text" name="date-range-picker" />
                            <asp:LinkButton ID="btnDate" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input id="txtSearch" type="text" autocomplete="off" maxlength="150" style="width: 300px;" class="form-control" runat="server" placeholder="输入搜索：企业名称、电话" />
                            <asp:LinkButton ID="btnSearch" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                    </div>
                    <div class="pull-right tableTools-container" style="margin-right:50px;">
                         <asp:Button ID="ExportFile" runat="server" Text="导出" class="btn btn-sm btn-success" OnClick="ExportFile_Click" />
                    </div>
                </div>

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlOrderStatus" />
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
                                            <th>电话（注册）</th>
                                            <th>索取时间</th>
                                            <th>金额</th>
                                            <th>发票抬头</th>
                                            <th>发票类型</th>
                                            <th>收取方式</th>
                                            <th>快递单号</th>
                                            <th>标注</th>
                                            <th>状态</th>
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
                                    <td><%# Eval("CreateDate") %></td>
                                    <td><%# string.Format("{0:C0}",Eval("FMoney")) %></td>
                                    <td><a href="InvoiceDetail.aspx?oid=<%#Eval("Id") %>&did=<%#Eval("InvoInfoId") %>&page=<%#AspNetPager1.CurrentPageIndex %>"><%#Eval("FTitle") %></a></td>
                                    <td><%# (InvoType)SiteInvoice.GetOne( Common.ToLong(Eval("InvoInfoId")) ).InvoType %></td>
                                    <td><%# (ReceiveWay)Common.ToInt(Eval("ReceiveWay")) %></td>
                                    <td><%# Eval("CourierNumber") %></td>
                                    <td><%# Eval("Feedback") %></td>
                                    <td>
                                        <div class="inline position-relative">
                                            <a href="javascript:" rolecode="<%# Eval("FStatus") %>" class="dropdown-toggle" <%# !true ? "" : "data-toggle='dropdown'" %>>
                                                <span class="role-label label label-primary arrowed arrowed-in-right"><%# (InvoStatus)Common.ToInt(Eval("FStatus")) %></span>
                                            </a>
                                            <ul class="align-left dropdown-menu dropdown-caret dropdown-lighter">
                                          <%foreach (var item in list)
                                          {
                                              if (item.PrivilegeCode == "XG")
                                              {%>
                                                  <li class="dropdown-header">更改状态</li>
                                                <asp:Repeater ID="Repeater2" runat="server">
                                                    <ItemTemplate>
                                                        <li>
                                                            <a href="javascript:" rolecode="<%# Eval("Key") %>">
                                                                <i class="ace-icon fa fa-hand-o-right grey"></i>
                                                                <span class="label label-primary arrowed arrowed-in-right"><%# Eval("Value") %></span>
                                                            </a>
                                                        </li>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                              <%}
                                          } %>

                                                
                                            </ul>
                                        </div>
                                    </td>
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
                                              <%}
                                          } %>

                                       
                                    </td>
                                    <td class="action-buttons hidden-480 hidden-xs center"></td>
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
        ActiveSubMenu('menu22');


        //下拉控件
        $('[id$=ddlOrderStatus]').chosen({
            width: '110px',
            placeholder_text_single: "状态",
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


        //切换状态
        $('form').on('click', '.dropdown-menu a', function (e) {
            var me = this;

            var userid = $(me).parents('tr').attr('id');
            var rolecode = $(me).attr('rolecode');
            var oldrolecode = $(me).parents('ul').prev('a').attr('rolecode');
            if (rolecode === oldrolecode) {
                //showInfo('无需切换');
            } else {
                $.post('', { action: 4, id: userid, rolecode: rolecode },
                    function (jdata) {
                        switch (jdata.code) {
                            case "OK":
                                __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                                showInfo(jdata.message);
                                break;
                            case "Err":
                                showErr(jdata.message);
                                break;
                        }
                    }, 'json');
                }
        });




        var tdlist = [7];
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
                    case 7:
                        formData.acc = value;
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
    </script>

</asp:Content>
