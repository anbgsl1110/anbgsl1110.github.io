<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="Auth.aspx.cs" Inherits="Weetop.Web.member.Auth" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">


    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />用户中心 &gt; 认证信息</div>

        <div id="authSuccess" class="hy_right1_wxts" style="display:none;background-color: lightgoldenrodyellow;">
            <b style="display: block; text-align: center;">您已通过认证！</b>
        </div>

        <div class="hy_right1_wxts">
            <h1>温馨提示：</h1>
            <ul>
                <li>1、默认注册用户为一般开发者，完成【个人开发者】或者【企业开发者】认证后，通过平台开发的应用可申请上线商用；</li>
                <li>2、【企业开发者】优于【个人开发者】能使用更多的功能、选择更优惠的资费套餐。</li>
            </ul>
        </div>
        <div class="hy_right1_qykfz">
            <h1>账户认证</h1>
            <form id="authform">
                <table>
                </table>
            </form>
        </div>
    </div>


    <div id="auth1" style="display: none;">
        <table>
            <tbody>
                <tr>
                    <td><span><b style="color: #FF0004;">*</b>公司名称</span></td>
                    <td>
                        <input type="text" name="cname" class="input_tx01"></td>
                </tr>
                <tr>
                    <td><span><b style="color: #FF0004;">*</b>公司注册地址</span></td>
                    <td>
                        <input type="text" name="caddr" class="input_tx01"></td>
                </tr>
                <tr>
                    <td style="height: 24px; line-height: 24px;">&nbsp;</td>
                    <td style="height: 24px; line-height: 24px;">公司地址必须与营业执照相同</td>
                </tr>
                <tr>
                    <td><span><b style="color: #FF0004;">*</b>证件类型</span></td>
                    <td>
                        <label>
                            <input type="radio" name="zjlx" value="1" checked>普通证件</label><label><input type="radio" name="zjlx" value="2">三证合一</label></td>
                </tr>
                <tr class="panel1">
                    <td><span><b style="color: #FF0004;">*</b>组织机构证件</span></td>
                    <td>
                        <input type="text" readonly="" class="input_tx02"><a href="javascript:void(0);">浏览<input type="file" name="cfilez" value=""></a></td>
                </tr>
                <tr class="panel1">
                    <td style="height: 24px; line-height: 24px;">&nbsp;</td>
                    <td style="height: 24px; line-height: 24px;">请上传控制图片大小在2M以内，格式支持jpg，jpeg，png，gif；Mac OSX用户请使用firefox浏览器进行上传。</td>
                </tr>
                <tr class="panel1">
                    <td><span><b style="color: #FF0004;">*</b>税务登记证件</span></td>
                    <td>
                        <input type="text" readonly="" class="input_tx02"><a href="javascript:void(0);">浏览<input type="file" name="cfiles" value=""></a></td>
                </tr>
                <tr class="panel1">
                    <td style="height: 24px; line-height: 24px;">&nbsp;</td>
                    <td style="height: 24px; line-height: 24px;">请上传控制图片大小在2M以内，格式支持jpg，jpeg，png，gif；Mac OSX用户请使用firefox浏览器进行上传。</td>
                </tr>
                <tr class="panel1">
                    <td><span><b style="color: #FF0004;">*</b>营业执照证件</span></td>
                    <td>
                        <input type="text" readonly="" class="input_tx02"><a href="javascript:void(0);">浏览<input type="file" name="cfiley" value=""></a></td>
                </tr>
                <tr class="panel1">
                    <td style="height: 24px; line-height: 24px;">&nbsp;</td>
                    <td style="height: 24px; line-height: 24px;">请上传控制图片大小在2M以内，格式支持jpg，jpeg，png，gif；Mac OSX用户请使用firefox浏览器进行上传。</td>
                </tr>
                <tr class="panel2" style="display: none;">
                    <td><span><b style="color: #FF0004;">*</b>三证合一</span></td>
                    <td>
                        <input type="text" readonly="" class="input_tx02"><a href="javascript:void(0);">浏览<input type="file" name="cfile3in1" value=""></a></td>
                </tr>
                <tr class="panel2" style="display: none;">
                    <td style="height: 24px; line-height: 24px;">&nbsp;</td>
                    <td style="height: 24px; line-height: 24px;">请上传控制图片大小在2M以内，格式支持jpg，jpeg，png，gif；Mac OSX用户请使用firefox浏览器进行上传。</td>
                </tr>
                <tr>
                    <td><span><b style="color: #FF0004;">*</b>法定代表人</span></td>
                    <td>
                        <input type="text" name="clegalpeo" class="input_tx01"></td>
                </tr>
                <tr>
                    <td><span><b style="color: #FF0004;">*</b>公司电话</span></td>
                    <td>
                        <input type="text" name="cphone" class="input_tx01"><label style="margin-left: 10px;">实例号码：055112345678</label></td>
                </tr>
                <tr>
                    <td><span>申请人真实姓名</span></td>
                    <td>
                        <input type="text" name="cpeoname" class="input_tx01"></td>
                </tr>
                <tr>
                    <td><span>申请人证件照片</span></td>
                    <td>
                        <input type="text" readonly="" class="input_tx02"><a href="javascript:void(0);">浏览<input type="file" name="cpeopic" value=""></a></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="auth2" style="display: none;">
        <table>
            <tbody>
                <tr>
                    <td><span><b style="color: #FF0004;">*</b>真实姓名</span></td>
                    <td>
                        <input type="text" name="pname" class="input_tx01"></td>
                </tr>
                <tr>
                    <td><span><b style="color: #FF0004;">*</b>证件类型</span></td>
                    <td>
                        <select name="ptype">
                            <option value="0">－－请选择证件类型－－</option>
                            <option value="1">身份证</option>
                            <option value="2">居住证</option>
                            <option value="3">签证</option>
                            <option value="4">护照</option>
                            <option value="5">户口本</option>
                            <option value="6">军人证</option>
                            <option value="7">团员证</option>
                            <option value="8">党员证</option>
                            <option value="9">港澳通行证</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><span><b style="color: #FF0004;">*</b>证件号码</span></td>
                    <td>
                        <input type="text" name="pfilenum" class="input_tx01"></td>
                </tr>
                <tr>
                    <td><span><b style="color: #FF0004;">*</b>证件照片</span></td>
                    <td>
                        <input type="text" readonly="" class="input_tx02"><a href="javascript:void(0);">浏览<input type="file" name="pfile" value=""></a></td>
                </tr>
                <tr>
                    <td style="height: 24px; line-height: 24px;">&nbsp;</td>
                    <td style="height: 24px; line-height: 24px;">请上传手持真实有效的身份证及护照扫描件、照片的正面。请确保证件内容和脸部清晰可见，控制在2M以内，格式支持jpg，jpeg，png，gif。Mac OSX用户请使用firefox浏览器进行上传。</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <div>
                            <p class="p01">
                                请注意：<br>
                                照片中的以下信息必须真实<br>
                                有效且清晰可见
                            </p>
                            <p class="p02">
                                1、手持证件人的五官<br>
                                2、身份证上的所有信息
                            </p>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="authDetails" style="display:none;">
         <table>
            <tbody>
                <tr>
                    <td style="width:20%" ><span>开发者账户</span></td>
                    <td >
                        <asp:Literal ID="litAccEmail" runat="server"></asp:Literal>
                    </td>
                </tr>
                <tr>
                    <td ><span>申请认证类型</span></td>
                    <td>
                        <asp:Literal ID="litAuthType" runat="server"></asp:Literal>
                    </td>
                </tr>

                <asp:Panel ID="Panel1" runat="server">
                    <tr>
                        <td ><span>公司名称</span></td>
                        <td>
                            <asp:Literal ID="litCName" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td ><span>公司注册地址</span></td>
                        <td>
                            <asp:Literal ID="litCAddr" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td ><span>证件类型</span></td>
                        <td>
                            <asp:Literal ID="litAuCType" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr runat="server" id="trCFileZ">
                        <td ><span>组织机构证件</span></td>
                        <td>
                            <asp:HyperLink ID="lnkCFileZ" runat="server">
                                <asp:Image ID="ImgCFileZ" runat="server" />
                            </asp:HyperLink>
                        </td>
                    </tr>
                    <tr runat="server" id="trCFileS">
                        <td><span>税务登记证件</span></td>
                        <td>
                            <asp:HyperLink ID="lnkCFileS" runat="server">
                                <asp:Image ID="ImgCFileS" runat="server" />
                            </asp:HyperLink>
                        </td>
                    </tr>
                    <tr runat="server" id="trCFileY">
                        <td ><span>营业执照证件</span></td>
                        <td>
                            <asp:HyperLink ID="lnkCFileY" runat="server">
                                <asp:Image ID="ImgCFileY" runat="server" />
                            </asp:HyperLink>
                        </td>
                    </tr>
                    <tr runat="server" id="trCFile3in1">
                        <td><span>三证合一</span></td>
                        <td>
                            <asp:HyperLink ID="lnkCFile3in1" runat="server">
                                <asp:Image ID="ImgCFile3in1" runat="server" />
                            </asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td ><span>法定代表人</span></td>
                        <td>
                            <asp:Literal ID="litCLegalPeo" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td ><span>公司电话</span></td>
                        <td>
                            <asp:Literal ID="litCPhone" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td><span>申请人真实姓名</span></td>
                        <td>
                            <asp:Literal ID="litCPeoName" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr runat="server" id="trCPeoPic">
                        <td ><span>申请人证件照片</span></td>
                        <td>
                            <asp:HyperLink ID="lnkPeoPic" runat="server">
                                <asp:Image ID="ImgPeoPic" runat="server" />
                            </asp:HyperLink>
                        </td>
                    </tr>
                </asp:Panel>

                <asp:Panel ID="Panel2" runat="server">
                    <tr>
                        <td><span>真实姓名</span></td>
                        <td>
                            <asp:Literal ID="litPName" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td ><span>证件类型</span></td>
                        <td>
                            <asp:Literal ID="litPType" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td ><span>证件号码</span></td>
                        <td>
                            <asp:Literal ID="litPFileNum" runat="server"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td><span>组织机构证件</span></td>
                        <td>
                            <asp:HyperLink ID="lnkPFile" runat="server">
                                <asp:Image ID="ImgPFile" runat="server" />
                            </asp:HyperLink>
                        </td>
                    </tr>
                </asp:Panel>
                <tr >
                    <td>&nbsp;</td>
                    <td style="padding-top:40px;">
                        <input type="button" value="修改" id="btnEditAuthInfo"  class="input_Btn03" />
                        <!--
                        <a href="javascript:;" id="btnFeedback" class="btn btn-sm btn-primary">保存</a>
                        <a href="UserList.aspx?page=<%= Request["page"] ?? "1" %>" id="btnReturn" class="btn btn-sm btn-default">返回</a>
                        -->
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <div id="authing" style="display:none" >
        <div class="hy_content_authStatus" >
            <b style="display: block; text-align: center;">您的认证信息已提交，请等待审核！</b>
        </div>

    </div>
    <div id="authFailed" style="display:none" >
        <table>
            <tbody>
                <tr>
                    <td style="width:30%;">
                        <div class="hy_content_authStatus" >
                            <b style="display: block; text-align: center;">您的提交的账户认证信息不符合标准，请重新提交！</b>
                         </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <center><input type="button" value="重新提交" id="btnReauth" class="input_Btn03" />  </center>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">

        var loading = null;

        var head = '<tr>\
                        <td style="width: 20%;"><span>开发者账户</span></td>\
                        <td><em><%= TUser.Email %></em></td>\
                    </tr>\
                    <tr>\
                        <td><span><b style="color: #FF0004;">*</b>申请认证类型</span></td>\
                        <td>\
                            <label>\
                                <input type="radio" value="1" name="rzlx">企业开发者</label>\
                            <label>\
                                <input type="radio" value="2" name="rzlx">个人开发者</label></td>\
                    </tr>';
        var foot = '<tr style="display: inline-block; margin-top: 40px;">\
                        <td><span>&nbsp;</span></td>\
                        <td><input type="submit" value="提交" class="input_Btn03" /></td>\
                    </tr>';

        var content1 = $('#auth1 tbody').prepend($(head)).append($(foot));
        var content2 = $('#auth2 tbody').prepend($(head)).append($(foot));
        var container = $('.hy_right1_qykfz table');


        <%if (authInfo != null)
        {
            if (authInfo.ValidState == (int)AuthValidState.已认证){
                %>
        $("#authSuccess").show();
        container.append($('#authDetails tbody'));
                <%
            }
            else if(authInfo.ValidState == (int)AuthValidState.待认证)
            {%>
        container.empty().append($("#authing .hy_content_authStatus"))
            <%}
            else if(authInfo.ValidState == (int)AuthValidState.认证失败)
            {%>
        container.empty().append($("#authFailed tbody"))
            <%}
            else
            {%>
        container.append(content1);
        $('.hy_right1_qykfz input[name=rzlx][value=1]').prop('checked', true);
            <%}

        }
        else
        {%>
        container.append(content1);
        $('.hy_right1_qykfz input[name=rzlx][value=1]').prop('checked', true);
        <%}
        %>

        $('.hy_right1_qykfz input[name=rzlx][value=1]').prop('checked', true);

        $('.hy_right1_qykfz').on('change', 'input[type=radio][name=rzlx]', function () {
            if ($(this).val() === "1") {
                container.empty().append(content1);
                $('.hy_right1_qykfz input[name=rzlx][value=1]').prop('checked', true);
            } else {
                container.empty().append(content2);
                $('.hy_right1_qykfz input[name=rzlx][value=2]').prop('checked', true);
            }
            reHeight();
        });


        $('.hy_right1_qykfz').on('change', 'input[type=radio][name=zjlx]', function () {
            if ($(this).val() === "1") {
                $('.panel1').show();
                $('.panel2').hide();
            } else {
                $('.panel2').show();
                $('.panel1').hide();
            }
            reHeight();
        });


        $('.hy_right1_qykfz').on('change', 'input[type=file]', function () {
            $(this).parent().prev().val(this.files[0].name);
        });

        $("#btnEditAuthInfo").on('click', function (e) {
            <%if (authInfo != null && authInfo.AuthType == (int)AuthType.企业开发者)
        {%>
            container.empty().append(content1);
            $('.hy_right1_qykfz input[name=rzlx][value=1]').prop('checked', true);
            <%}
        else
        {
            %>
            container.empty().append(content2);
            $('.hy_right1_qykfz input[name=rzlx][value=2]').prop('checked', true);
            <%
        }
        %>
        });

        $('#btnReauth').on("click", function (e) {
            container.empty().append(content1);
            $('.hy_right1_qykfz input[name=rzlx][value=1]').prop('checked', true);

        });

        $('#authform').on('submit', function (e) {
            e.preventDefault();

            var type = $('input[type=radio][name=rzlx]:checked').val();
            if (type == 1) {
                var cname = $('input[name=cname]').val();
                if (cname == "") {
                    Lay.showErr("请填写公司名称");
                    return false;
                }
                var caddr = $('input[name=caddr]').val();
                if (caddr == "") {
                    Lay.showErr("请填写公司注册地址");
                    return false;
                }

                //证件类型
                var ck = $('.hy_right1_qykfz input[name=zjlx]:checked').val();
                if (ck == 1) {
                    //三证
                    var cfilez = $('input[name=cfilez]').val();
                    if (cfilez == null || cfilez == "") {
                        Lay.showErr("请上传组织机构证件");
                        return false;
                    }
                    var cfiles = $('input[name=cfiles]').val();
                    if (cfiles == null || cfiles == "") {
                        Lay.showErr("请上传税务登记证件");
                        return false;
                    }
                    var cfiley = $('input[name=cfiley]').val();
                    if (cfiley == null || cfiley == "") {
                        Lay.showErr("请上传营业执照证件");
                        return false;
                    }
                } else if (ck == 2) {
                    //三证合一
                    var cfile3in1 = $('input[name=cfile3in1]').val();
                    if (cfile3in1 == null || cfile3in1 == "") {
                        Lay.showErr("请上传证件");
                        return false;
                    }
                } else {
                    Lay.showErr("无效参数");
                    return false;
                }

                var clegalpeo = $('input[name=clegalpeo]').val();
                if (clegalpeo == "") {
                    Lay.showErr("请填写法定代表人");
                    return false;
                }
                var cphone = $('input[name=cphone]').val();
                if (cphone == "") {
                    Lay.showErr("请填写公司电话");
                    return false;
                }
            } else if (type == 2) {
                var pname = $('input[name=pname]').val();
                if (pname == "") {
                    Lay.showErr("请填写真实姓名");
                    return false;
                }
                var ptype = $('select[name=ptype]').val();
                if (ptype == "0") {
                    Lay.showErr("请选择证件类型");
                    return false;
                }
                var pfilenum = $('input[name=pfilenum]').val();
                if (pfilenum == "") {
                    Lay.showErr("请填写证件号码");
                    return false;
                }
                var pfile = $('input[name=pfile]').val();
                if (pfile == null || pfile == "") {
                    Lay.showErr("请上传证件照片");
                    return false;
                }
            } else {
                Lay.showErr("无效参数");
                return false;
            }


            loading = Lay.showLoading('正在提交');

            $("#authform").ajaxSubmit({
                url: 'Auth',
                data: { ac: 1 },
                type: 'post',
                dataType: 'json',
                success: function (jdata, statusText) {
                    if (jdata.code == "OK") {
                        Lay.showMsg(jdata.message);
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



    </script>

</asp:Content>
