using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{

    /// <summary>
    /// Summary description for SiteCategory
    /// </summary>
    public sealed class SiteCategory
    {
        private SiteCategory() { }


        public static string GetNameById(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.CategoryInfo.SingleOrDefault(s => s.Id == id);
                if (temp != null)
                    return temp.Name;
                else return "";
            }
        }

    }

}