using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteSettings
    {
        private SiteSettings() { }


        public static string Get(string key)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.SysSettings.SingleOrDefault(s => s.Key == key);
                return temp.Value;
            }
        }

        public static void Update(string key, string value)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.SysSettings.SingleOrDefault(s => s.Key == key);
                if (temp != null)
                {
                    temp.Value = value;
                    db.SubmitChanges();
                }
            }
        }
    }
}
