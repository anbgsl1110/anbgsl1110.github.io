<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Price.aspx.cs" Inherits="Weetop.Web.Price" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="js/tablecloth.js"></script>
<title>产品价格_验证码短信价格_验证码短信接口价格-示远科技</title>
<meta name="keywords" content="示远产品价格,验证码短信价格,验证码短信接口价格,短信平台报价,短信通知服务费多少钱">
<meta name="description" content="产品价格栏目展示了示远短信验证码价格、验证码短信接口价格等价格问题，让客户更快的了解到示远短信验证码、通知短信、营销短信等各产品的价格。">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="NYbanner" style="background: url(images/price_banner.jpg) no-repeat top center; background-size:cover; width:100%; min-width:1200px; height:450px;">
        <%--<div class="ny_price_banner">
            <div class="ny_price_text">
                <h1>更好的服务、更好的产品</h1>
                <h2>给你最优惠的价格</h2>
                <input class="current" type="button" value="立即购买">
                <input type="button" value="联系客服">
            </div>
        </div>--%>
    </div>
    
    <div class="ny_priceBox">
       <label style="color:red;font-size:16px;font-family:'Microsoft YaHei';" >注: 短信30万条内,购买不同数量,享受价格不一样.购买不超过5万条不享受优惠政策! (例:张总要购买18W条,那么他享受的政策为 10万~20万 每条0.053元)</label> 
        <div class="table01 clearfix">
            <div class="tableL fl">
                <i style="background:url(images/table01.png) no-repeat center;"></i>
                <h1>短<br>信<br>验<br>证<br>码</h1>
            </div>
            <table class="fr">
                <tr>
                    <th class="headT">短信验证码</th>
                    <td class="headT">优惠包</td>
                    <td class="headT">特惠包</td>
                    <td class="headT">超值包</td>
                    <td class="headT">至尊包</td>
                </tr>
                <tr>
                    <th>价格（元/条）</th>
                    <td>0.058</td>
                    <td>0.053</td>
                    <td>0.048</td>
                    <th>咨询商务或客服</th>
                </tr>
                <tr>
                    <th>充值量（条）</th>
                    <td>5万~10万</td>
                    <td>10万~20万</td>
                    <td>20万~30万</td>
                    <td>30万及以上</td>
                </tr>
                <tr>
                    <th>一键购买</th>
                    <td><a href="/member/Account">立即购买</a></td>
                    <td><a href="/member/Account">立即购买</a></td>
                    <td><a href="/member/Account">立即购买</a></td>
                    <th class="chatgt"><a href="javascript:;"><h1><i></i>在线沟通</h1></a></th>
                </tr>
            </table>
        </div>
        <div class="table02 clearfix">
            <div class="tableL fl">
                <i style="background:url(images/table02.png) no-repeat center;"></i>
                <h1 style=" font-size:16px;">会<br>员<br>通<br>知<br>短<br>信</h1>
            </div>
            <table class="fr">
                <tr>
                    <th class="headT">会员通知短信</th>
                    <td class="headT">优惠包</td>
                    <td class="headT">特惠包</td>
                    <td class="headT">超值包</td>
                    <td class="headT">至尊包</td>
                </tr>
                <tr>
                    <th  scope="row">价格（元/条）</th>
                    <td>0.058</td>
                    <td>0.053</td>
                    <td>0.048</td>
                    <td>咨询商务或客服</td>
                </tr>
                <tr>
                    <th>充值量（条）</th>
                    <td>5万~10万</td>
                    <td>10万~20万</td>
                    <td>20万~30万</td>
                    <td>30万及以上</td>
                </tr>
                <tr>
                    <th>一键购买</th>
                    <td><a href="/member/Account">立即购买</a></td>
                    <td><a href="/member/Account">立即购买</a></td>
                    <td><a href="/member/Account">立即购买</a></td>
                    <th class="chatgt"><a href="javascript:;"><h1><i></i>在线沟通</h1></a></th>
                </tr>
            </table>
        </div>
        <div class="table03 clearfix">
            <div class="tableL fl">
                <i style="background:url(images/table03.png) no-repeat center;"></i>
                <h1 style=" font-size:16px;">会<br>员<br>营<br>销<br>短<br>信</h1>
            </div>
            <table class="fr">
                <tr>
                    <th class="headT">会员营销短信</th>
                    <td class="headT">优惠包</td>
                    <td class="headT">特惠包</td>
                    <td class="headT">超值包</td>
                    <td class="headT">至尊包</td>
                </tr>
                <tr>
                    <th>价格（元/条）</th>
                    <td>0.058</td>
                    <td>0.053</td>
                    <td>0.048</td>
                    <td>咨询商务或客服</td>
                </tr>
                <tr>
                    <th>充值量（条）</th>
                    <td>5万~10万</td>
                    <td>10万~20万</td>
                    <td>20万~30万</td>
                    <td>30万及以上</td>
                </tr>
                <tr>
                    <th>一键购买</th>
                    <td><a href="/member/Account">立即购买</a></td>
                    <td><a href="/member/Account">立即购买</a></td>
                    <td><a href="/member/Account">立即购买</a></td>
                    <th class="chatgt"><a href="javascript:;"><h1><i></i>在线沟通</h1></a></th>
                </tr>
            </table>
        </div>
        <div class="table04 clearfix">
            <div class="tableL fl">
                <i style="background:url(images/table04.png) no-repeat center;"></i>
                <h1 style=" font-size:16px;">国<br>际<br>短<br>信<br>验<br>证<br>码</h1>
            </div>
            <table class="fl">
                <tr>
                    <th class="headT">国际短信验证码</th>
                    <td class="headT">全国统一低价（无地域限制、无最低起充量限制）</td>
                    <td class="headT" style="width:276px;">至尊包</td>
                </tr>
                <tr>
                    <th>价格（元/条）</th>
                    <td>0.80</td>
                    <td>咨询客服</td>
                </tr>
                <tr>
                    <th>充值量（条）</th>
                    <td>1万以上</td>
                    <td>52万以上</td>
                </tr>
                <tr>
                    <th>一键购买</th>
                    <td><a href="/member/Account">立即购买</a></td>
                    <th class="chatgt"><a href="javascript:;"><h1><i></i>在线沟通</h1></a></th>
                </tr>
            </table>
            <!--<div class="tableR fr"><div style="height:48px; background-color:#c8abde;"></div><a href="prepare.html"></a></div>-->
        </div>
        <div class="table05 clearfix">
            <div class="tableL fl">
                <i style="background:url(images/table05.png) no-repeat center;"></i>
                <h1 style=" font-size:16px;">语<br>音<br>验<br>证<br>码</h1>
            </div>
            <table class="fr">
                <tr>
                    <th class="headT">语音验证码</th>
                    <td class="headT">优惠包</td>
                    <td class="headT">特惠包</td>
                    <td class="headT">超值包</td>
                    <td class="headT">钻石包</td>
                    <td class="headT">至尊包</td>
                </tr>
                <tr>
                    <th>价格（元/条）</th>
                    <td>0.060</td>
                    <td>0.058</td>
                    <td>0.055</td>
                    <td>0.050</td>
                    <td>咨询商务或客服</td>
                </tr>
                <tr>
                    <th>充值量（条）</th>
                    <td>1万~5万</td>
                    <td>6万~10万</td>
                    <td>12万~30万</td>
                    <td>32万~50万</td>
                    <td>52万以上</td>
                </tr>
                <tr>
                    <th>一键购买</th>
                    <td><a href="/member/Account">立即购买</a></td>
                    <td><a href="/member/Account">立即购买</a></td>
                    <td><a href="/member/Account">立即购买</a></td>
                    <td><a href="/member/Account">立即购买</a></td>
                    <th class="chatgt"><a href="javascript:;"><h1><i></i>在线沟通</h1></a></th>
                </tr>
            </table>
        </div>
        <div class="table06 clearfix">
            <div class="tableL fl">
                <i style="background:url(images/table06.png) no-repeat center;"></i>
                <h1 style=" font-size:16px;">手<br>机<br>流<br>量<br>推<br>广</h1>
            </div>
            <table class="fr">
                <tr><th class="headT">流量值</th><th class="headT">移动/面值（元）</th><th class="headT">联通/面值（元）</th><th class="headT">电信/面值（元）</th><th class="headT">示远价格（元）</th></tr>
                <tr><td>10M</td><td>3</td><td>/</td><td>2</td><td>2.85 / 1.90</td></tr>
                <tr><td>20M</td><td>/</td><td>3</td><td>/</td><td>2.94</td></tr>
                <tr><td>30M</td><td>5</td><td>/</td><td>5</td><td>4.75</td></tr>
                <tr><td>50M</td><td>/</td><td>6</td><td>7</td><td>5.88 / 6.65</td></tr>
                <tr><td>70M</td><td>10</td><td>/</td><td>/</td> <td>9.5</td></tr>
                <tr><td>100M</td><td>/</td><td>10</td><td>10</td><td>9.8 / 9.5</td></tr>
                <tr><td>150M</td><td>20</td><td>/</td><td>/</td><td>19</td></tr>
                <tr><td>200M</td><td>/</td><td>15</td><td>15</td><td>14.70 / 14.25</td></tr>
                <tr><td>500M</td><td>30</td><td>30</td><td>30</td><td>28.5 / 29.4 / 28.5</td></tr>
                <tr><td>1G</td><td>50</td><td>/</td><td>50</td><td>47.5</td></tr>
            </table>
        </div>
        <div class="beizhu">
            <p>备注：以上均为含税价。</p>
        </div>
        <div class="caozuo">
            <input class="btn02 chatgt" type="button" value="联系客服开通流量业务" onclick="javascript:;">
            <input class="btn03" type="button" value="立即购买" onclick="javascript: location = '/member/Account'">
        </div>
    </div>


</asp:Content>
