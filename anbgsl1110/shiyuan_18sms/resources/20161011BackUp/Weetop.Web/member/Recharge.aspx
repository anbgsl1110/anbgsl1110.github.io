<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="Recharge.aspx.cs" Inherits="Weetop.Web.member.Recharge" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">




    <div>
    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />用户中心 &gt; 充值</div>

        <div class="cz_yyxz">
            <div class="cz_yyxz_bt">应用选择</div>
            <ul class="clearfix">
                <li class="dx" data-pid="1"><span></span>短信验证码/通知</li>
                <li class="gj" data-pid="3"><span></span>国际短信验证码</li>
                <li class="yy" data-pid="4"><span></span>语音验证码</li>
                <%--<li class="hyyx" data-pid="2"><span></span>会员营销短信</li>
                <li class="sj" data-pid="5"><span></span>手机流量推广</li>--%>
            </ul>
        </div>

        <div class="cz_tcxz cz_tcxz_dx">
            <div class="cz_tcxz_bt">套餐选择</div>
            <ul class="clearfix">
                <li data-cm="4060" data-cc="70000">
                    <h1><b>原价:4200元<em></em></b><span><i>特惠包</i>RMB</span>4060</h1>
                    <p>包含验证码短信70,000条</p>
                </li>
                <li data-cm="7950" data-cc="150000">
                    <h1><b>原价:8700元<em></em></b><span><i>超值包</i>RMB</span>7950</h1>
                    <p>包含验证码短信150,000条</p>
                </li>
                <li data-cm="12000" data-cc="250000">
                    <h1><b>原价:13250元<em></em></b><span><i>至尊包</i>RMB</span>12000</h1>
                    <p>包含验证码短信250,000条</p>
                </li>
            </ul>
        </div>

        <div class="cz_tcxz cz_tcxz_gj" style="display:none;">
            <div class="cz_tcxz_bt">套餐选择</div>
            <ul class="clearfix">
                <li data-cm="8000" data-cc="10000">
                    <h1><span><i>优惠包</i>RMB</span>8000</h1>
                    <p>包含验证码短信10,000条</p>
            </ul>
        </div>
        
        <div class="cz_tcxz cz_tcxz_yy" style="display:none;">
            <div class="cz_tcxz_bt">套餐选择</div>
            <ul class="clearfix">
                <li data-cm="1800" data-cc="30000">
                    <h1><span><i>优惠包</i>RMB</span>1800</h1>
                    <p>包含验证码短信30,000条</p>
                </li>
                <li data-cm="4060" data-cc="70000">
                    <h1><b>原价:4200元<em></em></b><span><i>特惠包</i>RMB</span>4060</h1>
                    <p>包含验证码短信70,000条</p>
                </li>
                <li data-cm="9900" data-cc="180000">
                    <h1><b>原价:10440元<em></em></b><span><i>超值包</i>RMB</span>9900</h1>
                    <p>包含验证码短信180,000条</p>
                </li>
                <li data-cm="20000" data-cc="400000">
                    <h1><b>原价:22000元<em></em></b><span><i>至尊包</i>RMB</span>20000</h1>
                    <p>包含验证码短信400,000条</p>
                </li>
            </ul>
        </div>

        <div class="cz_tcxz cz_tcxz_ll" style="display:none;">
            <div class="cz_tcxz_bt">套餐选择</div>
            <ul class="clearfix">
                <li data-cm="5800" data-cc="100000">
                    <h1><span><i>优惠包</i>RMB</span>5803</h1>
                    <p>包含验证码短信100,000条</p>
                    <!--此处定位删除线背景图盒子-->
                </li>
                <li data-cm="10600" data-cc="200000">
                    <h1><b>原价:11600元<em></em></b><span><i>特惠包</i>RMB</span>10600</h1>
                    <p>包含验证码短信200,000条</p>
                </li>
                <li data-cm="14400" data-cc="300000">
                    <h1><b>原价:17400元<em></em></b><span><i>超值包</i>RMB</span>14400</h1>
                    <p>包含验证码短信300,000条</p>
                </li>
                <%-- <li data-cm="20000" data-cc="500000">
                    <h1><b>原价:27500元<em></em></b><span><i>至尊包</i>RMB</span>20000</h1>
                    <p>包含验证码短信500,000条</p>
                </li> --%>
            </ul>
        </div>

        <div class="cz_je">
            <div class="cz_je_bt">输入金额<span>注：以上套餐不在充值范围内时，可手动充值，系统将自动匹配条数。</span></div>
            <p>
                充值金额：<input type="number" class="text" value="" step="1" min="1" max="1000000" id="chargeMy">
                元<span>充值汇总：<strong class="yellow">0</strong>元<%--（含赠送金额90元）--%></span>
            </p>
            <p><em>充值金额，包含验证码短信<i style="color: inherit;">0</i>条</em></p>
            <p><i class="yellow">提示：</i>单笔充值金额充值金额1000起，最大不超过1,000,000元。</p>
        </div>


        <div class="cz_fkfs">
            <div class="cz_fkfs_bt">付款方式</div>
            <p>
                <input type="radio" name="RadioGroup2" value="1" checked="checked" id="RadioGroup2_0">
                <img src="../images/zhifubao.png" alt="" /><span style="display: inline-block; width: 30px;"></span>
                <%--<input type="radio" name="RadioGroup2" value="2" id="RadioGroup2_1">--%>
                <%--<img src="../images/yinlian.png" alt="" />--%>
            </p>
            <p>
                <input type="button" id="payNow" value="立即支付" class="anniu">
            </p>
        </div>

    </div>


    <script>
        $(function () {
            $(".cz_yyxz ul li").addClass("hui").removeClass("on");

            //应用选择
            $(".cz_yyxz ul li").click(function () {
                var pid = $(this).data('pid');
                if (pid == 2 || pid == 5) return false;
                $(this).addClass("on").removeClass("hui").siblings().addClass("hui").removeClass("on");
                $(this).addClass("Atypes").siblings().addClass("").removeClass("Atypes");
            });


            //套餐选择
            $(".cz_tcxz ul li").click(function () {
                $(this).addClass("on").siblings().removeClass("on");
                $('.cz_je #chargeMy').val($(this).data('cm'));
                $('.cz_je strong.yellow').text($(this).data('cm'));
                $('.cz_je p>em>i').text($(this).data('cc'));
            });

            //应用对应套餐
            $(".cz_yyxz ul li.dx").click(function () {
                $(".cz_tcxz").hide(); $(".cz_tcxz_dx").show(); $(".cz_tcxz_dx ul li").click();
            });
            $(".cz_yyxz ul li.gj").click(function () {
                $(".cz_tcxz").hide(); $(".cz_tcxz_gj").show(); $(".cz_tcxz_gj ul li").click();
            });
            $(".cz_yyxz ul li.yy").click(function () {
                $(".cz_tcxz").hide(); $(".cz_tcxz_yy").show(); $(".cz_tcxz_yy ul li").click();
            });
            $(".cz_yyxz ul li.ll").click(function () {
                $(".cz_tcxz").hide(); $(".cz_tcxz_ll").show(); $(".cz_tcxz_ll ul li").click();
            });


            //计算短信条数，实时监听输入框值变化
            $('.cz_je').on('change input propertychange', '#chargeMy', function (e) {
                $('.cz_je strong.yellow').text($(this).val());
                $.getJSON('Recharge', { op: 1, m: $(this).val(), pid: $(".Atypes").data('pid') }, function (jdata, textStatus) {
                    if (jdata.code === "OK")
                        $('.cz_je p>em>i').text(jdata.message);
                });
            });

            //只能输入纯数字
            $('.cz_je').on('keydown', '#chargeMy', function (e) {
                var key = e.which || e.keyCode || 0;
                //console.log(key);
                if (key && key === 8 || key === 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105)) {//退格，删除，纯数字
                } else {
                    e.preventDefault();
                }
            });

            dj = 0;
            $('#payNow').on('click', function (e) {
                var pid = $(".cz_yyxz ul li.on").data('pid');
                var my = $('.cz_je #chargeMy').val();
                var paytype = $('input[type=radio]:checked').val();
                   

                if (!pid || (pid <= 0 || pid > 5)) {
                    Lay.showWarn('请选择要充值的应用');
                    return false;
                } else if (!my || my <= 0) {
                    Lay.showWarn('充值金额无效');
                    return false;
                } else if (!paytype) {
                    Lay.showWarn('请选择付款方式');
                    return false;
                } else if (my < 1000) {
                    Lay.showWarn('充值金额应大于一千元');
                    return false;
                } else if (my < 10000 && my >= 1000) {
                    if (dj == 0) {
                        Lay.showWarn('您当前充值金额不满一万，您可以充值到一万以获得一次抽奖机会');
                        dj++;
                        return false;
                    } 
                    
                } else if (my%10000!=0) {
                    var num = parseInt(my / 10000);
                    var num2 = (num + 1) * 10000;
                    if (dj == 0) {
                        Lay.showWarn('您当前充值金额为'+my+'，现在有'+num+'次抽奖机会,您是否充值到'+num2+'以获得'+(num+1)+'次抽奖机会');
                        dj++;
                        return false;
                    }

                }

                Lay.showLoading("正在支付，请等待页面跳转");
                $.post('Recharge', { op: 2, pid: pid, m: my, pt: paytype }, function (data) {
                    if (data.indexOf('{') === 0) {
                        var jdata = JSON.parse(data);
                        switch (jdata.code) {
                            case "Err":
                                Lay.showErr(jdata.message);
                                break;
                        }
                    } else {
                        //$('body').after(data);
                        document.write(data);
                    }
                });
            });



            //页面加载时初始化
            if (window.CurProId > 0) {
                $(".cz_yyxz ul li[data-pid=" + CurProId + "]").addClass("on").removeClass("hui").siblings().addClass("hui").removeClass("on");
                $(".cz_tcxz ul li").eq(0).click();
                window.CurProId = 0;
            }
        });
    </script>


    </div>

</asp:Content>
