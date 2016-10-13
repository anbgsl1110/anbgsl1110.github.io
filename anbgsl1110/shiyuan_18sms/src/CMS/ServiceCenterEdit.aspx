<%@ Page Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="ServiceCenterEdit.aspx.cs" Inherits="Weetop.Web.CMS.ServiceCenterEdit" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/static/dep/assets/css/bootstrap-editable.css" rel="stylesheet" />
    <link href="/static/dep/validator/jquery.validator.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">


    <style type="text/css">
        /* ckeditor file upload */
        .cke_dialog_ui_input_file {
            width: 100%;
            height: 30px;
        }
    </style>

    <div class="page-header">
        <h1><%: Page.Title %>
            <small>
                <i class="ace-icon fa fa-angle-double-right"></i>
                添加咨询服务人员
            </small>
        </h1>
    </div>
    <!-- /.page-header -->


    <div class="row">
        <div class="col-xs-12">
            <form class="form-horizontal" enctype="multipart/form-data" runat="server">
                <asp:HiddenField ID="hidId" runat="server" />
                <asp:HiddenField ID="hidCateId" runat="server" />
                <asp:HiddenField ID="HidImgUrl" runat="server" />
                <span style="color:RoyalBlue; margin-left: 35px">【注意】为保证上传成功，请上传不大于2M符合格式（.gif|.png|.jpg|.jpeg|.bmp）的图片！</span>
                <div class="space space-4"></div>
                <div class="form-group">
                    <div id="preview" class="col-xs-12 col-sm-3 center" style="margin-left: 40px">                        
                        <span class="profile-picture" style="max-width: 220px; margin-left: 0px">
                            <img class="img-responsive" alt="personImage" id="headImg" src="/static/dep/assets/avatars/avatar3.png">
                        </span>
                        <div class="space space-4"></div>
                    </div>
                    <div class="col-sm-1"></div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtName.ClientID %>">姓名</label>
                    <div class="col-sm-2">
                        <input id="txtName" required class="form-control" maxlength="100" type="text" placeholder="请填写姓名。。。" runat="server" width="140px" />
                    </div>
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtPhone.ClientID %>">手机号</label>
                    <div class="col-sm-2">
                        <input id="txtPhone" required class="form-control" maxlength="100" type="text" placeholder="请填写手机号。。。" runat="server" width="140px" />
                    </div>
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtWeChat.ClientID %>">微信</label>
                    <div class="col-sm-2">
                        <input id="txtWeChat" class="form-control" maxlength="100" type="text" placeholder="请填写微信。。。" runat="server" width="140px" />
                    </div>
                    <div class="col-sm-1"></div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtQQNumber.ClientID %>">QQ</label>
                    <div class="col-sm-2">
                        <input id="txtQQNumber" required class="form-control" maxlength="100" type="text" placeholder="请填写QQ。。。" runat="server" width="140px" />
                    </div>
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtEmail.ClientID %>">邮箱</label>
                    <div class="col-sm-2">
                        <input id="txtEmail" class="form-control" maxlength="100" type="text" placeholder="请填写邮箱。。。" runat="server" width="140px" />
                    </div>
                    <label class="col-sm-1 control-label no-padding-right">分类</label>
                    <div class="col-sm-2">
                        <select name="ctl00$ContentPlaceHolder2$ddlOrderStatus" onchange="javascript:setTimeout(&#39;__doPostBack(\&#39;ctl00$ContentPlaceHolder2$ddlOrderStatus\&#39;,\&#39;\&#39;)&#39;, 0)" id="ContentPlaceHolder2_ddlOrderStatus" class="form-control">
                            <option selected="selected" value="1">客服</option>
                            <option value="2">商务</option>
                            <option value="3">运维</option>
                        </select>
                    </div>
                    <div class="col-sm-1"></div>
                </div>

                <div class="form-group">
                    <div class="col-sm-1"></div>
                    <div class="col-sm-1">
                        <input id="btnSubmit" type="submit" value="保存" class="btn btn-primary" />
                    </div>
                    <div class="col-sm-10">
                        <%--<a href="<%= BackUrl %>" class="btn">返回</a>--%>
                    </div>
                </div>
            </form>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <script src="/static/dep/jquery.form.min.js"></script>
    <script src="/static/dep/assets/js/x-editable/bootstrap-editable.js"></script>
    <script src="/static/dep/assets/js/x-editable/ace-editable.js"></script>
    <script src="/static/dep/assets/js/ace/elements.fileinput.js"></script>
    <script src="/static/dep/validator/jquery.validator.js"></script>
    <script src="/static/dep/validator/local/zh-CN.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveSubMenu('<%= MenuId %>');

        //上传图片
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
                $('#headImg').editable({
                    type: 'image',
                    name: 'headImg',
                    value: null,
                    onblur: 'ignore',
                    image: {
                        //specify ace file input plugin's options here
                        btn_choose: '上传图片',
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
                        var headImg = '#headImg';

                        //if value is empty (""), it means no valid files were selected
                        //but it may still be submitted by x-editable plugin
                        //because "" (empty string) is different from previous non-empty value whatever it was
                        //so we return just here to prevent problems
                        var value = $(headImg).next().find('input[type=hidden]:eq(0)').val();
                        if (!value || value.length == 0) {
                            deferred = new $.Deferred;
                            deferred.resolve();
                            return deferred.promise();
                        }

                        var $form = $(headImg).next().find('.editableform:eq(0)');
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
                            deferred = $.ajax({
                                url: submit_url,
                                type: 'POST',
                                processData: false,//important
                                contentType: false,//important
                                dataType: 'json',//server response type
                                data: formData_object
                            });
                            //alert("图片上传成功");
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
                                $(headImg).get(0).src = "../"+result.message;
                                $(headImg).get(0).alt = "true";
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

            } catch (e) { }

        });


        $('form').on('submit', function (event) {
            event.preventDefault();

            if ($.trim($('#<%= txtName.ClientID %>').val()) == '') {
                showWarn('姓名不能为空');
                return false;
            }

            if ($.trim($('#<%= txtPhone.ClientID %>').val()) == '') {
                showWarn('手机号不能为空');
                return false;
            }

            var isImgUrl = false;  //判断是否有上传图片
            if ($(headImg).get(0).alt == "true")
            {
                isImgUrl = true;
            }

            var options = $("#ContentPlaceHolder2_ddlOrderStatus option:selected");  //获取选中的项
            //alert(options.val());   //拿到选中项的值
            var ServiceType = options.text();   //拿到选中项的文本

            $('#btnSubmit').attr('disabled', 'disabled');

            $(this).ajaxSubmit({
                url: '',
                type: 'post',
                dataType: 'json',
                data: { 'ServiceType': ServiceType,'isImgUrl': isImgUrl },
                success: function (jdata, statusText) {

                    $('#btnSubmit').removeAttr('disabled');

                    switch (jdata.code) {
                        case "OK":
                            $(headImg).get(0).alt = "personImage";
                            showInfo(jdata.message);
                            if ($('#<%= hidId.ClientID %>').val() == 0) {
                                window.location = 'ServiceCenterList.aspx?catid= menu75';
                            }
                            break;
                        case "Err":
                            showErr(jdata.message);
                            break;
                    }
                },
                error: function (jdata, statusText) {
                    $('#btnSubmit').removeAttr('disabled');
                    console.log('ERR:' + statusText);
                }
            });

        });

        //点击下拉选框
        $('form').on('change', '.col-sm-2 span', function (e) {

            var options = $("#ContentPlaceHolder2_ddlOrderStatus option:selected");  //获取选中的项
            //alert(options.val());   //拿到选中项的值
            var ServiceType = options.text();   //拿到选中项的文本

            $.post('', { action: 2, ServiceType: ServiceType }, function (jdata) {
                switch (jdata.code) {
                    case "OK":
                        showInfo(jdata.message);
                        break;
                    case "Err":
                        showErr(jdata.message);
                        break;
                }
            }, 'json');
        });

    </script>

</asp:Content>

