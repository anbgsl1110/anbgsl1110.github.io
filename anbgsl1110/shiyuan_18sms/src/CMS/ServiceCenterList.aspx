<%@ Page Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="ServiceCenterList.aspx.cs" Inherits="Weetop.Web.CMS.ServiceCenterList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/static/dep/assets/css/chosen.css" rel="stylesheet" />
    <link href="/static/dep/assets/css/bootstrap-editable.css" rel="stylesheet" />
    <link href="/static/dep/validator/jquery.validator.css" rel="stylesheet" />
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
            <form runat="server" autocomplete="off">

                <div class="clearfix">
                    <div class="pull-left tableTools-container">
                        <span style="float: left; margin-right: 10px;">
                            <asp:DropDownList ID="ddlOrderStatus" AutoPostBack="true" CssClass="form-control" runat="server" OnTextChanged="UpdatePanel1_Load"></asp:DropDownList>
                        </span>
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input id="txtSearch" type="text" autocomplete="off" maxlength="150" style="width: 300px;" class="form-control" runat="server" placeholder="输入搜索：姓名、电话、微信" />
                            <asp:LinkButton ID="btnSearch" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>      
                    </div>
                    <div class="clearfix">
                            <div class="pull-right tableTools-container">
                              <a href="ServiceCenterEdit.aspx?catid=<%= CategoryID %>" role="button" class="btn btn-sm btn-success" title="添加"><i class="ace-icon fa fa-plus-circle bigger-130"></i>添加</a>
                            </div>
                        </div>
                </div>

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlOrderStatus" />
                        <asp:AsyncPostBackTrigger ControlID="txtSearch" />
                        <asp:AsyncPostBackTrigger ControlID="btnSearch" />
                    </Triggers>
                    <ContentTemplate>

                        <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_OnItemDataBound">
                            <HeaderTemplate>
                                <table id="mytable" class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th style="display:none;">ID</th>
                                            <th>名字</th>
                                            <th>手机号</th>
                                            <th>微信</th>
                                            <th>QQ</th>
                                            <th>邮箱</th>
                                            <th>分类</th>
                                            <th class="hidden-480 hidden-xs"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>

                                        <tr id="<%# Eval("Id") %>">
                                            <td style="display:none;" data-name="Id"><%# Eval("Id") %></td>       
                                            <td class="edit" data-name="Name"><%# Eval("Name") %></td>
                                            <td class="edit" data-name="Phone"><%# Eval("Phone") %></td>
                                            <td class="edit" data-name="WeChat"><%# Eval("WeChat") %></td>
                                            <td class="edit" data-name="QQNumber"><%# Eval("QQNumber") %></td>
                                            <td class="edit" data-name="mailBox"><%# Eval("mailBox") %></td>                             
                                            <td>
                                                <div class="inline position-relative">
                                                    <a href="javascript:" rolecode="<%# Eval("cateid")  %>" class="dropdown-toggle" <%# !true ? "" : "data-toggle='dropdown'" %>>
                                                        <span class="role-label label label-primary arrowed arrowed-in-right"><%# Eval("CategroyName") %></span>
                                                    </a>
                                                    <ul class="align-left dropdown-menu dropdown-caret dropdown-lighter">
                                                      <%foreach (var item in list)
                                                      {
                                                          if (item.PrivilegeCode == "XG")
                                                          {%>
                                                              <li class="dropdown-header">更改分类</li>
                                                                <asp:Repeater ID="Repeater2" runat="server">
                                                                    <ItemTemplate>
                                                                        <li>
                                                                            <a href="javascript:" rolecode="<%# Eval("Key") %>">
                                                                                <i class="ace-icon fa fa-hand-o-right grey"></i>
                                                                                <span class="label label-primary arrowed arrowed-in-right"><%# Eval("Value") %></span>
                                                                            </a>
                                                                        </li>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                          <%}
                                                      } %>                                              
                                                    </ul>
                                                </div>
                                            </td>

                                            <td class="action-buttons hidden-480 hidden-xs center">
                                                <%foreach (var item in list)
                                                  {
                                                      if (item.PrivilegeCode == "XG")
                                                      {%>
                                                            <%--<div class="hidden-xs action-buttons">--%>
                                                            <span id="op-normal">
                                                                <a class="green" href="javascript:DoEditInline('<%# Eval("Id") %>');" title="修改">
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
                                                            <span>
                                                            <a class="red" href="javascript:modifyImg('<%# Eval("Id") %>');" title="修改图片" >
                                                                 <i class="ace-icon fa fa-picture-o bigger-130"></i>
                                                            </a>
                                                            </span>   
                                                            <%--</div>--%>
                                                      <%}
                                                        if (item.PrivilegeCode == "SC")
                                                      {%>
                                                            <%--<span>--%>
                                                            <a class="delete" href="javascript:ConfirmDel('<%# Eval("Id") %>');" title="删除">
                                                                 <i class="ace-icon fa fa-trash-o bigger-130"></i>
                                                            </a>
                                                            <%--</span>--%>
                                                            
                                                      <%}                                                                                              
                                                  } %>
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

        </div>
    </div>

    <form id="modal-form" class="modal fade" tabindex="-1" data-backdrop="static" autocomplete="on">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id ="modal-form-title" class="blue bigger">服务人员(<a id ="modal-form-title-name" style ="color:red;">###</a>)图片修改</h4>
                    <span style="color:#abbac3">【注意】为保证上传成功，请上传不大于2M符合格式（.gif|.png|.jpg|.jpeg|.bmp）的图片！</span>
                </div>

                <input type="hidden" id="hidRoleId" name="hidRoleId" />
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12">
                                <div class="form-group">
                                    <div id="preview" class="col-xs-12 col-sm-3 center" style="margin-left: 40px">
                                        <span class="profile-picture" style="max-width: 220px; margin-left: 0px">
                                            <img class="img-responsive" alt="personImage" id="headImg" src="/static/dep/assets/avatars/avatar3.png">
                                        </span>
                                        <div class="space space-4"></div>
                                    </div>
                                    <div class="col-sm-1"></div>
                                </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-sm" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>

                    <button class="btn btn-sm btn-primary">
                        <i class="ace-icon fa fa-check"></i>
                        确定
                    </button>
                </div>
            </div>
        </div>
    </form>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script src="/static/dep/assets/js/chosen.jquery.js"></script>
    <script src="/static/dep/jsrender.min.js"></script>
    <script src="/static/dep/assets/js/x-editable/bootstrap-editable.js"></script>
    <script src="/static/dep/assets/js/x-editable/ace-editable.js"></script>
    <script src="/static/dep/assets/js/ace/elements.fileinput.js"></script>
    <script src="/static/dep/validator/jquery.validator.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">


    <script type="text/javascript">

        SetSecondCrumb('<%: Page.Title %>');
        <%-- 设置菜单档激活位置 --%>
        ActiveMenu('menu75');

        //下拉控件
        $('[id$=ddlOrderStatus]').chosen({
            width: '110px',
            placeholder_text_single: "查看全部",
            disable_search_threshold: 10,//小于此值不显示搜索
            allow_single_deselect: true//可清除选择
        });

        //textbox无法回车回发
        $('form').on('keydown', '#<%= txtSearch.ClientID %>', function (e) {
            var key = e.which || e.keyCode || 0;
            if (key && key == 13) {
                document.getElementById('<%= btnSearch.ClientID %>').click();
            };
        });

        //切换状态
        $('form').on('click', '.dropdown-menu a', function (e) {
            var me = this;
            var id = $(me).parents('tr').attr('id');
            var rolecode = $(me).attr('rolecode');
            var oldrolecode = $(me).parents('ul').prev('a').attr('rolecode');
            if (rolecode === oldrolecode) {
                //showInfo('无需切换');
            } else {
                $.post('', { action: 4, id: id, rolecode: rolecode }, function (jdata) {
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
        });


        var tdlist = [1, 2, 3, 4, 5];
        //编辑按钮
        function DoEditInline(id) {
            //替换控件
            var trline = $('#' + id);
            trline.find('td').each(function (idx, item) {
                if (tdlist.indexOf(idx) != -1) {
                    var value = $(this).text();
                    var input = $('<input type="text" maxlength="16" />');
                    input.val(value);
                    input.attr('hidval', value);
                    $(this).empty().append(input);
                }
            });
            trline.find('#op-normal').hide();
            trline.find('.red').hide();
            $('.delete').hide();
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
            trline.find('.red').show();
            $('.delete').show();
            trline.find('#op-edit').hide();
        }

        //保存
        function SaveEdit(id) {
            var trline = $('#' + id);
            var data = {};
            var i = 0;
            data[0] = id;
            trline.find('td').each(function (idx, item) {
                var value = $(this).find('input').val();
                if (value != undefined) {
                    data[i] = value;
                }
                i = i + 1;
            });

            data[6] = "1";

            $.getJSON('', { "action": "7", "Id": data[0], "Name": data[1], "Phone": data[2], "WeChat": data[3], "QQNumber": data[4], "mailBox": data[5], "cateid": data[6] }, function (jdata, textStatus, jqXHR) {
                if ('success' == textStatus) {
                    switch (jdata.code) {
                        case "OK":
                            trline.find('td').each(function (idx, item) {
                                if (tdlist.indexOf(idx) != -1) {
                                    var value = $(this).find('input').val();
                                    $(this).empty().text(value);
                                }
                            });
                            trline.find('#op-normal').show();
                            trline.find('.red').show();
                            $('.delete').show();
                            trline.find('#op-edit').hide();
                            showInfo(jdata.message);
                            break;
                        case "Err":
                            showErr(jdata.message);
                            break;
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

        //修改服务人员图片
        function modifyImg(id) {
            setTimeout(function () {
                $('#hidRoleId').val(id);//设置id便于post到服务器
            }, 500);

            $.getJSON('', { action: 5, id: id }, function (jdata, textStatus, jqXHR) {
                if ('success' == textStatus) {
                    switch (jdata.code) {
                        case "OK":
                            $('#modal-form #headImg').get(0).src = "../"+jdata.data.content;
                            $("#modal-form-title-name").html("<b>"+jdata.data.name+"</b>");
                            $("#modal-form").modal("show");
                            break;
                        case "Err":
                            showErr(jdata.message);
                            break;
                    }
                }
            });

        }

        jQuery(function ($) {
            //隐藏后重置，显示前重置，清空自填表
            $('#modal-form').on('hidden.bs.modal show.bs.modal', function (e) {
                this.reset();
            });

            $('#modal-form').on('submit', function (e) {
                e.preventDefault();

                $('#modal-form button').attr('disabled', 'disabled');
                var isImgUrl = false;  //判断是否有上传图片
                if ($(headImg).get(0).alt == "true")
                {
                    isImgUrl = true;
                }

                $.post('', 'action=6&' + $(this).serialize()+'&isImgUrl='+isImgUrl, function (jdata) {
                    $('#modal-form button').removeAttr('disabled');

                    switch (jdata.code) {
                        case "OK":
                            __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                            $(headImg).get(0).alt = "personImage";
                            showInfo(jdata.message);
                            $("#modal-form").modal("hide");
                            break;
                        case "Err":
                            showErr(jdata.message);
                            break;
                    }
                }, 'json');

            });
        });

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

                            formData_object.append('action','2');

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

    </script>
</asp:Content>

