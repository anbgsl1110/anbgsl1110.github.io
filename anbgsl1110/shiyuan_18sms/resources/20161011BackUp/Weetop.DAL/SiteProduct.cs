using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteProduct
    {
        private SiteProduct() { }


        public static void Update(ProductInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.ProductInfo.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        public static ProductInfo GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ProductInfo.SingleOrDefault(s => s.Id == id);
            }
        }

        public static List<ProductInfo> GetList()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ProductInfo.ToList();
            }
        }

        public static string GetPCode(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ProductInfo.SingleOrDefault(s => s.Id == id);
                return temp.ProductId;
            }
        }

        public static string GetPName(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ProductInfo.SingleOrDefault(s => s.Id == id);
                return temp.ProductIdName;
            }
        }

        public static string GetPName(string code)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ProductInfo.SingleOrDefault(s => s.ProductId == code);
                return temp.ProductIdName;
            }
        }

        public static bool CheckStatue(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ProductInfo.SingleOrDefault(s => s.Id == id);
                if (temp != null)
                    return temp.Enabled;
                else return false;
            }
        }

        public static bool CheckStatue(string code)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ProductInfo.SingleOrDefault(s => s.ProductId == code);
                if (temp != null)
                    return temp.Enabled;
                else return false;
            }
        }


    }
}
