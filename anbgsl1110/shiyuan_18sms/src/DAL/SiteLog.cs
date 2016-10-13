using System;
using System.Collections.Generic;
using System.Linq;
using System.Management;
using System.Net;
using System.Text;
using System.Web;
using Weetop.Model; 

namespace Weetop.DAL
{
    public sealed class SiteLog
    {
        /// <summary>
        /// 添加日志
        /// </summary>
        /// <param name="entity"></param>
        public static void Add(Log entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Log.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// 根据PageParams获取日志信息
        /// </summary>
        /// <param name="pp"></param>
        /// <returns></returns>
        public static List<Log> GetList(ref PageParams pp,string searchText = null,string timeRange = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                List<Log> temp = new List<Log>();
                string sql = " select top 1000 * from log where 1 = 1 ";
                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    sql += " and (UserName like '% "+searchText+" %' or  ModuleName like '% "+searchText+" %' or ModuleObject like '% "+searchText+" %') "; 
                }
                if (!string.IsNullOrWhiteSpace(timeRange))
                {
                    List<DateTime> dt = timeRange.Split('-').Select(s => Convert.ToDateTime(s.Trim())).ToList();
                    sql +=" and (ActionTime >= cast('"+dt[0]+"' as datetime) and ActionTime < cast('"+dt[1]+"' as datetime ))";
                }
                sql += " order by Id desc "; 
                IEnumerable<Log> em = db.ExecuteQuery<Log>(sql);
                return em.Skip(pp.PageSize * (pp.PageIndex - 1)).Take(pp.PageSize).ToList();
            }
        }

        /// <summary>
        /// 检查IP地址格式
        /// </summary>
        /// <param name="ip"></param>
        /// <returns></returns>
        public static bool IsIP(string ip)
        {
            return System.Text.RegularExpressions.Regex.IsMatch(ip, @"^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$");
        }

        public static string GetClientIP()
        {
            string userIP = "未获取用户IP";

            try
            {
                if (System.Web.HttpContext.Current == null
            || System.Web.HttpContext.Current.Request == null
            || System.Web.HttpContext.Current.Request.ServerVariables == null)
                    return "";

                string CustomerIP = "";

                //CDN加速后取到的IP   
                CustomerIP = System.Web.HttpContext.Current.Request.Headers["Cdn-Src-Ip"];
                if (!string.IsNullOrEmpty(CustomerIP))
                {
                    //判断获取是否成功，并检查IP地址的格式
                    if (!string.IsNullOrEmpty(CustomerIP) && IsIP(CustomerIP))
                    {
                        return CustomerIP;
                    }
                }

                CustomerIP = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];


                if (!String.IsNullOrEmpty(CustomerIP))
                {
                    if (!string.IsNullOrEmpty(CustomerIP) && IsIP(CustomerIP))
                    {
                        return CustomerIP;
                    }
                }

                if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != null)
                {
                    //如果客户端使用了代理服务器，则利用HTTP_X_FORWARDED_FOR找到客户端IP地址
                    CustomerIP = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                    if (CustomerIP == null)
                        //否则直接读取REMOTE_ADDR获取客户端IP地址
                        CustomerIP = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                }
                else
                {
                    CustomerIP = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

                }

                //前两者均失败，则利用Request.UserHostAddress属性获取IP地址，但此时无法确定该IP是客户端IP还是代理IP
                if (string.Compare(CustomerIP, "unknown", true) == 0)
                {
                    return System.Web.HttpContext.Current.Request.UserHostAddress;

                }
                return CustomerIP;
            }
            catch { }

            return userIP;
        }

        /// <summary>  
        /// 获取客户端本机MAC地址  
        /// </summary>  
        /// <param name="sender"></param>  
        /// <param name="e"></param>  
        ///   
        public static string GetClientMAC()  
        {  
            try  
            {  
                ManagementObjectSearcher query = new ManagementObjectSearcher("SELECT * FROM Win32_NetworkAdapterConfiguration");  
                ManagementObjectCollection queryCollection = query.Get();  
                foreach (ManagementObject mo in queryCollection)  
                {  
                    if (mo["IPEnabled"].ToString() == "True")  
                        return mo["MacAddress"].ToString();  
                }  
                return "";  
            }  
            catch  
            {  
                return "";  
            }  
        }
        
    }
}