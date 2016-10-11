<%@ Page Title="短信模板管理" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="SmsTemp.aspx.cs" Inherits="Weetop.Web.CMS.SmsTemp" %>

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
                            <input class="form-control" style="width: 300px; max-width: 100%;" id="txtDateRange" placeholder="按时间段筛选：申请时间" runat="server" type="text" name="date-range-picker" />
                            <asp:LinkButton ID="btnDate" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input id="txtSearch" type="text" autocomplete="off" maxlength="150" style="width: 300px;" class="form-control" runat="server" placeholder="输入搜索：企业名称、电话" />
                            <asp:LinkButton ID="btnSearch" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
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
                                <table id="mytable" class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>帐号</th>
                                            <th>认证企业名称</th>
                                            <%--<th class="center">特服号</th>--%>
                                            <th>模板名称</th>
                                            <th>模板类型</th>
                                            <th>申请说明</th>
                                            <th>申请时间</th>
                                            <th>审核状态</th>
                                            <th>标注</th>
                                            <th class="hidden-480 hidden-xs"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id="<%# Eval("Id") %>">
                                    <td><%# Eval("Id") %></td>
                                    <td>
                                        <asp:Literal ID="Literal1" runat="server"></asp:Literal></td>
                                    <td>
                                        <asp:Literal ID="Literal2" runat="server"></asp:Literal></td>
                                    <%--<td class="center">
                                        <asp:Literal ID="Literal3" runat="server"></asp:Literal></td>--%>
                                    <td><%# Eval("Title") %></td>
                                    <td><%# (TempSmsType)Common.ToInt(Eval("SmsType")) %></td>
                                    <td><%# Eval("Remark") %></td>
                                    <td><%# Eval("CreateDate") %></td>
                                    <td>
                                        <div class="inline position-relative">
                                            <a href="javascript:" rolecode="<%# Eval("CheckStatus") %>" class="dropdown-toggle" <%# !true ? "" : "data-toggle='dropdown'" %>>
                                                <span class="role-label label label-primary arrowed arrowed-in-right"><%# (TempCheckStatus)Common.ToInt(Eval("CheckStatus")) %></span>
                                            </a>
                                            <ul class="align-left dropdown-menu dropdown-caret dropdown-lighter">
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
                                            </ul>
                                        </div>
                                    </td>
                                    <td><%# Eval("Feedback") %></td>
                                    <td class="action-buttons hidden-480 hidden-xs center">
                                        <%foreach (var item in list)
                                          {
                                              if (item.PrivilegeCode == "XG")
                                              {%>
                                                  <a class="green" href="#modal-form" onclick="javascript:BindPriv('<%# Eval("Id") %>');" data-toggle="modal" title="修改标注">
                                                    <i class="ace-icon fa fa-pencil bigger-130"></i>
                                                  </a>
                                              <%}
                                                if (item.PrivilegeCode == "SC")
                                              {%>
                                                    <a class="red" href="javascript:ConfirmDel('<%# Eval("Id") %>');" title="删除">
                                                    <i class="ace-icon fa fa-trash-o bigger-130"></i>
                                                    </a>
                                              <%} 
                                                
                                          } %>
                                    </td>
                                </tr>
                                <tr style="border-bottom: 1px solid #d5d5d5">
                                    <td colspan="3"></td>
                                    <td class="align-right" colspan="6"><%# Eval("Content") %></td>
                                    <td class="action-buttons hidden-480 hidden-xs center">
                                        <a class="green" href="#modal-form2" onclick="javascript:BindPriv2('<%# Eval("Id") %>');" data-toggle="modal" title="修改模板内容">
                                            <i class="ace-icon fa fa-pencil-square-o bigger-130"></i>
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


        </div>
    </div>



    <form id="modal-form" class="modal fade" tabindex="-1" data-backdrop="static" autocomplete="on">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="blue bigger">标注管理</h4>
                </div>

                <input type="hidden" id="hidRoleId" name="hidRoleId" />
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12">
                            <div class="form-group">
                                <label for="form-field-name">标注</label>

                                <div>
                                    <textarea id="form-field-name" class="form-control" name="remark" maxlength="250" placeholder="250字"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-sm" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>

                    <button class="btn btn-sm btn-primary">
                        <i class="ace-icon fa fa-check"></i>
                        确定
                    </button>
                </div>
            </div>
        </div>
    </form>



    <form id="modal-form2" class="modal fade" tabindex="-1" data-backdrop="static" autocomplete="on">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="blue bigger">模板内容修改</h4>
                </div>

                <input type="hidden" id="hidRoleId2" name="hidRoleId" />
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12">
                            <div class="form-group">
                                <div>
                                    <textarea id="form-field-name2" class="form-control" name="remark" maxlength="300" onkeyup="checkWord(this);" onkeydown="checkWord(this);" placeholder="300字" style="height: 140px;"></textarea>
                                    还可以输入<span style="font-family: Georgia; font-size: 20px;" id="wordCheck">300</span>个字符，最多<span style="font-family: Georgia; font-size: 20px;" id="wordCheck">300</span>个字符
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-sm" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>

                    <button class="btn btn-sm btn-primary">
                        <i class="ace-icon fa fa-check"></i>
                        确定
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
    <script src="/static/dep/jsrender.min.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">



    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveMenu('menu4a');


        //下拉控件
        $('[id$=ddlOrderStatus]').chosen({
            width: '110px',
            placeholder_text_single: "审核状态",
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
                $.post('', { action: 4, id: userid, rolecode: rolecode }, function (jdata) {
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


        function BindPriv(id) {
            setTimeout(function () {
                $('#hidRoleId').val(id);//设置id便于post到服务器
            }, 500);
        }

        jQuery(function ($) {
            //隐藏后重置，显示前重置，清空自填表
            $('#modal-form').on('hidden.bs.modal show.bs.modal', function (e) {
                this.reset();
            });

            $('#modal-form').on('submit', function (e) {
                e.preventDefault();

                $('#modal-form button').attr('disabled', 'disabled');

                $.post('', 'action=2&' + $(this).serialize(), function (jdata) {
                    $('#modal-form button').removeAttr('disabled');

                    switch (jdata.code) {
                        case "OK":
                            showInfo(jdata.message);
                            __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                            $("#modal-form").modal("hide");
                            break;
                        case "Err":
                            showErr(jdata.message);
                            break;
                    }
                }, 'json');

            });
        });










        var maxstrlen = 300;
        function Q(s) { return document.getElementById(s); }

        function checkWord(c) {
            len = maxstrlen;
            var str = c.value;
            myLen = getStrleng(str);
            var wck = Q("wordCheck");

            if (myLen > len * 2) {
                c.value = str.substring(0, i + 1);
            }
            else {
                wck.innerHTML = Math.floor((len * 2 - myLen) / 2);
            }
        }

        function getStrleng(str) {
            myLen = 0;
            i = 0;
            for (; (i < str.length) && (myLen <= maxstrlen * 2) ; i++) {
                if (str.charCodeAt(i) > 0 && str.charCodeAt(i) < 128)
                    myLen++;
                else
                    myLen += 2;
            }
            return myLen;
        }






        function BindPriv2(id) {
            setTimeout(function () {
                $('#hidRoleId2').val(id);//设置id便于post到服务器
            }, 500);
            $.getJSON('', { action: 5, id: id }, function (jdata, textStatus, jqXHR) {
                if ('success' == textStatus) {
                    switch (jdata.code) {
                        case "OK":
                            $('#modal-form2 #form-field-name2').val(jdata.data.content);
                            checkWord($('#form-field-name2').get(0));
                            break;
                        case "Err":
                            showErr(jdata.message);
                            break;
                    }

                }
            });
        }

        jQuery(function ($) {
            //隐藏后重置，显示前重置，清空自填表
            $('#modal-form2').on('hidden.bs.modal show.bs.modal', function (e) {
                this.reset();
            });

            $('#modal-form2').on('submit', function (e) {
                e.preventDefault();

                $('#modal-form2 button').attr('disabled', 'disabled');

                $.post('', 'action=6&' + $(this).serialize(), function (jdata) {
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
        });



        //删除
        function ConfirmDel(id) {
            bootbox.confirm({
                message: "确认要删除？",
                buttons: {
                    confirm: {
                        label: "是的",
                        className: "btn-primary btn-sm"
                    },
                    cancel: {
                        label: "不要",
                        className: "btn-sm"
                    }
                },
                callback: function (result) {
                    //alert(result);
                    if (result) {
                        $.post('', { action: 3, id: id }, function (jdata) {
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
                }
            });
        }





    </script>

</asp:Content>
