using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Weetop.Model;

namespace Weetop.DAL
{
    public sealed class SiteConsultingService
    {
        private SiteConsultingService() { }
        /// <summary>
        /// 根据id获取客服人员信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static ConsultingService GetOne(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ConsultingService.SingleOrDefault(w => w.id == id);
            }
        }

        /// <summary>
        /// 获取服务人员信息List
        /// </summary>
        /// <returns></returns>
        public static List<ConsultingService> GetList()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ConsultingService.ToList();
            }
        }

        /// <summary>
        /// 服务人员信息模糊查询
        /// </summary>
        /// <param name="pp"></param>
        /// <param name="servicePersonType"></param>
        /// <param name="searchText"></param>
        /// <returns></returns>
        public static List<ConsultingService> GetList(ref PageParams pp,int servicePersonType,string searchText = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<ConsultingService> temp = db.ConsultingService.ToList();
                if (!string.IsNullOrWhiteSpace(searchText))
                {

                    var temp2 = from tm in temp
                                where tm.Phone.Contains(searchText) || tm.Name.Contains(searchText) || tm.WeChat.Contains(searchText)
                                select tm;

                    if (pp.AllowPaging)
                    {
                        pp.TotalCount = temp2.Count();

                        return temp2.ToList().Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                    }
                    else
                    {
                        return temp2.ToList();
                    }
                }
                if (!("-1".Equals(servicePersonType.ToString())))
                {
                    var temp2 = from tm in temp
                                where tm.cateId == servicePersonType
                                select tm;

                    if (pp.AllowPaging)
                    {
                        pp.TotalCount = temp2.Count();

                        return temp2.ToList().Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                    }
                    else
                    {
                        return temp2.ToList();
                    }
                }
                if (pp.AllowPaging)
                {
                    pp.TotalCount = temp.Count();

                    return temp.ToList().Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp.ToList();
                }
            }

        }

        /// <summary>
        /// 根据ID删除服务人员信息
        /// </summary>
        /// <param name="id"></param>
        public static void Delete(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ConsultingService.SingleOrDefault(w => w.id == id);
                if (temp != null)
                {
                    SiteConsultingServiceNexus.DeleteBycid(temp.id);
                    db.ConsultingService.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 更新服务人员信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Update(ConsultingService entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.ConsultingService.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 修改服务人员信息
        /// </summary>
        /// <param name="entity"></param>
        public static void UpdateEntity(ConsultingService entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.GetTable<ConsultingService>().First<ConsultingService>(u => u.id == entity.id);
                if (temp != null)
                {
                    temp.cateId = entity.cateId;
                    temp.mailBox = entity.mailBox;
                    temp.Name = entity.Name;
                    temp.Phone = entity.Phone;
                    temp.QQNumber = entity.QQNumber;
                    temp.WeChat = entity.WeChat;
                    temp.ImgUrl = entity.ImgUrl;
                    temp.CategroyName = entity.CategroyName;
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 添加信息
        /// </summary>
        /// <param name="entity"></param>
        public static void Add(ConsultingService entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.ConsultingService.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 获取人员信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static ConsultingService GetConsultingServiceInfo(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ConsultingService.SingleOrDefault(w => w.id == id);
            }
        }

        /// <summary>
        /// 根据userID获取已分配服务人员信息
        /// </summary>
        /// <param name="UserId"></param>
        /// <param name="cateId"></param>
        /// <returns></returns>
        public static List<ConsultingService> GetByBoundListUserId(Guid UserId, int cateId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<ConsultingService> list = new List<ConsultingService>();
                string sql = "select * from ConsultingService where id in(select cid from ConsultingServiceNexus where UserId = '"+UserId.ToString()+"')";
                switch (cateId)
                {
                    case 1:
                        sql += "and cateId = 1";
                        break;
                    case 2:
                        sql += "and cateId = 2";
                        break;
                    default:
                        break;
                }
                IEnumerable<ConsultingService> emps = db.ExecuteQuery<ConsultingService>(sql);
                return emps.ToList();
            }
        }

        /// <summary>
        /// 根据userID获取已分配服务人员信息
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns></returns>
        public static List<ConsultingService> GetByBoundListUserId(Guid UserId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<ConsultingService> list = new List<ConsultingService>();
                string sql = "select * from ConsultingService where id in(select cid from ConsultingServiceNexus where UserId = '"+UserId.ToString()+"')";
                IEnumerable<ConsultingService> emps = db.ExecuteQuery<ConsultingService>(sql);
                return emps.ToList();
            }
        }

        /// <summary>
        /// 根据userId获取未分配服务人员信息（包含分页）
        /// </summary>
        /// <param name="pp"></param>
        /// <param name="UserId"></param>
        /// <param name="cateId"></param>
        /// <returns></returns>
        public static List<ConsultingService> GetBoundListByUserId(ref PageParams pp, Guid UserId, int cateId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<ConsultingService> list = new List<ConsultingService>();
                string sql = "select * from ConsultingService where id not in(select cid from ConsultingServiceNexus where UserId = '" + UserId.ToString() + "') ";
                switch (cateId)
                {
                    case 1:
                        sql += " AND cateId = 1";
                        break;
                    case 2:
                        sql += " AND cateId = 2";
                        break;
                    default:
                        break;
                }
                IEnumerable<ConsultingService> emps = db.ExecuteQuery<ConsultingService>(sql);
                return emps.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
            }
        }       
         
    }
}
