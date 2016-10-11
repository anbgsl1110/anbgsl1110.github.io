using System;
using System.Collections.Generic;
using System.Data.Linq.SqlClient;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteFund
    {
        private SiteFund() { }



        public static void Update(Funds entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Funds.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        public static void Update(List<Funds> entities)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Funds.AttachAll(entities, true);
                db.SubmitChanges();
            }
        }

        public static Funds GetFunds(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.Funds.SingleOrDefault(s => s.UserId == uid);
            }
        }

        /// <summary>
        /// 获取余额预警列表
        /// </summary>
        /// <returns></returns>
        public static List<Funds> GetAlertList()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.Funds.Where(w => w.EarlyWarningEnable.Value && !w.EarlyWarningFirst.Value && w.Available.Value < w.EarlyWarningVal.Value).ToList();
            }
        }










        public static void Update(ProductFunds entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.ProductFunds.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        public static ProductFunds GetProductFunds(Guid uid, long pid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ProductFunds.SingleOrDefault(s => s.UserId == uid && s.ProId == pid);
            }
        }

        public static ProductFunds GetProductFunds(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ProductFunds.SingleOrDefault(s => s.Id == id);
            }
        }


        public static List<ProductFunds> GetProductOpenedList(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ProductFunds.Where(w => !w.IsDeleted && w.UserId == uid && w.IsOpen).ToList();
            }
        }

        public static List<ProductFunds> GetProductFundsList(ref PageParams pp, int? cType = null, string searchText = null, string timeRange = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ProductFunds.Where(w => !w.IsDeleted && w.IsOpen);//

                if (cType.HasValue && cType > 0)
                {
                    temp = temp.Where(w => w.ProId == cType.Value);
                }
                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    temp = from tm in temp
                           join ui in db.UserInfo on tm.UserId equals ui.UserId
                           where ui.CompanyName.Contains(searchText) || ui.Phone.Contains(searchText) || tm.SyAccount.Contains(searchText) || tm.ExtNo.Contains(searchText)
                           select tm;
                }
                if (!string.IsNullOrWhiteSpace(timeRange))
                {
                    List<DateTime> dt = timeRange.Split('-').Select(s => Convert.ToDateTime(s.Trim())).ToList();
                    temp = temp.Where(w => w.OpenDate.Value >= dt[0] && w.OpenDate.Value < dt[1]);
                }

                if (pp.AllowPaging)
                {
                    pp.TotalCount = temp.Count();

                    return temp.OrderByDescending(o => o.OpenDate).Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp.OrderByDescending(o => o.OpenDate).ToList();
                }
            }
        }



        /// <summary>
        /// 检查用户产品是否已开通
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="pid"></param>
        /// <returns></returns>
        public static bool CheckProOpened(Guid uid, long pid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ProductFunds.SingleOrDefault(s => s.UserId == uid && s.ProId == pid);
                if (temp != null)
                    return temp.IsOpen;
                else return false;
            }
        }
    }
}
