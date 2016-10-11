using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SitePrize
    {
        private SitePrize() { }

        public static List<Prize> GetList()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                string strSql = "select count(*) FROM UserWinningInfo WHERE datediff(week,WinningDate,getdate()) = 0 AND WinningPrizeID = 1";
                var query = db.ExecuteQuery<int>(strSql);
                var temp = db.Prize.SingleOrDefault(s => s.Id == 1); //Iphone的ID默认为0
                if (query.FirstOrDefault<int>() == 1)
                    temp.states = 1;
                else
                {
                    temp.states = 0;
                }
                db.SubmitChanges();
                return db.Prize.Where(p => p.states == 0 && p.PrizeNumber > 0).OrderByDescending(p => p.Id).ToList();
            }
        }
        public static void UpdatePrizeNumber(Prize entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Prize.SingleOrDefault(s => s.Id == entity.Id);
                if (temp != null)
                {
                    temp.PrizeNumber = temp.PrizeNumber - 1;
                    db.SubmitChanges();
                }     
            }
        }
    }
}
