<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="SensitiveWord.aspx.cs" Inherits="Weetop.Web.member.SensitiveWord" %>


<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">




    <div class="hy_right1">
        <div class="hy_right1_bt">位置：<img src="../images/hy_right_btt.png" alt="" />服务管理 &gt; 敏感词查询</div>

        <div class="fwgl_mgc clearfix">
            <ul>
                <li>
                    <i>
                        <img src="../images/fwgl_mgc_tu.jpg" alt="" /></i>
                    <textarea name="textarea" id="textarea" class="textarea"></textarea>
                    <input type="button" value="查询" class="anniu">
                </li>
                <li>
                    <i>
                        <img src="../images/fwgl_mgc_tu1.jpg" alt="" /></i>
                    <span><%--我们党肩负着带领全国各族人民实现“两个一百年”奋斗目标、实现中华民族伟大<em>复兴</em>的历史使命，同时也<em>面临</em>着“四大考验”--%></span>
                    <p>
                        智能显示敏感词<br>
                        带有下划线“——”为敏感词
                    </p>
                </li>
            </ul>
        </div>

    </div>

    <script type="text/javascript">
        $('input.anniu').on('click', function () {
            var text = $('#textarea').val();
            if (text) {
                $.post('SensitiveWord', { text: text }, function (data) {
                    $('ul li span').html(data);
                }, 'text');
            }
        });
    </script>

</asp:Content>
