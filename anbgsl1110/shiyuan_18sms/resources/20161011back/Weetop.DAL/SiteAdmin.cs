using OctoLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{
    /// <summary>
    /// 后台管理员管理
    /// </summary>
    public sealed class SiteAdmin
    {
        private SiteAdmin() { }

        /// <summary>
        /// 检查登陆
        /// </summary>
        /// <param name="UserName"></param>
        /// <param name="UserPwd"></param>
        /// <returns></returns>
        public static string CheckLogin(string UserName, string UserPwd)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.AdminInfo.SingleOrDefault(w => w.UserName == UserName && w.Enabled && !w.IsDeleted);
                if (temp != null)
                {
                    if (temp.UserPwd == UserPwd)
                    {
                        temp.LastLogin = DateTime.Now;
                        db.SubmitChanges();

                        return temp.UserId.ToString(); //返回登录管理用户的ID
                    }
                    else
                    {
                        return "PWDERROR"; //管理用户密码错误
                    }
                }
                else
                {
                    return "NOTFOUND";//管理用户不存在
                }
            }
        }

        /// <summary>
        /// 获得管理员信息
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static AdminInfo GetAdminInfo(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.AdminInfo.SingleOrDefault(w => w.UserId == uid);
            }
        }


        public static string GetAdminName(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.AdminInfo.SingleOrDefault(w => w.UserId == uid);
                if (temp != null) return temp.RealName;
                else return "";
            }
        }

        /// <summary>
        /// 获得管理员视图
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static View_AdminInfo GetAdminView(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.View_AdminInfo.SingleOrDefault(w => w.UserId == uid);
            }
        }

        /// <summary>
        /// 获得所有管理员信息视图列表
        /// </summary>
        /// <param name="pp"></param>
        /// <returns></returns>
        public static List<View_AdminInfo> GetAllAdminViewList(ref PageParams pp)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.View_AdminInfo.OrderBy(o => o.AccountCode);

                if (pp.AllowPaging)
                {
                    pp.TotalCount = temp.Count();

                    return temp.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp.ToList();
                }
            }
        }

        public static List<View_AdminInfo> GetAllAdminViewList()
        {
            PageParams pp = new PageParams(false);
            return GetAllAdminViewList(ref pp);
        }


        /// <summary>
        /// 更新管理员信息
        /// </summary>
        /// <param name="entity"></param>
        public static void UpdateAdminInfo(AdminInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.AdminInfo.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 更新管理员角色
        /// </summary>
        /// <param name="entity"></param>
        public static void UpdateAdminRole(View_AdminInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                AccountRole ar = db.AccountRole.SingleOrDefault(s => s.AccountCode == entity.AccountCode);
                if (ar != null)
                {
                    ar.RoleCode = entity.RoleCode;
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 删除管理员信息，物理删除
        /// </summary>
        /// <param name="uid"></param>
        public static void DeleteAdminInfo(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.AdminInfo.SingleOrDefault(w => w.UserId == uid);
                if (temp != null)
                {
                    //先删除用户角色表相关数据
                    DeleteAdminRole(temp.AccountCode);

                    db.AdminInfo.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 删除管理员角色，物理删除
        /// </summary>
        /// <param name="accCode"></param>
        public static void DeleteAdminRole(string accCode)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.AccountRole.Where(w => w.AccountCode == accCode);
                db.AccountRole.DeleteAllOnSubmit(temp);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 添加管理员信息
        /// </summary>
        /// <param name="entity">管理员和角色对象</param>
        /// <returns><c>true</c> 添加成功, <c>false</c> 用户名已经存在，添加失败</returns>
        public static bool AddAdminInfo(View_AdminInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.AdminInfo.SingleOrDefault(w => w.UserName == entity.UserName);
                if (temp != null)
                {
                    return false;
                }

                AdminInfo aitmp = new AdminInfo();
                aitmp.UserId = entity.UserId;
                aitmp.AccountCode = entity.AccountCode;
                aitmp.UserName = entity.UserName;
                aitmp.UserPwd = entity.UserPwd;
                aitmp.RealName = entity.RealName;
                aitmp.Phone = entity.Phone;
                aitmp.Email = entity.Email;
                aitmp.Remark = entity.Remark;
                aitmp.RegDate = entity.RegDate;
                aitmp.UpdateDate = entity.UpdateDate;
                aitmp.Enabled = entity.Enabled;
                aitmp.IsDeleted = entity.IsDeleted;
                aitmp.Sort = entity.Sort;
                aitmp.Language = entity.Language;

                db.AdminInfo.InsertOnSubmit(aitmp);

                AccountRole artmp = new AccountRole();
                artmp.AccountCode = entity.AccountCode;
                artmp.RoleCode = entity.RoleCode;

                db.AccountRole.InsertOnSubmit(artmp);

                db.SubmitChanges();
                return true;
            }
        }

        /// <summary>
        /// 检查用户名是否已存在
        /// </summary>
        /// <param name="name">The name.</param>
        /// <returns><c>true</c> 存在, <c>false</c> 不存在</returns>
        public static bool CheckName(string name)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.AdminInfo.SingleOrDefault(w => w.UserName == name);
                if (temp != null)
                {
                    return true;
                }
                else return false;
            }
        }

        /// <summary>
        /// 重置密码
        /// </summary>
        /// <param name="uid"></param>
        public static void ResetPwd(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.AdminInfo.SingleOrDefault(w => w.UserId == uid);
                if (temp != null)
                {
                    temp.UserPwd = Common.MD5(Common.AppSettings["ResetPwd"]);
                    db.SubmitChanges();
                }
            }
        }
    }
}