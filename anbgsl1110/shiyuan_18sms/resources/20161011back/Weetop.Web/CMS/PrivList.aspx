<%@ Page Title="角色权限" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="PrivList.aspx.cs" Inherits="Weetop.Web.CMS.PrivList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                    <a href="#modal-form-new" id="" role="button" class="btn btn-sm btn-success" data-toggle="modal" title="添加角色"><i class="ace-icon fa fa-plus-circle bigger-130"></i>添加</a>
                </div>
            </div>

            <form runat="server" autocomplete="off">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <ContentTemplate>

                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>

                                <table id="mytable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th class="center">角色</th>
                                            <th class="center">状态</th>
                                            <th class="hidden-xs center action-buttons"></th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id="<%# Eval("RoleId") %>">
                                    <td class="center">
                                        <span class="role-label label <%# Eval("RoleCode").ToString() == "SUPER_ADMIN" ? "label-purple" : "label-yellow" %> arrowed arrowed-right"><%# Eval("RoleName") %></span>
                                    </td>
                                    <td class="center">
                                        <label>
                                            <input <%# Eval("RoleCode").ToString() == "SUPER_ADMIN" ? "disabled='disabled'" : "" %> <%# (bool)Eval("Enabled") ? "checked='checked'" : "" %> class="ace ace-switch ace-switch-4 btn-empty" type="checkbox" />
                                            <span class="lbl middle" data-lbl="启用       禁用"></span>
                                        </label>
                                    </td>

                                    <td class="hidden-xs center action-buttons">
                                        <%# Eval("RoleCode").ToString() == "SUPER_ADMIN" ? "" : "<a class=\"green middle\" href=\"#modal-form\" onclick=\"javascript:BindPriv('" + Eval("RoleId") + "');\" role=\"button\" data-toggle=\"modal\" title=\"编辑权限\"><i class=\"ace-icon fa fa-pencil-square-o bigger-130\"></i></a>" %>
                                        <%# Eval("RoleCode").ToString() == "SUPER_ADMIN" ? "" : "<a class=\"red\" href=\"javascript:ConfirmDel('" + Eval("RoleId") + "');\" title=\"删除\"><i class=\"ace-icon fa fa-trash-o bigger-130\"></i></a>" %>
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

            <form id="modal-form" class="modal fade" tabindex="-1" data-backdrop="static" autocomplete="off">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="blue bigger">修改角色权限</h4>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="hidRoleId" name="hidRoleId" />
                            <table class="table table-striped table-bordered">
                                <thead>
                                    <tr>
                                        <td></td>
                                        <td class="center"><strong>模块名称</strong></td>
                                        <td><strong>权限集合</strong></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% string oldMode = null; %>
                                    <% foreach (Weetop.Model.View_ModPrivilege mp in ModPrivList)
                                        {
                                            if (mp.ModuleCode == "QXGL") { continue; }
                                            if (oldMode != mp.ModuleCode)
                                            {
                                                if (oldMode != null)
                                                { %>
                                            </td></tr>
                                            <% }
                                                oldMode = mp.ModuleCode;
                                            %>
                                    <tr>
                                        <td></td>
                                        <td class="center"><%= mp.ModuleName %></td>
                                        <td><% } %>
                                            <label>
                                                <input name="CkModPrivId" id="mp<%= mp.ModPrivId %>" value="<%= mp.ModPrivId %>" class="ace" type="checkbox" />
                                                <span class="lbl"><%= mp.PrivilegeName %></span>
                                            </label>
                                            <% } %>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-sm" id="" data-dismiss="modal">
                                <i class="ace-icon fa fa-times"></i>
                                取消
                            </button>

                            <button class="btn btn-sm btn-primary" id="">
                                <i class="ace-icon fa fa-check"></i>
                                保存
                            </button>
                        </div>
                    </div>
                </div>
            </form>


            <form id="modal-form-new" class="form-horizontal modal fade" tabindex="-1" data-backdrop="static" autocomplete="off">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="blue bigger">添加普通角色</h4>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-xs-12 col-sm-12">
                                    <div class="form-group">
                                        <div class="col-xs-3 col-sm-3">
                                            <label class="control-label pull-right" for="form-roleName">角色名称</label>
                                        </div>
                                        <div class="col-xs-7 col-sm-7">
                                            <input type="text" id="form-roleName" class="form-control" name="roleName" maxlength="50" placeholder="角色名称" autocomplete="off" />
                                        </div>
                                        <div class="col-xs-2 col-sm-2"></div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-sm" id="" data-dismiss="modal">
                                <i class="ace-icon fa fa-times"></i>
                                取消
                            </button>

                            <button class="btn btn-sm btn-primary" id="">
                                <i class="ace-icon fa fa-check"></i>
                                保存
                            </button>
                        </div>
                    </div>
                </div>
            </form>

        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <script src="/static/dep/validator/jquery.validator.js"></script>
    <script src="/static/dep/validator/local/zh-CN.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveSubMenu('menu12');


        jQuery(function ($) {

            //编辑权限

            //隐藏后重置
            $('#modal-form')
                .on('hidden.bs.modal',
                    function (e) {
                        $('#hidRoleId').val('');
                        $(this).find('input').prop('checked', false);
                        //this.reset();
                    });

            //提交
            $('#modal-form').on('submit', function (e) {

                $('#modal-form button').attr('disabled', 'disabled');

                $.post('',
                    'action=2&' + $(this).serialize(),
                    function (jdata) {
                        $('#modal-form button').removeAttr('disabled');

                        switch (jdata.code) {
                            case "OK":
                                showInfo(jdata.message);
                                $("#modal-form").modal("hide");
                                break;
                            case "Err":
                                showErr(jdata.message);
                                break;
                        }
                    },
                    'json');

                e.preventDefault();
            });


            //添加角色

            //隐藏后重置，显示前重置
            $('#modal-form-new')
                .on('hidden.bs.modal show.bs.modal',
                    function (e) {
                        //$('#form-roleName').val('');
                        this.reset();
                    });

            //验证
            $('#modal-form-new').validator({
                stopOnError: true,
                theme: 'yellow_top',
                fields: {
                    'roleName': '角色名称:required;length[~40]'
                }
            }).on('valid.form', function (e, form) {
                e.preventDefault();

                $.post('',
                    { action: 1, rolename: $('#form-roleName').val() },
                    function (jdata) {
                        switch (jdata.code) {
                            case "OK":
                                showInfo(jdata.message);
                                __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                                $("#modal-form-new").modal("hide");
                                break;
                            case "Err":
                                showErr(jdata.message);
                                break;
                        }
                    },
                            'json');

            });

        });


            //初始化权限数据
            function BindPriv(id) {
                setTimeout(function () {
                    $('#hidRoleId').val(id);//设置id便于post到服务器
                }, 300);
                $.getJSON('', { action: 5, id: id }, function (data, state, xhr) {
                    if (state == 'success') {
                        //console.log(data.toSource());
                        if (data.length > 0) {
                            $.each(data, function (idx, item) {
                                $('#mp' + item.ModPrivId).prop("checked", true);
                            });
                        }
                    }
                });
            }

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

    </script>

</asp:Content>

