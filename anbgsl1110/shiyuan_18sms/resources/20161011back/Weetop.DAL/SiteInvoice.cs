using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteInvoice
    {
        private SiteInvoice() { }

        public static void Add(InvoiceInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.InvoiceInfo.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        public static void Update(InvoiceInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.InvoiceInfo.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        public static void Delete(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.InvoiceInfo.SingleOrDefault(s => s.Id == id);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.InvoiceInfo.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }


        public static InvoiceInfo GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.InvoiceInfo.SingleOrDefault(s => !s.IsDeleted && s.Id == id);
            }
        }

        /// <summary>
        /// 获取用户认证信息
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static InvoiceInfo GetOne(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.InvoiceInfo.Where(s => !s.IsDeleted && s.UserId == uid).OrderByDescending(o => o.CreateDate).FirstOrDefault();
            }
        }

    }
}
