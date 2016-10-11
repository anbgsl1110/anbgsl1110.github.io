<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="Award.aspx.cs" Inherits="Weetop.Web.member.Award" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">



    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />用户中心 &gt; 中奖信息</div>

        <div class="fwgl_dxmb">
            <div class="fwgl_dxmb_lb">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tbody>
                        <tr>
                            <th width="18%" scope="col">奖品信息</th>
                            <th width="8%" scope="col">姓名</th> 
                            <th width="10%" scope="col">手机/电话</th>
                            <th width="30%" scope="col">收货地址</th> 
<%--                            <th width="10%" scope="col">公司</th> --%>
<%--                            <th width="14%" scope="col">地址</th> --%>
                            <th width="8%" scope="col">颜色</th>
                            <th width="13%" scope="col">时间</th>
                            <th width="5%" scope="col">操作</th>  
                            <th width="13%" scope="col">状态</th>  
                        </tr>
                  <%if (dt1 != null)
                    { %>
                  <%foreach (var info in dt1)
                  { %>
                        <tr>
                            <td class="award">
                                <span class="jpimg"><img src="/member/images/hf.png" /></span>
                                <span class="jp"><%=info.WinningPrizeName %></span>
                            </td>
                            <td></td>
                            <td><%=info.Phone %></td>
                            <td><%=info.ConsigneeCompany %><%=info.ConsigneePosition %><%=info.ConsigneeAddr %></td>
                            <td></td>
                            <td><%=info.WinningDate %></td>
                            <%if(info.Status==0){ %>
                            <td><a title="<%=info.Id %>"  href="javascript:void(0)" class="run">修改</a></td>
                            <%} %>
                            <%else{ %>
                            <td></td>
                            <%} %>
                            <td><%=GetStatus((int)info.Status) %></td>
                        </tr>
                         <%} %>  
                    <%} %>  
                 <%if (dt2 != null)
                  { %>
                <%foreach (var info in dt2)
                  { %>  
                         <tr>
                            <td class="award">
                                <span class="jpimg">
                     <%if (info.WinningPrizeID == 1)
                      { %>
                    <img src="/member/images/iPhone.jpg" />
                    <%} %>
                    <%else if (info.WinningPrizeID == 2)
                      { %>
                    <img src="/member/images/mini4.jpg" />
                    <%} %>
                    <%else
                      { %>
                    <img src="/member/images/beats.jpg" />
                    <%} %></span>
                                <%if(info.WinningPrizeID!=1) {%>
                                <span class="jp"><%=info.WinningPrizeName.Substring(0,info.WinningPrizeName.Length-2) %></span>
                                <%} %>
                                <%else{ %>
                                <span class="jp"><%=info.WinningPrizeName %></span>
                                <%} %>
                            </td>
                            <td><%=info.ConsigneeName %></td>
                            <td><%=info.ConsigneePhone %></td>
<%--                            <td><%=info.ConsigneePosition %></td>
                            <td><%=info.ConsigneeCompany %></td>--%>
                            <td><%=info.ConsigneeCompany %><%=info.ConsigneePosition %><%=info.ConsigneeAddr %></td>
                             <%if(info.WinningPrizeID!=1) {%>
                            <td><%=info.WinningPrizeName.Substring(info.WinningPrizeName.Length-2,2) %></td>
                             <%} %>
                             <%else{ %>
                               <td>亮黑色</td>
                             <%} %>
                            <td><%=info.WinningDate %></td>
                              <%if(info.Status==0){ %>
                            <td><a title="<%=info.Id %>"  href="javascript:void(0)" class="run">修改</a></td>
                             <%} %>
                              <%else{ %>
                            <td></td>
                            <%} %>
                             <td><%=GetStatus((int)info.Status) %></td>
                        </tr>   
                    <%} %>  
                    <%} %>  
                    </tbody>
                </table>
            </div>

             <%--弹出层--%>
             <div id="hy_fwgl_demo">
                <div class="hy_fwgl_xzdx">
                    <form id="signform">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                                <tr>
                                    <td>姓名:</td>
                                    <td><input type="text" class="text" name="name" id="name"/></td>
                                </tr>
                                <tr>
                                    <td>电话:</td>
                                    <td><input type="text" class="text" name="phone" id="phone"/></td>
                                </tr>
                                <tr>
                                    <td>职位:</td>
                                    <td><input type="text" class="text" name="position" /></td>
                                </tr>
                                <tr>
                                    <td>公司:</td>
                                    <td><input type="text" class="text" name="company" /></td>
                                </tr>
                                <tr>
                                    <td>地址:</td>
                                    <td><input type="text" class="text" name="address" /></td>
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
            <%--弹出层--%>
          
            
        </div>

    </div>



   

    

 <script type="text/javascript">
     $(function () {
         var num = 0;
         $(".run").click(function () {
             num = this.title;
             $("#hy_fwgl_demo").layerModel({
                 title: "修改领奖信息",
                 drag: false
             });
         });
            <%--提交--%>


            $('#signform').on('valid.form', function () {

                loading = Lay.showLoading('正在提交');

                $("#signform").ajaxSubmit({
                    url: 'Award',
                    data: { ac: 1, id: num },
                    type: 'post',
                    dataType: 'json',
                    success: function (jdata, statusText) {
                        if (jdata.code == "OK") {
                            Lay.showMsg(jdata.message);
                            $('.layerModel_closeBtn').click();
                            location.reload();
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
            }

                );


        });
    </script>

</asp:Content>
