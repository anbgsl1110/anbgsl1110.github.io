<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Lottery.aspx.cs" Inherits="Weetop.Web.Lottery" %>

<%@ Import Namespace="Weetop.DAL" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>抽奖页面-示远科技</title>
    <link href="css/lottery.css" rel="stylesheet" />
    <meta name="keywords" content="公司动态,公司新闻,公司资讯">
    <meta name="description" content="公司动态栏目展示了公司在各个阶段的动态、新闻、资讯，帮助客户更快的了解示远科技。">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" runat="server" id="dateTimes" />
    <div id="wrap">
		<div id="main">
			<div id="left">
				<div class="sec1 lottery-unit lottery-unit-0" style="margin-right: 4px;margin-bottom: 4px;" id="btn1">
					<img src="images/iPhone.jpg" alt=""/>
				</div>
				<div class="sec2 lottery-unit lottery-unit-1">
					<span>2G</span>流量
				</div>
				<div class="sec2 lottery-unit lottery-unit-2">
					<i>¥</i><span>300</span>话费
				</div>
				<div class="sec2 lottery-unit lottery-unit-3">
					<img src="images/mini4.jpg" alt=""/>
				</div>
				<div class="sec3" style="background: url(images/action.jpg) no-repeat center;">
                    <div id="start">
                        <div class="show">立即抽奖</div>
					    <div class="chance">当前你有<label id="chnum" runat="server"></label>次抽奖机会</div>
                    </div>
                    <div class="coverf"></div>
				</div>
				<div class="sec2 lottery-unit lottery-unit-4">
					<i>¥</i><span>400</span>话费
				</div>
				<div class="sec4">
					<div class="sec2 lottery-unit lottery-unit-9">
						<i>¥</i><span>100</span>话费
					</div>
					<div class="sec2 lottery-unit lottery-unit-10">
						<span>20G</span>流量
					</div>
					<div class="sec2 lottery-unit lottery-unit-11">
						<span>5G</span>流量
					</div>
					<div class="sec2 lottery-unit lottery-unit-8">
						<img src="images/beats.jpg" alt=""/>
					</div>
					<div class="sec2 lottery-unit lottery-unit-7">
						<span>10G</span>流量
					</div>
					<div class="sec2 lottery-unit lottery-unit-6">
						<i>¥</i><span>500</span>话费
					</div>
				</div>
				<div class="sec1 lottery-unit lottery-unit-5" id="btn2">
					<img src="images/watch.jpg"/>
				</div>
			</div>
			<div id="right">
				<div class="listtit">
					<h1>中奖榜单</h1>
					<div>累计有<span id="countUsr"></span>人中奖</div>
				</div>
                <div id="demo" class="conter">
                    <ul class="list" id="demo1">
					    
				    </ul>
                    <ul id="demo2" class="list">
                    </ul>
                </div>
				
			</div>
		</div>
	</div>
    <div id="dewrap">
	    <div id="detail">
		    <h4>【活动细则】</h4>
		    <ul>
			    <li>1、活动时间</li>
			    <li style="padding-left: 20px;">1.1、参与时间：10月1日到10月31日充值有效；</li>
			    <li style="padding-left: 20px;">1.2、奖励领取时间：获得抽奖机会后需在11月4日之前完成抽奖并领取相应奖品，逾期作废。</li>
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
   

    <div class="sj_mask">
      <form action="/" method="post" class="sj_form">
          <div class="form_top">
              <span class="btn_gb"><span class="cgb"></span></span>
              <div class="ts">恭喜<span>189****1234</span>用户，抽中<label>iPhone 7</label>一台。</div>
              <div class="bz">你需要填写信息领取奖品，在奖品到货2天内与你取得联系，</br>
保证奖品寄出信息准确无误。</div>
              <div class="dj">点击填写信息</div>
          </div>
          <div class="form_bottom">
              <div class="box">
                  <span>姓名</span>
                  <input type="text" name="name" value=" " class="name1"/>
              </div>
              <div class="box">
                  <span>电话</span>
                  <input type="text" name="name" value=" " class="tell1"/>
              </div>
              <div class="box">
                  <span>地址</span>
                  <input type="text" name="name" value=" " class="add1"/>
              </div>
              <div class="box">
                  <span>公司</span>
                  <input type="text" name="name" value=" " class="co1"/>
              </div>
              <div class="box">
                  <span>职位</span>
                  <input type="text" name="name" value=" " class="job1"/>
              </div>
              <a href="#" class="sure" id="rsure">确定</a>
              <span class="ts_bz">备注：以上为必选项。</span>
          </div>
          <!--耳机-->
          <div class="form_bottom2 clearfix">
              <div class="box">
                  <span>姓名</span>
                  <input type="text" name="name" value=" " class="name2"/>
              </div>
              <div class="box">
                  <span>电话</span>
                  <input type="text" name="name" value=" " class="tell2"/>
              </div>
              <div class="box">
                  <span>地址</span>
                  <input type="text" name="name" value=" " class="add2"/>
              </div>
              <div class="box">
                  <span>公司</span>
                  <input type="text" name="name" value=" " class="co2"/>
              </div>
              <div class="box">
                  <span>职位</span>
                  <input type="text" name="name" value=" " class="job2"/>
              </div>
               <div class="box ys">
                  <span>颜色</span>
                  <input type="text" name="name" value=" " id="earchco" disabled="true"/>
              </div>
              <ul class="color">
                  <li class="yanse"><img src="/images/hs.png"  /></li>
                  <li class="yanse"><img src="/images/bs.png"  /></li>
                  <li class="yanse"><img src="/images/js.png"  /></li>
                  <li class="yanse"><img src="/images/hongs.png"  /></li>
                  <li class="yanse"><img src="/images/huis.png"  /></li>
                  <li class="yanse"><img src="/images/ys.png"  /></li>
                  <li class="yanse"><img src="/images/mgj.png"  /></li>
                  <li class="yanse"><img src="/images/ls.png"  /></li>
              </ul>
              <a href="#" class="sure">确&nbsp;定</a>
              <span class="ts_bz">备注：以上为必选项。</span>
          </div>
          <!--mini4-->
          <div class="form_bottom3 clearfix">
              <div class="box">
                  <span>姓名</span>
                  <input type="text" name="name" value=" " class="name3"/>
              </div>
              <div class="box">
                  <span>电话</span>
                  <input type="text" name="name" value=" " class="tell3"/>
              </div>
              <div class="box">
                  <span>地址</span>
                  <input type="text" name="name" value=" " class="add3"/>
              </div>
              <div class="box">
                  <span>公司</span>
                  <input type="text" name="name" value=" " class="co3"/>
              </div>
              <div class="box">
                  <span>职位</span>
                  <input type="text" name="name" value=" " class="job3"/>
              </div>
               <div class="box ys">
                  <span>颜色</span>
                  <input type="text" name="name" value=" " id="michco" disabled="true"/>
              </div>
              <ul class="color">
                  <li class="yanse"><img src="/images/ipadys.png"  /></li>
                  <li class="yanse"><img src="/images/ipadhs.png"  /></li>
              </ul>
              <a href="#" class="sure">确&nbsp;定</a>
              <span class="ts_bz">备注：以上为必选项。</span>
          </div>
      </form>

      <form action="/" method="post" class="sj_form2">
          <div class="form_top">
              <span class="btn_gb"><span class="cgb"></span></span>
              <div class="ts">恭喜<span id="user">189****1234</span>用户，抽中<span id="awards">500元话费</span>。</div>
              <div class="ts2">请根据提示领取奖品</div>
               <div class="box2">
                  <input type="text" name="name" value="请输入手机号" class="phone" />
                  <a href="#" id="vsure">确&nbsp;定</a>
              </div>
          </div>
      </form>
    </div>

    <script src="js/lottery.js"></script>


</asp:Content>
