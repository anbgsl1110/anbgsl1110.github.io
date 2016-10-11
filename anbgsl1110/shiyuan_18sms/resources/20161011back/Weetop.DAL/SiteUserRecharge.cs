using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteUserRecharge
    {
        private SiteUserRecharge() { }

        public static void Add(UserRecharge entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.UserRecharge.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }
        public static UserRecharge GetOne(Guid? uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserRecharge.SingleOrDefault(w => w.UserId == uid);
            }
        }

        public static bool IsRecharge(Guid? uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserRecharge.SingleOrDefault(w => w.UserId == uid);
                if (temp != null)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        public static void Update(UserRecharge entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserRecharge.SingleOrDefault(s => s.Id == entity.Id); //Iphone的ID默认为0
                temp.LotteryNumber = entity.LotteryNumber - 1;
                db.SubmitChanges();
            }
        }
    }
}