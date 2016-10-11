<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Weetop.Web.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>示远科技官网 - 短信验证码,语音验证码,通知短信,营销短信首选平台</title>
<meta name="keywords" content="短信验证码,短信验证码平台,手机验证码平台,语音验证码,手机语音验证码,国际短信验证码,短信通知,短信营销">
<meta name="description" content="示远信息科技有限公司具有5年通信产业3年短信验证码通道运营服务经验，我们提供短信验证码，短信验证码接口，手机短信验证码，语音验证码，国际短信验证码，通知短信，短信营销等产品，坚持5秒必达、短信到达率100%的原则，持续为客户提供最优质短信通道，咨询热线：400-0571-363。">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="NYbanner" style="background: url(images/about_banner.jpg) no-repeat top center; background-size:cover; height: 930px;"></div>
    <div class="ny_about">
        <div class="aboutT">
        <a name="1f" style=" height:100px; display:block;"></a>
            <h1>公司简介</h1>
            <i></i>
        </div>
        <div class="aboutP">
            <p>示远信息科技有限公司（上海示远与杭州示远为同一控股平行公司）自成立以来专注于互联网企业短信验证码服务，如：美团、滴滴、优步、京东等各类互联网企业的短信订单通知，短信验证码等一系列短信通信类服务。作为一家短信验证码服务供应商，目前是中国移动、中国联通、中国电信三大运营商的资深战略合作伙伴，也是国内发展速度最快，成长速度最迅猛的企业之一。</p>
            <p>公司通过自主研发的SDK接口文档及智能短信平台接入各大互联网企业、移动APP、020网站、智能办公软件等提供定制化短信验证服务和行业会员通知类及营销类服务，获得了海量明星企业客户的高度认可和赞誉！</p>
            <p>公司在原有的5年技术沉淀基础上为客户提供了最新的移动行业通道资源和最完美的服务体验，并取得国家工信部颁发的《短消息类服务接入代码使用证书》和《增值电信业务经营许可证》，以及数次荣誉优秀企业殊荣，是业内为数不多的资质企业之一。</p>
            <p>2016年1月20日，获得著名投资机构第一轮天使轮投资。预计年底将会获得千万级以上A轮融资。</p>
            <p>目前公司平台市场估值6000万人民币。预计未来三年内在北京、上海、广州、成都、西安、武汉等地相继成立分公司，布局全国，计划于2020年前成立华东、华中、西南、西北四大运营部，冲击新三板。</p>
        </div>
        <div class="aboutT">
        <a name="2f" style=" height:100px; display:block;"></a>
            <h1>发展历程</h1>
            <i></i>
        </div>
        <div class="year-aboutP">
            <ul class="yearBox">
                <li>
                    <div class="year">
                        <span class="span2013"></span>
                        <b style="padding-top: 30px;">成立示远<br>
                            专注互联网行业<br>
                            短信注册<br>
                            验证码服务</b>
                    </div>
                </li>
                <li class=" yearSelected">
                    <div class="year">
                        <span class="span2014"></span>
                        <b style="padding-top: 45px;">与移动互联网公司<br>
                            深度合作<br>
                            完善团队</b>
                    </div>
                </li>
                <li>
                    <div class="year">
                        <span class="span2015"></span>
                        <b style="padding-top: 45px;">布局全国市场<br>
                            人才引进<br>
                            团队扩充</b>
                    </div>
                </li>
                <li>
                    <div class="year">
                        <span class="span2016"></span>
                        <b style="padding-top: 60px;">首轮天使轮投资<br>
                            市场估值6000万元</b>
                    </div>
                </li>
                <li>
                    <div class="year">
                        <span class="span2020"></span>
                        <b style="padding-top: 60px;">成立四大运营部<br>
                            冲击新三板</b>
                    </div>
                </li>
            </ul>
            <script type="text/javascript">
                $(function () {
                    $(".yearBox li").hover(function () {
                        var i = $(".yearBox li").index(this);
                        $(".yearBox li").eq(i).stop(false, true).addClass("yearSelected")
                        $(".yearBox li").eq(i).siblings().stop(false, true).removeClass("yearSelected")
                    })
                })
            </script>
            <ul class="yearlist">
                <li>2013年，顺从市场发展趋势，积极拥抱互联网，示远科技孕育而生，以“示梦于心，远航于行”为至高经营理念，专注于移动互联网短信验证码服务应用，APP内嵌式验证系统开发。在原有的5年技术沉淀上为客户提供最新的移动互联网行业通道资源和最完美的服务体验。</li>
                <li>2014年，示远科技与浙江地区乃至全国移动互联网公司及传统行业进行深度合作，逐步完善销售团队和技术团队，其中技术团队核心骨干均来自华为及中兴。</li>
                <li>2015年，示远科技开始布局全国市场，并不断完善示远科技办公环境，建设企业文化并大量引进人才扩展团队，为布局全国做好准备。</li>
                <li>2016年1月20日，获得了首轮天使轮投资，市场估值6000万元。用于积极升级产品革新，企业发展。</li>
                <li>2020年，成立华东、华中、西南、西北四大运营部，冲击新三板。</li>
            </ul>
        </div>
        <div class="aboutT">
        <a name="3f" style=" height:100px; display:block;"></a>
            <h1>团队介绍</h1>
            <i></i>
        </div>
        <div class="team-aboutP">
            <ul>
                <li>
                    <div class="imgNormal">
                        <img src="images/about01.png" alt="">
                        <h1>销售部&nbsp;&nbsp;|&nbsp;&nbsp;Sales Department</h1>
                    </div>
                    <div class="imgHover">
                        <img src="images/about01.png" alt="">
                        <span>
                            <h2>销售部</h2>
                            <h3>极具热情的团队，互联网从业经验平均3-5年的精英团队，1对1深入沟通了解客户需求。</h3>
                        </span>
                    </div>
                </li>
                <li>
                    <div class="imgNormal">
                        <img src="images/about02.png" alt="">
                        <h1>技术部&nbsp;&nbsp;|&nbsp;&nbsp;Technology Department</h1>
                    </div>
                    <div class="imgHover">
                        <img src="images/about02.png" alt="">
                        <span>
                            <h2>技术部</h2>
                            <h3>高度专业的团队，来自华为、中兴的技术骨干，最专业的人做最专业的事，只为快速解决客户的问题。</h3>
                        </span>
                    </div>
                </li>
                <li>
                    <div class="imgNormal">
                        <img src="images/about03.png" alt="">
                        <h1>客服部&nbsp;&nbsp;|&nbsp;&nbsp;Service Department</h1>
                    </div>
                    <div class="imgHover">
                        <img src="images/about03.png" alt="">
                        <span>
                            <h2>客服部</h2>
                            <h3>一个有责任的团队，7*24小时服务，急客户之所急，全天候待命。</h3>
                        </span>
                    </div>
                </li>
                <li>
                    <div class="imgNormal">
                        <img src="images/about04.png" alt="">
                        <h1>培训商学院&nbsp;&nbsp;|&nbsp;&nbsp;Business School</h1>
                    </div>
                    <div class="imgHover">
                        <img src="images/about04.png" alt="">
                        <span>
                            <h2>培训商学院</h2>
                            <h3>紧密联系公司发展战略，制定培训计划，适时做出调整并带领团队适应和高速的学习新计划。</h3>
                        </span>
                    </div>
                </li>
                <li>
                    <div class="imgNormal">
                        <img src="images/about05.png" alt="">
                        <h1>市场部&nbsp;&nbsp;|&nbsp;&nbsp;Marketing</h1>
                    </div>
                    <div class="imgHover">
                        <img src="images/about05.png" alt="">
                        <span>
                            <h2>市场部</h2>
                            <h3>高效率的团队，向客户传达公司最新的销售政策和市场动态信息，企业的“内容生产商”。</h3>
                        </span>
                    </div>
                </li>
                <li>
                    <div class="imgNormal">
                        <img src="images/about06.png" alt="">
                        <h1>行政部&nbsp;&nbsp;|&nbsp;&nbsp;Administrative</h1>
                    </div>
                    <div class="imgHover">
                        <img src="images/about06.png" alt="">
                        <span>
                            <h2>行政部</h2>
                            <h3>暖心的团队，承上启下，把各部门联结成一个健康运行的有机整体 ,保证企业发展目标顺利实现。</h3>
                        </span>
                    </div>
                </li>
                <li>
                    <div class="imgNormal">
                        <img src="images/about07.png" alt="">
                        <h1>人事部&nbsp;&nbsp;|&nbsp;&nbsp;Personnel</h1>
                    </div>
                    <div class="imgHover">
                        <img src="images/about07.png" alt="">
                        <span>
                            <h2>人事部</h2>
                            <h3>负责企业的管理制度的制定和人才招聘，人员管理等事务。</h3>
                        </span>
                    </div>
                </li>
                <li>
                    <div class="imgNormal">
                        <img src="images/about08.png" alt="">
                        <h1>财务部&nbsp;&nbsp;|&nbsp;&nbsp;Finance Department</h1>
                    </div>
                    <div class="imgHover">
                        <img src="images/about08.png" alt="">
                        <span>
                            <h2>财务部</h2>
                            <h3>无比严谨的团队，根据企业资金运作情况，合理调配资金，确保企业资金正常运转。</h3>
                        </span>
                    </div>
                </li>
            </ul>
        </div>
        <div class="aboutT">
        <a name="4f" style=" height:100px; display:block;"></a>
            <h1>荣誉资质</h1>
            <i></i>
        </div>
        <div class="honor-aboutP">
            <ul>
                <li>
                    <img src="images/honor01.png" alt=""></li>
                <li>
                    <img src="images/honor02.png" alt=""></li>
                <li>
                    <img src="images/honor03.png" alt=""></li>
                <li>
                    <img src="images/honor04.png" alt=""></li>
                <li>
                    <img src="images/honor05.png" alt=""></li>
            </ul>
        </div>
        <div class="bz">
            <h4>注：杭州心动营销策划有限公司与示远科技（杭州）有限公司的为同一控股平行公司</h4>
        </div>
    </div>
    <a name="5f" style=" height:100px; display:block;"></a>
    <div class="address" style="width:100%;height:620px"><iframe frameborder="0" scrolling="no" class="mapBox" style="width:100%;height:620px" src="map.html"></iframe></div>

</asp:Content>
