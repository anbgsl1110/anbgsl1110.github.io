using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public class SiteModulePrivilege
    {
        private SiteModulePrivilege() { }

        public static List<ModulePrivilege> GetListModulePrivilege(string modCode)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ModulePrivilege.Where(w => w.ModuleCode == modCode);
                return temp.ToList();
            }
        }
    }
}
