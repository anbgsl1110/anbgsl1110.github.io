<%@ Page Title="会员认证信息" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="AuthDetail.aspx.cs" Inherits="Weetop.Web.CMS.AuthDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="/static/dep/assets/css/chosen.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">


    <style type="text/css">
        /* =input-sm */
        .chosen-container > .chosen-single, [class*="chosen-container"] > .chosen-single {
            line-height: 28px;
            height: 30px;
        }

        .table > tbody > tr > td {
            padding: 8px 25px;
        }
    </style>


    <div class="page-header">
        <h1><%: Page.Title %>
            <small>
                <i class="ace-icon fa fa-angle-double-right"></i>
                详细内容
            </small>
        </h1>
    </div>
    <!-- /.page-header -->

    <div class="row">
        <div class="col-xs-1"></div>
        <div class="col-xs-10">

            <form runat="server">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th class="center" colspan="2">会员认证信息</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="align-right" width="30%">开发者账户</td>
                            <td width="70%">
                                <asp:Literal ID="litAccEmail" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-right">申请认证类型</td>
                            <td>
                                <asp:Literal ID="litAuthType" runat="server"></asp:Literal>
                            </td>
                        </tr>

                        <asp:Panel ID="Panel1" runat="server">
                            <tr>
                                <td class="align-right">公司名称</td>
                                <td>
                                    <asp:Literal ID="litCName" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">公司注册地址</td>
                                <td>
                                    <asp:Literal ID="litCAddr" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">证件类型</td>
                                <td>
                                    <asp:Literal ID="litAuCType" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <asp:Panel ID="Panel4" runat="server">
                            <tr>
                                <td class="align-right">三证合一证件</td>
                                <td>
                                    <asp:HyperLink ID="lnkCFileQ" runat="server">
                                        <asp:Image ID="ImgCFileQ" runat="server" />
                                    </asp:HyperLink>
                                </td>
                            </tr>
                           </asp:Panel>
                            <asp:Panel ID="Panel3" runat="server">
                            <tr>
                                <td class="align-right">组织机构证件</td>
                                <td>
                                    <asp:HyperLink ID="lnkCFileZ" runat="server">
                                        <asp:Image ID="ImgCFileZ" runat="server" />
                                    </asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">税务登记证件</td>
                                <td>
                                    <asp:HyperLink ID="lnkCFileS" runat="server">
                                        <asp:Image ID="ImgCFileS" runat="server" />
                                    </asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">营业执照证件</td>
                                <td>
                                    <asp:HyperLink ID="lnkCFileY" runat="server">
                                        <asp:Image ID="ImgCFileY" runat="server" />
                                    </asp:HyperLink>
                                </td>
                            </tr>
                            </asp:Panel>
                            <tr>
                                <td class="align-right">法定代表人</td>
                                <td>
                                    <asp:Literal ID="litCLegalPeo" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">公司电话</td>
                                <td>
                                    <asp:Literal ID="litCPhone" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">申请人真实姓名</td>
                                <td>
                                    <asp:Literal ID="litCPeoName" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">申请人证件照片</td>
                                <td>
                                    <asp:HyperLink ID="lnkPeoPic" runat="server">
                                        <asp:Image ID="ImgPeoPic" runat="server" />
                                    </asp:HyperLink>
                                </td>
                            </tr>
                        </asp:Panel>

                        <asp:Panel ID="Panel2" runat="server">
                            <tr>
                                <td class="align-right">真实姓名</td>
                                <td>
                                    <asp:Literal ID="litPName" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">证件类型</td>
                                <td>
                                    <asp:Literal ID="litPType" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">证件号码</td>
                                <td>
                                    <asp:Literal ID="litPFileNum" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">组织机构证件</td>
                                <td>
                                    <asp:HyperLink ID="lnkPFile" runat="server">
                                        <asp:Image ID="ImgPFile" runat="server" />
                                    </asp:HyperLink>
                                </td>
                            </tr>
                        </asp:Panel>

                        <tr>
                            <td class="align-right">认证状态</td>
                            <td>
                                <asp:DropDownList ID="ddlCheckStatus" runat="server"></asp:DropDownList>
                                <% if (validState == (int)AuthValidState.已认证)
                                    { %>
                                <asp:Literal ID="litValidState" runat="server"></asp:Literal>
                                <% } %>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-right">标注<br />
                                (可用来反馈认证失败信息)</td>
                            <td>
                                <asp:TextBox ID="txtFeedback" Width="60%" MaxLength="250" placeholder="250字" runat="server" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:HiddenField ID="hidAuId" runat="server" />
                                <a href="javascript:;" id="btnFeedback" class="btn btn-sm btn-primary">保存</a>
                                <a href="UserList.aspx?page=<%= Request["page"] ?? "1" %>" id="btnReturn" class="btn btn-sm btn-default">返回</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>

        </div>
        <div class="col-xs-1"></div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script src="/static/dep/assets/js/chosen.jquery.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="server">

    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveMenu('menu3');

        //下拉控件
        $('[id$=ddlCheckStatus]').chosen({
            width: '110px',
            placeholder_text_single: "认证状态",
            disable_search_threshold: 10,//小于此值不显示搜索
            allow_single_deselect: true//可清除选择
        });

        $('#btnFeedback').on('click', function () {
            $.post('', { action: 1, auid: $('[id$=hidAuId]').val(), uid: '<%= Request["uid"] %>', sel: $('[id$=ddlCheckStatus]').val(), vl: $('[id$=txtFeedback]').val() },
                function (jdata) {
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
