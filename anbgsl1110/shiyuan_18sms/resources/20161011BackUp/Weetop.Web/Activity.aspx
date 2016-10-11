<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Activity.aspx.cs" Inherits="Weetop.Web.Activity" %>

<%@ Import Namespace="Weetop.DAL" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>公司_活动-示远科技</title>
    <link href="css/activity.css" rel="stylesheet" />
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ac_banner">
        <a href="javascript:void(0)" class="ljcj" onclick="lotterys()">立即抽奖</a>
    </div>
    <div class="ac_box01">
        <div class="wzqd"></div>
        <a href="Register" class="ljhd">立即获得抽奖机会</a>
    </div>
    <div class="ac_banner2"></div>
    <div class="ac_banner3">
        <div class="ipad"></div>
    </div>
    <div class="ac_banner4">
        <a href="member/Recharge.aspx" class="ljcz">立即充值</a>
    </div>
     <div class="ac_box02">
        <div class="ac_title04">100%中奖机会！等你来拿！</div>
        <div class="ac_title05">活动期间累计充值满一万，可获得一次抽奖机会，两万两次，上不封顶！</div>
        <div class="ac_title06">*老客户介绍一名新客户达成合作并累计充值满5000元，可额外获得1次抽奖机会。</div>
        <a href="Lottery.aspx" class="ljhd hd">立即获得抽奖机会</a>
        <ul class="jx clearfix">
            <li>
                <img src="/images/2g.png"  />
            </li>
            <li>
                <img src="/images/5g.png"  />
            </li>
            <li>
                <img src="/images/10g.png"  />
            </li>
            <li>
                <img src="/images/20g.png"  />
            </li>
           
        </ul>
         <ul class="jx hf clearfix">
             <li>
                <img src="/images/100.png"  />
            </li>
             <li>
                <img src="/images/300.png"  />
            </li>
             <li>
                <img src="/images/400.png"  />
            </li>
             <li>
                <img src="/images/500.png"  />
            </li>
        </ul>
    </div>
    <div class="detail">
        <div id="detail">
		    <h4>【活动细则】</h4>
		    <ul>
			    <li>1、活动时间</li>
			    <li style="padding-left: 20px;">参与时间：10月1日到10月31日充值有效；</li>
			    <li style="padding-left: 20px;">奖励领取时间：获得抽奖机会后需在11月4日之前完成抽奖并领取相应奖品，逾期作废。</li>
			    <li>2、参与条件</li>
			    <li style="padding-left: 20px;">2.1、当月累计充值满1万元，可获得1次抽奖机会，满2万元获得2次抽奖机会，以此类推，上不封顶；</li>
			    <li style="padding-left: 20px;">2.2、老客户介绍一名新客户达成合作并累计充值满5000元，可获得一次充值机会。</li>
			    <li>3、活动不限新合作客户充值与已合作客户续充</li>
			    <li>4、除实物中奖外，即时发放奖励，部分实物奖励需在奖品到货后三天发放。</li>
			    <li>5、抽奖机会根据实际到账金额计算，若有疑问，请联系客服或商务人员。</li>
			    <li>6、此活动不与其他活动同时进行。</li>
			    <li>7、此活动最终解释权归杭州示远信息科技有限公司所有。</li>
		    </ul>
	    </div>
    </div>

    <script type="text/javascript">
        function lotterys() {

            $.get("Activity.aspx", { action: "lt" }, function (data) {
                if (data.code === "Err") {
                    location.href = "Login.aspx";
                    return false;
                }
                else {
                    location.href = "Lottery.aspx";
                }
            }, "json");
        };

   </script>

</asp:Content>

