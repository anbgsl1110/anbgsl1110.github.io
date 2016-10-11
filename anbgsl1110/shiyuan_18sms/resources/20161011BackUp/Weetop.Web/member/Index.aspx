<%@ Page Title="" Language="C#" MasterPageFile="~/member/MemBase.master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Weetop.Web.member.Index" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Weetop.Web.member" %>
<%@ Import Namespace="Weetop.DAL" %>
<%@ Import Namespace="Weetop.Model" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cpHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cpBody" runat="server">

    <a href="Account.aspx">进入会员中心</a>
    <%


#region DES加密测试

//Logg.Debug(typeof(Index), "jishu01 DES: " + ShiYuanAPI.DesEncrypto("jishu01", false));//LW4Zjb8dOww=
//Logg.Debug(typeof(Index), "LW4Zjb8dOww= DES: " + ShiYuanAPI.DesDecrypto("LW4Zjb8dOww=", false));//jishu01

#endregion DES加密测试


#region 接口测试


//var api = new ShiYuanAPI();
//var result = "";


//var testAccount = "test0521";//test0516
//var extno = "4803";//4800
//var t = typeof(Index);

////开户接口测试，account ac_password true_name contact_mobile extno pro_list
//result = api.UserManage(t, testAccount, "abcd1234,./", "CompanyName", "18058105028", extno, "1662425");

////充值接口测试
//result = api.Recharge(t, testAccount, 1000, 1, "1662425");

////查询帐号额度接口测试
//result = api.QueryAccountBalance(t, testAccount);

////查询统计报表接口测试
//result = api.QueryReportSys(t, testAccount, DateTime.Now.AddMonths(-3).ToString("yyyyMMdd"), DateTime.Now.ToString("yyyyMMdd"));

////查询发送记录接口测试
//result = api.QueryMtSys(t, testAccount, "18058105028", DateTime.Now);

////同步模板接口测试
//result = api.SmsTemplateSys(t, testAccount, ".*验证码.*", 1, 1, 1);


//var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
//while (!sr.EndOfStream)
//{
//    var str = sr.ReadLine();
//}


#endregion 接口测试


#region 生成开户接口extno扩展码，只需要运行一次

//int[] arr = new int[2000 - 0];
//for (int i = 0; i < arr.Length; i++)
//{
//    arr[i] = i;
//}
//Item<int> disrupter = new Item<int>(arr);
//int[] disupterArr = disrupter.GetDisruptedItems();

//var list = disupterArr.Select(s => new RdmNumber() { Num = s });

//SiteRdmNum.Add(list);

#endregion 生成开户接口extno扩展码，只需要运行一次


#region 发短信接口

//var phone = "18058105026";
//var msg = string.Format(Common.AppSettings["SMSALERT"], "", 200);
//string res = ShiYuanSMS.SendSMS(phone, msg);
//var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(res ?? "")));
//var str = sr.ReadLine();
//Response.Write(str);
//Response.End();

#endregion 发短信接口


    %>
</asp:Content>
