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
    public sealed class SiteDevDoc
    {
        private SiteDevDoc() { }



        /// <summary>
        /// 获取所有列表
        /// </summary>
        /// <returns></returns>
        public static List<DevDoc> GetList(long cateId, ref PageParams pp, string searchText = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.DevDoc.Where(w => !w.IsDeleted && w.CateId == cateId).OrderByDescending(o => o.Sort);

                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    temp = temp.Where(w => w.Title.Contains(searchText)).OrderByDescending(o => o.Sort);
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

        public static List<DevDoc> GetList(long cateId)
        {
            PageParams pp = new PageParams(false);
            return GetList(cateId, ref pp);
        }


        /// <summary>
        /// 获取信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static DevDoc GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.DevDoc.SingleOrDefault(w => w.Id == id);
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
                var temp = db.DevDoc.SingleOrDefault(w => w.Id == id);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.DevDoc.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 更新信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Update(DevDoc entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.DevDoc.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 添加信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Add(DevDoc entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.DevDoc.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }
    }
}