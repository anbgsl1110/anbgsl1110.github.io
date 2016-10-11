<%@ Page Title="产品应用管理" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="ProductList.aspx.cs" Inherits="Weetop.Web.CMS.ProductList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <ContentTemplate>

                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>
                                <table id="mytable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>产品名称</th>
                                            <th>产品代码</th>
                                            <th class="center">状态</th>
                                            <th class="hidden-480 hidden-xs"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id="<%# Eval("Id") %>">
                                    <td><%# Eval("Id") %></td>
                                    <td><%# Eval("ProductIdName") %></td>
                                    <td><%# Eval("ProductId") %></td>
                                    <td class="center">
                                        <label>
                                            <input <%# (bool)Eval("Enabled") ? "checked='checked'" : "" %> class="ace ace-switch enable ace-switch-4 btn-flat btn-empty" type="checkbox" />
                                            <span class="lbl middle" data-lbl="启用       禁用"></span>
                                        </label>
                                    </td>
                                    <td class="action-buttons hidden-480 hidden-xs center">
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
                                    </td>
                                </tr>

                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </form>


        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">


    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveMenu('menu9');





        //切换状态
        $('form').on('click.switch', '.ace.ace-switch.enable', function (e) {
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





        var tdlist = [2];
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
                    case 2:
                        formData.pcode = value;
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
