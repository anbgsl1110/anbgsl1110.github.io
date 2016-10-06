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
        //根据id获取客服人员信息
        public static ConsultingService GetOne(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ConsultingService.SingleOrDefault(w => w.id == id);
            }
        }

        //根据主键id获取客服人员相关表信息
        public static List<ConsultingServiceNexus> GetList(Guid id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ConsultingServiceNexus.Where(w => w.UserId == id).ToList();
            }
        }

        //获取服务人员信息List
        public static List<ConsultingService> GetList()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ConsultingService.ToList();
            }
        }

        //服务人员信息模糊查询
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

        //根据ID删除服务人员信息
        public static void Delete(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.ConsultingService.SingleOrDefault(w => w.id == id);
                if (temp != null)
                {
                    DeleteNexusBycid(temp.id);
                    db.ConsultingService.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
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

        //更新服务人员信息
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

        //获取人员信息
        public static ConsultingService GetUserInfo(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ConsultingService.SingleOrDefault(w => w.id.ToString() == uid.ToString());
            }
        }
    }

}
