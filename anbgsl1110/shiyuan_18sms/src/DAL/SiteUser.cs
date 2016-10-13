using System;
using System.Collections.Generic;
using System.Data.Linq.SqlClient;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{
    /// <summary>
    /// 注册用户管理
    /// </summary>
    public sealed class SiteUser
    {
        private SiteUser() { }

        /// <summary>
        /// 检查并修改验证码有效性，应该在数据库中由作业定期执行
        /// </summary>
        public static void UpdateValiCodeState()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var valids = db.TempReg.Where(w => ((DateTime)w.UpdateDate).AddMinutes(Convert.ToDouble(w.EffectiveTime)) <= DateTime.Now).ToList();
                if (valids.Count > 0)
                {
                    foreach (var item in valids)
                    {
                        item.IsOutDate = 1;
                    }
                }
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 检查登陆名
        /// </summary>
        /// <param name="uname"></param>
        /// <returns></returns>
        public static bool CheckLoginName(string uname)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserInfo.SingleOrDefault(s => s.NickName == uname);
                if (temp != null) return true;
                else return false;
            }
        }

        /// <summary>
        /// 检查邮件是否存在
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        public static bool CheckEmail(string email)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserInfo.SingleOrDefault(s => s.Email == email);
                if (temp != null) return true;
                else return false;
            }
        }


        /// <summary>
        /// 获取所有用户列表
        /// </summary>
        /// <returns></returns>
        public static List<UserInfo> GetAllUserInfoList(ref PageParams pp, int? cType = null, string searchText = null, string timeRange = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserInfo.Where(w => !w.IsDeleted);//MARK 排序放到最后的分页或ToList()方法之前

                if (cType.HasValue && cType > -1)
                {
                    //bool ct = cType == 1 ? true : false;
                    //temp = temp.Where(w => w.InfoValid == ct).OrderByDescending(o => o.CreateDate);

                    //用户最新一条认证信息集合
                    var ualist = db.UserAuth.Where(w => w.CreateDate == (db.UserAuth.Where(w2 => w2.UserId == w.UserId).OrderByDescending(o => o.CreateDate).Max(m => m.CreateDate)));

                    if (cType == 0)
                    {
                        temp = temp.Where(w => !ualist.Select(s => s.UserId.Value).Contains(w.UserId));
                    }
                    else
                    {
                        temp = from tm in temp
                               join ua in ualist on tm.UserId equals ua.UserId.Value
                               where ua.ValidState == cType
                               select tm;
                    }
                }
                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    temp = temp.Where(w => w.NickName.Contains(searchText) || w.RealName.Contains(searchText) || SqlMethods.Like(w.Phone, "%" + searchText + "%") || w.QQ.Contains(searchText) || w.Email.Contains(searchText));
                }
                if (!string.IsNullOrWhiteSpace(timeRange))
                {
                    List<DateTime> dt = timeRange.Split('-').Select(s => Convert.ToDateTime(s.Trim())).ToList();
                    temp = temp.Where(w => w.CreateDate.Value >= dt[0] && w.CreateDate.Value < dt[1]);
                }

                if (pp.AllowPaging)
                {
                    pp.TotalCount = temp.Count();

                    return temp.OrderByDescending(o => o.CreateDate).Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
                }
                else
                {
                    return temp.OrderByDescending(o => o.CreateDate).ToList();
                }
            }
        }
        public static List<UserInfo> GetAllUserInfoList()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserInfo.Where(w => !w.IsDeleted).ToList();
            }
        }

        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <param name="uid"></param>
        /// <returns></returns>
        public static UserInfo GetUserInfo(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.UserInfo.SingleOrDefault(w => w.UserId == uid);
            }
        }


        public static string GetUserEmail(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserInfo.SingleOrDefault(w => w.UserId == uid);
                if (temp != null) return temp.Email;
                else return "";
            }
        }


        /// <summary>
        /// 删除用户信息
        /// </summary>
        /// <param name="uid"></param>
        public static void DeleteUserInfo(Guid uid)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.UserInfo.SingleOrDefault(w => w.UserId == uid);
                if (temp != null)
                {
                    temp.IsDeleted = true;
                    //db.UserInfo.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
        }

        /// <summary>
        /// 更新用户信息
        /// </summary>
        /// <param name="entity"></param>
        public static void UpdateUserInfo(UserInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.UserInfo.Attach(entity, true);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 添加用户信息
        /// </summary>
        /// <param name="entity"></param>
        public static void AddUserInfo(UserInfo entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.UserInfo.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }
        
    }
}