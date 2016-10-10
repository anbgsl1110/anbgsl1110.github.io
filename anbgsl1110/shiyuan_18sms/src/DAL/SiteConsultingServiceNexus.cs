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
        
        //根据userId获取ConsultingServiceNexus关联表的信息
        public static List<ConsultingServiceNexus> GetAllConsultServiceNexusByUserId(Guid userId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = from ConsultingServiceNexus in db.ConsultingServiceNexus where (ConsultingServiceNexus.UserId == userId) 
                           select ConsultingServiceNexus;
                return temp.ToList();
            }
        }

        //添加服务人员关联表ConsultingServiceNexus信息
        public static void AddConsultingServiceNexus(ConsultingServiceNexus entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.ConsultingServiceNexus.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        //根据userId删除服务人员关联表ConsultingServiceNexus信息
        public static void DeleteConsultingServiceNexusByUserId(Guid userId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = (from ConsultingServiceNexus in db.ConsultingServiceNexus where (ConsultingServiceNexus.UserId == userId)
                           select ConsultingServiceNexus).ToArray();
                for(int i = 0;i<temp.Length;i++)
                {
                    DeleteConsultingServiceNexus(temp[i]);
                }
            }
        }

        //根据实体object删除服务人员关联表ConsultingService信息
        public static void DeleteConsultingServiceNexus (ConsultingServiceNexus entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.ConsultingServiceNexus.DeleteOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        //根据ID删除服务人员相关数据信息
        public static void DeleteNexusBycid(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ConsultingServiceNexus.SingleOrDefault(w => w.cid == id);
                if (temp != null)
                {
                    db.ConsultingServiceNexus.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

    }
}