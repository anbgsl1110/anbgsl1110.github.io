using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{
    /// <summary>
    /// Privilege 的摘要说明
    /// </summary>
    public sealed class PrivManager
    {
        private PrivManager() { }

        /// <summary>
        /// 检查是否拥有某种动作权限
        /// </summary>
        /// <param name="accountCode">用户代码</param>
        /// <param name="privCode">动作代码</param>
        /// <param name="moduleUri">模块URI</param>
        /// <returns></returns>
        public static bool HasPrivilegeForAction(string accountCode, string privCode, string moduleUri)
        {
            using (DataClassesDataContext privdb = new DataClassesDataContext())
            {
                var temp = from a in privdb.AdminInfo
                           join ar in privdb.AccountRole on a.AccountCode equals ar.AccountCode
                           join r in privdb.Role on ar.RoleCode equals r.RoleCode
                           join rp in privdb.RolePrivilege on r.RoleId equals rp.RoleId
                           join mp in privdb.ModulePrivilege on rp.ModPrivId equals mp.ModPrivId
                           join m in privdb.Module on mp.ModuleCode equals m.ModuleCode
                           join p in privdb.Privilege on mp.PrivilegeCode equals p.PrivilegeCode
                           where a.AccountCode == accountCode && m.ModuleURI == moduleUri && p.PrivilegeCode == privCode
                           && a.Enabled && !a.IsDeleted
                           && r.Enabled && !r.IsDeleted
                           && m.Enabled && !m.IsDeleted
                           && p.Enabled && !p.IsDeleted
                           select a;
                AdminInfo acc = temp.SingleOrDefault();
                if (acc != null)
                    return true;
                else
                    return false;
            }
        }

        /// <summary>
        /// 检查是否拥有某种动作权限
        /// </summary>
        /// <param name="accountCode">用户代码</param>
        /// <param name="privCode">动作代码</param>
        /// <param name="modCode">模块代码</param>
        /// <returns></returns>
        public static bool HasPrivilegeForModule(string accountCode, string privCode, string modCode)
        {
            using (DataClassesDataContext privdb = new DataClassesDataContext())
            {
                var temp = from a in privdb.AdminInfo
                           join ar in privdb.AccountRole on a.AccountCode equals ar.AccountCode
                           join r in privdb.Role on ar.RoleCode equals r.RoleCode
                           join rp in privdb.RolePrivilege on r.RoleId equals rp.RoleId
                           join mp in privdb.ModulePrivilege on rp.ModPrivId equals mp.ModPrivId
                           join m in privdb.Module on mp.ModuleCode equals m.ModuleCode
                           join p in privdb.Privilege on mp.PrivilegeCode equals p.PrivilegeCode
                           where a.AccountCode == accountCode && m.ModuleCode == modCode && p.PrivilegeCode == privCode
                           && a.Enabled && !a.IsDeleted
                           && r.Enabled && !r.IsDeleted
                           && m.Enabled && !m.IsDeleted
                           && p.Enabled && !p.IsDeleted
                           select a;
                AdminInfo acc = temp.SingleOrDefault();
                if (acc != null)
                    return true;
                else
                    return false;
            }
        }

    }
}