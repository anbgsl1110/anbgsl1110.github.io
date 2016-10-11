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
    public partial class ConsultSrv : FrontBasic
    {
        protected List<ConsultingService> consultingService = new List<ConsultingService>();
        protected ConsultingService customerService;
        protected ConsultingService businessService;
        protected string  customerHref = " ";//客服QQ沟通链接
        protected string customerImgUrl = " ";//客服头像链接
        protected string  businessHref = " ";//商务QQ沟通链接
        protected string businessImgUrl = " ";//商务头像链接
        protected void Page_Load(object sender, EventArgs e)
        {
            GetConsultingService();
        }

        /// <summary>
        /// 获取用户咨询服务人员
        /// </summary>
        private void GetConsultingService()
        {
            consultingService  = SiteConsultingService.GetByBoundListUserId(TUser.UserId);
            //获取满足条件的第一个客服对象
            for (int i = 0; i < consultingService.Count; i++)
            {
                if (consultingService.ElementAt(i).cateId == 1)
                {
                    customerService = consultingService.ElementAt(i);
                    customerHref = "http://wpa.qq.com/msgrd?v=3&uin=" + customerService.QQNumber + "&site=qq&menu=yes";
                    if(!string.IsNullOrWhiteSpace(customerService.ImgUrl))
                    {
                        customerImgUrl = "../" + customerService.ImgUrl;
                    }
                    break;
                }
            }
            //获取满足条件的第一个商务对象
            for (int i = 0; i < consultingService.Count; i++)
            {
                if (consultingService.ElementAt(i).cateId == 2)
                {
                    businessService = consultingService.ElementAt(i);
                    businessHref = "http://wpa.qq.com/msgrd?v=3&uin=" + businessService.QQNumber + "&site=qq&menu=yes";
                    if (!string.IsNullOrWhiteSpace(businessService.ImgUrl))
                    {
                        businessImgUrl = "../" + businessImgUrl;
                    }
                    break;
                }
            }
        }
    }
}