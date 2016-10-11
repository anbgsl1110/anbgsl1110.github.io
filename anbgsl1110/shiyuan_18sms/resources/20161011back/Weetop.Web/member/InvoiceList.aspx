<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="InvoiceList.aspx.cs" Inherits="Weetop.Web.member.InvoiceList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">



    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />财务管理 &gt; 发票申请信息</div>

        <div class="fwgl_dxmb">
            <div class="fwgl_dxmb_lb">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tbody>
                        <tr>
                            <th width="10%" scope="col">发票金额</th>
                            <th width="15%" scope="col">申请时间</th>
                            <th width="25%" scope="col">发票抬头</th>
                            <th width="15%" scope="col">发票类型</th>
                            <th width="10%" scope="col">收取方式</th>
                            <th width="10%" scope="col">状态</th>
                            <th width="10%" scope="col">消息</th>
                            <th width="10%" scope="col">操作</th>
                        </tr>

                    </tbody>
                </table>
            </div>

            <div class="page"></div>

        </div>

    </div>



    <script id="listTmpl" type="text/x-jsrender">
        <tr>
            <td>{{: money }}</td>
            <td>{{: date }}</td>
            <td>{{: title }}</td>
            <td>{{: invoTypeTxt }}</td>
            <td>{{: receiveTxt }}</td>
            <td>{{: statusTxt }}</td>
            <td>{{: feedback }}</td>
            <td>{{: ~getLink(status,id) }}</td>
        </tr>

    </script>


    <script type="text/javascript">

        var UserHelper = {
            getLink: function (status, orderId) {
                return (status && status === 1)
                    ? '<a href="javascript:;" data-oid="' + orderId + '" class="doNow">作废</a>'
                    : '';
            }
        };

        function loadData(data) {
            var head = '<tr>\
                            <th width="10%" scope="col">发票金额</th>\
                            <th width="15%" scope="col">申请时间</th>\
                            <th width="25%" scope="col">发票抬头</th>\
                            <th width="15%" scope="col">发票类型</th>\
                            <th width="10%" scope="col">收取方式</th>\
                            <th width="10%" scope="col">状态</th>\
                            <th width="10%" scope="col">消息</th>\
                            <th width="10%" scope="col">操作</th>\
                        </tr>';

            var tmpl = $.templates("#listTmpl");
            var html = head + tmpl.render(data, UserHelper);
            $('.fwgl_dxmb_lb tbody').html(html);
        }

        $('.fwgl_dxmb_lb').on('click', '.doNow', function () {
            var me = this;
            var oid = $(me).data('oid');
            $.post('InvoiceList', { op: 2, oid: oid }, function (jdata) {
                switch (jdata.code) {
                    case 'OK':
                        Lay.showMsg(jdata.message);
                        $(me).parent().prev().html("已作废");
                        $(me).remove();
                        break;
                    default:
                        Lay.showErr(jdata.message);
                        break;
                }
            });
        });


        function InitDataList() {
            $.getJSON('InvoiceList',
                { op: 1 },
                function (jdata, state, xhr) {
                    if (state == 'success') {
                        switch (jdata.code) {
                            case 'OK':
                                //加载数据
                                loadData(jdata.data.list);
                                break;
                            default:
                                Lay.showErr(jdata.message);
                                break;
                        }

                        //初始化分页
                        $('.page')
                            .bootpag({
                                total: jdata.data.pages, //总页数
                                page: 1, //当前页数
                                maxVisible: 5,
                                leaps: false,
                                prev: '上一页',
                                next: '下一页',
                                firstLastUse: true,
                                first: '首页',
                                last: '尾页',
                                activeClass: 'current'
                            })
                            .off('page')
                            .on('page',
                                function (event, num) {
                                    $.getJSON('InvoiceList',
                                        { op: 1, page: num },
                                        function (jdata, state, xhr) {
                                            if (state == 'success') {
                                                switch (jdata.code) {
                                                    case 'OK':
                                                        //加载数据
                                                        loadData(jdata.data.list);
                                                        reHeight();//重新计算左导航高度
                                                        break;
                                                    default:
                                                        Lay.showErr(jdata.message);
                                                        break;
                                                }
                                            } else {
                                                Lay.showErr("数据加载失败");
                                            }
                                        });
                                });

                        reHeight();//重新计算左导航高度
                    } else {
                        Lay.showErr("数据加载失败");
                    }
                });
        }

        InitDataList();
    </script>



</asp:Content>
