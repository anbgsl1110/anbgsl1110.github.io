<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="Weetop.Web.member.Account" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">




    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />用户中心 &gt; 账户管理</div>

        <div class="zhgl_sum clearfix">
            <div class="zhgl_sum1 fl">
                <p class="nav"><span class="title">账户余额（元）</span><a href="RechargeList">充值记录</a></p>
                <p class="money"><%: string.Format("{0:F}",totalAvaiMoney) %></p>
                <p class="nav">本月已消费<b><%: string.Format("{0:F}",totalMonthMoney) %></b>元<a href="Recharge" class="cz">充值</a></p>
            </div>
            <div class="zhgl_sum2 fl">
                <p class="nav">
                    <span class="title">代金券余额（元）</span>
                    <% if (validState != (int)AuthValidState.已认证)
                        { %>
                    <a href="Auth">认证送代金券</a>
                    <% } %>
                    <%--<img src="../images/hy_right_djj_tu.png" alt="" title="消费金额优先从代金券余额代扣代金券管理功能敬请期待" /><a href="hy_cwgl2">详情</a>--%>
                </p>
                <p class="money">0.00</p>
                <% if (validState == (int)AuthValidState.已认证)
                    { %>
                <p class="nav">未激活：<b>短信验证码/通知</b>充值满<b>1000</b>元可使用</p>
                <% } %>
            </div>
            <div class="zhgl_sum3 fr">
                <p class="nav" id="alertStatus">账户状态：<b><%= alertStatus %></b></p>
                <p class="nav" id="alertMoney"><span class="title">余额预警：</span><img src="../images/hy_right_djj_tu.png" alt="" title="余额首次低于预警值时，您将会收到系统的短信提醒。" /><i><%= alertMoney %></i>元 <a href="javascript:void(0)" class="run" id="demoBtn2">修改</a></p>
                <div id="hy_yhzx_demo">
                    <div class="login_grzl">
                        <form id="warnform">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tbody>
                                    <tr>
                                        <td colspan="2">余额首次低于预警值时，您将会收到系统的短信提醒。</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><span>*</span>预警值：</td>
                                        <td>
                                            <select class="xiala yealert">
                                                <option value="200">200</option>
                                                <option value="500">500</option>
                                                <option value="1000">1000</option>
                                                <option value="2000">2000</option>
                                                <option value="5000">5000</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"></td>
                                        <td>
                                            <input type="button" class="anniu" value="确认修改"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <form runat="server">
            <div class="zhgl_zdcx">
                <span class="title">账单查询</span>
                <span>
                    <asp:DropDownList ID="ddlYear" CssClass="chaxun" runat="server" ClientIDMode="Static">
                        <asp:ListItem Text="选择年份" Value="0"></asp:ListItem>
                    </asp:DropDownList></span>
                <span>
                    <asp:DropDownList ID="ddlMonth" CssClass="chaxun" runat="server" ClientIDMode="Static">
                        <asp:ListItem Text="选择月份" Value="0"></asp:ListItem>
                    </asp:DropDownList></span>
                <%--<span><a href="#">账单下载</a></span>--%>
            </div>
        </form>


        <div class="zhgl_tablebg">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                    <tr>
                        <th scope="col" width="25%">计费项目</th>
                        <th scope="col" width="25%">使用量</th>
                        <th scope="col" width="25%">金额（元）</th>
                        <th scope="col" width="25%">操作</th>
                    </tr>
                    <% if (Pro1Opened)
                        { %>
                    <tr>
                        <td>短信验证码/通知</td>
                        <td><%= monthCount1 %></td>
                        <td><%: string.Format("{0:F}",monthMoney1) %></td>
                        <td>&nbsp;</td>
                    </tr>
                    <% } %>
                    <% if (Pro3Opened)
                        { %>
                    <tr>
                        <td>国际短信验证码</td>
                        <td><%= monthCount3 %></td>
                        <td><%: string.Format("{0:F}",monthMoney3) %></td>
                        <td>&nbsp;</td>
                    </tr>
                    <% } %>
                    <% if (Pro4Opened)
                        { %>
                    <tr>
                        <td>语音验证码</td>
                        <td><%= monthCount4 %></td>
                        <td><%: string.Format("{0:F}",monthMoney4) %></td>
                        <td>&nbsp;</td>
                    </tr>
                    <% } %>
                    <% if (Pro2Opened)
                        { %>
                    <tr>
                        <td>会员营销短信</td>
                        <td><%= monthCount2 %></td>
                        <td><%: string.Format("{0:F}",monthMoney2) %></td>
                        <td>&nbsp;</td>
                    </tr>
                    <% } %>
                    <% if (Pro5Opened)
                        { %>
                    <tr>
                        <td>手机流量推广</td>
                        <td><%= monthCount5 %></td>
                        <td><%: string.Format("{0:F}",monthMoney5) %></td>
                        <td>&nbsp;</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

        </div>


        <div class="zhgl_cpfw">
            <div class="zhgl_cpfw_bt">产品服务</div>
            <ul class="clearfix">
                <li class="dx <%= Pro1Enabled?"on":"" %>">
                    <span></span>短信验证码/通知
                    <% if (Pro1Enabled)
                        { %>
                    <% if (Pro1Opened)
                        { %>
                    <div class="xianshi" data-pid="1">
                        <p>账号 :    <%= entity1.SyAccount %></p>
                        <p>密码 :    <%= entity1.SyAccPwd %></p>
                        <p><a href="/Download" target="_blank">API文档下载</a></p>
                        <p>余额 :    <b><%= string.Format("{0:F}",avaiMoney1) %></b>    元</p>
                        <p>剩余条数 :    <b><%= balance1 %></b>条</p>
                        <p><a href="javascript:Recharge(1);" class="cz">充值</a></p>
                    </div>
                    <% }
                        else
                        { %>
                    <div class="xianshi" style="height: 30px;">
                        <p><a href="javascript:OpenPro(1);" class="cz">开通服务</a></p>
                    </div>
                    <% }
                        }
                        else
                        { %>
                    <div class="xianshi" style="display: block; height: 30px;">
                        <p>请联系客服开通</p>
                    </div>
                    <% } %>
                </li>
                <li class="gj <%= Pro3Enabled?"on":"" %>">
                    <span></span>国际短信验证码
                    <% if (Pro3Enabled)
                        { %>
                    <% if (Pro3Opened)
                        { %>
                    <div class="xianshi" data-pid="3">
                        <p>账号 :    <%= entity3.SyAccount %></p>
                        <p>密码 :    <%= entity3.SyAccPwd %></p>
                        <p><a href="/Download" target="_blank">API文档下载</a></p>
                        <p>余额 :    <b><%= string.Format("{0:F}",avaiMoney3) %></b>    元</p>
                        <p>剩余条数 :    <b><%=balance3 %></b>条</p>
                        <p><a href="javascript:Recharge(3);" class="cz">充值</a></p>
                    </div>
                    <% }
                        else
                        { %>
                    <div class="xianshi" style="height: 30px;">
                        <p><a href="javascript:OpenPro(3);" class="cz">开通服务</a></p>
                    </div>
                    <% }
                        }
                        else
                        { %>
                    <div class="xianshi" style="display: block; height: 30px;">
                        <p>请联系客服开通</p>
                    </div>
                    <% } %>
                </li>
                <li class="yy <%= Pro4Enabled?"on":"" %>">
                    <span></span>语音验证码
                    <% if (Pro4Enabled)
                        { %>
                    <% if (Pro4Opened)
                        { %>
                    <div class="xianshi" data-pid="4">
                        <p>账号 :    <%= entity4.SyAccount %></p>
                        <p>密码 :    <%= entity4.SyAccPwd %></p>
                        <p><a href="/Download" target="_blank">API文档下载</a></p>
                        <p>余额 :    <b><%= string.Format("{0:F}",avaiMoney4) %></b>    元</p>
                        <p>剩余条数 :    <b><%= balance4 %></b>条</p>
                        <p><a href="javascript:Recharge(4);" class="cz">充值</a></p>
                    </div>
                    <% }
                        else
                        { %>
                    <div class="xianshi" style="height: 30px;">
                        <p><a href="javascript:OpenPro(4);" class="cz">开通服务</a></p>
                    </div>
                    <% }
                        }
                        else
                        { %>
                    <div class="xianshi" style="display: block; height: 30px;">
                        <p>请联系客服开通</p>
                    </div>
                    <% } %>
                </li>
               <%-- <li class="hyyx <%= Pro2Enabled?"on":"" %>">
                    <span></span>会员营销短信
                    <% if (Pro2Enabled)
                        { %>
                    <% if (Pro2Opened)
                        { %>
                    <div class="xianshi" data-pid="2">
                        <p>账号 :    <%= entity2.SyAccount %></p>
                        <p>密码 :    <%= entity2.SyAccPwd %></p>
                        <p><a href="/Download" target="_blank">API文档下载</a></p>
                        <p>余额 :    <b><%= string.Format("{0:F}", avaiMoney2) %></b>    元</p>
                        <p><a href="javascript:Recharge(2);" class="cz">充值</a></p>
                    </div>
                    <% }
                        else
                        { %>
                    <div class="xianshi" style="height: 30px;">
                        <p><a href="javascript:OpenPro(2);" class="cz">开通服务</a></p>
                    </div>
                    <% }
                        }
                        else
                        { %>
                    <div class="xianshi" style="display: block; height: 30px;">
                        <p>请联系客服开通</p>
                    </div>
                    <% } %>
                </li>--%>
                <%--<li class="sj <%= Pro5Enabled?"on":"" %>">
                    <span></span>手机流量推广
                    <% if (Pro5Enabled)
                        { %>
                    <% if (Pro5Opened)
                        { %>
                    <div class="xianshi" data-pid="5">
                        <p>账号 :    <%= entity5.SyAccount %></p>
                        <p>密码 :    <%= entity5.SyAccPwd %></p>
                        <p><a href="/Download" target="_blank">API文档下载</a></p>
                        <p>余额 :    <b><%= string.Format("{0:F}",avaiMoney5) %></b>    元</p>
                        <p><a href="javascript:Recharge(5);" class="cz">充值</a></p>
                    </div>
                    <% }
                        else
                        { %>
                    <div class="xianshi" style="height: 30px;">
                        <p><a href="javascript:OpenPro(5);" class="cz">开通服务</a></p>
                    </div>
                    <% }
                        }
                        else
                        { %>
                    <div class="xianshi" style="display: block; height: 30px;">
                        <p>请联系客服开通</p>
                    </div>
                    <% } %>
                </li>--%>
            </ul>
        </div>

    </div>


    <script id="searchTmpl" type="text/x-jsrender">
        <tr>
            <th scope="col" width="25%">计费项目</th>
            <th scope="col" width="25%">使用量</th>
            <th scope="col" width="25%">金额（元）</th>
            <th scope="col" width="25%">操作</th>
        </tr>
        <% if (Pro1Opened)
            { %>
        <tr>
            <td>短信验证码/通知</td>
            <td>{{: pro1[0] }}</td>
            <td>{{: pro1[1] }}</td>
            <td>&nbsp;</td>
        </tr>
        <% } %>
        <% if (Pro3Opened)
            { %>
        <tr>
            <td>国际短信验证码</td>
            <td>{{: pro3[0] }}</td>
            <td>{{: pro3[1] }}</td>
            <td>&nbsp;</td>
        </tr>
        <% } %>
        <% if (Pro4Opened)
            { %>
        <tr>
            <td>语音验证码</td>
            <td>{{: pro4[0] }}</td>
            <td>{{: pro4[1] }}</td>
            <td>&nbsp;</td>
        </tr>
        <% } %>
        <% if (Pro2Opened)
            { %>
        <tr>
            <td>会员营销短信</td>
            <td>{{: pro2[0] }}</td>
            <td>{{: pro2[1] }}</td>
            <td>&nbsp;</td>
        </tr>
        <% } %>
        <% if (Pro5Opened)
            { %>
        <tr>
            <td>手机流量推广</td>
            <td>{{: pro5[0] }}</td>
            <td>{{: pro5[1] }}</td>
            <td>&nbsp;</td>
        </tr>
        <% } %>
    </script>

    <script>

        $(function () {

            $("#demoBtn2").click(function () {
                $("#hy_yhzx_demo").layerModel({
                    title: "余额预警修改",
                    drag: false
                });

                $('#warnform .anniu').on('click', function () {
                    $.post('/ashx/hd.ashx', {
                        ac: 7,
                        mm: $('.yealert').val()
                    }, function (jdata) {
                        switch (jdata.code) {
                            case "OK":
                                $('#alertStatus b').text(jdata.data.isSafe ? "正常" : "余额不足");
                                $('#alertMoney i').text($('.yealert').val());
                                $('.layerModel_closeBtn').click();
                                Lay.showMsg(jdata.message);
                                break;
                            default:
                                Lay.showErr(jdata.message);
                                break;
                        }
                    }, 'json');
                });
            });

            $('#ddlYear, #ddlMonth').on('change', function () {
                var year = $('#ddlYear').val();
                var month = $('#ddlMonth').val();
                Search(year + "," + month);
            });

        });

        function Search(date) {
            var loading = Lay.showLoading();
            $.getJSON('Account', { op: 2, date: date }, function (jdata, textStatus) {
                Lay.close(loading);
                if ('success' == textStatus) {
                    switch (jdata.code) {
                        case 'OK':
                            Lay.showMsg(jdata.message);
                            var data = jdata.data;
                            var tmpl = $.templates("#searchTmpl");
                            var html = tmpl.render(data);
                            $('.zhgl_tablebg tbody').html(html);
                            break;
                        default:
                            Lay.showErr(jdata.message);
                            break;
                    }
                }
            });
        }

        function OpenPro(pid) {
            var proId = pid;
            var loading = Lay.showLoading("正在开通");
            $.post('Account', { op: 1, proId: proId }, function (jdata) {
                Lay.close(loading);
                switch (jdata.code) {
                    case 'OK':
                        Lay.showMsg(jdata.message);
                        $('a[href=Account]').click();
                        break;
                    default:
                        Lay.showErr(jdata.message);
                        break;
                }

            });
        }

        function Recharge(pid) {
            window.CurProId = pid;
            $('a[href=Recharge]').click();
        }


    </script>
</asp:Content>
