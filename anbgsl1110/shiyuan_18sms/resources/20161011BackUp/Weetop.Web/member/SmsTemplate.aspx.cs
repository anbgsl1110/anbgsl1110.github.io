using OctoLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.member
{
    public partial class SmsTemplate : FrontBasic
    {

        protected List<TemplateSign> signList = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string action = Request["ac"];
                switch (action)
                {
                    case "1": //add
                        Add();
                        break;
                    case "2"://search
                        GetPage();
                        break;
                    case "3":
                        Del();
                        break;
                    default:
                        signList = SiteSignTemp.GetList(TUser.UserId);
                        break;
                }
            }
        }




        private void Add()
        {
            Response.ContentType = "application/json";

            var title = Request["title"];
            var content = Request["cont"];
            var smsType = Request["SmsType"];
            var signTxt = SiteSignTemp.GetCont(Common.ToLong(Request["sign"]));
            var remark = Request["rem"];

            if ((string.IsNullOrEmpty(title) || title.Length > 30) ||
                (string.IsNullOrEmpty(content) || content.Length > 290) ||
                string.IsNullOrEmpty(smsType) ||
                string.IsNullOrEmpty(signTxt) ||
                (string.IsNullOrEmpty(remark) || remark.Length > 250))
            {
                Response.Write(Common.Json("Err", "无效参数"));
                Response.End();
            }


            var entity = new TemplateSms()
            {
                UserId = TUser.UserId,
                Title = title,
                Content = content + "【" + signTxt + "】",//加上签名模板
                ProId = 1,//短信验证码
                SmsType = Common.ToInt(smsType),
                Remark = remark,
                CheckStatus = (int)TempCheckStatus.等待审核,
                CreateDate = DateTime.Now,
                UpdateDate = DateTime.Now
            };

            SiteSmsTemp.Add(entity);
            UserInfo usr = SiteUser.GetUserInfo(TUser.UserId);
            string emailTitle = "用户: " + usr.Phone + "申请新增短信模板!";
            string emailContent = "用户" + usr.Phone + "申请新增短信模板.<br/>模板名称为: " + entity.Title + "<br/>内容为: 【" + entity.Content + "】";
            EmailHp.SendEmail("1743165047@qq.com", emailTitle, emailContent);
            Response.Write(Common.Json("OK", "添加成功"));
            Response.End();

        }


        private void GetPage()
        {
            Response.ContentType = "application/json";

            var searchText = Request["st"];

            var page = Common.ToInt(Request["page"], 1);
            PageParams pp = new PageParams(page);

            var list = SiteSmsTemp.GetList(ref pp, TUser.UserId, searchText);

            var tempList = new List<object>();

            foreach (var item in list)
            {
                var temp = new
                {
                    id = item.Id,
                    title = item.Title,
                    content = item.Content,
                    smstype = ((TempSmsType)item.SmsType.Value).ToString(),
                    //remark = item.Remark,
                    date = item.CreateDate.Value.ToString("yyyy-MM-dd hh:mm"),
                    status = item.CheckStatus,
                    statusTxt = ((TempCheckStatus)item.CheckStatus.Value).ToString(),
                    feedback = item.Feedback
                };
                tempList.Add(temp);
            }

            var obj = new
            {
                pages = pp.Pages,
                list = tempList
            };

            Response.Write(Common.Json("OK", "操作成功", obj));
            Response.End();
        }


        private void Del()
        {
            Response.ContentType = "application/json";

            var tid = Common.ToLong(Request["tid"]);
            var entity = SiteSmsTemp.GetOne(tid);
            if (entity == null)
            {
                Response.Write(Common.Json("OK", "无效参数"));
                Response.End();
            }

            if (entity.CheckStatus.Value == (int)TempCheckStatus.通过审核)
            {
                //TODO 先用API同步删除再删除本地

                //SiteSmsTemp.Delete(tid);
                Response.Write(Common.Json("OK", "删除成功"));
                Response.End();
            }
            else
            {
                //直接删除本地
                SiteSmsTemp.Delete(tid);
                Response.Write(Common.Json("OK", "删除成功"));
                Response.End();
            }

        }


    }
}