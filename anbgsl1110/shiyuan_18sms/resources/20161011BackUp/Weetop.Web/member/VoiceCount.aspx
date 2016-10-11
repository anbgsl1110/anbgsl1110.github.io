<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="VoiceCount.aspx.cs" Inherits="Weetop.Web.member.VoiceCount" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">


    <style type="text/css">
        .ywtj_yzm .anniu {
            background: #fa800a;
            width: 120px;
            height: 35px;
            line-height: 35px;
            border-radius: 3px;
            color: #fff;
            font-size: 13px;
            border: 0px;
            cursor: pointer;
        }

        .xdsoft_datetimepicker .xdsoft_year {
            width: 50px;
        }
    </style>


    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />业务统计 &gt; 验证码发送统计</div>

        <div class="ywtj_yzm">
            <div class="ywtj_yzm_bt">
                <label>
                    <input type="radio" name="rdoDateSpan" value="1" style="vertical-align: middle;">&nbsp;近7天</label>&nbsp;&nbsp;&nbsp;&nbsp;
                <label>
                    <input type="radio" name="rdoDateSpan" value="2" style="vertical-align: middle;">&nbsp;近30天</label>&nbsp;&nbsp;&nbsp;&nbsp;
                <label>
                    <input type="radio" name="rdoDateSpan" value="3" style="vertical-align: middle;">&nbsp;时间区间</label>&nbsp;&nbsp;&nbsp;&nbsp;
                <input class="jcDate" id="dt1" style="width: 100px; height: 20px; line-height: 20px; padding: 4px; border: 1px solid #ccc;" />
                <input class="jcDate" id="dt2" style="width: 100px; height: 20px; line-height: 20px; padding: 4px; border: 1px solid #ccc;" />
                &nbsp;&nbsp;<input type="button" id="btnChart" value="查询" class="anniu">
            </div>
            <div class="ywtj_yzm1" style="width: 895px; height: 895px;">
                <canvas id="chart-area" width="300" height="300" />
            </div>

        </div>

        <div class="ywtj_dx" style="margin-top: 20px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                    <tr>
                        <td width="34%">手机号：<input type="text" name="" id="phone" maxlength="11" class="text"></td>
                        <td width="34%">时间：<input type="text" name="" id="dt3" class="text"></td>
                        <td width="32%">
                            <input type="button" id="btnList" value="查询" class="anniu"></td>
                    </tr>
                </tbody>
            </table>

        </div>

        <div class="ywtj_yzm3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                    <tr>
                        <th scope="col" width="15%">发送时间</th>
                        <th scope="col" width="15%">接收时间</th>
                        <th scope="col" width="10%">发送状态</th>
                        <th scope="col" width="60%">内容</th>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="page"></div>
        <%--<div class="ywtj_yzm4"><a href="#">下载报表</a></div>--%>
    </div>


    <script id="listTmpl" type="text/x-jsrender">
        <tr>
            <td>{{: date1 }}</td>
            <td>{{: date2 }}</td>
            <td>{{: stat }}</td>
            <td>{{: txt }}</td>
        </tr>

    </script>

    <script type="text/javascript">

        var myChart = null;//图表实例
        var loading = null;


        function InitChart() {

            var rdoval = $('input[name=rdoDateSpan]:checked').val();
            var dt1, dt2 = moment().format('YYYY-MM-DD');
            switch (rdoval) {
                case '1':
                    dt1 = moment().add(-7, 'days').format('YYYY-MM-DD');
                    break;
                case '2':
                    dt1 = moment().add(-30, 'days').format('YYYY-MM-DD');
                    break;
                default:
                    dt1 = $('#dt1').val();
                    dt2 = $('#dt2').val();
                    if (dt1 === "" || dt2 === "") {
                        Lay.showErr("时间区间不能为空");
                        return false;
                    }
                    break;
            }

            $.getJSON('VoiceCount',
                { op: 1, dt1: dt1, dt2: dt2 },
                function (jdata, state, xhr) {
                if (state == 'success') {
                    switch (jdata.code) {
                        case 'OK':
                            if (myChart) {
                                config.datasets[0].data = jdata.data.datasets[0].data;
                                myChart.update();
                            } else {
                                config = jdata.data;
                                myChart = new Chart($("#chart-area"), { type: 'pie', data: config });
                            }
                            break;
                        default:
                            Lay.showErr(jdata.message);
                            break;
                    }
                } else {
                    Lay.showErr("数据加载失败");
                }
                if (loading) Lay.close(loading);
            });

        }

        function loadData(data) {
            var head = '<tr>\
                            <th scope="col" width="15%">发送时间</th>\
                            <th scope="col" width="15%">接收时间</th>\
                            <th scope="col" width="10%">发送状态</th>\
                            <th scope="col" width="60%">内容</th>\
                        </tr>';

            var tmpl = $.templates("#listTmpl");
            var html = head + tmpl.render(data);
            $('.ywtj_yzm3 tbody').html(html);
        }

        function InitDataList() {

            var phone = $('#phone').val();
            var dt3 = $('#dt3').val();
            if (phone === "" || dt3 === "") {
                Lay.showErr("手机号和时间不能为空");
                return false;
            }

            $.getJSON('VoiceCount',
                { op: 2, page: 1, phone: phone, dt: dt3 },
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
                                    $.getJSON('VoiceCount',
                                        { op: 2, page: num, phone: phone, dt: dt3 },
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
                    if (loading) Lay.close(loading);
                });
        }


        $(function () {
            $('input[name=rdoDateSpan][value=1]').prop('checked', true);

            $('#dt1,#dt2').on('focus', function () {
                $('input[name=rdoDateSpan][value=3]').prop('checked', true);
            });
            $('#dt1,#dt2').datetimepicker({
                lang: 'cn',
                timepicker: false,
                format: 'Y-m-d',
                formatDate: 'Y/m/d',
                //minDate: '-1970/01/01', // yesterday is minimum date
                maxDate: '+1970/01/01' // and tommorow is maximum date calendar
            });
            $('#dt3').datetimepicker({
                lang: 'cn',
                timepicker: false,
                format: 'Y-m-d',
                formatDate: 'Y/m/d',
                minDate: '-1970/01/07', //只能查前7天
                maxDate: '+1970/01/01' // and tommorow is maximum date calendar
            });

            $('#btnChart').on('click', function () {
                loading = Lay.showLoading();
                InitChart();
            });

            //只能输入纯数字
            $('#phone').on('keydown', function (e) {
                var key = e.which || e.keyCode || 0;
                //console.log(key);
                if (key && key === 8 || key === 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105)) {//退格，删除，纯数字
                } else {
                    e.preventDefault();
                }
            });

            $('#btnList').on('click', function () {
                loading = Lay.showLoading();
                InitDataList();
            });


            loading = Lay.showLoading();
            InitChart();
        });
    </script>


</asp:Content>
