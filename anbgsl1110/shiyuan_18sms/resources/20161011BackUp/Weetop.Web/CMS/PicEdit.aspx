<%@ Page Title="图片管理" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="PicEdit.aspx.cs" Inherits="Weetop.Web.CMS.PicEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <div class="page-header">
        <h1><%: Page.Title %>
            <small>
                <i class="ace-icon fa fa-angle-double-right"></i>
                <%: PageSubTitle %>
            </small>
        </h1>
    </div>
    <!-- /.page-header -->

    <div class="row">
        <div class="col-xs-12">
            <form runat="server" class="form">
                <asp:HiddenField ID="hidType" runat="server" />

                <div class="clearfix">
                    <label for="link" class="">链接</label>
                    <div class="">
                        <input type="text" id="link" class="col-xs-12 col-sm-10 col-md-9" maxlength="250" placeholder="#" runat="server" />
                        <a href="javascript:;" id="saveLink" class="btn btn-sm btn-primary" style="height: 34px;" title="保存">保存</a>
                    </div>
                </div>

                <div class="space-8"></div>

                <span class="profile-picture" style="cursor: pointer;">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                        <ContentTemplate>
                            <img id="bannerImg" runat="server" class="img-responsive" style="max-width: 100%;" alt='图片' title='图片' src="/empty.png" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </span>
            </form>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <script src="/static/dep/assets/js/ace/elements.fileinput.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        var id = $('#<%= hidType.ClientID %>').val();
        switch(id){
            case '1':
                ActiveSubMenu('menu22');
                break;
            case '2':
                ActiveSubMenu('menu23');
                break;
        }


        $('#saveLink').on('click', function(){
            $.post('', {action:2, link:$('#<%= link.ClientID %>').val()}, function(jdata){
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


        var maxBytes = <%= maxImageByte %>;
        $('form.form').on('click', '#<%= bannerImg.ClientID %>', function () {
            var modalhtml =
                    '<div class="modal fade" data-backdrop="static">\
                      <div class="modal-dialog">\
                       <div class="modal-content">\
                        <div class="modal-header">\
                            <button type="button" class="close" data-dismiss="modal">&times;</button>\
                            <h4 class="blue">更换图片</h4>\
                        </div>\
                        \
                        <form class="no-margin">\
                         <div class="modal-body">\
                            <div class="space-4"></div>\
                            <div style="width:68%;margin-left:16%;"><input type="file" name="file-input" /></div>\
                         </div>\
                        \
                         <div class="modal-footer center">\
                            <button type="button" class="btn btn-sm" data-dismiss="modal"><i class="ace-icon fa fa-times"></i> 取消</button>\
                            <button type="submit" class="btn btn-sm btn-primary"><i class="ace-icon fa fa-check"></i> 确定</button>\
                         </div>\
                        </form>\
                      </div>\
                     </div>\
                    </div>';

            var modal = $(modalhtml);
            modal.modal('show').on('hidden', function () {
                modal.remove();
            });

            var submiting = false;

            var form = modal.find('form:eq(0)');
            var file = form.find('input[type=file]').eq(0);
            file.ace_file_input({
                style: 'well',
                thumbnail: 'fit',
                btn_choose: '拖动图片到这里或点击添加（gif,png,jpg,bmp）',
                btn_change: null,
                no_icon: "ace-icon fa fa-picture-o",
                droppable: true,
                maxSize: maxBytes,
                allowExt: ['gif', 'png', 'jpg', 'jpeg', 'bmp'],// TODO 改成配置读取
                allowMime: ['image/gif', 'image/png', 'image/jpg', 'image/jpeg', 'image/bmp'],
                before_remove: function () {
                    //don't remove/reset files while being uploaded
                    return !submiting;
                }
            }).off('file.error.ace').on('file.error.ace', function (e, info) {
                if (info.error_list.ext) {
                    showWarn('图片格式错误');
                }
                if (info.error_list.size) {
                    showWarn('图片大小不能超过 ' + (maxBytes / 1024 / 1024) + 'M');
                }
            });

            form.on('submit', function(e){

                //if ($('input[type=file]')[0].files.length === 0) return false;
                if(!file.data('ace_input_files')) return false;

                file.ace_file_input('disable');
                form.find('button').attr('disabled', 'disabled');
                form.find('.modal-body').append("<div class='center'><i class='ace-icon fa fa-spinner fa-spin bigger-150 orange'></i></div>");

                var formData = new FormData();
                formData.append('action', 1);
                //formData.append('file', $('input[type=file]')[0].files[0]);
                formData.append('file', file.data('ace_input_files')[0]);

                submiting = true;
                $.ajax({
                    url: '',
                    type: 'POST',
                    data: formData,
                    async: false,
                    success: function (jdata) {
                        file.ace_file_input('enable');
                        form.find('button').removeAttr('disabled');
                        form.find('.modal-body > :last-child').remove();

                        switch (jdata.code) {
                            case "OK":
                                __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                                modal.modal("hide");
                                showInfo(jdata.message);
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

                e.preventDefault();
            });
        });
    </script>

</asp:Content>

