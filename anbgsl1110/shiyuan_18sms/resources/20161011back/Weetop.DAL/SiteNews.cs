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
    public sealed class SiteNews
    {
        private SiteNews() { }



        /// <summary>
        /// 获取所有列表
        /// </summary>
        /// <returns></returns>
        public static List<News> GetList(long cateId, ref PageParams pp, string searchText = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.News.Where(w => !w.IsDeleted && w.CateId == cateId).OrderByDescending(o => o.Sort).ThenByDescending(o => o.PostDate);

                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    temp = temp.Where(w => w.Title.Contains(searchText)).OrderByDescending(o => o.Sort).ThenByDescending(o => o.PostDate);
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

        public static List<News> GetList(long cateId)
        {
            PageParams pp = new PageParams(false);
            return GetList(cateId, ref pp);
        }

        /// <summary>
        /// 获取前几条数据
        /// </summary>
        /// <param name="cateId"></param>
        /// <param name="top"></param>
        /// <returns></returns>
        public static List<News> GetListTop(long cateId, int top = 4)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.News.Where(w => !w.IsDeleted && w.CateId == cateId).OrderByDescending(o => o.Sort).ThenByDescending(o => o.PostDate);

                return temp.Take(top).ToList();
            }
        }
        /// <summary>
        /// 获取某个cateid范围内的前几条数据
        /// </summary>
        /// <param name="cateId"></param>
        /// <param name="top"></param>
        /// <returns></returns>
        public static List<News> GetListTopIncateId(long cateId,long maxcateId, int top = 4)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.News.Where(w => !w.IsDeleted && w.CateId >= cateId && w.CateId <= maxcateId).OrderByDescending(o => o.Sort).ThenByDescending(o => o.PostDate);

                return temp.Take(top).ToList();
            }
        }
        /// <summary>
        /// 相关阅读,去除当前新闻
        /// </summary>
        /// <param name="cateId"></param>
        /// <param name="conId"></param>
        /// <param name="top"></param>
        /// <returns></returns>
        public static List<News> GetListTop(long cateId, long conId,int top = 4)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.News.Where(w => !w.IsDeleted && w.CateId == cateId && w.Id!=conId).OrderByDescending(o => o.Sort).ThenByDescending(o => o.PostDate);

                return temp.Take(top).ToList();
            }
        }
        public static List<News> GetListTop(int top = 10)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.News.Where(w => !w.IsDeleted && w.CateId >= 21 && w.CateId <= 30).OrderByDescending(o => o.PostDate);

                return temp.Take(top).ToList();
            }
        }

        /// <summary>
        /// 获取信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static News GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.News.SingleOrDefault(w => w.Id == id);
            }
        }

        /// <summary>
        /// 下一条记录
        /// </summary>
        /// <param name="cateId"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public static News GetNext(long cateId, long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                //return db.News.Where(w => !w.IsDeleted && w.CateId == cateId).OrderByDescending(o => o.Sort).ThenByDescending(o => o.PostDate).ToList().SkipWhile(i => i.Id != id).Skip(1).FirstOrDefault();
                return db.News.Where(w => !w.IsDeleted && w.CateId == cateId).OrderByDescending(o => o.Sort).ThenByDescending(o => o.PostDate).ToList().SkipWhile(i => i.Id != id).Skip(1).FirstOrDefault();
            }
        }

        /// <summary>
        /// 上一条记录
        /// </summary>
        /// <param name="cateId"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public static News GetPrev(long cateId, long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.News.Where(w => !w.IsDeleted && w.CateId == cateId).OrderBy(o => o.Sort).ThenBy(o => o.PostDate).ToList().SkipWhile(i => i.Id != id).Skip(1).FirstOrDefault();
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
                var temp = db.News.SingleOrDefault(w => w.Id == id);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.News.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 更新信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Update(News entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.News.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 添加信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Add(News entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.News.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }


        public static void AddViewCount(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.News.SingleOrDefault(s => s.Id == id);
                if (temp != null)
                {
                    temp.ViewCount++;
                    db.SubmitChanges();
                }
            }
        }
    }
}