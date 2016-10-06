<%@ Page Title="会员管理" Language="C#" MasterPageFile="~/CMS/BasePage.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="Weetop.Web.CMS.UserList" %>

<%@ Import Namespace="Weetop.DAL" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="/static/dep/assets/css/chosen.css" rel="stylesheet" />
    <link href="/static/dep/assets/css/bootstrap-datepicker3.css" rel="stylesheet" />
    <link href="/static/dep/assets/css/daterangepicker.css" rel="stylesheet" />
    <%--<link href="/static/dep/validator/jquery.validator.css" rel="stylesheet" />--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <div class="page-header">
        <h1><%: Page.Title %> 
            <small>
                <i class="ace-icon fa fa-angle-double-right"></i>
                信息列表
            </small>
        </h1>
    </div>
    <!-- /.page-header -->

    <div class="row">
        <div class="col-xs-12">
            <form runat="server" autocomplete="off">

                <div class="clearfix">
                    <div class="pull-left tableTools-container">
                        <span style="float: left; margin-right: 10px;">
                            <asp:DropDownList ID="ddlCheckStatus" AutoPostBack="true" CssClass="form-control" runat="server"></asp:DropDownList>
                        </span>
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input class="form-control" style="width: 300px; max-width: 100%;" id="txtDateRange" placeholder="按时间段筛选：注册日期" runat="server" type="text" name="date-range-picker" />
                            <asp:LinkButton ID="btnDate" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                        <span class="input-icon input-icon-right" style="float: left; margin-right: 10px;">
                            <input id="txtSearch" type="text" autocomplete="off" maxlength="150" style="width: 300px;" class="form-control" runat="server" placeholder="输入搜索：帐号、姓名、手机、邮箱" />
                            <asp:LinkButton ID="btnSearch" CssClass="ace-icon" runat="server"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                    </div>
                </div>

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnLoad="UpdatePanel1_Load">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlCheckStatus" />
                        <asp:AsyncPostBackTrigger ControlID="txtSearch" />
                        <asp:AsyncPostBackTrigger ControlID="btnSearch" />
                        <asp:AsyncPostBackTrigger ControlID="btnDate" />
                    </Triggers>
                    <ContentTemplate>

                        <asp:Repeater ID="Repeater1" runat="server">
                            <HeaderTemplate>
                                <table id="mytable" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>电话</th>
                                            <th>邮箱</th>
                                            <th class="hidden-480 hidden-xs hidden-sm hidden-md">名称</th>
                                            <th class="center hidden-480 hidden-xs hidden-sm hidden-md">活跃度</th>
                                            <th class="hidden-480 hidden-xs hidden-sm hidden-md">注册日期</th>
                                            <th class="hidden-480 hidden-xs hidden-sm hidden-md">上次登陆</th>
                                            <th class="center hidden-xs hidden-sm">认证信息</th>
                                            <%--<th class="center hidden-xs hidden-sm">认证状态</th>--%>
                                            <th class="center hidden-xs">状态</th>
                                            <th class="hidden-480 hidden-xs"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr id="<%# Eval("UserId") %>">
                                    <td><%# Eval("Phone") %></td>
                                    <td><%# Eval("Email") %></td>
                                    <td class="hidden-480 hidden-xs hidden-sm hidden-md"><%# Eval("NickName") %></td>
                                    <td class="center hidden-480 hidden-xs hidden-sm hidden-md"><%# SiteFundsHistory.GetSuccMoney( Guid.Parse(Eval("UserId").ToString()) ).HasValue ? "活跃用户" : "潜在用户" %></td>
                                    <td class="hidden-480 hidden-xs hidden-sm hidden-md"><%# Eval("CreateDate") %></td>
                                    <td class="hidden-480 hidden-xs hidden-sm hidden-md"><%# Eval("LastLogin") %></td>
                                    <td class="center hidden-xs hidden-sm"><%# GetLink(Guid.Parse(Eval("UserId").ToString()), AspNetPager1.CurrentPageIndex) %></td>

                                    <%--<%# GetLink(Guid.Parse(Eval("UserId").ToString()), AspNetPager1.CurrentPageIndex) %></td>--%>
                                    <%--<td class="center hidden-xs hidden-sm">
                                        <label>
                                            <input <%# (bool)Eval("InfoValid") ? "checked='checked'" : "" %> class="ace ace-switch valid ace-switch-4 btn-flat btn-empty" type="checkbox" />
                                            <span class="lbl middle" data-lbl=" 是          否"></span>
                                        </label>
                                    </td>--%>
                                    <td class="center hidden-xs">
                                        <% if (isState)
                                              {%>
                                                    <label>
                                                    <input <%# (bool)Eval("Enabled") ? "checked='checked'" : "" %> class="ace ace-switch enable ace-switch-4 btn-flat btn-empty" type="checkbox" />
                                                    <span class="lbl middle" data-lbl="启用       禁用"></span>
                                                    </label>
                                              <%} else
                                               {%>
                                                    <label><%# (bool)Eval("Enabled") ? "启用" : "禁用" %></label>
                                              <% }%>
                                    </td>
                                    <td class="action-buttons hidden-480 hidden-xs center">
                                        <%foreach (var item2 in list)
                                          {
                                               if (item2.PrivilegeCode == "FW")
                                              {%>
                                                  <a href='#modal-form' role='button' onclick='javascript:Bind("<%# Eval("UserId") %>");' data-toggle='modal' title="详细信息">
                                                   <i class="ace-icon fa fa-search-plus bigger-130"></i>
                                                  </a>
                                              <%}
                                                
                                                if (item2.PrivilegeCode == "SC")
                                              {%>
                                                   <a class="red" href="javascript:ConfirmDel('<%# Eval("UserId") %>');" title="删除">
                                                    <i class="ace-icon fa fa-trash-o bigger-130"></i>
                                                   </a>
                                              <%} 
                                              if(item2.PrivilegeCode == "XG")
                                              {%>
                                                   <a class="green" href="javascript:assortServicePerson('<%# Eval("UserId") %>');" title="分配服务人员">
                                                    <i class="ace-icon fa fa-edit bigger-130"></i>
                                                   </a>                                              
                                              <%}
                                          } %>
                                    </td>
                                </tr>

                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>

                        <div class="pagination center">
                            <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
                                NextPageText="下一页" OnPageChanging="AspNetPager1_PageChanging" AlwaysShow="true" CurrentPageButtonClass="active"
                                PrevPageText="上一页" TextAfterPageIndexBox="页" TextBeforePageIndexBox="跳转到第">
                            </webdiyer:AspNetPager>
                        </div>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </form>


            <form id="modal-form" class="modal fade" tabindex="-1" data-backdrop="static" autocomplete="on">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="blue bigger">会员详细信息</h4>
                        </div>
                        <input type="hidden" id="hidUserId" value="" />
                        <div class="modal-body" id="userHtml">
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-sm" id="cancelForm" data-dismiss="modal">
                                <i class="ace-icon fa fa-times"></i>
                                关闭
                            </button>
                        </div>
                    </div>
                </div>
            </form>
                      
    <form class="modal fade" id="modal-form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" autocomplete="on">
      <div class="modal-dialog" style="width:800px">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close btn-xs" data-dismiss="modal" aria-hidden="true">x</button>
            <h5>
              给会员(<span id="assortUserId" style="color:red">###</span>)分配服务人员
            </h5>
          </div>
          <input type="hidden" id="hidUserId" name="hidUserId" />//用于向服务器传递UerId的值
          <div class="modal-body">
            <div class="row clearfix">
              <div class="col-md-12 column">
                <div class="clearfix">
                  <div class="pull-left tableTools-container">
                    <span style="float:left;">
                      <div class="dropdown">
                        <button type="button" class="btn btn-sm dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">查看全部
                          <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                          <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">客服</a>
                          </li>
                          <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">商务</a>
                          </li>
                          <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">运维</a>
                          </li>
                        </ul>
                      </div>
                    </span>
                  </div>
                </div>
                <div class="row clearfix">
                  <div class="col-md-6 column">
                    <table class="table table-bordered table-bordered table-hover table-condensed">
                      <thead>
                        <tr>
                          <th style="display:none">
                            id
                          </th>
                          <th style="display:none">
                            cateId
                          </th>
                          <th>
                            姓名
                          </th>
                          <th>
                            分类
                          </th>
                          <th>
                            操作
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td style="display:none">
                            1
                          </td>
                          <td style="display:none">
                            TB - Monthly
                          </td>
                          <td>
                            01/04/2012
                          </td>
                          <td>
                            Default
                          </td>
                          <td style="text-align:center">
                            <a href="javascript:btnDeletePerson();" class="btn btn-xs btn-warning" id="btnDelete" title="去除" role="button"><i class="ace-icon fa fa-minus bigger-130"></i>去除</a>
                          </td>
                        </tr>
                        <tr>
                          <td style="display:none">
                            1
                          </td>
                          <td style="display:none">
                            TB - Monthly
                          </td>
                          <td>
                            01/04/2012
                          </td>
                          <td>
                            Default
                          </td>
                          <td style="text-align:center">
                            <a href="javascript:btnDeletePerson();" class="btn btn-xs btn-warning" id="btnDelete" title="去除" role="button"><i class="ace-icon fa fa-minus bigger-130"></i>去除</a>
                          </td>
                        </tr>
                        <tr>
                          <td style="display:none">
                            1
                          </td>
                          <td style="display:none">
                            TB - Monthly
                          </td>
                          <td>
                            01/04/2012
                          </td>
                          <td>
                            Default
                          </td>
                          <td style="text-align:center">
                            <a href="javascript:btnDeletePerson();" class="btn btn-xs btn-warning" id="btnDelete" title="去除" role="button"><i class="ace-icon fa fa-minus bigger-130"></i>去除</a>
                          </td>
                        </tr>
                        <tr>
                          <td style="display:none">
                            1
                          </td>
                          <td style="display:none">
                            TB - Monthly
                          </td>
                          <td>
                            01/04/2012
                          </td>
                          <td>
                            Default
                          </td>
                          <td style="text-align:center">
                            <a href="javascript:btnDeletePerson();" class="btn btn-xs btn-warning" id="btnDelete" title="去除" role="button"><i class="ace-icon fa fa-minus bigger-130"></i>去除</a>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                    <span>
                      <p style="color:red">
                        【注意】请确保分配了一对客服和一对商务!
                      </p>
                    </span>
                    <blockquote class="pull-left">
                      <p><small id="time1"></small></p>
                    </blockquote>
                  </div>
                  <div class="col-md-6 column">
                    <table class="table table-striped table-bordered table-hover table-condensed">
                      <thead>
                        <tr>
                          <th style="display:none">
                            id
                          </th>
                          <th style="display:none">
                            cateId
                          </th>
                          <th>
                            姓名
                          </th>
                          <th>
                            分类
                          </th>
                          <th>
                            操作
                          </th>
                      </thead>
                      <tbody>
                        <tr>
                          <td style="display:none">
                            1
                          </td>
                          <td style="display:none">
                            TB - Monthly
                          </td>
                          <td>
                            01/04/2012
                          </td>
                          <td>
                            Default
                          </td>
                          <td style="text-align:center">
                            <a href="javascript:btnDeletePerson();" class="btn btn-xs btn-success" id="btnDelete" title="去除" role="button"><i class="ace-icon fa fa-plus bigger-130"></i>添加</a>
                          </td>
                        </tr>
                        <tr>
                         <td style="display:none">
                            1
                          </td>
                          <td style="display:none">
                            TB - Monthly
                          </td>
                          <td>
                            01/04/2012
                          </td>
                          <td>
                            Default
                          </td>
                          <td style="text-align:center">
                            <a href="javascript:btnDeletePerson();" class="btn btn-xs btn-success" id="btnDelete" title="去除" role="button"><i class="ace-icon fa fa-plus bigger-130"></i>添加</a>
                          </td>
                        </tr>
                        <tr>
                          <td style="display:none">
                            1
                          </td>
                          <td style="display:none">
                            TB - Monthly
                          </td>
                          <td>
                            01/04/2012
                          </td>
                          <td>
                            Default
                          </td>
                          <td style="text-align:center">
                            <a href="javascript:btnDeletePerson();" class="btn btn-xs btn-success" id="btnDelete" title="去除" role="button"><i class="ace-icon fa fa-plus bigger-130"></i>添加</a>
                          </td>
                        </tr>
                        <tr>
                          <td style="display:none">
                            1
                          </td>
                          <td style="display:none">
                            TB - Monthly
                          </td>
                          <td>
                            01/04/2012
                          </td>
                          <td>
                            Default
                          </td>
                          <td style="text-align:center">
                            <a href="javascript:btnDeletePerson();" class="btn btn-xs btn-success" id="btnDelete" title="去除" role="button"><i class="ace-icon fa fa-plus bigger-130"></i>添加</a>
                          </td>
                        </tr>
                        <tr>
                          <td style="display:none">
                            1
                          </td>
                          <td style="display:none">
                            TB - Monthly
                          </td>
                          <td>
                            01/04/2012
                          </td>
                          <td>
                            Default
                          </td>
                          <td style="text-align:center">
                            <a href="javascript:btnDeletePerson();" class="btn btn-xs btn-success" id="btnDelete" title="去除" role="button"><i class="ace-icon fa fa-plus bigger-130"></i>添加</a>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                    <ul class="pagination">
                      <li>
                        <a href="#">Prev</a>
                      </li>
                      <li>
                        <a href="#">1</a>
                      </li>
                      <li>
                        <a href="#">Next</a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-sm" data-dismiss="modal">
              <i class="ace-icon fa fa-times"></i>
              取消
            </button>
            <button class="btn btn-sm btn-primary"  data-toggle="modal" data-target="#modal-form">
              <i class="ace-icon fa fa-check"></i>
              确定
            </button>
          </div>
        </div>
    </form>


        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="Server">
    <script src="/static/dep/assets/js/chosen.jquery.js"></script>
    <script src="/static/dep/assets/js/date-time/moment.js"></script>
    <script src="/static/dep/assets/js/date-time/bootstrap-datepicker.js"></script>
    <script src="/static/dep/assets/js/date-time/daterangepicker.js"></script>
    <script src="/static/dep/jsrender.min.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" runat="Server">


    <script id="userTmpl" type="text/x-jsrender">
        {{if user == null}}
        <div class="center">无数据</div>
        {{else}}
        <table class="table table-striped table-bordered">
            <tr>
                <td align="right">电话：</td>
                <td>{{: user.Phone }}</td>
            </tr>
            <tr>
                <td align="right">邮箱：</td>
                <td>{{: user.Email }}</td>
            </tr>
            <tr>
                <td align="right">名称：</td>
                <td>{{: user.NickName }}</td>
            </tr>
            <tr>
                <td align="right">性别：</td>
                <td>{{: ~getSex(user.Sex) }}</td>
            </tr>
            <tr>
                <td align="right">公司名称：</td>
                <td>{{: user.CompanyName }}</td>
            </tr>
        </table>
        {{/if}}
    </script>



    <script type="text/javascript">
        SetSecondCrumb('<%: Page.Title %>');
        ActiveMenu('menu3');


        //下拉控件
        $('#<%= ddlCheckStatus.ClientID %>').chosen({
            width: '110px',
            placeholder_text_single: "认证状态",
            disable_search_threshold: 10,//小于此值不显示搜索
            allow_single_deselect: true//可清除选择
        });



        //textbox无法回车回发
        $('form').on('keydown', '#<%= txtSearch.ClientID %>', function (e) {
            var key = e.which || e.keyCode || 0;
            if (key && key == 13) {
                document.getElementById('<%= btnSearch.ClientID %>').click();
            };
        });


        //日期区间选择控件
        $('#<%= txtDateRange.ClientID %>').daterangepicker({
            'applyClass': 'btn-xs btn-success',
            'cancelClass': 'btn-xs btn-default',
            autoUpdateInput: true,//自动更新值
            showDropdowns: true,
            timePicker: true,
            timePicker24Hour: true,
            timePickerIncrement: 10,
            locale: {
                applyLabel: '确定',
                cancelLabel: '清空',
                format: 'YYYY/MM/DD HH:mm',
                "separator": " - ",
                "fromLabel": "从",
                "toLabel": "到",
                "customRangeLabel": "Custom",
                "daysOfWeek": [
                    "日",
                    "一",
                    "二",
                    "三",
                    "四",
                    "五",
                    "六"
                ],
                "monthNames": [
                    "一月",
                    "二月",
                    "三月",
                    "四月",
                    "五月",
                    "六月",
                    "七月",
                    "八月",
                    "九月",
                    "十月",
                    "十一月",
                    "十二月"
                ],
                "firstDay": 1
            }
        });
        $('#<%= txtDateRange.ClientID %>').val('');//页面加载时清空预设值
        $('#<%= txtDateRange.ClientID %>').on('apply.daterangepicker', function (ev, picker) {
            //$(this).val(picker.startDate.format('YYYY/MM/DD HH:mm') + ' - ' + picker.endDate.format('YYYY/MM/DD HH:mm'));
        });
        $('#<%= txtDateRange.ClientID %>').on('cancel.daterangepicker', function (ev, picker) {
            $(this).val('');
        });




        //认证
        //$('form').on('click.switch', '.ace.ace-switch.valid', function (e) {
        //    var me = this;

        //    $(me).attr('disabled', 'disabled');

        //    $.post('', { action: 7, id: $(me).parents('tr').attr('id'), checked: me.checked }, function (jdata) {
        //        $(me).removeAttr('disabled');

        //        switch (jdata.code) {
        //            case "OK":
        //                showInfo(jdata.message);
        //                break;
        //            case "Err":
        //                showErr(jdata.message);
        //                me.checked = !me.checked;
        //                break;
        //        }
        //    }, 'json');
        //});



        //切换状态
        $('form').on('click.switch', '.ace.ace-switch.enable', function (e) {
            var me = this;

            $(me).attr('disabled', 'disabled');

            $.post('', { action: 4, id: $(me).parents('tr').attr('id'), checked: me.checked }, function (jdata) {
                $(me).removeAttr('disabled');

                switch (jdata.code) {
                    case "OK":
                        showInfo(jdata.message);
                        break;
                    case "Err":
                        showErr(jdata.message);
                        me.checked = !me.checked;
                        break;
                }
            }, 'json');
        });




        var UserHelper = {
            getSex: function (sex) {
                return (sex != null) ? (sex === 1 ? "男" : "女") : "";
            },
            getBool: function (bo) {
                return bo ? "是" : "否";
            },
            getChk: function (bo) {
                return bo ? 'checked="checked"' : "";
            },
            getSaler: function (sid) {
                return $.ajax({
                    type: "GET",
                    url: '',
                    data: { action: 6, id: sid },
                    async: false
                }).responseText;
            }
        };



        //查看详细
        function Bind(id) {
            setTimeout(function () {
                $('#hidUserId').val(id);//要等modal-form显示后才能设置值
            }, 500);
            BindHtml(id);
        }
        $('#modal-form').on('hidden.bs.modal', function (e) {
            $('#hidUserId').val('');
            $('#userHtml').empty();
        });
        function BindHtml(id) {
            $.getJSON('', { action: 5, id: id }, function (jdata, textStatus, jqXHR) {
                if ('success' == textStatus) {
                    switch (jdata.code) {
                        case "OK":
                            var tmpl = $.templates("#userTmpl");
                            //var tmpl = $.templates({
                            //    markup: "#userTmpl",
                            //    allowCode: true //http://www.jsviews.com/#allowcodetag
                            //});

                            //var html = tmpl.render(jdata);
                            var html = tmpl.render(jdata, UserHelper); //http://www.jsviews.com/#helpers

                            $('#userHtml').html(html);
                            break;
                        case "Err":
                            showErr(jdata.message);
                            break;
                    }

                }
            });
        }



        //删除
        function ConfirmDel(id) {
            bootbox.confirm({
                message: "确认要删除？这将删除该用户的所有相关数据。",
                buttons: {
                    confirm: {
                        label: "绝不反悔",
                        className: "btn-primary btn-sm"
                    },
                    cancel: {
                        label: "再想想",
                        className: "btn-sm"
                    }
                },
                callback: function (result) {
                    //alert(result);
                    if (result) {
                        $.post('', { action: 3, id: id }, function (jdata) {
                            switch (jdata.code) {
                                case "OK":
                                    __doPostBack('<%= UpdatePanel1.ClientID %>', '');
                                    showInfo(jdata.message);
                                    break;
                                case "Err":
                                    showErr(jdata.message);
                                    break;
                            }
                        }, 'json');
                    }
                }
            });
        }

        //分配服务人员
        function assortServicePerson(id) {
            alert("正在完善分配客服人员信息！");
            SetTimeOut(function(){
                $('#hidUserId').Val(id);
            },500);

            $('#modal-form1').modal('show');

            jQuery(function($){
                $('#modal-form1').on('show.bs.modal hide.bs.modal',function(e){
                    this.reset();
                });
                var date = new Date();
                $('#time1').text(date.toLocaleString());

            });
        }

    </script>
    
</asp:Content>

