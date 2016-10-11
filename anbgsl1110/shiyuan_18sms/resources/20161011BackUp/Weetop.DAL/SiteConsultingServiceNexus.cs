using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteConsultingServiceNexus
    {
        private SiteConsultingServiceNexus(){ }
        
        /// <summary>
        /// 根据userId获取ConsultingServiceNexus关联表的信息
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public static List<ConsultingServiceNexus> GetAllByUserId(Guid userId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ConsultingServiceNexus.Where(w => w.UserId == userId).ToList();
            }
        }

        /// <summary>
        /// 添加服务人员关联表ConsultingServiceNexus信息
        /// </summary>
        /// <param name="entity"></param>
        public static void AddByEntity(ConsultingServiceNexus entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.ConsultingServiceNexus.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 根据cid和userId删除服务人员关联表信息
        /// </summary>
        /// <param name="cid"></param>
        /// <param name="userId"></param>
        public static void Delete(int cid, Guid userId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ConsultingServiceNexus.SingleOrDefault(w => w.cid == cid && w.UserId ==userId);
                if (temp != null)
                {
                    db.ConsultingServiceNexus.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 根据cid删除服务人员相关数据信息
        /// </summary>
        /// <param name="cid"></param>
        public static void DeleteBycid(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<ConsultingServiceNexus> temp = (from ConsultingServiceNexus in db.ConsultingServiceNexus
                                               where (ConsultingServiceNexus.cid == id)
                           select ConsultingServiceNexus).ToList();
                foreach(ConsultingServiceNexus cs in temp)
                {
                    Delete(int.Parse(cs.cid.ToString()),Guid.Parse(cs.UserId.ToString()));
                }
            }
        }

        /// <summary>
        /// 根据userId删除服务人员关联表ConsultingServiceNexus信息
        /// </summary>
        /// <param name="userId"></param>
        public static void DeleteByUserId(Guid userId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<ConsultingServiceNexus> temp = (from ConsultingServiceNexus in db.ConsultingServiceNexus
                                                     where (ConsultingServiceNexus.UserId == userId)
                                                     select ConsultingServiceNexus).ToList();
                foreach (ConsultingServiceNexus cs in temp)
                {
                    Delete(int.Parse(cs.cid.ToString()), Guid.Parse(userId.ToString()));
                }
            }
        }

        /// <summary>
        /// 根据实体删除服务人员关联表ConsultingServiceNexus信息
        /// </summary>
        /// <param name="entity"></param>
        public static void DeleteByEntity(ConsultingServiceNexus entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                Delete(int.Parse(entity.cid.ToString()), Guid.Parse(entity.UserId.ToString()));
            }
        }

    }
}