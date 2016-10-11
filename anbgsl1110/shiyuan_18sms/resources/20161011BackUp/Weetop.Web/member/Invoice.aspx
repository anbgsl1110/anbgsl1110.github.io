<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="Weetop.Web.member.Invoice" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">



    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />用户中心 &gt; 开发票</div>

        <div class="kfp">
            <div class="sqfpje">
                <h1>可索取发票金额：<span><%= string.Format("{0:F0}", availableInvoice) %></span>&nbsp;元</h1>
            </div>
            <form id="invoform">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                </table>
            </form>
        </div>

    </div>


    <div id="invo1" style="display: none;">
        <table>
            <tbody>
            </tbody>
        </table>
    </div>

    <div id="invo2" style="display: none;">
        <table>
            <tbody>
                <%--<tr>
                    <td align="right" valign="top"><span style="color: #FF0004; padding-right: 3px;">*</span>营业执照/税务登记证扫描件：</td>
                    <td>
                        <p>
                            <input type="file" name="filetax">
                            (格式：jpg,gif,png；单张最大：2M)
                        </p>
                        <p class="yellow">请上传加盖国家税务局章的税务登记证扫描件</p>
                    </td>
                </tr>--%>
            </tbody>
        </table>
    </div>

    <div id="invo3" style="display: none;">
        <table>
            <tbody>
                <tr>
                    <td align="right" valign="top"><span style="color: #FF0004; padding-right: 3px;">*</span>统一社会信用代码/税务登记号：</td>
                    <td>
                        <p>
                            <input type="text" name="ftaxcode" class="text">
                        </p>
                        <p class="yellow">请与主管税务局确认能使发票认证通过的正确号码</p>
                    </td>
                </tr>
                <tr>
                    <td align="right"><span style="color: #FF0004; padding-right: 3px;">*</span>开户银行：</td>
                    <td>
                        <input type="text" name="fbank" class="text"></td>
                </tr>
                <tr>
                    <td align="right"><span style="color: #FF0004; padding-right: 3px;">*</span>开户银行帐号：</td>
                    <td>
                        <input type="text" name="fbankcode" class="text"></td>
                </tr>
                <tr>
                    <td align="right"><span style="color: #FF0004; padding-right: 3px;">*</span>营业电话：</td>
                    <td>
                        <input type="text" name="fbusphone" class="text"></td>
                </tr>
                <tr>
                    <td align="right"><span style="color: #FF0004; padding-right: 3px;">*</span>营业执照地址：</td>
                    <td>
                        <input type="text" name="fbusaddr" class="text"></td>
                </tr>
               <%-- <tr>
                    <td align="right" valign="top"><span style="color: #FF0004; padding-right: 3px;">*</span>营业执照/税务登记证扫描件：</td>
                    <td>
                        <p>
                            <input type="file" name="filetax">
                            (格式：jpg,gif,png；单张最大：2M)
                        </p>
                        <p class="yellow">请上传加盖国家税务局章的税务登记证扫描件</p>
                    </td>
                </tr>
                <tr>
                    <td align="right"><span style="color: #FF0004; padding-right: 3px;">*</span>一般纳税人资格认证扫描件：</td>
                    <td>
                        <input type="file" name="filenormal">
                        (格式：jpg,gif,png；单张最大：2M)</td>
                </tr>--%>
            </tbody>
        </table>
    </div>




    <script type="text/javascript">

        var loading = null;

        var head = '<tr>\
                        <td align="right">开票类型：</td>\
                        <td>\
                            <label>\
                                <input type="radio" name="InvoType" value="1">&nbsp;个人</label>&nbsp;&nbsp;\
                            <label>\
                                <input type="radio" name="InvoType" value="2">&nbsp;公司小规模纳税人</label>&nbsp;&nbsp;\
                            <label>\
                                <input type="radio" name="InvoType" value="3">&nbsp;公司一般纳税人</label>\
                        </td>\
                    </tr>\
                    <tr>\
                        <td width="37%" align="right" valign="top"><span style="color: #FF0004; padding-right: 3px;">*</span>开票金额：</td>\
                        <td width="63%">\
                            <p>\
                                <input type="number" name="fmoney" step="1" min="1" max="100000000" value="" class="text">\
                            </p>\
                        </td>\
                    </tr>\
                    <tr>\
                        <td width="37%" align="right" valign="top"><span style="color: #FF0004; padding-right: 3px;">*</span>发票抬头：</td>\
                        <td width="63%">\
                            <p>\
                                <input type="text" name="ftitle" class="text">\
                            </p>\
                            <p class="yellow">发票抬头必须与打款账户名保持一致。</p>\
                        </td>\
                    </tr>';
        var foot = '<tr>\
                        <td align="right"><span style="color: #FF0004; padding-right: 3px;">*</span>发票寄往地址：</td>\
                        <td>\
                            <select id="s_province" name="province"></select>\
                            <select id="s_city" name="city" ></select>\
                            <select id="s_county" name="county"></select>\
                        </td>\
                    </tr>\
                    <tr>\
                        <td align="right" width="37%">\
                        </td>\
                        <td width="63%">\
                        <input type="text" name="faddr"  class="text">\
                        </td>\
                    </tr>\
                    <tr>\
                        <td align="right" valign="top">其他文件：</td>\
                        <td>\
                            <p>\
                                <input type="file" name="fileother">\
                                (格式：jpg,gif,png；单张最大：2M)\
                            </p>\
                            <p class="yellow">支付宝付款，请截图上传</p>\
                        </td>\
                    </tr>\
                    <tr>\
                        <td align="right">备注：</td>\
                        <td>\
                            <input type="text" name="fremark" class="text"></td>\
                    </tr>\
                    <tr>\
                        <td>&nbsp;</td>\
                        <td>\
                            <input type="submit" name="button" value="提交" class="anniu"></td>\
                    </tr>\
                    <tr>\
                        <td colspan="2">\
                            <p>&nbsp;</p>\
                            <p>\
                                注意事项：<br>\
                                1、开票抬头取自支付宝认证信息，如要修改请更新支付宝认证信息;<br>\
                                2、开票信息审核5个工作日内完成，通过才能申请发票，请关注审核状态;<br>\
                                3、邮寄地址申请发票必填，如未填写请补充;<br>\
                                4、答疑渠道：右侧问答机器人、置顶账房论坛或电话咨询商家客服;\
                            </p>\
                        </td>\
                    </tr>';

        var content1 = $('#invo1 tbody').prepend($(head)).append($(foot));
        var content2 = $('#invo2 tbody').prepend($(head)).append($(foot));
        var content3 = $('#invo3 tbody').prepend($(head)).append($(foot));
        var container = $('.kfp table');

        container.append(content2);//move with value
        $('.kfp input[name=InvoType][value=2]').prop('checked', true);

        $('.kfp').on('change', 'input[type=radio][name=InvoType]', function () {
            if ($(this).val() === "1") {
                container.empty().append(content1);
                _init_area();
                $('.kfp input[name=InvoType][value=1]').prop('checked', true);
            } else if ($(this).val() === "2") {
                container.empty().append(content2);
                _init_area();
                $('.kfp input[name=InvoType][value=2]').prop('checked', true);
            } else {
                container.empty().append(content3);
                _init_area();
                $('.kfp input[name=InvoType][value=3]').prop('checked', true);
            }
            reHeight();
        });


        //$('#invoform').on('reset', function (e) {
        //    var ck = $('input[type=radio][name=InvoType]:checked').val();
        //    alert(ck);
        //    //重置后再选中，这样无效
        //    $('.kfp input[name=InvoType][value=' + ck + ']').prop('checked', true);
        //});


        $('#invoform').on('submit', function (e) {
            e.preventDefault();

            var avaiMy = <%= string.Format("{0:F0}", availableInvoice) %>;
            if (avaiMy <= 0) {
                Lay.showErr("可开发票金额不足，无法开票");
                return false;
            }

            var fmoney = $('input[name=fmoney]').val();
            if (fmoney == "") {
                Lay.showErr("请填写开票金额");
                return false;
            }
            if (fmoney <= 0 || fmoney > avaiMy) {
                Lay.showErr("开票金额无效");
                return false;
            }

            var ftitle = $('input[name=ftitle]').val();
            if (ftitle == "") {
                Lay.showErr("请填写发票抬头");
                return false;
            }

            var type = $('input[type=radio][name=InvoType]:checked').val();
            if (type == 3) {
                var ftaxcode = $('input[name=ftaxcode]').val();
                if (ftaxcode == "") {
                    Lay.showErr("请填写统一社会信用代码/税务登记号");
                    return false;
                }
                var fbank = $('input[name=fbank]').val();
                if (fbank == "") {
                    Lay.showErr("请填写开户银行");
                    return false;
                }
                var fbankcode = $('input[name=fbankcode]').val();
                if (fbankcode == "") {
                    Lay.showErr("请填写开户银行帐号");
                    return false;
                }
                var fbusphone = $('input[name=fbusphone]').val();
                if (fbusphone == "") {
                    Lay.showErr("请填写营业电话");
                    return false;
                }
                var fbusaddr = $('input[name=fbusaddr]').val();
                if (fbusaddr == "") {
                    Lay.showErr("请填写营业执照地址");
                    return false;
                }
            }

            var faddr = $('input[name=faddr]').val();
            var province=$('#s_province').val();
            var city=$('#s_city').val();
            var county=$('#s_county').val();
            if (faddr == "") {
                Lay.showErr("请填写发票寄往地址");
                return false;
            }

            loading = Lay.showLoading('正在提交');

            $("#invoform").ajaxSubmit({
                url: 'Invoice',
                data: { ac: 1 },
                type: 'post',
                dataType: 'json',
                success: function (jdata, statusText) {
                    if (jdata.code == "OK") {
                        Lay.showMsg(jdata.message);
                        $('a[href=InvoiceList]').click();
                    } else {
                        Lay.showErr(jdata.message);
                    }
                    if (loading) Lay.close(loading);
                },
                error: function (jdata, statusText) {
                    if (loading) Lay.close(loading);
                    Lay.showErr(statusText);
                }
            });

        });

        //三级联动
        _init_area();

        var Gid;
        var showArea = function(){
            Gid('show').innerHTML = "<h3>省" + Gid('s_province').value + " - 市" + 	
            Gid('s_city').value + " - 县/区" + 
            Gid('s_county').value + "</h3>"
        }
        //Gid('s_county').setAttribute('onchange','showArea()');
    </script>


</asp:Content>
