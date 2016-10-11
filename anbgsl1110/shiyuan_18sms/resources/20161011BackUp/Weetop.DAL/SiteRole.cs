using OctoLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{
    /// <summary>
    /// 后台权限角色管理
    /// </summary>
    public class SiteRole
    {
        private SiteRole() { }


        #region 角色相关

        /// <summary>
        /// 获得角色列表
        /// </summary>
        /// <returns></returns>
        public static List<Role> GetRoleList()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.Role.Where(w => !w.IsDeleted).ToList();
            }
        }

        /// <summary>
        /// 获得角色列表
        /// </summary>
        /// <param name="pp"></param>
        /// <returns></returns>
        public static List<Role> GetRoleList(ref PageParams pp)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Role.Where(w => !w.IsDeleted);

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

        /// <summary>
        /// 启用或禁用角色
        /// </summary>
        /// <param name="entity"></param>
        public static void ToggleRole(Role entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                //db.Role.Attach(entity, true);//IsVersion=True 或添加 timestamp 类型的列，且需解除外键关联

                var temp = db.Role.SingleOrDefault(w => w.RoleId == entity.RoleId);
                if (temp != null)
                {
                    temp.Enabled = entity.Enabled;
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 检查角色名是否存在
        /// </summary>
        /// <param name="name"></param>
        /// <returns><c>true</c> 存在, <c>false</c> 不存在</returns>
        public static bool CheckRoleName(string name)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Role.SingleOrDefault(s => s.RoleName == name);
                if (temp != null)
                {
                    return true;
                }
                else return false;
            }
        }

        /// <summary>
        /// 添加角色
        /// </summary>
        /// <param name="entity"></param>
        public static void AddRole(Role entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Role.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 删除前检查角色下是否有用户
        /// </summary>
        /// <param name="RoleId"></param>
        /// <returns><c>true</c> 没有, <c>false</c> 有</returns>
        public static bool CheckRoleNoAccount(long RoleId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = from r in db.Role
                           join ar in db.AccountRole on r.RoleCode equals ar.RoleCode
                           where r.RoleId == RoleId
                           select ar;
                if (temp.FirstOrDefault() == null) return true;
                else return false;
            }
        }

        /// <summary>
        /// 删除角色
        /// </summary>
        /// <param name="RoleId"></param>
        public static void DeleteRole(long RoleId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Role.SingleOrDefault(w => w.RoleId == RoleId);
                if (temp != null)
                {
                    //先删除角色权限表相关数据
                    DeleteAllRolePriv(RoleId);

                    //temp.IsDeleted = true;
                    //temp.UpdateDate = DateTime.Now;

                    //物理删除
                    db.Role.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 删除角色权限表数据
        /// </summary>
        /// <param name="RoleId"></param>
        public static void DeleteAllRolePriv(long RoleId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = from rp in db.RolePrivilege
                           join mp in db.ModulePrivilege on rp.ModPrivId equals mp.ModPrivId
                           where rp.RoleId == RoleId && mp.ModuleCode != "QXGL"//跳过权限管理模块
                           select rp;
                db.RolePrivilege.DeleteAllOnSubmit(temp);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 获取角色信息
        /// </summary>
        /// <param name="RoleId"></param>
        /// <returns></returns>
        public static Role GetRoleInfo(long RoleId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.Role.SingleOrDefault(w => w.RoleId == RoleId);
            }
        }

        #endregion 角色相关


        #region 模块权限相关

        /// <summary>
        /// 获取模块权限列表，根据插入时的ID排序
        /// </summary>
        /// <returns></returns>
        public static List<View_ModPrivilege> GetModPriv()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.View_ModPrivilege.Where(w => !w.IsDeleted).OrderBy(o => o.ModuleId).ThenBy(o => o.PrivilegeId).ToList();
            }
        }

        /// <summary>
        /// 获得角色的所有权限
        /// </summary>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public static string GetRolePrivJson(long roleId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var list = db.RolePrivilege.Where(w => w.RoleId.Value == roleId).ToList();
                return Common.ListToJson(list);
            }
        }

        /// <summary>
        /// 检查角色是否有某权限
        /// </summary>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public static bool CheckRolePriv(long roleId, long mprivId)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.RolePrivilege.FirstOrDefault(f => f.RoleId == roleId && f.ModPrivId == mprivId);
                if (temp != null)
                    return true;
                else
                    return false;
            }
        }

        /// <summary>
        /// 批量插入权限
        /// </summary>
        /// <param name="rplist"></param>
        public static void InsertRolePriv(List<RolePrivilege> rplist)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.RolePrivilege.InsertAllOnSubmit(rplist);
                db.SubmitChanges();
            }
        }


        public static Role GetRoleByAccountCode(string accountCode)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                AccountRole ar = db.AccountRole.FirstOrDefault(f => f.AccountCode == accountCode);
                Role r = db.Role.FirstOrDefault(f => f.RoleCode == ar.RoleCode);
                return r;
            }
        }

        #endregion 模块权限相关
    }
}