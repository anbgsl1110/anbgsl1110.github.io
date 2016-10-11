<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Weetop.Web.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>登录-示远科技</title>
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
        <div class="ny_login_left">
            <div class="ny_login_left_bt">账户登录</div>
            <form id="loginform">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ny_login_left1">
                    <tbody>
                        <tr>
                            <td>
                                <div style="position:relative">
                                    <span style="position: absolute; left: 0px; top: 1px;">
                                        <img src="images/login_03.png" alt="" /></span>
                                    <input type="text" class="yhm" name="yhm" id="yhm">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="position:relative">
                                    <span style="position: absolute; left: 0px; top: 1px;">
                                        <img src="images/login_06.png" alt="" /></span>
                                    <input type="password" class="mm" name="pwd" id="pwd">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="captcha"></span></td>
                        </tr>
                        <tr>
                            <td><a href="FindPwd.aspx" style="color: #fa800a;">忘记密码</a></td>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" name="button" id="btnLogin" value="登录" class="anniu"></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <div class="ny_login_right">
            <div class="ny_login_right_bt">还没有账号？</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ny_login_left1">
                <tbody>
                    <tr>
                        <td>
                            <input type="button" name="button" id="button" value="立即注册" class="anniu1" onclick="javascript: location = 'Register.aspx'"></td>
                    </tr>
                    <tr>
                        <td>
                            <p>&nbsp;</p>
                            <p>若 <a href="FindPwd.aspx" style="color: #fa800a;">忘记密码？ </a>可以通过 <a href="FindPwd.aspx" style="color: #fa800a;">手机</a> 找回</p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>
                                ·  开发者零门槛加入<br>
                                ·  自助化服务<br>
                                ·  快速集成到现有产品<br>
                                ·  新的通讯世界在这里等您<br>
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


    <script type="text/javascript">
        //提交注册
        $('#loginform').validator({
            stopOnError: true,
            theme: 'yellow_right',
            fields: {
                'yhm': '帐号:required',
                'pwd': '密码:required;password'
            }
        }).on('valid.form', function () {

            var validate = window.captCha.getValidate();
            if (!validate) {
                Lay.showErr('请完成滑块验证');
                return;
            }

            $.post('', {
                op: 2,
                yhm: $('#yhm').val(),
                pwd: md5($('#pwd').val()),
                geetest_challenge: $('#loginform .geetest_challenge').val(),
                geetest_validate: $('#loginform .geetest_validate').val(),
                geetest_seccode: $('#loginform .geetest_seccode').val()
            }, function (jdata) {
                switch (jdata.code) {
                    case "4":
                        Lay.showMsg(jdata.message);
                        window.location = '/member/Account';
                        break;
                    default:
                        window.captCha.refresh();
                        Lay.showErr(jdata.message);
                        break;
                }
            }, 'json');

        });
    </script>
</asp:Content>
