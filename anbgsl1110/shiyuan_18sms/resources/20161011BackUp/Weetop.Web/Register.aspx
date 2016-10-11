<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Weetop.Web.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>注册-示远科技</title>
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
        <div class="ny_zhuce_left">
            <div class="ny_zhuce_left_bt">账户注册</div>
            <form id="regform">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ny_zhuce_left1">
                    <tbody>
                        <tr>
                            <td width="66%"><span class="span" style="font-size: 14px; color: #333;">
                                <b style="color: #FF0004;">*</b>手机号码：</span><input type="text" name="txtPhone" id="txtPhone" class="srk1" />
                                <input type="button" id="btnValiCode" value="获取验证码" style="height: 36px; padding: 0px 10px;background-color:#fa800a;color:#fff;" /></td>
                            <td width="34%" align="right">手机号可以作为用户名登录</td>
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
                            <td><span class="span" style="font-size: 14px; color: #333;"><b style="color: #FF0004;">*</b> 邮箱：</span><input type="text" name="txtEmail" id="txtEmail" class="srk"></td>
                            <td align="right">邮箱可以作为用户名登录</td>
                        </tr>
                        <tr>
                            <td><span class="span" style="font-size: 14px; color: #333;"><b style="color: #FF0004;">*</b> 公司名称：</span><input type="text" name="txtCmpName" id="txtCmpName" class="srk"></td>
                            <td align="right">公司名称用于开发票信息</td>
                        </tr>
                        <tr>
                            <td><span class="span" style="font-size: 14px; color: #333;"><b style="color: #FF0004;">*</b> 输入密码：</span><input type="password" name="txtPwd1" id="txtPwd1" class="srk"></td>
                            <td align="right">填写6-16位字符，不能包含空格</td>
                        </tr>
                        <tr>
                            <td><span class="span" style="font-size: 14px; color: #333;"><b style="color: #FF0004;">*</b> 确认密码：</span><input type="password" name="txtPwd2" id="txtPwd2" class="srk"></td>
                            <td align="right">两次输入密码请保持一致</td>
                        </tr>
                        <tr>
                            <td><span class="span" style="font-size: 14px; color: #333;">邀请码：</span><input type="text" name="txtInvitation" id="txtInvitation" class="srk"></td>
                            <td align="right">邀请码检测    没有可不填写</td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" name="checkbox" id="checkbox" checked="checked" style="vertical-align: middle; margin-right: 10px; margin-left: 50px;">我已阅读<a href="javascript:void(0)" class="run" id="demoBtn1" style="color: #fa800a;">《自助通用户注册协议》</a></td>
                            <td align="right">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input type="submit" name="button" id="btnReg" value="同意条款并注册" class="anniu"></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>


        <div id="tanchu_demo">
            <strong style="display: block; text-align: center; color: #333; font-size: 22px;">《用户注册协议》</strong>
            <p>&nbsp; </p>
            <p>
                “法律百科”所提供的各项服务的所有权和运作权属于其运营商。用户必须同意下述所有服务条款并完成注册程序，才能成为“法律百科”的正式会员并使用“法律百科”提供的各项服务。服务条款的修改权归“法律百科”运营商所有。<br>
                一、 “法律百科”运用自己的操作系统，通过国际互联网络等手段为会员提供法律信息交流平台。“法律百科”有权在必要时修改服务条款，服务条款一旦发生变动，将会在重要页面上提示修改内容或通过其他形式告知会员。如果会员不同意所改动的内容，可以主动取消获得的网络服务。如果会员继续享用网络服务，则视为接受服务条款的变动。“法律百科”保留随时修改或中断服务而不需知照会员的权利。“法律百科”行使修改或中断服务的权利，不需对会员或第三方负责。<br>
                二、保护会员隐私权<br>
                您注册“法律百科”相关服务时，跟据网站要求提供相关个人信息；在您使用“法律百科”服务、参加网站活动、或访问网站网页时，网站自动接收并记录的您浏览器上的服务器数据，包括但不限于IP地址、网站Cookie中的资料及您要求取用的网页记录；“法律百科”承诺不公开或透露您的密码、手机号码等在本站的非公开信息。除非因会员本人的需要、法律或其他合法程序的要求、服务条款的改变或修订等。<br>
                为服务用户的目的，“法律百科”可能通过使用您的个人信息，向您提供服务，包括但不限于向您发出活动和服务信息等。<br>
                同时会员须做到：<br>
                ● 用户名和昵称的注册与使用应符合网络道德，遵守中华人民共和国的相关法律法规。<br>
                ● 用户名和昵称中不能含有威胁、淫秽、漫骂、非法、侵害他人权益等有争议性的文字。<br>
                ● 注册成功后，会员必须保护好自己的帐号和密码，因会员本人泄露而造成的任何损失由会员本人负责。<br>
                ● 不得盗用他人帐号，由此行为造成的后果自负。<br>
                您的个人信息将在下述情况下部分或全部被披露：<br>
                ● 经您同意，向第三方披露；<br>
                ● 如您是合资格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；<br>
                ● 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；<br>
                ● 如果您出现违反中国有关法律或者网站政策的情况，需要向第三方披露；<br>
                ● 为提供你所要求的产品和服务，而必须和第三方分享您的个人信息；<br>
                ● 其他本网站根据法律或者网站政策认为合适的披露<br>
                三、责任说明<br>
                基于技术和不可预见的原因而导致的服务中断，或者因会员的非法操作而造成的损失，“法律百科”不负责任。会员应当自行承担一切因自身行为而直接或者间接导致的民事或刑事法律责任。<br>
                四、会员必须做到：<br>
                1、不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本站制作、复制和传播下列信息：<br>
                （1）煽动抗拒、破坏宪法和法律、行政法规实施的；<br>
                （2）煽动颠覆国家政权，推翻社会主义制度的；<br>
                （3）煽动分裂国家、破坏国家统一的；<br>
                （4）煽动民族仇恨、民族歧视，破坏民族团结的；<br>
                （5）捏造或者歪曲事实，散布谣言，扰乱社会秩序的；<br>
                （6）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；<br>
                （7）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；<br>
                （8）损害国家机关信誉的；<br>
                （9）其他违反宪法和法律行政法规的；<br>
                （10）进行商业广告行为的。<br>
                2、未经本站的授权或许可，任何会员不得借用本站的名义从事任何商业活动，也不得将本站作为从事商业活动的场所、平台或其他任何形式的媒介。禁止将本站用作从事各种非法活动的场所、平台或者其他任何形式的媒介。违反者若触犯法律，一切后果自负，本站不承担任何责任。<br>
                五、版权说明：<br>
                任何会员在本站发表任何形式的信息，均表明该用户主动将该信息的发表权、汇编权、修改权、信息网络传播权无偿独家转让给“法律百科”运营商。本协议已经构成《著作权法》第二十五条所规定的书面协议，并在用户同意本注册协议时生效，其效力及于用户此后在法律百科发布的任何内容。<br>
                会员同意并明确了解上述条款，不将已发表于本站的信息，以任何形式发布或授权其它网站（及媒体）使用。<br>
                同时，“法律百科”保留删除站内各类不符合规定点评而不通知会员的权利：<br>
                六、免责声明：<br>
                ● “法律百科”是为互联网用户提供信息存储空间的互联网服务提供者，对于任何包含、经由或连接、下载或从任何与有关本网站所获得的任何内容、信息或广告，不声明或保证其正确性或可靠性；并且对于用户经本网站上的内容、广告、展示而购买、取得的任何产品、信息或资料，“法律百科”不负保证责任。用户自行负担使用本网站的风险。<br>
                ● “法律百科”有权但无义务，改善或更正本网站任何部分之任何疏漏、错误。<br>
                ● 本站内相关信息内容仅代表发布者的个人观点，并不表示本站赞同其观点或证实其描述，本站不承担由此引发的法律责任。
            </p>
        </div>



        <div class="ny_login_right">
            <div class="ny_login_right_bt">已有账号？</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ny_login_left1">
                <tbody>
                    <tr>
                        <td>
                            <input type="button" name="button" id="button" value="立即登录" class="anniu1" onclick="javascript: location = 'Login.aspx'"></td>
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

    <script type="text/javascript" src="js/jquery.layerModel.js"></script>
    <link type="text/css" rel="stylesheet" href="css/layerModel.css" />
    <script>
        $(function () {
            $("#demoBtn1").click(function () {
                $("#tanchu_demo").layerModel({
                    title: "用户注册协议",
                    drag: false
                });
            });
        });
    </script>

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

                            $("#btnValiCode").css("background-color", "#8f8f8f");
                            $("#btnValiCode").css("color", "#F0F0F0");
                            // 开始倒计时
                            var timer = null, tim = 60;
                            $('#btnValiCode').val(tim + ' 秒');
                            tim--;
                            timer = setInterval(function () {
                                if (tim == 0) {
                                    clearInterval(timer);
                                    window.captCha.refresh();
                                    $("#btnValiCode").css("background-color", "#fa800a");
                                    $("#btnValiCode").css("color", "#fff");
                                    $('#btnValiCode').val('获取验证码');
                                    $('#btnValiCode').bind('click.valicode', valiEvent);
                                } else {
                                    $('#btnValiCode').val(tim + ' 秒');
                                }
                                tim--;
                            }, 1000);
                            Lay.showMsg(jdata.message);
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
                required: "{0}要填哦",
                checked: { eq: "请仔细阅读条款，并选中接受" }
            },
            fields: {
                'txtPhone': '手机号码:required;mobile',
                'txtValiCode': '验证码:required',
                'txtEmail': '邮箱:required;email',
                'txtCmpName': '公司名称:required',
                'txtPwd1': '密码:required;password',
                'txtPwd2': '确认密码:required;password;match[txtPwd1]',
                'checkbox': 'checked[1]'
            }
        }).on('valid.form', function () {
            $.post('', {
                op: 2,
                phone: $('#txtPhone').val(),
                valicode: $('#txtValiCode').val(),
                email: $('#txtEmail').val(),
                cmpname: $('#txtCmpName').val(),
                pwd: md5($('#txtPwd1').val()),
                invi: $('#txtInvitation').val()
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
