using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.BLL;
using Weetop.DAL;

namespace Weetop.Web.member
{
    public partial class VoiceCount : FrontBasic
    {

        protected bool Pro4Opened = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                Pro4Opened = SiteFund.CheckProOpened(TUser.UserId, 4);

                var op = Request["op"];
                switch (op)
                {
                    case "1":
                        if (!Pro4Opened)
                        {
                            Response.ContentType = "application/json";
                            Response.Write(Common.Json("Err", "您未开通此应用，服务不可用"));
                            Response.End();
                        }
                        GetChartJson();
                        break;
                    case "2":
                        if (!Pro4Opened)
                        {
                            Response.ContentType = "application/json";
                            Response.Write(Common.Json("Err", "您未开通此应用，服务不可用"));
                            Response.End();
                        }
                        GetPage();
                        break;
                }
            }
        }


        private void GetChartJson()
        {
            Response.ContentType = "application/json";

            if (string.IsNullOrEmpty(Request["dt1"]) || string.IsNullOrEmpty(Request["dt2"]))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var startDate = Common.ToDateTime(Request["dt1"]);
            var endDate = Common.ToDateTime(Request["dt2"]);
            int SendSuccess = 0;
            int SendErr = 0;
            int UnknownState = 0;
            int SendCount = 0;
            List<string> labelsList;//标签
            List<string> backgroundColorList; //颜色集合
            List<int> DatacList; //数据集合
            var datasetList = new List<object>();

            var api = new ShiYuanAPI();
            var temp = SiteFund.GetProductFunds(TUser.UserId, 4);//1,3,4
            var account = temp.SyAccount;

            var result = api.QueryReportSys(typeof(VoiceCount), account ?? "", startDate.ToString("yyyyMMdd"), endDate.ToString("yyyyMMdd"));
            //var result = "20130303180000,0\r\n20160118,10000,8000,1500,500\r\n20160117,30000,28500,34,200\r\n20160116,45566,20004,534,0\r\n20160115,34556,6767,45,500\r\n20160114,34523,453,4545,200\r\n20160113,22005,23454,4455,0\r\n20160112,23454,23423,6,0";

            var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
            var str = sr.ReadLine();
            int value = -1;
            try
            {
                value = Common.ToInt(str.Split(',')[1], -1);//第一行判断操作是否成功
            }
            catch (Exception ex)
            {
                Response.Write(Common.Json("Err", str));
                Response.End();
            }

            if (value == 0)
            {
                while (!sr.EndOfStream)
                {
                    str = sr.ReadLine();
                    var arr = str.Split(',');
                    //arr[0]为日期
                    SendCount += Convert.ToInt32(arr[1]);
                    SendSuccess += Convert.ToInt32(arr[2]);
                    SendErr += Convert.ToInt32(arr[3]);
                    UnknownState += Convert.ToInt32(arr[4]);
                }
                DatacList = new List<int>(new int[] { SendSuccess, SendErr, UnknownState });
                backgroundColorList = new List<string>(new string[] { "#548B54", "#CD2626", "#FDB45C" });
                labelsList = new List<string>(new string[] { "发送成功", "发送失败", "未知状态" });
                datasetList.AddRange(new List<object>
                {
                    new {
                        data = DatacList.ToArray(),
                        backgroundColor = backgroundColorList.ToArray()
                    }
                });
                var data = new
                {
                    datasets = datasetList.ToArray(),
                    labels = labelsList.ToArray()
                };

                Response.Write(Common.Json("OK", "加载成功", data));
                Response.End();
            }
            else
            {
                Response.Write(Common.Json("Err", "加载失败，请稍后再试(" + value + ")"));
                Response.End();
            }
        }



        private void GetPage()
        {
            Response.ContentType = "application/json";

            if (string.IsNullOrEmpty(Request["phone"]) || string.IsNullOrEmpty(Request["dt"]))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            var phone = Request["phone"].Trim();
            var dt = Common.ToDateTime(Request["dt"]);

            //TODO 可使用缓存，暂存Session
            var dataList = new List<object>();

            var api = new ShiYuanAPI();
            var temp = SiteFund.GetProductFunds(TUser.UserId, 4);//1,3,4
            var account = temp.SyAccount;

            if (Session[account + phone + dt] == null)
            {
                var result = api.QueryMtSys(typeof(VoiceCount), account ?? "", phone, dt);
                //var result = "20130303180000,0\r\n20160118123055,20160118123106,DELIVRD,内容1\r\n20160118123055,,,内容2\r\n20160118123055,20160118123106,UNDELIV,内容3";

                var sr = new StreamReader(new MemoryStream(Encoding.UTF8.GetBytes(result ?? "")));
                var str = sr.ReadLine();
                int value = -1;
                try
                {
                    value = Common.ToInt(str.Split(',')[1], -1); //第一行判断操作是否成功
                }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", str));
                    Response.End();
                }

                if (value == 0)
                {
                    while (!sr.EndOfStream)
                    {
                        str = sr.ReadLine();
                        var arr = str.Split(',');
                        if (arr[0] == "")
                        {
                            arr[0] = DateTime.Now.ToString("yyyyMMddHHmmss");
                        }
                        if (arr[1] == "")
                        {
                            arr[1] = DateTime.Now.ToString("yyyyMMddHHmmss");
                        }
                        dataList.Add(new
                        {
                            date1 = DateTime.ParseExact(arr[0], "yyyyMMddHHmmss", null).ToString("yyyy-MM-dd hh:mm:ss"),
                            date2 = DateTime.ParseExact(arr[1], "yyyyMMddHHmmss", null).ToString("yyyy-MM-dd hh:mm:ss"),
                            stat = arr[2],
                            txt = arr[3]
                        });
                    }

                    Session[account + phone + dt] = dataList;
                }
                else
                {
                    Response.Write(Common.Json("Err", "操作失败，请稍后再试(" + value + ")"));
                    Response.End();
                }

            }
            else
            {
                dataList = (List<object>)Session[account + phone + dt];
            }

            if (dataList == null)
            {
                Response.Write(Common.Json("OK", "操作失败，请稍后再试"));
                Response.End();
            }

            var page = Common.ToInt(Request["page"], 1);
            PageParams pp = new PageParams(page);

            pp.TotalCount = dataList.Count();

            var tempList = dataList.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();

            var obj = new
            {
                pages = pp.Pages,
                list = tempList
            };

            Response.Write(Common.Json("OK", "操作成功", obj));
            Response.End();
        }

    }
}