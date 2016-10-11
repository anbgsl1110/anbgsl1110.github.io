<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="SignTemplate.aspx.cs" Inherits="Weetop.Web.member.SignTemplate" %>

<%@ Import Namespace="Weetop.DAL" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">




    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />服务管理 &gt; 签名模板管理</div>

        <div class="fwgl_dxmb">
            <div class="fwgl_dxmb_bt clearfix">
                <span>
                    <input type="text" class="text" id="searchText" placeholder="请输入模板名搜索"><input type="button" value="" id="btnSearch" class="anniu"></span>
                <a href="javascript:void(0)" class="run" id="demoBtn2">新增模板</a>
            </div>
            <div id="hy_fwgl_demo">
                <div class="hy_fwgl_xzdx">
                    <form id="signform">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td width="17%" align="right"><span style="color: #FF0004;">*</span>模板名称：</td>
                                    <td width="83%">
                                        <input type="text" class="text" name="title" maxlength="30" placeholder="请输入模板名称，不超过30个字符"></td>
                                </tr>
                                <tr>
                                    <td width="17%" align="right" valign="top"><span style="color: #FF0004;">*</span>模板内容：</td>
                                    <td width="83%">
                                        <input type="text" class="text" name="cont" maxlength="8" placeholder="请输入签名，3到8个字符">
                                        <p>&nbsp;</p>
                                        <p>
                                            * 建议使用公司或产品名称，不能包含违禁词汇与其他特殊符号<br>
                                            * 输入多个签名 请在输入完一个签名后 按回车键确定<br>
                                            * 单个签名长度介于3到8个字符之间<br>
                                            * 可以包含汉字、数字、英文，不能为纯数字、纯英文、数字英文组合<br>
                                            * 无须添加【】、()、[]符号，短信发送会自带【】、()、[]符号，避免重复
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top">签名用途：</td>
                                    <td>
                                        <p>
                                            <label>
                                                <input type="radio" name="Useage" value="1" id="RadioGroup3_0" checked="">
                                                &nbsp;自有产品或业务名</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                            <label>
                                                <input type="radio" name="Useage" value="2" id="RadioGroup3_1">
                                                &nbsp;他人产品或业务名</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                            <label>
                                                <input type="radio" name="Useage" value="3" id="RadioGroup3_2">
                                                &nbsp;其它</label>
                                        </p>
                                        <p>&nbsp;</p>
                                        <p>
                                            * "其它"说明:是他人产品或业务名且公司是媒体.报社.学校.医院.机关事业单位请选择<br>
                                            * 请根据签名内容正确选择，避免审核不通过
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top"><span style="color: #FF0004;">*</span>选择产品：</td>
                                    <td>
                                        <p>
                                            <select name="pro">
                                                <option value="0">请选择产品</option>
                                                <% foreach (var item in proList)
                                                    { %>
                                                <option value="<%= item.ProId %>"><%= SiteProduct.GetPName(item.ProId) %></option>
                                                <% } %>
                                            </select>
                                        </p>
                                        <p>&nbsp;</p>
                                        <p>* 若无产品服务，请先开通</p>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" valign="top"><span style="color: #FF0004;">*</span>申请说明：</td>
                                    <td>
                                        <p>
                                            <textarea class="text1" name="rem" maxlength="250" placeholder="250字"></textarea>
                                        </p>
                                    </td>
                                </tr>

                                <% if (validState != (int)AuthValidState.已认证)
                                    { %>
                                <tr>
                                    <td align="right" valign="top">证明文件：</td>
                                    <td>
                                        <p style="margin-bottom: 8px;">
                                            <input type="file" name="file1" id="file1">
                                        </p>
                                        <p style="margin-bottom: 8px;">
                                            <input type="file" name="file2" id="file2">
                                        </p>
                                        <p style="margin-bottom: 8px;">
                                            <input type="file" name="file3" id="file3">
                                        </p>
                                        <p>&nbsp;</p>
                                        <p>
                                            * 需要上传　<a href="javascript:;">组织机构代码证</a>、<a href="javascript:;">税务登记证</a>、<a href="javascript:;">企业营业执照</a><br>
                                            * 支持jpg、png、gif、jpeg格式的图片，每张图片不大于2MB<br>
                                            * 注：审计预计将在1个工作日内完成
                                        </p>
                                    </td>
                                </tr>
                                <% }
                                    else
                                    { %>
                                <tr>
                                    <td></td>
                                    <td>帐号已通过认证，无需上传证明文件。</td>
                                </tr>
                                <% } %>

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
                            <th width="15%" scope="col">模板名称</th>
                            <th width="15%" scope="col">模板内容</th>
                            <th width="15%" scope="col">签名用途</th>
                            <th width="5%" scope="col">EXTNO</th>
                            <th width="15%" scope="col">申请时间</th>
                            <th width="10%" scope="col">审核状态</th>
                            <th width="10%" scope="col">消息</th>
                            <th width="5%" scope="col">操作</th>
                        </tr>

                    </tbody>
                </table>
                <div class="page"></div>

            </div>

        </div>

    </div>


    <script id="listTmpl" type="text/x-jsrender">
        <tr>
            <td>{{: title }}</td>
            <td>{{: content }}</td>
            <td>{{: useage }}</td>
            <td>{{: extno }}</td>
            <td>{{: date }}</td>
            <td><em class="{{: ~getClass(status) }}"></em>{{: statusTxt }}</td>
            <td>{{: feedback }}</td>
            <td><a href="javascript:;" class="delRow" data-id="{{: id }}">删除</a></td>
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
                            <th width="15%" scope="col">模板名称</th>\
                            <th width="15%" scope="col">模板内容</th>\
                            <th width="15%" scope="col">签名用途</th>\
                            <th width="5%" scope="col">EXTNO</th>\
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

            $.getJSON('SignTemplate',
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
                                    $.getJSON('SignTemplate',
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
                    title: "添加签名模板",
                    drag: false
                });

                //提交
                $('#signform').validator({
                    stopOnError: true,
                    theme: 'yellow_right',
                    messages: {
                        required: "{0}要的哦"
                    },
                    fields: {
                        title: 'required,length[~30]',
                        cont: 'required,length[3~8]',
                        pro: 'required(not, 0)',
                        //rem: 'required,length[~250]'
                    }
                }).on('valid.form', function () {

                    var fileObj = $('#file1')[0];
                    if (fileObj && !(fileObj.files && fileObj.files[0])) {
                        Lay.showErr("请上传证明文件");
                        return false;
                    }
                    fileObj = $('#file2')[0];
                    if (fileObj && !(fileObj.files && fileObj.files[0])) {
                        Lay.showErr("请上传证明文件");
                        return false;
                    }
                    fileObj = $('#file3')[0];
                    if (fileObj && !(fileObj.files && fileObj.files[0])) {
                        Lay.showErr("请上传证明文件");
                        return false;
                    }

                    loading = Lay.showLoading('正在提交');

                    $("#signform").ajaxSubmit({
                        url: 'SignTemplate',
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
                $.post('SignTemplate', { ac: 3, tid: id }, function (jdata) {
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
