using System;
using System.Collections.Generic;
using System.Data.Linq.SqlClient;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{
    /// <summary>
    /// 
    /// </summary>
    public sealed class SitePopularize
    {
        private SitePopularize() { }



        /// <summary>
        /// 获取所有列表
        /// </summary>
        /// <returns></returns>
        public static List<Popularize> GetList(ref PageParams pp, string searchText = null, string timeRange = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Popularize.Where(w => !w.IsDeleted).OrderByDescending(o => o.PostDate);

                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    temp = temp.Where(w => w.Mobile.Contains(searchText) || w.SrcPath.Contains(searchText)).OrderByDescending(o => o.PostDate);
                }
                if (!string.IsNullOrWhiteSpace(timeRange))
                {
                    List<DateTime> dt = timeRange.Split('-').Select(s => Convert.ToDateTime(s.Trim())).ToList();
                    temp = temp.Where(w => w.PostDate.Value >= dt[0] && w.PostDate.Value < dt[1]).OrderByDescending(o => o.PostDate);
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

        public static List<Popularize> GetList()
        {
            PageParams pp = new PageParams(false);
            return GetList(ref pp);
        }

        public static List<Popularize> GetListALL()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Popularize.Where(w => !w.IsDeleted).OrderByDescending(o => o.PostDate).ToList();
                return temp;
            }
        }
        /// <summary>
        /// 获取信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Popularize GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.Popularize.SingleOrDefault(w => w.Id == id);
            }
        }


        /// <summary>
        /// 删除信息
        /// </summary>
        /// <param name="id"></param>
        public static void Delete(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Popularize.SingleOrDefault(w => w.Id == id);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.Popularize.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 更新信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Update(Popularize entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Popularize.Attach(entity, true);
                db.SubmitChanges();
            }
        }
        public static void UpdateEntity(Popularize entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var profile = db.GetTable<Popularize>().First<Popularize>(u => u.Id == entity.Id);
                profile.Mobile = entity.Mobile;
                profile.SrcPath = entity.SrcPath;
                profile.Valid = entity.Valid;
                profile.SmsCode = entity.SmsCode;
                profile.SendTimes = entity.SendTimes;
                profile.Remark = entity.Remark;
                profile.PostDate = entity.PostDate;
                profile.IsDeleted = entity.IsDeleted;
                db.SubmitChanges();
            }
        }
        /// <summary>
        /// 添加信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Add(Popularize entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Popularize.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }
    }
}