using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteRdmNum
    {
        private SiteRdmNum() { }


        /// <summary>
        /// 添加数据集合
        /// </summary>
        /// <param name="entities"></param>
        public static void AddList(IEnumerable<RdmNumber> entities)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.RdmNumber.InsertAllOnSubmit(entities);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 根据ID获取随机值，ID依序递增，另外保存
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static string Get(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.RdmNumber.SingleOrDefault(s => s.Id == id);
                return temp.Num;
            }
        }


    }
}
