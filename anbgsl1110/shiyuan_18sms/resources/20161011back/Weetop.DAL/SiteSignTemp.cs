using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{
    /// <summary>
    /// Summary description for SiteSignTemp
    /// </summary>
    public sealed class SiteSignTemp
    {
        private SiteSignTemp() { }

        public static void Add(TemplateSign entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.TemplateSign.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        public static void Update(TemplateSign entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.TemplateSign.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        public static void Delete(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.TemplateSign.SingleOrDefault(s => s.Id == id);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.TemplateSign.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        public static TemplateSign GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.TemplateSign.SingleOrDefault(s => !s.IsDeleted && s.Id == id);
            }
        }


        public static string GetCont(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.TemplateSign.SingleOrDefault(s => s.Id == id);
                return temp.Content;
            }
        }


        public static List<TemplateSign> GetList(ref PageParams pp, int? oType = null, string searchText = null, string timeRange = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.TemplateSign.Where(w => !w.IsDeleted);

                if (oType.HasValue && oType > 0)
                {
                    temp = temp.Where(w => w.CheckStatus == oType.Value);
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

        public static List<TemplateSign> GetList()
        {
            PageParams pp = new PageParams(false);
            return GetList(ref pp);
        }



        public static List<TemplateSign> GetList(ref PageParams pp, Guid uid, string txtSearch = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.TemplateSign.Where(w => !w.IsDeleted && w.UserId == uid).OrderByDescending(o => o.CreateDate);

                if (!string.IsNullOrEmpty(txtSearch))
                {
                    temp = temp.Where(w => w.Title.Contains(txtSearch)).OrderByDescending(o => o.CreateDate);
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

        public static List<TemplateSign> GetList(Guid uid)
        {
            PageParams pp = new PageParams(false);
            return GetList(ref pp, uid);
        }


        /// <summary>
        /// 获取可用拓展码
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static List<string> GetAvailableExtno(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.TemplateSign.Where(w => !w.IsDeleted && w.UserId == uid).Select(s => s.ExtNo).ToList();
            }
        }


    }

}

