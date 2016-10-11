using OctoLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{
    /// <summary>
    /// 轮播图管理
    /// </summary>
    public sealed class SiteBanner
    {
        private SiteBanner() { }

        public static void AddBanner(BannerInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.BannerInfo.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        public static void DeleteBanner(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.BannerInfo.SingleOrDefault(s => s.Id == id);
                if (temp != null)
                {
                    db.BannerInfo.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        public static void UpdateBanner(BannerInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.BannerInfo.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        public static BannerInfo GetBanner(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.BannerInfo.SingleOrDefault(s => s.Id == id);
            }
        }

        public static List<BannerInfo> GetAllBannerList(ref PageParams pp, string type = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.BannerInfo.OrderByDescending(o => o.Sort).ThenBy(o => o.Id);

                if (!string.IsNullOrWhiteSpace(type))
                {
                    temp = temp.Where(w => w.Type == type).OrderByDescending(o => o.Sort).ThenBy(o => o.Id);
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

        public static List<BannerInfo> GetAllBannerList(int top)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.BannerInfo.OrderByDescending(o => o.Sort).ThenBy(o => o.Id).Take(top).ToList();
            }
        }

        public static List<BannerInfo> GetAllBannerList(string type, int top = 3)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.BannerInfo.Where(w => w.Type == type).OrderByDescending(o => o.Sort).ThenBy(o => o.Id).Take(top).ToList();
            }
        }
    }
}