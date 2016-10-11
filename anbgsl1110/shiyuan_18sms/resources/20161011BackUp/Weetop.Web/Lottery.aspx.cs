using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web
{
    public partial class Lottery : FrontBasic
    {
        private string[] telStarts = "134,135,136,137,138,139,150,151,152,157,158,159,130,131,132,155,156,133,153,180,181,182,183,185,186,176,187,188,189,177,178".Split(',');
        private string[] WinningName = "500元话费,100元话费,10G流量,2G流量,300元话费,400元话费".Split(',');
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string ac = Request["action"] == null ? "" : Request["action"].ToString();
                switch (ac)
                {
                    case "lt":
                        ZhuanPan();
                        break;
                    case "wi":
                        GetWinningInfo();
                        break;
                    case "ut":
                        UpdateWinningInfo();
                        break;
                    default:
                        GetNumBer();
                        break;
                }
            }
            
        }
        public void UpdateWinningInfo() 
        {
            string tp = Request["type"] == null ? "" : Request["type"].ToString();
            if (tp != "")
            {
                if (tp == "x")
                {
                    string phone = Request["tel"].ToString();
                    string dates = Request["dates"].ToString();
                    UserWinningInfo ui = SiteUserWinningInfo.GetOne(new Guid(dates));
                    ui.ConsigneePhone = phone;
                    SiteUserWinningInfo.Update(ui, new Guid(dates));
                    Response.Write(Common.Json("OK", "提交成功"));
                    Response.End();
                }
                else if (tp == "s")
                {
                    string ConsigneeName = Request["name"].ToString();
                    string ConsigneePhone = Request["tel"].ToString();
                    string ConsigneeAddr = Request["add"].ToString();
                    string ConsigneeCompany = Request["co"].ToString();
                    string ConsigneePosition = Request["job"].ToString();
                    string dates = Request["dates"].ToString();

                    UserWinningInfo ui = SiteUserWinningInfo.GetOne(new Guid(dates));
                    ui.ConsigneePhone = ConsigneePhone;
                    ui.ConsigneeName = ConsigneeName;
                    ui.ConsigneeAddr = ConsigneeAddr;
                    ui.ConsigneeCompany = ConsigneeCompany;
                    ui.ConsigneePosition = ConsigneePosition;
                    SiteUserWinningInfo.Update(ui, new Guid(dates));
                    Response.Write(Common.Json("OK", "提交成功"));
                    Response.End();
                }
            }
            else
            {

            }
        }

        public void GetWinningInfo()
        {
            List<UserWinningInfo> WinningInfo = SiteUserWinningInfo.GetList();
            foreach (var item in WinningInfo)
            {
                item.Datetim = item.WinningDate.ToString("yyyy/MM/dd");
                if (!string.IsNullOrEmpty(item.Phone) && item.Phone.Length == 11)
                {
                    item.Phone = item.Phone.Substring(0, 3) + "****" + item.Phone.Substring(7, 4);
                }
            }
            Random ran = new Random();
            for (int i = 0; i < 20; i++)
            {
                WinningInfo.Add(getUserWinningInfo(ran));
            }
            Response.Write(Common.Json("OK", WinningInfo.Count.ToString(), WinningInfo));
            Response.End();
        }

        public UserWinningInfo getUserWinningInfo(Random ran)
        {
            int telStartsIndex = ran.Next(0, telStarts.Length - 1);
            int WinningNameIndex = ran.Next(0, WinningName.Length - 1);

            UserWinningInfo wi = new UserWinningInfo();
            string first = telStarts[telStartsIndex];
            string thrid = (ran.Next(1, 9100) + 10000).ToString().Substring(1);
            wi.Phone = first + "****" + thrid;
            wi.WinningPrizeName = WinningName[WinningNameIndex];
            wi.Datetim = DateTime.Today.ToString("yyyy/MM/dd");
            return wi;
        }

        public string getRandomTel()
        {
            int index = new Random().Next(0, telStarts.Length - 1);
            string first = telStarts[index];
            //string second = (ran.Next(100, 888) + 10000).ToString().Substring(1);
            string thrid = (new Random().Next(1, 9100) + 10000).ToString().Substring(1);
            return first + "****" + thrid;

        }
        public string getWinningName()
        {
            int index = new Random().Next(0, WinningName.Length - 1);
            return WinningName[index];
        }


        public void GetNumBer()
        {
            try
            {
                if (TUser == null)
                    chnum.InnerText = "0";
                else
                {
                    //判断用户次数
                    Guid userID = TUser.UserId;
                    UserRecharge ur = SiteUserRecharge.GetOne(userID);
                    if (ur == null)
                        chnum.InnerText = "0";
                    else if (ur.LotteryNumber > 0)
                        chnum.InnerText = ur.LotteryNumber.ToString();
                    else
                        chnum.InnerText = "0";
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        //随机数
        static Random Rnd = new Random();
        public void ZhuanPan()
        {
            try
            {
                if (TUser == null)
                {
                    ResponseJson("Err", "请登录后再抽奖哦!");
                }
                //判断用户次数
                Guid userID = TUser.UserId;
                UserRecharge ur = SiteUserRecharge.GetOne(userID);
                if (ur != null && ur.LotteryNumber > 0)
                {
                    string result = string.Empty;
                    //定义奖品和概率
                    List<Model.Prize> szZP;

                    szZP = SitePrize.GetList();
                    int sum = 0;
                    foreach (var item in szZP)//获取总概率
                    {
                        sum += item.PrizeProbability;
                    }
                    Prize p = ChouJiang(szZP, sum);
                    if (p == null)
                    {
                        ResponseJson("Err", "目前抽奖人数过多，请重新抽奖!");
                    }
                    SitePrize.UpdatePrizeNumber(p); //抽中奖品库存减1
                    SiteUserRecharge.Update(ur); //更新用户次数
                    UserInfo ui = SiteUser.GetUserInfo(TUser.UserId);
                    DateTime dt = DateTime.Now;
                    Guid g = Guid.NewGuid();
                    if (ui != null)
                    {
                        UserWinningInfo uwi = new UserWinningInfo();
                        uwi.UserId = ui.UserId;
                        uwi.Phone = ui.Phone;
                        uwi.WinningDate = dt;
                        uwi.WinningPrizeID = p.Id;
                        uwi.WinningPrizeName = p.PrizeName;
                        uwi.OnlyLable = g;
                        SiteUserWinningInfo.Add(uwi); //增加用户中奖信息
                    }
                    //指针 奖品名字 次数 手机号 时间 用户中奖信息唯一标示
                    result += p.PrizePointer + "," + p.PrizeName + "," + (ur.LotteryNumber - 1).ToString() + "," + ui.Phone + "," + dt.ToString("yyyy/MM/dd") + "," + g;
                    ResponseJson("OK", result);
                }
                else
                {
                    ResponseJson("Err", "您还没可用抽奖次数哦！快去充值吧！");
                }
            }
            catch (Exception err)
            {
                
            }
        }
        //抽奖计算
        private static Prize ChouJiang(List<Model.Prize> szZP,int sum)
        {
            if (szZP.Count > 0)
            {
                return (from x in Enumerable.Range(0, 1000000)  //最多随机100万次
                        let sjcp = szZP[Rnd.Next(szZP.Count())]
                        let zgz = Rnd.Next(0, sum)  //概率按照百分之几
                        where zgz < sjcp.PrizeProbability
                        select sjcp).First();
            }
            else
            {
                return null;
            }
        }
        public void ResponseJson(string state,string info)
        {
            Response.ContentType = "application/json";
            Response.Clear();
            Response.Write(Common.Json(state, info));
            Response.End();
        }
    }
}