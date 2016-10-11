using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteUserWinningInfo
    {
        private SiteUserWinningInfo() { }

        public static void Add(UserWinningInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {                
                db.UserWinningInfo.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }
        public static void Delete(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserWinningInfo.SingleOrDefault(w => w.Id == id);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.UserInfo.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }
        public static List<UserWinningInfo> GetList()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserWinningInfo.Where(w=>w.IsDeleted==false).OrderByDescending(p => p.WinningDate).ToList();
            }
        }

        public static List<UserWinningInfo> GetList(ref PageParams pp, int? oType = null, string searchText = null, string timeRange = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserWinningInfo.Where(w=>w.IsDeleted!=true);

                if (oType.HasValue && oType > -1)
                {
                    temp = temp.Where(w => w.Status == oType.Value);
                }
                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    temp = from tm in temp
                           where tm.ConsigneeCompany.Contains(searchText) || tm.ConsigneePhone.Contains(searchText)
                           select tm;
                }
                if (!string.IsNullOrWhiteSpace(timeRange))
                {
                    List<DateTime> dt = timeRange.Split('-').Select(s => Convert.ToDateTime(s.Trim())).ToList();
                    temp = temp.Where(w => w.WinningDate >= dt[0] && w.WinningDate < dt[1]);
                }

                if (pp.AllowPaging)
                {
                    pp.TotalCount = temp.Count();

                    return temp.OrderByDescending(o => o.WinningDate).Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp.OrderByDescending(o => o.WinningDate).ToList();
                }
            }

        }

        /// <summary>
        /// 获取某用户获取的非实体奖品
        /// </summary>
        /// <param name="id">用户id</param>
        /// <param name="prizeid">peizeid</param>
        /// <returns></returns>
        public static List<UserWinningInfo> GetListByUserIdF(Guid id,int prizeid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserWinningInfo.Where(w=>w.UserId==id && w.WinningPrizeID>prizeid).OrderByDescending(p => p.WinningDate).ToList();
            }
        }
        /// <summary>
        /// 获取某用户获取的实体奖品
        /// </summary>
        /// <param name="id">用户id</param>
        /// <param name="prizeid"></param>
        /// <returns></returns>
        public static List<UserWinningInfo> GetListByUserIdT(Guid id, int prizeid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserWinningInfo.Where(w => w.UserId == id &&w.WinningPrizeID<prizeid).OrderByDescending(p => p.WinningDate).ToList();
            }
        }

        public static bool GetCount(Guid id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                if ((db.UserWinningInfo.Where(w => w.UserId == id).ToList()) == null)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        public static UserWinningInfo GetOne(Guid dates)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserWinningInfo.SingleOrDefault(w => w.OnlyLable == dates);
            }
        }
        public static UserWinningInfo GetOne(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserWinningInfo.SingleOrDefault(w => w.Id == id);
            }
        }

        public static void Update(UserWinningInfo entity, Guid dates)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserWinningInfo.SingleOrDefault(s => s.OnlyLable == dates); //Iphone的ID默认为0
                temp.ConsigneePhone = entity.ConsigneePhone;
                temp.ConsigneeName = entity.ConsigneeName;
                temp.ConsigneeAddr = entity.ConsigneeAddr;
                temp.ConsigneeCompany = entity.ConsigneeCompany;
                temp.ConsigneePosition = entity.ConsigneePosition;
                temp.Status = entity.Status;
                db.SubmitChanges();
            }
        }
    }
}
