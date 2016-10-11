<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="SmsTemplate.aspx.cs" Inherits="Weetop.Web.member.SmsTemplate" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">

    <style type="text/css">
        .fwgl_dxmb_lb table tr td {
            border-bottom: 0 dashed #ccc;
        }
    </style>


    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />服务管理 &gt; 短信模板管理</div>

        <div class="fwgl_dxmb">
            <div class="fwgl_dxmb_bt clearfix">
                <span>
                    <input type="text" class="text" id="searchText" placeholder="请输入模板名搜索"><input type="button" value="" id="btnSearch" class="anniu"></span>
                <a href="javascript:void(0)" class="run" id="demoBtn2">新增模板</a>
            </div>
            <div id="hy_fwgl_demo">
                <div class="hy_fwgl_xzdx">
                    <form id="smsform">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td width="17%" align="right"><span style="color: #FF0004;">*</span>模板名称：</td>
                                    <td width="83%">
                                        <input type="text" class="text" name="title" maxlength="30" placeholder="请输入模板名称，不超过30个字符"></td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top">模板类型：</td>
                                    <td>
                                        <p>
                                            <label>
                                                <input type="radio" name="SmsType" value="1" id="RadioGroup3_0" checked="">
                                                &nbsp;验证码</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                            <label>
                                                <input type="radio" name="SmsType" value="2" id="RadioGroup3_1">
                                                &nbsp;短信通知</label>
                                        </p>
                                        <p>&nbsp;</p>
                                        <p>* 模板内容含有注册码\验证码\校验码\激活码，请选择"验证码"，避免审核不通过</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top"><span style="color: #FF0004;">*</span>选择签名：</td>
                                    <td>
                                        <p>
                                            <select name="sign">
                                                <option value="0">请选择签名</option>
                                                <% foreach (var item in signList)
                                                    { %>
                                                <option value="<%= item.Id %>">【<%= item.Content %>】</option>
                                                <% } %>
                                            </select>
                                        </p>
                                        <p>&nbsp;</p>
                                        <p>* 若无签名，请前往签名模板管理新增签名</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top"><span style="color: #FF0004;">*</span>模板内容：</td>
                                    <td>
                                        <p>
                                            <textarea class="text1" name="cont" maxlength="290" placeholder="变量格式：${name}; 示例：尊敬的${name}，您的快递已飞奔的路上，将在今天${time}送达您的手里，请注意接收"></textarea>
                                        </p>
                                        <p>&nbsp;</p>
                                        <p>
                                            * 代表任意多个字符，\d*代表任意多个数字，(a|b)代表任意a或者b。 例如： .*(你好|您好)，您的验证码是\d*<br>
                                            * 变量格式如${name}，不能使用${email},${mobile},${id},${nick},${site}<br>
                                            * 请勿在变量中添加特殊符号,如: , . # / : - ，。<br>
                                            * 如有链接，请将链接地址写于模板内容中，便于核实<br>
                                            * 模板内容无须添加签名,内容首尾不能添加[],【】符号,调用接口时传入签名即可<br>
                                            * 支持TD或T或N进行短信退订回复,其它参数回复不支持<br>
                                            * 短信字数&lt;=70个字数，按照70个字数一条短信计算<br>
                                            * 短信字数&gt;70个字数，即为长短信，按照67个字数记为一条短信计算
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top">申请说明：</td>
                                    <td>
                                        <p>
                                            <textarea name="rem" class="text1" maxlength="250" placeholder="250字"></textarea>
                                        </p>
                                        <p>&nbsp;</p>
                                        <p>注：审计预计将在1个工作日内完成 </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">&nbsp;</td>
                                    <td>
                                        <input type="submit" class="anniu" value="提交"><p>&nbsp;</p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>


            <div class="fwgl_dxmb_lb">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tbody>
                        <tr>
                            <th width="20%" scope="col">模板名称</th>
                            <%--<th width="35%" scope="col">模板内容</th>--%>
                            <th width="10%" scope="col">模板类型</th>
                            <th width="15%" scope="col">申请时间</th>
                            <th width="10%" scope="col">审核状态</th>
                            <th width="10%" scope="col">消息</th>
                            <th width="5%" scope="col">操作</th>
                        </tr>

                    </tbody>
                </table>
                <%--<div id="hy_fwgl_demo1">
                    <div class="hy_fwgl_xzdx">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td width="5%" align="right"></td>
                                    <td width="95%">模板名称：身份验证验证码</td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top"></td>
                                    <td>模板ID：SMS_8155659</td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top"></td>
                                    <td><span style="color: #FF0004;">*</span>模板内容：验证码${code}，您正在进行${product}身份验证，打死不要告诉别人哦！</td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                </div>--%>


                <div class="page"></div>

            </div>

        </div>

    </div>


    <script id="listTmpl" type="text/x-jsrender">
        <tr>
            <td>{{: title }}</td>
            <td>{{: smstype }}</td>
            <td>{{: date }}</td>
            <td><em class="{{: ~getClass(status) }}"></em>{{: statusTxt }}</td>
            <td>{{: feedback }}</td>
            <td><a href="javascript:;" class="delRow" data-id="{{: id }}">删除</a>
            </td>
        </tr>
        <tr style="border-bottom: 1px solid #ccc">
            <td align="right" colspan="5">{{: content }}</td>
            <td></td>
        </tr>

    </script>


    <script>

        var loading = null;
        var curPage = 1;

        var UserHelper = {
            getClass: function (status) {
                switch (status) {
                    case 1:
                        return "sp";
                    case 2:
                        return "tg";
                    case 3:
                        return "sb";
                    default:
                        return "";
                }
            }
        };
        function loadData(data) {
            var head = '<tr>\
                            <th width="20%" scope="col">模板名称</th>\
                            <th width="10%" scope="col">模板类型</th>\
                            <th width="15%" scope="col">申请时间</th>\
                            <th width="10%" scope="col">审核状态</th>\
                            <th width="10%" scope="col">消息</th>\
                            <th width="5%" scope="col">操作</th>\
                        </tr>';

            var tmpl = $.templates("#listTmpl");
            var html = head + tmpl.render(data, UserHelper);
            $('.fwgl_dxmb_lb tbody').html(html);
        }


        function InitDataList() {

            var searchText = $('#searchText').val();

            $.getJSON('SmsTemplate',
                { ac: 2, page: curPage, st: searchText },
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
                                page: curPage, //当前页数
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
                                    $.getJSON('SmsTemplate',
                                        { ac: 2, page: num, st: searchText },
                                        function (jdata, state, xhr) {
                                            if (state == 'success') {
                                                curPage = num;
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
                    if (loading) Lay.close(loading);
                });
        }



        $(function () {

            $('#btnSearch').on('click', function () {
                loading = Lay.showLoading();
                curPage = 1;//重置当前页
                InitDataList();
            });

            $("#demoBtn2").click(function () {
                $("#hy_fwgl_demo").layerModel({
                    title: "添加短信模板",
                    drag: false
                });


                //提交
                $('#smsform').validator({
                    stopOnError: true,
                    theme: 'yellow_right',
                    messages: {
                        required: "{0}要的哦"
                    },
                    fields: {
                        title: 'required,length[~30]',
                        cont: 'required,length[~290]',
                        sign: 'required(not, 0)',
                        rem: 'length[~250]'
                    }
                }).on('valid.form', function () {

                    loading = Lay.showLoading('正在提交');

                    $("#smsform").ajaxSubmit({
                        url: 'SmsTemplate',
                        data: { ac: 1 },
                        type: 'post',
                        dataType: 'json',
                        success: function (jdata, statusText) {
                            if (jdata.code == "OK") {
                                Lay.showMsg(jdata.message);
                                $('#btnSearch').click();
                                $('.layerModel_closeBtn').click();
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

            });

            $('.fwgl_dxmb_lb').on('click', '.delRow', function () {
                loading = Lay.showLoading('正在删除');
                var id = $(this).data('id');
                $.post('SmsTemplate', { ac: 3, tid: id }, function (jdata) {
                    switch (jdata.code) {
                        case 'OK':
                            Lay.showMsg(jdata.message);
                            //加载数据
                            InitDataList();
                            reHeight();//重新计算左导航高度
                            break;
                        default:
                            Lay.showErr(jdata.message);
                            break;
                    }
                    if (loading) Lay.close(loading);
                }, 'json');
            });

            InitDataList();
        });
    </script>

</asp:Content>
