using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteUserAuth
    {
        private SiteUserAuth() { }

        public static void Add(UserAuth entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.UserAuth.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        public static void Update(UserAuth entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.UserAuth.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        public static void Delete(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserAuth.SingleOrDefault(s => s.Id == id);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.UserAuth.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 获取用户认证信息
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static UserAuth GetOne(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserAuth.Where(s => !s.IsDeleted && s.UserId == uid).OrderByDescending(o => o.CreateDate).FirstOrDefault();
            }
        }

        public static UserAuth GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserAuth.SingleOrDefault(s => !s.IsDeleted && s.Id == id);
            }
        }

        /// <summary>
        /// 获取认证状态
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static int? GetValidState(Guid uid)
        {
            var entity = GetOne(uid);
            if (entity != null)
            {
                return entity.ValidState;
            }
            else
            {
                return 0;
            }
            
        }
    }
}
