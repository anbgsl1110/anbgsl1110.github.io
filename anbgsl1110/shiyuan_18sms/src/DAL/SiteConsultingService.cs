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
                    SiteConsultingServiceNexus.DeleteNexusBycid(temp.id);
                    db.ConsultingService.DeleteOnSubmit(temp);
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
        public static ConsultingService GetConsultingServiceInfo(int id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.ConsultingService.SingleOrDefault(w => w.id == id);
            }
        }

        //根据userID获取已分配服务人员信息
        public static List<ConsultingService> GetAssignedConsultingServiceListByUserId(Guid UserId, int cateId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<ConsultingService> temp1 = db.ConsultingService.ToList();
                if (!("-1".Equals(cateId)))
                {
                    if(cateId == 0)//显示全部
                    {
                        var temp2 = from consultingService in db.ConsultingService
                        join consultingServiceNexus in db.ConsultingServiceNexus
                        on consultingService.id equals consultingServiceNexus.cid
                        where (consultingServiceNexus.UserId == UserId)
                        orderby consultingService.cateId
                        select consultingService;

                        return temp2.ToList();
                    }
                    else//根据服务人员分类显示
                    {
                        var temp2 = from consultingService in db.ConsultingService
                        join consultingServiceNexus in db.ConsultingServiceNexus
                        on consultingService.id equals consultingServiceNexus.cid
                        where (consultingServiceNexus.UserId == UserId&&consultingService.cateId == cateId)
                        orderby consultingService.cateId
                        select consultingService;
                        return temp2.ToList();                       
                    }
                    
                }
                else
                {
                    return null;
                }
            }
        }

        //根据userId获取未分配服务人员信息（包含分页）
        public static List<ConsultingService> GetNotAssignedConsultingServiceListByUserId(ref PageParams pp, Guid UserId, int cateId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<ConsultingService> temp1 = db.ConsultingService.ToList();
                if(!("-1".Equals(cateId)))
                {
                    if(cateId == 0)//显示全部
                    {
                        var temp2 = SiteConsultingServiceNexus.GetAllConsultServiceNexusByUserId(UserId);
                        List<ConsultingService> temp3 = new List<ConsultingService>();
                        foreach (ConsultingService ConsultingService1 in temp1)
                        {
                            temp3.Add(ConsultingService1);
                        }
                        foreach (ConsultingService consultingService2 in temp3)
                        {
                            foreach (ConsultingServiceNexus ConsultingServiceNexus1 in temp2)
                            {
                                if(consultingService2.id == ConsultingServiceNexus1.cid)
                                {
                                    temp1.Remove(consultingService2);
                                    continue;
                                }
                            }
                        }
                        if(pp.AllowPaging)
                        {
                            pp.TotalCount = temp1.Count();
                            return temp1.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                        }
                        else
                        {
                            return temp1.ToList();                        
                        }
                    }
                    else//根据服务人员分类显示
                    {
                        var temp2 = SiteConsultingServiceNexus.GetAllConsultServiceNexusByUserId(UserId);
                        List<ConsultingService> temp3 = new List<ConsultingService>();
                        foreach (ConsultingService ConsultingService1 in temp1)
                        {
                            temp3.Add(ConsultingService1);
                        }
                        foreach (ConsultingService consultingService2 in temp3)
                        {
                            if(temp2.Count == 0)//显示全部
                            {
                                if (consultingService2.cateId != cateId)
                                {
                                    temp1.Remove(consultingService2);
                                    continue;
                                }
                            }
                            else//根据服务人员分类显示
                            {
                                foreach (ConsultingServiceNexus ConsultingServiceNexus1 in temp2)
                                {
                                    if(consultingService2.id == ConsultingServiceNexus1.cid || consultingService2.cateId != cateId)
                                    {
                                        temp1.Remove(consultingService2);
                                        continue;
                                    }
                                }
                            }
                        }
                        if(pp.AllowPaging)
                        {
                            pp.TotalCount = temp1.Count();
                            return temp1.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                        }
                        else
                        {
                            return temp1.ToList();                        
                        }
                    }                    
                }
                if(pp.AllowPaging)
                {
                    pp.TotalCount = temp1.Count();
                    return temp1.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp1.ToList();
                }
            }
        }

        //根据userId获取未分配服务人员信息（不包含分页）
        public static List<ConsultingService> GetNotAssignedConsultingServiceListByUserId(Guid UserId, int cateId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<ConsultingService> temp1 = db.ConsultingService.ToList();
                if(!("-1".Equals(cateId)))
                {
                    if(cateId == 0)//显示全部
                    {
                        var temp2 = SiteConsultingServiceNexus.GetAllConsultServiceNexusByUserId(UserId);
                        List<ConsultingService> temp3 = new List<ConsultingService>();
                        foreach (ConsultingService ConsultingService1 in temp1)
                        {
                            temp3.Add(ConsultingService1);
                        }
                        foreach (ConsultingService consultingService2 in temp3)
                        {
                            foreach (ConsultingServiceNexus ConsultingServiceNexus1 in temp2)
                            {
                                if(consultingService2.id == ConsultingServiceNexus1.cid)
                                {
                                    temp1.Remove(consultingService2);
                                    continue;
                                }
                            }
                        }                   
                        return temp1.ToList();                        
                    }               
                    else//根据服务人员分类显示
                    {
                        var temp2 = SiteConsultingServiceNexus.GetAllConsultServiceNexusByUserId(UserId);
                        List<ConsultingService> temp3 = new List<ConsultingService>();
                        foreach (ConsultingService ConsultingService1 in temp1)
                        {
                            temp3.Add(ConsultingService1);
                        }
                        foreach (ConsultingService consultingService2 in temp3)
                        {
                            if(temp2.Count == 0)//显示全部
                            {
                                if (consultingService2.cateId != cateId)
                                {
                                    temp1.Remove(consultingService2);
                                    continue;
                                }
                            }
                            else//根据服务人员分类显示
                            {
                                foreach (ConsultingServiceNexus ConsultingServiceNexus1 in temp2)
                                {
                                    if(consultingService2.id == ConsultingServiceNexus1.cid || consultingService2.cateId != cateId)
                                    {
                                        temp1.Remove(consultingService2);
                                        continue;
                                    }
                                }
                            }
                        }
                        return temp1.ToList();                        
                    }                    
                }
                else
                {
                    return temp1.ToList();
                }
            }
        }

        //根据临时更改结果listTemp1获取已分配服务人员信息
        public static List<ConsultingService> GetAssignedConsultingServiceListByListTemp(int cateId,List<ConsultingService> listTemp)
        {
            List<ConsultingService> temp1 = listTemp.ToList();
            if (!("-1".Equals(cateId)))
            {
                if(cateId == 0)//显示全部
                {
                    return temp1;
                }
                else//根据服务人员分类显示
                {
                    List<ConsultingService> temp2 = new List<ConsultingService>();
                    foreach(ConsultingService cs in temp1)
                    {
                        if(cs.cateId == cateId)
                        {
                            temp2.Add(cs);
                        }
                    }
                    return temp2.ToList();                       
                }
            }
            else
            {
                return temp1;    
            }
        }

        //根据临时更改结果ListTemp2获取未分配服务人员信息
        public static List<ConsultingService> GetNotAssignedConsultingServiceListByListTemp(ref PageParams pp, int cateId, List<ConsultingService> listTemp)
        {
            List<ConsultingService> temp1 = listTemp.ToList();
            if(!("-1".Equals(cateId)))
            {
                if(cateId == 0)//显示全部
                {
                    if(pp.AllowPaging)
                    {
                        pp.TotalCount = temp1.Count();
                        return temp1.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                    }
                    else
                    {
                        return temp1.ToList();                        
                    }
                }
                else//根据服务人员分类显示
                {
                    List<ConsultingService> temp2 = new List<ConsultingService>();
                    foreach (ConsultingService ConsultingService1 in temp1)
                    {
                        if(ConsultingService1.cateId == cateId)
                        {
                            temp2.Add(ConsultingService1);
                        }
                    }
                    if(pp.AllowPaging)
                    {
                        pp.TotalCount = temp2.Count();
                        return temp1.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                    }
                    else
                    {
                        return temp2.ToList();                        
                    }
                }                    
            }
            if(pp.AllowPaging)
            {
                pp.TotalCount = temp1.Count();
                return temp1.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
            }
            else
            {
                return temp1.ToList();
            }
        }
         
    }
}
