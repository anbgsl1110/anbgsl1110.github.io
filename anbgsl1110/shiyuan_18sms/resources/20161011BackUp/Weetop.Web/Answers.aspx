<%@ Page Title="" Language="C#" MasterPageFile="~/FrontBase.Master" AutoEventWireup="true" CodeBehind="Answers.aspx.cs" Inherits="Weetop.Web.Answers" %>

<%@ Import Namespace="Weetop.DAL" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>问答中心_短信验证码_语音验证码_短信营销_通知短信_国际短信_平台,接口,通道-示远科技|极致短信验证码</title>
    <link href="css/answers.css" rel="stylesheet" />
    <meta name="keywords" content="短信验证码,语音验证码,短信营销,通知短信,国际短信,短信验证码平台,短信验证码接口,短信通道">
    <meta name="description" content="问答中心详细介绍了短信验证码，语音验证码，短信营销，通知短信，国际短信，短信验证码平台，短信验证码接口，短信通道的价格、费用、介绍等，短信平台找示远妥妥的放心。">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="NYbanner As_banner" style="background: url(/images/answers_banner.png) no-repeat center center; width: 100%; min-width: 1200px; height: 397px;">
    </div>
    <div class="as_center">
        <div class="position">
            <span>当前位置：</span>
            <span><a href="/Answers">问答中心></a></span>
            <span><a href="#" id="aPosition" runat="server"></a></span>
        </div>
        <div class="as_box">
            <a name="sms" href="#" style="position:absolute;top:350px;"></a>
            <ul class="as_fl">
                <li class="all" style="font-size:15px;">全部分类</li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/dxsms">短信验证码</a>
                </li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/vovc">语音验证码</a>
                </li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/msms">短信营销</a>
                </li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/notsms">通知短信</a>
                </li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/insms">国际短信</a>
                </li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/smsjog">短信接口</a>
                </li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/smsroof">短信平台</a>
                </li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/smsentry">短信通道</a>
                </li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/smspt">短信验证码平台</a>
                </li>
                <li class="nav">
                    <span class="as_icon">
                        <img src="images/as_icon.png" alt="" /></span>
                    <a class="as_nav" href="/ask/smsjk">短信验证码接口</a>
                </li>
            </ul>

            <div class="as_fr">
                <div class="as_top">
                    <img src="images/as_top.jpg" alt="Alternate Text" />
                </div>
                <div class="as_list">
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a class="as_title" href="/ask/dxsms">短信验证码</a>
                            <span><a class="more" href="/ask/dxsms">更多></a></span>
                        </li>
                        <li class="line02">
                            <span class="">
                                <img src="images/as_icon01.png" alt="" /></span>
                            <span class="title02">短信验证码主要用于用户注册、身份验证、重要资料修改或寻回、网上支付等场景。</span>
                        </li>
                        <li class="line03">
                            <div class="wt_fl">
                                <%for (int i = 0; i < dxyzm.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                                        <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxyzm[i].CateId)) %>/<%=dxyzm[i].Id %>"><%=dxyzm[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (dxyzm.Count > 2)
                                   {
                                       for (int i = 3; i < dxyzm.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxyzm[i].CateId)) %>/<%=dxyzm[i].Id %>"><%=dxyzm[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a href="/ask/vovc" class="as_title">语音验证码</a>
                            <span><a class="more" href="/ask/vovc">更多></a></span>
                        </li>
                        <li class="line02">
                            <span>
                                <img src="images/as_icon02.png" alt="" /></span>
                            <span class="title02">语音验证码是通过软件识别网站验证码，再在电脑上通过TTS语音播放给用户听到的方式。</span>
                        </li>
                        <li class="line03">
                            <div class="wt_fl">
                                <%for (int i = 0; i < yyyzm.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(yyyzm[i].CateId)) %>/<%=yyyzm[i].Id %>"><%=yyyzm[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (yyyzm.Count > 2)
                                   {
                                       for (int i = 3; i < yyyzm.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(yyyzm[i].CateId)) %>/<%=yyyzm[i].Id %>"><%=yyyzm[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="as_list">
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a href="/ask/msms" class="as_title">短信营销</a>
                            <span><a class="more" href="/ask/msms">更多></a></span>
                        </li>
                        <li class="line02">
                            <span class="">
                                <img src="images/as_icon03.png" alt="" /></span>
                            <span class="title02">营销短信以营销为目的通过短信的方式发送到用户手机上的一种营销方式。</span>
                        </li>
                        <li class="line03">
                           <div class="wt_fl">
                                <%for (int i = 0; i < yxdx.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                               <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(yxdx[i].CateId)) %>/<%=yxdx[i].Id %>"><%=yxdx[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (yxdx.Count > 2)
                                   {
                                       for (int i = 3; i < yxdx.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(yxdx[i].CateId)) %>/<%=yxdx[i].Id %>"><%=yxdx[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a href="/ask/notsms" class="as_title">通知短信</a>
                            <span><a class="more" href="/ask/notsms">更多></a></span>
                        </li>
                        <li class="line02">
                            <span class="">
                                <img src="images/as_icon04.png" alt="" /></span>
                            <span class="title02">通知短信指通过发送内容为通知或提醒的短信到用户手机，用于及时准确的提醒用户。</span>
                        </li>
                        <li class="line03">
                            <div class="wt_fl">
                                <%for (int i = 0; i < tzdx.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(tzdx[i].CateId)) %>/<%=tzdx[i].Id %>"><%=tzdx[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (tzdx.Count > 2)
                                   {
                                       for (int i = 3; i < tzdx.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(tzdx[i].CateId)) %>/<%=tzdx[i].Id %>"><%=tzdx[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="as_list">
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a href="/ask/insms" class="as_title">国际短信</a>
                            <span><a class="more" href="/ask/insms">更多></a></span>
                        </li>
                        <li class="line02">
                            <span class="">
                                <img src="images/as_icon05.png" alt="" /></span>
                            <span class="title02">国际短信指国内的手机客户与大陆以外国家或地区运营商的客户之间发送和接收短信的业务。</span>
                        </li>
                        <li class="line03">
                            <div class="wt_fl">
                                <%for (int i = 0; i < gjdx.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(gjdx[i].CateId)) %>/<%=gjdx[i].Id %>"><%=gjdx[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (gjdx.Count > 2)
                                   {
                                       for (int i = 3; i < gjdx.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(gjdx[i].CateId)) %>/<%=gjdx[i].Id %>"><%=gjdx[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a href="/ask/smsjog" class="as_title">短信接口</a>
                            <span><a class="more" href="/ask/smsjog">更多></a></span>
                        </li>
                        <li class="line02">
                            <span class="">
                                <img src="images/as_icon06.png" alt="" /></span>
                            <span class="title02">短信接口是面向有一定技术开发能力的企业用户而单独研发的短信（sms）接口。</span>
                        </li>
                        <li class="line03">
                            <div class="wt_fl">
                                <%for (int i = 0; i < dxjk.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxjk[i].CateId)) %>/<%=dxjk[i].Id %>"><%=dxjk[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (dxjk.Count > 2)
                                   {
                                       for (int i = 3; i < dxjk.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxjk[i].CateId)) %>/<%=dxjk[i].Id %>"><%=dxjk[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="as_list">
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a href="/ask/smsroof" class="as_title">短信平台</a>
                            <span><a class="more" href="/ask/smsroof">更多></a></span>
                        </li>
                        <li class="line02">
                            <span class="">
                                <img src="images/as_icon07.png" alt="" /></span>
                            <span class="title02">短信平台基于中国三大运营商直接提供的短信端口与客户指定号码进行短信批量或自定义发送系统。</span>
                        </li>
                        <li class="line03">
                            <div class="wt_fl">
                                <%for (int i = 0; i < dxpt.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxpt[i].CateId)) %>/<%=dxpt[i].Id %>"><%=dxpt[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (dxpt.Count > 2)
                                   {
                                       for (int i = 3; i < dxpt.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxpt[i].CateId)) %>/<%=dxpt[i].Id %>"><%=dxpt[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a href="/ask/smsentry" class="as_title">短信通道</a>
                            <span><a class="more" href="/ask/smsentry">更多></a></span>
                        </li>
                        <li class="line02">
                            <span class="">
                                <img src="images/as_icon08.png" alt="" /></span>
                            <span class="title02">短信通道由中国三大运营商直接提供接口，能给客户指定号码进行短信批量发送和自定义发送的通道。</span>
                        </li>
                        <li class="line03">
                           <div class="wt_fl">
                                <%for (int i = 0; i < dxtd.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                               <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxtd[i].CateId)) %>/<%=dxtd[i].Id %>"><%=dxtd[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (dxtd.Count > 2)
                                   {
                                       for (int i = 3; i < dxtd.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxtd[i].CateId)) %>/<%=dxtd[i].Id %>"><%=dxtd[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="as_list">
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a  href="/ask/smspt" class="as_title">短信验证码平台</a>
                            <span><a class="more" href="/ask/smspt">更多></a></span>
                        </li>
                        <li class="line02">
                            <span class="">
                                <img src="images/as_icon09.png" alt="" /></span>
                            <span class="title02">短信验证码平台拥有三大运营商直接提供的短信端口，并给客户提供短信验证码发送服务的平台。</span>
                        </li>
                        <li class="line03">
                            <div class="wt_fl">
                                <%for (int i = 0; i < dxyzmpt.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxyzmpt[i].CateId)) %>/<%=dxyzmpt[i].Id %>"><%=dxyzmpt[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (dxyzmpt.Count > 2)
                                   {
                                       for (int i = 3; i < dxyzmpt.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxyzmpt[i].CateId)) %>/<%=dxyzmpt[i].Id %>"><%=dxyzmpt[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                    <ul class="as_xq">
                        <li class="line01">
                            <span class="line"></span>
                            <a href="/ask/smsjk" class="as_title">短信验证码接口</a>
                            <span><a class="more" href="/ask/smsjk">更多></a></span>
                        </li>
                        <li class="line02">
                            <span class="">
                                <img src="images/as_icon10.png" alt="" /></span>
                            <span class="title02">短信验证码接口具有网站或者客户端应用需要接入短信验证码功能的接口文档。</span>
                        </li>
                        <li class="line03">
                             <div class="wt_fl">
                                <%for (int i = 0; i < dxyzmjk.Count; i++)
                                  {
                                      if (i < 3)
                                      {%>
                                 <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxyzmjk[i].CateId)) %>/<%=dxyzmjk[i].Id %>"><%=dxyzmjk[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                      <%}


                                  } %>
                            </div>
                            <div class="wt_fr">
                                <% if (dxyzmjk.Count > 2)
                                   {
                                       for (int i = 3; i < dxyzmjk.Count; i++)
                                       {%>
                                <a href="AnswersDetail/<%= GetNameById(Convert.ToInt32(dxyzmjk[i].CateId)) %>/<%=dxyzmjk[i].Id %>"><%=dxyzmjk[i].Title.ToString().RemoveHtmlTag(13)  %></a>
                                <%  }
                                   } %>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

        </div>
    </div>


</asp:Content>
