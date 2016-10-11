<%@ Page Title="敏感词列表" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="KeywordsList.aspx.cs" Inherits="Weetop.Web.CMS.KeywordsList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                            <input id="txtSearch" type="text" autocomplete="off" maxlength="150" style="width: 300px;" class="form-control" runat="server" placeholder="输入搜索：敏感词" />
                            <asp:LinkButton ID="btnSearch" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                    </div>
                    <div class="pull-right tableTools-container">
                        <a href="#modal-form" id="" role="button" class="btn btn-sm btn-success" data-toggle="modal" title="添加"><i class="ace-icon fa fa-plus-circle bigger-130"></i>添加</a>
                        <a href="#uploadfiles" id="ImportFile" role="button" class="btn btn-sm btn-success" data-toggle="modal" title="导入"><i class="ace-icon fa fa-plus-circle bigger-130"></i>导入</a>
                    </div>
                </div>


                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtSearch" />
                        <asp:AsyncPostBackTrigger ControlID="btnSearch" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>
                                <table id="mytable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>敏感词</th>
                                            <th>排序</th>
                                            <th class="hidden-xs"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id='<%# Eval("Id") %>'>
                                    <td><%# Eval("KeyName") %></td>
                                    <td><%# Eval("Sort") %></td>
                                    <td class="action-buttons hidden-xs center">
                                        <span id="op-normal">
                                            <a class="green" href="javascript:DoEditInline('<%# Eval("Id") %>');" title="编辑">
                                                <i class="ace-icon fa fa-pencil bigger-130"></i>
                                            </a>
                                            <a class="red" href="javascript:ConfirmDel('<%# Eval("Id") %>');" title="删除">
                                                <i class="ace-icon fa fa-trash-o bigger-130"></i>
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
                            <h4 class="blue bigger">添加敏感词</h4>
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <label for="form-field-name">敏感词</label>

                                        <div>
                                            <input required type="text" id="form-field-name" class="form-control" name="value" maxlength="50" placeholder="敏感词" autocomplete="off" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="form-group">
                                        <label for="form-field-sort">排序</label>

                                        <div>
                                            <input type="text" id="form-field-sort" class="form-control" name="sort" maxlength="100" placeholder="0" autocomplete="off" />
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

            <div id="uploadfiles" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" id="close" data-dismiss="modal">&times;</button>
                            <h4 class="blue bigger">导入</h4>
                        </div>

                        <div class="modal-body">
                            <input type="file" id="fileToUpload" name="fileToUpload" accept=".xls,.txt" />
                        </div>
                        <div class="modal-footer">
                            <input type="button" id="ajaxfileuploadButton" value="提交" />
                        </div>
                    </div>
                </div>
            </div>  
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">
    <script src="/static/dep/jquery.min.js"></script>
    <script src="/static/dep/ajaxfileupload_JS_File/ajaxfileupload.js"></script>
    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveMenu('menu7');

        $(function () {
            $("#ajaxfileuploadButton").click(function () {
                $("#close").click();
                ajaxFileUpLoad();
                __doPostBack('<%= UpdatePanel1.ClientID %>', '');
            });
        });
        function ajaxFileUpLoad() {
            $.ajaxFileUpload(
                {
                    url: 'KeywordsList?action=4',
                    secureuri: false,
                    fileElementId: 'fileToUpload',
                    dataType: 'json',
                    success: function (data, status) {
                    },
                    error: function (data, status, e) {
                    }
                }
            )
        }

        //新建
        jQuery(function ($) {
            $("#Submit1").click(function () {
                if ($("#filedate").val() == null || $("#filedate").val() == "") {
                    alert("请上传资源!");
                    return false;
                }
            });

            //隐藏后重置，显示前重置，清空自填表
            $('#modal-form').on('hidden.bs.modal show.bs.modal', function (e) {
                this.reset();
            });

            $('#modal-form').on('submit', function (e) {

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

                return false;
            });
        })



        var tdlist = [0, 1];
        //编辑按钮
        function DoEditInline(id) {
            //替换控件
            var trline = $('#' + id);
            trline.find('td').each(function (idx, item) {
                //alert(idx + ' : ' + item.innerHTML);
                if (tdlist.indexOf(idx) != -1) {
                    var value = $(this).text();
                    var input = $('<input type="text" />');
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

            var warning = false;
            trline.find('td').each(function (idx, item) {
                var value = $(this).find('input').val();
                switch (idx) {
                    case 0:
                        if ($.trim(value) == "") {
                            showWarn('请填写有效专场名称');
                            warning = true;
                        }
                        else
                            formData.name = value;
                        break;
                    case 1:
                        formData.sort = value;
                        break;
                }
            });

            if (warning) return;

            $.post('', formData, function (jdata) {
                switch (jdata.code) {
                    case "OK":
                        showInfo(jdata.message);
                        __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                        break;
                    case "Err":
                        showErr(jdata.message);
                        break;
                }
            }, 'json');

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

    </script>

</asp:Content>

