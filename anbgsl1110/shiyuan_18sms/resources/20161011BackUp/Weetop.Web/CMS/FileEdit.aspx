﻿<%@ Page Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="FileEdit.aspx.cs" Inherits="Weetop.Web.CMS.FileEdit" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                内容编辑
            </small>
        </h1>
    </div>
    <!-- /.page-header -->


    <div class="row">
        <div class="col-xs-12">


            <form class="form-horizontal" enctype="multipart/form-data" runat="server">
                <asp:HiddenField ID="hidId" runat="server" />
                <asp:HiddenField ID="hidCateId" runat="server" />

                <div class="form-group">
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtTitle.ClientID %>">标题</label>
                    <div class="col-sm-4">
                        <input id="txtTitle" required class="form-control" maxlength="100" type="text" placeholder="标题" runat="server" />
                    </div>
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtSort.ClientID %>">排序</label>
                    <div class="col-sm-2">
                        <input id="txtSort" class="form-control input-sm" max="5" type="text" placeholder="0" runat="server" />
                    </div>
                    <div class="col-sm-1"></div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label no-padding-right" for="inputFile1">文件</label>
                    <div class="col-sm-4">
                        <input type="file" required id="inputFile1" name="inputFile1" />
                    </div>
                    <div class="col-sm-4">
                        <asp:HyperLink ID="HyperLink1" runat="server"></asp:HyperLink>
                    </div>
                    <div class="col-sm-1"></div>
                </div>
                <%--<div class="form-group">
                    <label class="col-sm-1 control-label no-padding-right" for="inputImg">首图</label>
                    <div class="col-sm-10">
                        <input type="file" id="inputImg" name="inputImg" />
                    </div>
                    <div class="col-sm-1"></div>
                </div>--%>
                <%--<div class="form-group">
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtContent.ClientID %>">内容</label>
                    <div class="col-sm-10">
                        <CKEditor:CKEditorControl ID="txtContent" BasePath="/static/dep/ckeditor/" Width="100%" Height="320px" runat="server"></CKEditor:CKEditorControl>
                    </div>
                    <div class="col-sm-1"></div>
                </div>--%>
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
    <script src="/static/dep/assets/js/ace/elements.fileinput.js"></script>
    <script src="/static/dep/jquery.form.min.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveSubMenu('<%= MenuId %>');

        var maxFileByte = <%= maxFileByte %>;
        $('#inputFile1').ace_file_input({
            no_file:'未选择文件 ...',
            btn_choose:'选择',
            btn_change:'重新选择',
            droppable:true,
            maxSize: maxFileByte,
            denyExt: ['exe','msi','php','asp','aspx'],
            blacklist:'exe|msi|php|asp|aspx',
            onchange:null
        }).off('file.error.ace').on('file.error.ace', function (e, info) {
            //console.log(info.error_list);
            if(info.error_list.ext){
                showWarn('文件格式错误');
            }
            if(info.error_list.size){
                showWarn('文件大小不能超过 ' + (maxFileByte / 1024 / 1024) + 'M');
            }
        });

        $('form').on('submit', function (event) {
            event.preventDefault();

            if ($.trim($('#<%= txtTitle.ClientID %>').val()) == '') {
                showWarn('标题不能为空');
                return false;
            }


            $('#btnSubmit').attr('disabled', 'disabled');

            $(this).ajaxSubmit({
                url: '',
                type: 'post',
                dataType: 'json',
                success: function (jdata, statusText) {

                    $('#btnSubmit').removeAttr('disabled');

                    switch (jdata.code) {
                        case "OK":
                            showInfo(jdata.message);
                            if ($('#<%= hidId.ClientID %>').val() == 0) {
                                window.location = 'filelist.aspx';
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
    </script>

</asp:Content>
