<%@ Page Title="图片管理" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="Carousel.aspx.cs" Inherits="Weetop.Web.CMS.Carousel" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <div class="page-header">
        <h1><%: Page.Title %>
            <small>
                <i class="ace-icon fa fa-angle-double-right"></i>
                <%= PageSubTitle %>
            </small>
        </h1>
    </div>
    <!-- /.page-header -->



    <div class="row">
        <div class="col-xs-12">

            <div class="clearfix">
                <div class="pull-right tableTools-container">
                    <a href="#modal-form" id="" role="button" class="btn btn-sm btn-success" data-toggle="modal" title="添加图片"><i class="ace-icon fa fa-plus-circle bigger-130"></i>添加图片</a>
                </div>
            </div>

            <form runat="server">

                <asp:HiddenField ID="hidType" runat="server" />

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <ContentTemplate>

                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>

                                <table id="mytable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th class="center">图片</th>
                                            <th>排序</th>
                                            <th>链接</th>
                                            <th class="hidden-480">更新日期</th>
                                            <th class="hidden-xs"></th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id="<%# Eval("Id") %>">
                                    <td class="center">
                                        <img height="50" src="<%# basePath + Eval("Image") %>" /></td>
                                    <td><%# Eval("Sort") %></td>
                                    <td><%# Eval("Link") %></td>
                                    <td class="hidden-480"><%# Eval("UpdateDate") %></td>
                                    <td class="hidden-xs center action-buttons">
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

            <div id="modal-form" class="modal fade" tabindex="-1" data-backdrop="static">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="blue bigger">添加图片</h4>
                        </div>

                        <div class="modal-body">
                            <div class="row">
                                <div class="col-xs-12 col-sm-1"></div>
                                <div class="col-xs-12 col-sm-6">
                                    <input type="file" name="fimage" />
                                </div>

                                <div class="col-xs-12 col-sm-4">

                                    <div class="form-group">
                                        <label for="form-sort">排序</label>

                                        <div>
                                            <input type="number" id="form-sort" class="form-control" name="fsort" max="9999999" value="" />
                                        </div>
                                    </div>

                                    <div class="space-4"></div>

                                    <div class="form-group">
                                        <label for="form-link">链接</label>

                                        <div>
                                            <input type="text" id="form-link" class="form-control" name="flink" maxlength="150" placeholder="#" value="" />
                                        </div>
                                    </div>

                                </div>
                                <div class="col-xs-12 col-sm-1"></div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button class="btn btn-sm" data-dismiss="modal">
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
            </div>

        </div>
    </div>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <script src="/static/dep/assets/js/ace/elements.fileinput.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveSubMenu('menu21');


        //上传图片
        jQuery(function ($) {
            
            var maxBytes = <%= maxImageByte %>;
            var submiting = false;

            $('#modal-form input[type=file]').ace_file_input({
                style: 'well',
                thumbnail: 'fit',
                btn_choose: '拖动图片到这里或点击添加（gif,png,jpg,bmp）',
                btn_change: null,
                no_icon: 'ace-icon fa fa-picture-o',
                droppable: true,
                maxSize: maxBytes,
                allowExt: ['gif','png','jpg','jpeg','bmp'],// TODO 改成配置读取
                allowMime: ['image/gif','image/png','image/jpg','image/jpeg','image/bmp'],
                before_remove: function () {
                    //don't remove/reset files while being uploaded
                    return !submiting;
                }
            }).off('file.error.ace').on('file.error.ace', function (e, info) {
                //console.log(info.error_list);
                if(info.error_list.ext){
                    showWarn('图片格式错误');
                }
                if(info.error_list.size){
                    showWarn('图片大小不能超过 ' + (maxBytes / 1024 / 1024) + 'M');
                }
            });

            //隐藏后重置
            $('#modal-form').on('hidden.bs.modal', function (e) {
                $('#modal-form input[type=file]').ace_file_input('reset_input');
                $('#form-sort').val('');
                $('#form-link').val('');
            });

            //确定按钮事件
            $('#modal-form').on('click', '#submitForm', function () {
                
                //if ($('#modal-form input[type=file]')[0].files.length === 0) return false;
                if (!$('#modal-form input[type=file]').eq(0).data('ace_input_files')) return false;

                //if ($('#modal-form input[type=file]')[0].files[0].size > maxBytes) {
                //    showWarn('图片大小不能超过 ' + (maxBytes / 1024 / 1024) + 'M');
                //    return false;
                //}

                $('#modal-form button').attr('disabled', 'disabled');
                $('#modal-form input[type=file]').ace_file_input('disable');
                $('#modal-form').find('.modal-body').append("<div class='center'><i class='ace-icon fa fa-spinner fa-spin bigger-150 orange'></i></div>");

                //var formData = new FormData($('.modal-body')[0]);

                var formData = new FormData();
                formData.append('action', '1');
                //formData.append('file', $('#modal-form input[type=file]')[0].files[0]);
                formData.append('file', $('#modal-form input[type=file]').eq(0).data('ace_input_files')[0]);
                formData.append('sort', $('#form-sort').val());
                formData.append('link', $('#form-link').val());

                submiting = true;
                $.ajax({
                    url: '',
                    type: 'POST',
                    data: formData,
                    async: true,
                    success: function (jdata) {
                        $('#modal-form button').removeAttr('disabled');
                        $('#modal-form input[type=file]').ace_file_input('enable');
                        $('#modal-form').find('.modal-body > :last-child').remove();

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
                        submiting = false;
                    },
                    cache: false,
                    contentType: false,
                    processData: false
                });

            });

        });



        var tdlist = [1, 2];
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
                if (tdlist.indexOf(idx) == 0) {
                    var input = $(this).find('input');
                    input.attr('type', 'number');
                    input.attr('max', 9999999);
                }
                else if (tdlist.indexOf(idx) == 1) {
                    var input = $(this).find('input');
                    input.attr('maxlength', 150);
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

            var formData = {
                action: '2',
                id: id
            };

            trline.find('td').each(function (idx, item) {
                var value = $(this).find('input').val();
                switch (idx) {
                    case 1:
                        formData.sort = value;
                        break;
                    case 2:
                        formData.link = value;
                        break;
                }
            });
            
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
            },'json');

        }


        //删除图片
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
                    if (result) {
                        $.post('', { action: 3, id: id }, function (jdata) {
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
                }
            });
        }




    </script>

</asp:Content>
