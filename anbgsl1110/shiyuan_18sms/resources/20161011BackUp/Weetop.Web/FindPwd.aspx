<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="FindPwd.aspx.cs" Inherits="Weetop.Web.FindPwd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>找回密码-示远科技</title>
    <meta name="keywords" content="短信验证码,短信验证码平台,手机验证码平台,语音验证码,手机语音验证码,国际短信验证码,短信通知,短信营销">
    <meta name="description" content="杭州示远信息科技有限公司具有5年通信产业3年短信验证码通道运营服务经验，我们提供短信验证码，短信验证码接口，手机短信验证码，语音验证码，国际短信验证码，通知短信，短信营销等产品，坚持5秒必达、短信到达率100%的原则持续为客户提供最优质短信通道，咨询热线：400-0571-363。">

    <link rel="stylesheet" href="css/member.css">
    <link href="static/dep/validator/jquery.validator.css" rel="stylesheet" />
    <script src="static/dep/validator/jquery.validator.js"></script>
    <script src="static/dep/validator/local/zh-CN.js"></script>
    <script src="static/dep/md5.min.js"></script>
    <script src="http://static.geetest.com/static/tools/gt.js"></script>
    <script>
        window.captCha = null;
        var handler = function (captchaObj) {
            // 将验证码加到id为captcha的元素里
            captchaObj.appendTo("#captcha");
            window.captCha = captchaObj;
        };
        $(function () {
            $.ajax({
                // 获取id，challenge，success（是否启用failback）
                url: "?op=1",
                type: "get",
                dataType: "json", // 使用jsonp格式
                success: function (data) {
                    // 使用initGeetest接口
                    // 参数1：配置参数，与创建Geetest实例时接受的参数一致
                    // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
                    initGeetest({
                        gt: data.gt,
                        challenge: data.challenge,
                        product: "float", // 产品形式
                        offline: !data.success
                    }, handler);
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div class="ny_login clearfix">
        <div class="ny_zhuce_left" style="margin: 0px auto; float: none;">
            <div class="ny_zhuce_left_bt">忘记密码</div>
            <form id="regform">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ny_zhuce_left1">
                    <tbody>
                        <tr>
                            <td width="66%"><span class="span" style="font-size: 14px; color: #333;">
                                <b style="color: #FF0004;">*</b>手机号码：</span><input type="text" value="" name="txtPhone" id="txtPhone" class="srk1"><input type="button" id="btnValiCode" value="获取验证码" style="height: 36px; padding: 0px 10px;"></td>
                            <td width="34%" align="right">输入手机号码</td>
                        </tr>
                        <tr>
                            <td align="center"><span id="captcha"></span></td>
                            <td align="right">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><span class="span" style="font-size: 14px; color: #333;"><b style="color: #FF0004;">*</b> 短信验证码：</span><input type="text" name="txtValiCode" id="txtValiCode" class="srk"></td>
                            <td align="right">输入您手机短信收到的验证码</td>
                        </tr>
                        <tr>
                            <td><span class="span" style="font-size: 14px; color: #333;"><b style="color: #FF0004;">*</b> 输入新密码：</span><input type="password" name="txtPwd1" id="txtPwd1" class="srk"></td>
                            <td align="right">填写6-16位字符，不能包含空格</td>
                        </tr>
                        <tr>
                            <td><span class="span" style="font-size: 14px; color: #333;"><b style="color: #FF0004;">*</b> 确认新密码：</span><input type="password" name="txtPwd2" id="txtPwd2" class="srk"></td>
                            <td align="right">两次输入密码请保持一致</td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input type="submit" name="button" id="button" value="修改密码" class="anniu"></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>


    <script type="text/javascript">
        //发送手机短信验证码
        var valiEvent = function () {
            var phoneNum = $.trim($('#txtPhone').val());
            if (phoneNum.match(/^1[3-9]\d{9}$/)) {

                var validate = window.captCha.getValidate();
                if (!validate) {
                    Lay.showErr('请完成滑块验证');
                    return;
                }

                $('#btnValiCode').unbind('click.valicode');
                $('#btnValiCode').val('发送中');

                $.post('', {
                    op: 3, phone: phoneNum,
                    geetest_challenge: $('#regform .geetest_challenge').val(),
                    geetest_validate: $('#regform .geetest_validate').val(),
                    geetest_seccode: $('#regform .geetest_seccode').val()
                }, function (jdata) {

                    $('#btnValiCode').val('获取验证码');
                    switch (jdata.code) {
                        case '2':
                            Lay.showMsg(jdata.message);
                            // 开始倒计时
                            var timer = null, tim = 60;
                            $('#btnValiCode').val(tim + ' 秒');
                            tim--;
                            timer = setInterval(function () {
                                if (tim == 0) {
                                    clearInterval(timer);
                                    window.captCha.refresh();
                                    $('#btnValiCode').val('获取验证码');
                                    $('#btnValiCode').bind('click.valicode', valiEvent);
                                } else {
                                    $('#btnValiCode').val(tim + ' 秒');
                                }
                                tim--;
                            }, 1000);
                            break;
                        default:
                            window.captCha.refresh();
                            $('#btnValiCode').bind('click.valicode', valiEvent);
                            Lay.showErr(jdata.message);
                            break;
                    }
                }, 'json');
            } else {
                Lay.showErr('手机号码格式错误');
            }
        };
        $('#btnValiCode').bind('click.valicode', valiEvent);

        //提交注册
        $('#regform').validator({
            stopOnError: true,
            theme: 'yellow_right',
            messages: {
                required: "{0}要填哦"
            },
            fields: {
                'txtPhone': '手机号码:required;mobile',
                'txtValiCode': '验证码:required',
                'txtPwd1': '密码:required;password',
                'txtPwd2': '确认密码:required;password;match[txtPwd1]'
            }
        }).on('valid.form', function () {
            $.post('', {
                op: 2,
                phone: $('#txtPhone').val(),
                valicode: $('#txtValiCode').val(),
                pwd: md5($('#txtPwd1').val())
            }, function (jdata) {
                switch (jdata.code) {
                    case "2":
                        window.captCha.refresh();
                        Lay.showErr(jdata.message);
                        break;
                    case "3":
                        Lay.showMsg(jdata.message);
                        window.location = 'Login.aspx';
                        break;
                    default:
                        Lay.showErr(jdata.message);
                        break;
                }
            }, 'json');

        });


    </script>

</asp:Content>
