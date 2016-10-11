<%@ Page Title="帐户信息" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="AdminList.aspx.cs" Inherits="Weetop.Web.CMS.AdminList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="/static/dep/assets/css/chosen.css" rel="stylesheet" />
    <link href="/static/dep/validator/jquery.validator.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

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
            <div class="clearfix">
                <div class="pull-right tableTools-container">
                    <a href="#modal-form" id="" role="button" class="btn btn-sm btn-success" data-toggle="modal" title="添加帐号"><i class="ace-icon fa fa-plus-circle bigger-130"></i>添加帐号</a>
                </div>
            </div>

            <form runat="server" autocomplete="on">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <ContentTemplate>

                        <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                            <HeaderTemplate>
                                <table id="mytable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>帐号</th>
                                            <th>姓名</th>
                                            <th class="hidden-480">邮箱</th>
                                            <th class="hidden-480">电话</th>
                                            <th class="hidden-480 hidden-xs">上次登陆</th>
                                            <th class="center">角色</th>
                                            <th class="center">状态</th>
                                            <th class="hidden-xs"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id="<%# Eval("UserId") %>">
                                    <td><%# Eval("UserName") %></td>
                                    <td><%# Eval("RealName") %></td>
                                    <td class="hidden-480"><%# Eval("Email") %></td>
                                    <td class="hidden-480"><%# Eval("Phone") %></td>
                                    <td class="hidden-480 hidden-xs"><%# Eval("LastLogin") %></td>
                                    <td class="center">
                                        <div class="inline position-relative">
                                            <a href="javascript:" rolecode="<%# Eval("RoleCode") %>" class="dropdown-toggle" <%# Eval("RoleCode").ToString() == "SUPER_ADMIN" || Eval("UserId").ToString() == Admin.UserId.ToString() ? "" : "data-toggle='dropdown'" %>>
                                                <span class="role-label label <%# Eval("RoleCode").ToString() == "SUPER_ADMIN" ? "label-purple" : "label-yellow" %> arrowed arrowed-right"><%# Eval("RoleName") %></span>
                                            </a>
                                            <ul class="align-left dropdown-menu dropdown-caret dropdown-lighter">
                                                <li class="dropdown-header">选择角色</li>
                                                <asp:Repeater ID="Repeater2" runat="server">
                                                    <ItemTemplate>
                                                        <li>
                                                            <a href="javascript:" rolecode="<%# Eval("RoleCode") %>">
                                                                <i class="ace-icon fa fa-hand-o-right grey"></i>
                                                                <span class="label arrowed arrowed-right label-yellow"><%# Eval("RoleName") %></span>
                                                            </a>
                                                        </li>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ul>
                                        </div>
                                    </td>
                                    <td class="center">
                                        <label>
                                            <input <%# Eval("RoleCode").ToString() == "SUPER_ADMIN" || Eval("UserId").ToString() == Admin.UserId.ToString() ? "disabled='disabled'" : "" %> <%# (bool)Eval("Enabled") ? "checked='checked'" : "" %> class="ace ace-switch ace-switch-4 btn-empty" type="checkbox" />
                                            <span class="lbl middle" data-lbl="启用       禁用"></span>
                                        </label>
                                    </td>
                                    <td class="action-buttons hidden-xs center">
                                        <%# Eval("RoleCode").ToString() == "SUPER_ADMIN" || Eval("UserId").ToString() == Admin.UserId.ToString() ? "" : "<a class=\"red\" href=\"javascript:ConfirmReset('" + Eval("UserId") + "');\" title=\"重置密码\"><i class=\"ace-icon fa fa-key bigger-130\"></i></a>" %>
                                        <%# Eval("RoleCode").ToString() == "SUPER_ADMIN" || Eval("UserId").ToString() == Admin.UserId.ToString() ? "" : "<a class=\"red\" href=\"javascript:ConfirmDel('" + Eval("UserId") + "');\" title=\"删除\"><i class=\"ace-icon fa fa-trash-o bigger-130\"></i></a>" %>
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
                            <h4 class="blue bigger">添加帐号</h4>
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <label for="form-userName">帐号<b style="color: red;">*</b></label>

                                        <div>
                                            <input type="text" id="form-userName" class="form-control" name="userName" maxlength="50" placeholder="帐号" autocomplete="on" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <label for="form-realName">姓名</label>

                                        <div>
                                            <input type="text" id="form-realName" class="form-control" name="realName" maxlength="50" placeholder="姓名" autocomplete="on" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <label for="form-email">邮箱</label>

                                        <div>
                                            <input type="text" id="form-email" class="form-control" name="email" maxlength="50" placeholder="邮箱" autocomplete="on" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <label for="form-phone">电话</label>

                                        <div>
                                            <input type="text" id="form-phone" class="form-control" name="phone" maxlength="11" placeholder="电话" autocomplete="on" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <label for="form-pwd">密码<b style="color: red;">*</b></label>

                                        <div>
                                            <input type="password" id="form-pwd" class="form-control" name="pwd" maxlength="16" placeholder="密码" autocomplete="off" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <label for="form-role">角色<b style="color: red;">*</b></label>

                                        <div>
                                            <select id="form-role" class="form-control" name="role">
                                                <% foreach (var role in RoleList)
                                                    { %>
                                                <option value="<%= role.RoleCode %>"><%= role.RoleName %></option>
                                                <% } %>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-12 col-sm-12">
                                    <div class="form-group">
                                        <label for="form-remark">备注</label>

                                        <div>
                                            <input type="text" id="form-remark" class="form-control" name="remark" maxlength="200" placeholder="备注" autocomplete="on" />
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <script src="/static/dep/assets/js/chosen.jquery.js"></script>
    <script src="/static/dep/validator/jquery.validator.js"></script>
    <script src="/static/dep/validator/local/zh-CN.js"></script>
    <script src="/static/dep/md5.min.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveSubMenu('menu11');


        //下拉控件
        $('#form-role').chosen({
            width: "100%",
            placeholder_text_single: "选择角色",
            disable_search_threshold: 20,//小于此值不显示搜索
            allow_single_deselect: true//可清除选择
        });


        //新建角色
        jQuery(function ($) {
            //隐藏后重置，显示前重置，清空自填表
            $('#modal-form').on('hidden.bs.modal show.bs.modal', function (e) {
                this.reset();
                $("#form-role").val('').trigger("chosen:updated");
            });

            //验证
            $('#modal-form').validator({
                stopOnError: true,
                theme: 'yellow_top',
                fields: {
                    'userName': 'required;username',
                    'pwd': 'required;password',
                    'email': 'email',
                    'phone': 'mobile',
                    'role': '角色:required(not, 0)'
                }
            }).on('valid.form', function (e, form) {

                $('#modal-form button').attr('disabled', 'disabled');

                $.post('', 'action=1&' + $(this).serialize(), function (jdata) {
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
                }, 'json');
            });
        })

        //切换角色
        $('form').on('click', '.dropdown-menu a', function (e) {
            var me = this;

            var userid = $(me).parents('tr').attr('id');
            var rolecode = $(me).attr('rolecode');
            var oldrolecode = $(me).parents('ul').prev('a').attr('rolecode');
            if (rolecode === oldrolecode) {
                //showInfo('无需切换');
            } else {
                $.post('', { action: 2, id: userid, rolecode: rolecode }, function (jdata) {
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
        })

        //切换状态
        $('form').on('click.switch', '.ace.ace-switch', function (e) {
            var me = this;

            $(me).attr('disabled', 'disabled');

            $.post('', { action: 4, id: $(me).parents('tr').attr('id'), checked: me.checked }, function (jdata) {
                $(me).removeAttr('disabled');

                switch (jdata.code) {
                    case "OK":
                        showInfo(jdata.message);
                        break;
                    case "Err":
                        showErr(jdata.message);
                        me.checked = !me.checked;
                        break;
                }
            }, 'json');
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

        //重置密码
        function ConfirmReset(id) {
            bootbox.confirm({
                message: "确认要重置？",
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
                        $.post('', { action: 5, id: id }, function (jdata) {
                            switch (jdata.code) {
                                case "OK":
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
