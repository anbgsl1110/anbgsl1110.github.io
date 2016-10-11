<%@ Page Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="DocList.aspx.cs" Inherits="Weetop.Web.CMS.DocList" %>

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
            <form runat="server">
                <asp:HiddenField ID="hidCateId" runat="server" />

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <div class="clearfix">
                    <div class="pull-right tableTools-container">
                        <%--<a href="docedit.aspx?catid=<%= CategoryID %>" role="button" class="btn btn-sm btn-success" title="添加"><i class="ace-icon fa fa-plus-circle bigger-130"></i>添加</a>--%>
                    </div>
                </div>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_OnLoad">
                    <ContentTemplate>

                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>

                                <table id="mytable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>标题</th>
                                            <th>发布日期</th>
                                            <th>排序</th>
                                            <th></th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id="<%# Eval("Id") %>">
                                    <td><%# Eval("Title") %></td>
                                    <td><%# Convert.ToDateTime( Eval("CreateDate")).ToString("yyyy-MM-dd") %></td>
                                    <td><%# Eval("Sort") %></td>

                                    <td class="hidden-xs center action-buttons">
                                        <a class="green" href="docedit.aspx?catid=<%= CategoryID %>&conid=<%# Eval("Id") %>" title="编辑">
                                            <i class="ace-icon fa fa-pencil bigger-130"></i>
                                        </a>
                                        <%--<a class="red" href="javascript:ConfirmDel('<%# Eval("Id") %>');" title="删除">
                                            <i class="ace-icon fa fa-trash-o bigger-130"></i>
                                        </a>--%>
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

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveSubMenu('<%= MenuId %>');



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
                        $.post('', { action: 3, conid: id }, function (jdata) {
                            switch (jdata.code) {
                                case "OK":
                                    $('tr#' + id).remove();
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

