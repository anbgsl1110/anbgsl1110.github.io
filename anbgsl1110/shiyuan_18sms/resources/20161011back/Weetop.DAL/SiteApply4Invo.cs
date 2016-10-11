using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{
    /// <summary>
    /// Summary description for SiteApply4Invo
    /// </summary>
    public sealed class SiteApply4Invo
    {
        private SiteApply4Invo() { }

        public static void Add(Apply4Invoice entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Apply4Invoice.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        public static void Update(Apply4Invoice entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Apply4Invoice.Attach(entity, true);
                db.SubmitChanges();
            }
        }
        public static void UpdateEntity(Apply4Invoice entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var profile = db.GetTable<Apply4Invoice>().First<Apply4Invoice>(u => u.Id == entity.Id);
                profile.CourierNumber = entity.CourierNumber;
                profile.CreateDate = entity.CreateDate;
                profile.Feedback = entity.Feedback;
                profile.FMoney = entity.FMoney;
                profile.FStatus = entity.FStatus;
                profile.FTitle = entity.FTitle;
                profile.InvoInfoId = entity.InvoInfoId;
                profile.IsDeleted = entity.IsDeleted;
                profile.ReceiveWay = entity.ReceiveWay;
                profile.UpdateDate = entity.UpdateDate;
                profile.UserId = entity.UserId;
                db.SubmitChanges();
            }
        }
        public static void Delete(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Apply4Invoice.SingleOrDefault(s => s.Id == id);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.Apply4Invoice.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        public static Apply4Invoice GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.Apply4Invoice.SingleOrDefault(s => !s.IsDeleted && s.Id == id);
            }
        }



        /// <summary>
        /// 获取待开已开发票的金额汇总
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static decimal? GetLockedMoney(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.Apply4Invoice.Where(w => !w.IsDeleted && (w.FStatus == (int)InvoStatus.待开发票 || w.FStatus == (int)InvoStatus.已开发票) && w.UserId == uid).Sum(s => s.FMoney);
            }
        }



        public static List<Apply4Invoice> GetList(ref PageParams pp, int? oType = null, string searchText = null, string timeRange = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Apply4Invoice.Where(w => !w.IsDeleted);

                if (oType.HasValue && oType > 0)
                {
                    temp = temp.Where(w => w.FStatus == oType.Value);
                }
                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    temp = from tm in temp
                           join ui in db.UserInfo on tm.UserId equals ui.UserId
                           where ui.CompanyName.Contains(searchText) || ui.Phone.Contains(searchText)
                           select tm;
                }
                if (!string.IsNullOrWhiteSpace(timeRange))
                {
                    List<DateTime> dt = timeRange.Split('-').Select(s => Convert.ToDateTime(s.Trim())).ToList();
                    temp = temp.Where(w => w.CreateDate.Value >= dt[0] && w.CreateDate.Value < dt[1]);
                }

                if (pp.AllowPaging)
                {
                    pp.TotalCount = temp.Count();

                    return temp.OrderByDescending(o => o.CreateDate).Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp.OrderByDescending(o => o.CreateDate).ToList();
                }
            }

        }

        public static List<Apply4Invoice> GetList()
        {
            PageParams pp = new PageParams(false);
            return GetList(ref pp);
        }



        public static List<Apply4Invoice> GetList(ref PageParams pp, Guid uid, string txtSearch = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Apply4Invoice.Where(w => !w.IsDeleted && w.UserId == uid).OrderByDescending(o => o.CreateDate);

                if (!string.IsNullOrEmpty(txtSearch))
                {
                    temp = temp.Where(w => w.FTitle.Contains(txtSearch)).OrderByDescending(o => o.CreateDate);
                }

                if (pp.AllowPaging)
                {
                    pp.TotalCount = temp.Count();

                    return temp.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp.ToList();
                }
            }

        }

        public static List<Apply4Invoice> GetList(Guid uid)
        {
            PageParams pp = new PageParams(false);
            return GetList(ref pp, uid);
        }

        public static List<Apply4Invoice> GetListALL()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Apply4Invoice.Where(w => !w.IsDeleted).OrderByDescending(o => o.CreateDate).ToList();
                return temp;
            }
        }
    }

}

