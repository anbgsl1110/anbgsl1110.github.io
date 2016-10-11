<%@ Page Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" ValidateRequest="false" CodeBehind="NewsEdit.aspx.cs" Inherits="Weetop.Web.CMS.NewsEdit" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/static/dep/assets/css/bootstrap-datepicker3.css" rel="stylesheet" />
    <link href="/static/dep/assets/css/bootstrap-datetimepicker.css" rel="stylesheet" />
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
                    <div class="col-sm-5">
                        <input id="txtTitle" required class="form-control" maxlength="100" type="text" placeholder="标题" runat="server" />
                    </div>
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtDate.ClientID %>">发布日期</label>
                    <div class="col-sm-2">
                        <input id="txtDate" required class="form-control input-sm" maxlength="20" type="text" placeholder="发布日期" runat="server" />
                    </div>
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtSort.ClientID %>">排序</label>
                    <div class="col-sm-1">
                        <input id="txtSort" class="form-control input-sm" maxlength="5" type="text" placeholder="0" runat="server" />
                    </div>
                    <div class="col-sm-1"></div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtSrc.ClientID %>">消息来源</label>
                    <div class="col-sm-2">
                        <input id="txtSrc" required class="form-control" maxlength="10" type="text" placeholder="消息来源" runat="server" />
                    </div>
                    <%--<label class="col-sm-1 control-label no-padding-right" for="<%= txtSrcVal.ClientID %>">消息链接</label>
                    <div class="col-sm-7">
                        <input id="txtSrcVal" class="form-control" maxlength="200" type="text" placeholder="消息链接" runat="server" />
                    </div>--%>
                    <div class="col-sm-1"></div>
                </div>
                <%--<div class="form-group">
                    <label class="col-sm-1 control-label no-padding-right" for="inputImg">首图</label>
                    <div class="col-sm-10">
                        <input type="file" id="inputImg" name="inputImg" />
                    </div>
                    <div class="col-sm-1"></div>
                </div>--%>
                <div class="form-group">
                    <label class="col-sm-1 control-label no-padding-right" for="<%= txtContent.ClientID %>">内容</label>
                    <div class="col-sm-10">
                        <CKEditor:CKEditorControl ID="txtContent" BasePath="/static/dep/ckeditor/" Width="100%" Height="320px" runat="server"></CKEditor:CKEditorControl>
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
    <%--<script src="/static/dep/assets/js/ace/elements.fileinput.js"></script>--%>
    <script src="/static/dep/assets/js/date-time/moment.js"></script>
    <script src="/static/dep/assets/js/date-time/locale/zh-cn.js"></script>
    <script src="/static/dep/assets/js/date-time/bootstrap-datetimepicker.js"></script>
    <script src="/static/dep/jquery.form.min.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveSubMenu('<%= MenuId %>');


        $('#<%= txtDate.ClientID %>').datetimepicker({
            locale: 'zh-cn',
            format: 'YYYY-MM-DD'
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
                                window.location = 'newslist.aspx?catid=' + $('#<%= hidCateId.ClientID %>').val();
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

