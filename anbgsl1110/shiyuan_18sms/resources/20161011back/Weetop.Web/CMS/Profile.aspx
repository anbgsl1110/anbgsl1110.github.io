<%@ Page Title="用户中心" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Weetop.Web.CMS.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/static/dep/assets/css/bootstrap-editable.css" rel="stylesheet" />
    <link href="/static/dep/validator/jquery.validator.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">



    <div class="page-header">
        <h1><%: Page.Title %>
            <small>
                <i class="ace-icon fa fa-angle-double-right"></i>
                信息管理
            </small>
        </h1>
    </div>
    <!-- /.page-header -->



    <div class="row">
        <div class="col-xs-12 col-sm-2"></div>
        <!-- /.col -->

        <div class="col-xs-12 col-sm-3 center">
            <span class="profile-picture" style="max-width: 220px;">
                <img class="img-responsive" alt="<%= Admin.UserName %>" id="avatar" src="<%= string.IsNullOrEmpty(Admin.Avatar) ? "/static/dep/assets/avatars/faceq.png" : basePath + Admin.Avatar %>">
            </span>

            <div class="space space-4"></div>

            <h4>
                <span class="middle width-70 label label-info label-xlg arrowed-in arrowed-in-right">
                    <%= Admin.UserName %></span>
            </h4>
        </div>
        <!-- /.col -->

        <div class="col-xs-12 col-sm-5">


            <div class="profile-user-info">
                <div class="profile-info-row">
                    <div class="profile-info-name">角色 </div>

                    <div class="profile-info-value">
                        <span class="middle label <%= VAdmin.RoleCode  == "SUPER_ADMIN" ? "label-purple" : "label-yellow" %>  arrowed-right">
                            <%= VAdmin.RoleName %></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name">姓名 </div>

                    <div class="profile-info-value">
                        <span><%= Admin.RealName %></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name">邮箱 </div>

                    <div class="profile-info-value">
                        <span><%= Admin.Email %></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name">电话 </div>

                    <div class="profile-info-value">
                        <span><%= Admin.Phone %></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name">备注 </div>

                    <div class="profile-info-value">
                        <span><%= Admin.Remark %></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name">密码 </div>

                    <div class="profile-info-value">
                        <span><a href="#modal-form" onclick="javascript:PassId('<%= Admin.UserId %>');" id="updatePwd" role="button" class="red middle" data-toggle="modal" title="修改密码">******</a></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name">注册日期 </div>

                    <div class="profile-info-value">
                        <span><%= Admin.RegDate %></span>
                    </div>
                </div>
            </div>

            <div class="hr hr-8 dotted"></div>

            <div class="profile-user-info">


                <div class="profile-info-row action-buttons">
                    <div style="text-align: right;">
                        <span id="op-normal">
                            <a class="green" href="javascript:DoEditInline();" title="编辑">
                                <i class="ace-icon fa fa-pencil bigger-130"></i>
                            </a>
                        </span>
                        <span id="op-edit" style="display: none;">
                            <a class="green" href="javascript:SaveEdit();" title="保存">
                                <i class="ace-icon fa fa-check bigger-130"></i>
                            </a>
                            <a class="grey" href="javascript:CancelEdit();" title="取消">
                                <i class="ace-icon fa fa-times bigger-130"></i>
                            </a>
                        </span>
                    </div>
                </div>

            </div>
        </div>
        <!-- /.col -->

        <div class="col-xs-12 col-sm-2"></div>
        <!-- /.col -->
    </div>


    <form id="modal-form" class="modal fade" tabindex="-1" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="blue bigger">修改密码</h4>
                </div>
                <input type="hidden" id="fuserId" value="" />
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-6">
                            <div class="form-group">
                                <label for="form-oldpwd">原密码</label>

                                <div>
                                    <input type="password" id="form-oldpwd" class="form-control" name="foldpwd" maxlength="20" placeholder="原密码" autocomplete="off" />
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="form-group">
                                <label for="form-newpwd">新密码</label>

                                <div>
                                    <input type="password" id="form-newpwd" class="form-control" name="fnewpwd" maxlength="20" placeholder="新密码" autocomplete="off" />
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-sm" id="cancelForm" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        放弃
                    </button>

                    <button class="btn btn-sm btn-primary" id="submitForm">
                        <i class="ace-icon fa fa-check"></i>
                        修改
                    </button>
                </div>
            </div>
        </div>
    </form>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <script src="/static/dep/assets/js/x-editable/bootstrap-editable.js"></script>
    <script src="/static/dep/assets/js/x-editable/ace-editable.js"></script>
    <script src="/static/dep/assets/js/ace/elements.fileinput.js"></script>
    <script src="/static/dep/validator/jquery.validator.js"></script>
    <script src="/static/dep/validator/local/zh-CN.js"></script>
    <script src="/static/dep/md5.min.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">


    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveMenu('menu0');


        //更新头像
        jQuery(function ($) {
            
            $.fn.editable.defaults.mode = 'inline';
            $.fn.editableform.loading = "<div class='editableform-loading'><i class='ace-icon fa fa-spinner fa-spin fa-2x light-blue'></i></div>";
            $.fn.editableform.buttons = '<button type="submit" class="btn btn-info editable-submit"><i class="ace-icon fa fa-check"></i></button>\
                                         <button type="button" class="btn editable-cancel"><i class="ace-icon fa fa-times"></i></button>';


            try {//ie8 throws some harmless exceptions, so let's catch'em

                //first let's add a fake appendChild method for Image element for browsers that have a problem with this
                //because editable plugin calls appendChild, and it causes errors on IE
                try {
                    document.createElement('IMG').appendChild(document.createElement('B'));
                } catch (e) {
                    Image.prototype.appendChild = function (el) { }
                }

                //var last_gritter;
                var maxBytes = <%= maxImageByte %>;
                $('#avatar').editable({
                    type: 'image',
                    name: 'avatar',
                    value: null,
                    onblur: 'ignore',
                    image: {
                        //specify ace file input plugin's options here
                        btn_choose: '更新头像',
                        droppable: true,
                        maxSize: maxBytes,

                        //and a few extra ones here
                        name: 'file',//put the field name here as well, will be used inside the custom plugin
                        on_error: function (error_type) {//on_error function will be called when the selected file has a problem
                            //if (last_gritter) $.gritter.remove(last_gritter);
                            if (error_type == 1) {//file format error
                                showWarn('图片格式错误');
                            } else if (error_type == 2) {//file size rror
                                showWarn('图片大小不能超过 ' + (maxBytes / 1024 / 1024) + 'M');
                            }
                            else {//other error
                                showErr('未知错误');
                            }
                        },
                        on_success: function () {
                            //$.gritter.removeAll();
                        }
                    },
                    url: function (params) {
                        // ***UPDATE AVATAR HERE*** //
                        var submit_url = '';//please modify submit_url accordingly
                        var deferred = null;
                        var avatar = '#avatar';

                        //if value is empty (""), it means no valid files were selected
                        //but it may still be submitted by x-editable plugin
                        //because "" (empty string) is different from previous non-empty value whatever it was
                        //so we return just here to prevent problems
                        var value = $(avatar).next().find('input[type=hidden]:eq(0)').val();
                        if (!value || value.length == 0) {
                            deferred = new $.Deferred;
                            deferred.resolve();
                            return deferred.promise();
                        }

                        var $form = $(avatar).next().find('.editableform:eq(0)');
                        var file_input = $form.find('input[type=file]:eq(0)');
                        //var pk = $(avatar).attr('data-pk');//primary key to be sent to server

                        var ie_timeout = null;


                        if ("FormData" in window) {
                            var formData_object = new FormData();//create empty FormData object

                            //serialize our form (which excludes file inputs)
                            $.each($form.serializeArray(), function (i, item) {
                                //add them one by one to our FormData 
                                formData_object.append(item.name, item.value);
                            });
                            //and then add files
                            $form.find('input[type=file]').each(function () {
                                var field_name = $(this).attr('name');
                                var files = $(this).data('ace_input_files');
                                if (files && files.length > 0) {
                                    formData_object.append(field_name, files[0]);
                                }
                            });

                            //append primary key to our formData
                            //formData_object.append('pk', pk);

                            formData_object.append('action','3');
                            formData_object.append('type','admin');
                            formData_object.append('id','<%= Admin.UserId %>');

                            deferred = $.ajax({
                                url: submit_url,
                                type: 'POST',
                                processData: false,//important
                                contentType: false,//important
                                dataType: 'json',//server response type
                                data: formData_object
                            });
                        }
                        else {
                            deferred = new $.Deferred;

                            var temporary_iframe_id = 'temporary-iframe-' + (new Date()).getTime() + '-' + (parseInt(Math.random() * 1000));
                            var temp_iframe =
                                    $('<iframe id="' + temporary_iframe_id + '" name="' + temporary_iframe_id + '" \
                                    frameborder="0" width="0" height="0" src="about:blank"\
                                    style="position:absolute; z-index:-1; visibility: hidden;"></iframe>')
                                    .insertAfter($form);

                            $form.append('<input type="hidden" name="temporary-iframe-id" value="' + temporary_iframe_id + '" />');

                            //append primary key (pk) to our form
                            //$('<input type="hidden" name="pk" />').val(pk).appendTo($form);

                            //temp_iframe.data('deferrer', deferred);
                            //we save the deferred object to the iframe and in our server side response
                            //we use "temporary-iframe-id" to access iframe and its deferred object

                            $form.attr({
                                action: submit_url,
                                method: 'POST',
                                enctype: 'multipart/form-data',
                                target: temporary_iframe_id //important
                            });

                            $form.get(0).submit();

                            //if we don't receive any response after 30 seconds, declare it as failed!
                            ie_timeout = setTimeout(function () {
                                ie_timeout = null;
                                temp_iframe.attr('src', 'about:blank').remove();
                                deferred.reject({ 'code': 'Err', 'message': '服务器连接超时' });
                            }, 30000);
                        }


                        //deferred callbacks, triggered by both ajax and iframe solution
                        deferred
                        .done(function (result) {//success
                            //the `result` is formatted by your server side response and is arbitrary
                            if (result.code == 'OK') {
                                $(avatar).get(0).src = result.message;
                                $('#adminAvatar').attr('src',result.message);
                            }
                            else showErr(result.message);
                        })
                        .fail(function (result) {//failure
                            showErr(result.message);
                        })
                        .always(function () {//called on both success and failure
                            if (ie_timeout) clearTimeout(ie_timeout);
                            ie_timeout = null;
                        });

                        return deferred.promise();
                        // ***END OF UPDATE AVATAR HERE*** //
                    },

                    success: function (response, newValue) {
                    }
                })

                /**
                //let's display edit mode by default?
                $('#avatar').editable('show').on('hidden', function(e, reason) {
                    if(reason == 'onblur') {
                        $('#avatar').editable('show');
                        return;
                    }
                    $('#avatar').off('hidden');
                })
                */

            } catch (e) { }

        });


        //隐藏后重置，显示前重置，清空自填表
        $('#modal-form').on('hidden.bs.modal show.bs.modal', function (e) {
            $('#fuserId').val('');//reset hidden fields
            this.reset();
        });

        //修改密码
        $('#modal-form').validator({
            stopOnError: true,
            theme: 'yellow_top',
            fields: {
                'foldpwd': '原密码:required;password',
                'fnewpwd': '新密码:required;password'
            }
        }).on('valid.form', function (e, form) {

            $('#modal-form button').attr('disabled', 'disabled');

            var formData = {
                action: '4',
                id: $('#modal-form #fuserId').val(),
                oldpwd: md5($('#form-oldpwd').val()),
                newpwd: md5($('#form-newpwd').val())
            };

            $.post('', formData, function (jdata) {
                $('#modal-form button').removeAttr('disabled');

                switch (jdata.code) {
                    case "OK":
                        $("#modal-form").modal("hide");
                        showInfo(jdata.message);
                        break;
                    case "Err":
                        showErr(jdata.message);
                        break;
                }
            }, 'json');

        });



        //待模态框显示后传递ID值
        function PassId(id) {
            setTimeout(function () {
                $('#fuserId').val(id);
            }, 500);
        }


        var tdlist = [1, 2, 3, 4];
        //编辑按钮
        function DoEditInline() {
            //替换控件
            var trline = $('.profile-info-value');
            trline.find('span').each(function (idx, item) {
                if (tdlist.indexOf(idx) != -1) {
                    var value = $(this).text();
                    var input = $('<input type="text" maxlength="50" />');
                    input.val(value);
                    input.attr('hidval', value);
                    $(this).empty().append(input);
                }
            });
            $('#op-normal').hide();
            $('#op-edit').show();
        }

        //取消编辑
        function CancelEdit() {
            var trline = $('.profile-info-value');
            trline.find('span').each(function (idx, item) {
                if (tdlist.indexOf(idx) != -1) {
                    var value = $(this).find('input').attr('hidval');
                    $(this).empty().text(value);
                }
            });
            $('#op-normal').show();
            $('#op-edit').hide();
        }

        //保存
        function SaveEdit() {
            var trline = $('.profile-info-value');

            var formData = {
                action: '2',
                id: '<%= Admin.UserId %>'
            };

            trline.find('span').each(function (idx, item) {
                var value = $(this).find('input').val();
                switch (idx) {
                    case 1:
                        formData.name = value;
                        break;
                    case 2:
                        formData.email = value;
                        break;
                    case 3:
                        formData.phone = value;
                        break;
                    case 4:
                        formData.remark = value;
                        break;
                }
            });

            $.post('', formData, function (jdata) {
                switch (jdata.code) {
                    case "OK":
                        trline.find('span').each(function (idx, item) {
                            if (tdlist.indexOf(idx) != -1) {
                                var value = $(this).find('input').val();
                                $(this).empty().text(value);
                            }
                            if (tdlist.indexOf(idx) == 0) {
                                $('#displayName').empty().text($(this).text());console.log($(this).text())
                            }
                        });
                        $('#op-normal').show();
                        $('#op-edit').hide();
                        showInfo(jdata.message);
                        break;
                    case "Err":
                        showErr(jdata.message);
                        break;
                }
            }, 'json');

        }


    </script>


</asp:Content>

