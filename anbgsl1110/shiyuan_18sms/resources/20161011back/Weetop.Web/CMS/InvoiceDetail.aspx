<%@ Page Title="发票详细信息" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="InvoiceDetail.aspx.cs" Inherits="Weetop.Web.CMS.InvoiceDetail" %>

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
                            <th class="center" colspan="2">发票详细信息</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="align-right" width="30%">开票类型</td>
                            <td width="70%">
                                <asp:Literal ID="litInvoType" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-right">开票金额</td>
                            <td>
                                <asp:Literal ID="litFMoney" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-right">发票抬头</td>
                            <td>
                                <asp:Literal ID="litFTitle" runat="server"></asp:Literal>
                            </td>
                        </tr>

                        <asp:Panel ID="Panel2" runat="server">
                            <tr>
                                <td class="align-right">营业执照/税务登记证扫描件</td>
                                <td>
                                    <asp:HyperLink ID="lnkFileTax2" runat="server">
                                        <asp:Image ID="ImgFileTax2" runat="server" />
                                    </asp:HyperLink>
                                </td>
                            </tr>
                        </asp:Panel>

                        <asp:Panel ID="Panel3" runat="server">
                            <tr>
                                <td class="align-right">统一社会信用代码/税务登记号</td>
                                <td>
                                    <asp:Literal ID="litFTaxCode" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">开户银行</td>
                                <td>
                                    <asp:Literal ID="litFBank" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">开户银行帐号</td>
                                <td>
                                    <asp:Literal ID="litFBankCode" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">营业电话</td>
                                <td>
                                    <asp:Literal ID="litFBusPhone" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">营业执照地址</td>
                                <td>
                                    <asp:Literal ID="litFBusAddr" runat="server"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">营业执照/税务登记证扫描件</td>
                                <td>
                                    <asp:HyperLink ID="lnkFileTax3" runat="server">
                                        <asp:Image ID="ImgFileTax3" runat="server" />
                                    </asp:HyperLink>
                                </td>
                            </tr>
                            <tr>
                                <td class="align-right">一般纳税人资格认证扫描件</td>
                                <td>
                                    <asp:HyperLink ID="lnkFileNormal" runat="server">
                                        <asp:Image ID="ImgFileNormal" runat="server" />
                                    </asp:HyperLink>
                                </td>
                            </tr>
                        </asp:Panel>

                        <tr>
                            <td class="align-right">发票寄往地址</td>
                            <td>
                                <asp:Literal ID="litFAddr" runat="server"></asp:Literal>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-right">其他文件</td>
                            <td>
                                <asp:HyperLink ID="lnkFileOther" runat="server">
                                    <asp:Image ID="ImgFileOther" runat="server" />
                                </asp:HyperLink>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-right">备注</td>
                            <td>
                                <asp:Literal ID="litFRemark" runat="server"></asp:Literal>
                            </td>
                        </tr>

                        <tr>
                            <td class="align-right">状态</td>
                            <td>
                                <asp:DropDownList ID="ddlCheckStatus" runat="server"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="align-right">标注</td>
                            <td>
                                <asp:TextBox ID="txtFeedback" Width="60%" MaxLength="250" placeholder="250字" runat="server" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:HiddenField ID="hidApp4Id" runat="server" />
                                <a href="javascript:;" id="btnFeedback" class="btn btn-sm btn-primary">保存</a>
                                <a href="InvoiceList.aspx?page=<%= Request["page"] ?? "1" %>" id="btnReturn" class="btn btn-sm btn-default">返回</a>
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
        ActiveSubMenu('menu22');

        //下拉控件
        $('[id$=ddlCheckStatus]').chosen({
            width: '110px',
            //placeholder_text_single: "状态",
            disable_search_threshold: 10,//小于此值不显示搜索
            allow_single_deselect: true//可清除选择
        });

        $('#btnFeedback').on('click', function () {
            $.post('', { action: 1, oid: $('[id$=hidApp4Id]').val(), sel: $('[id$=ddlCheckStatus]').val(), vl: $('[id$=txtFeedback]').val() },
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
