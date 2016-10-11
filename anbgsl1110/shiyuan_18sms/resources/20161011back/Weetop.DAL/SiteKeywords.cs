using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Weetop.Model;

namespace Weetop.DAL
{
    /// <summary>
    /// Summary description for SiteKeywords
    /// </summary>
    public sealed class SiteKeywords
    {
        private SiteKeywords() { }

        public static void Add(Keywords entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Keywords.InsertOnSubmit(entity);
                db.SubmitChanges();
            }
            HttpContext.Current.Application["TrieFilter"] = GenFilter();
        }

        public static void Update(Keywords entity)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                db.Keywords.Attach(entity, true);
                db.SubmitChanges();
            }
            HttpContext.Current.Application["TrieFilter"] = GenFilter();
        }

        public static void Delete(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Keywords.SingleOrDefault(s => s.Id == id);
                if (temp != null)
                {
                    db.Keywords.DeleteOnSubmit(temp);
                    db.SubmitChanges();
                }
            }
            HttpContext.Current.Application["TrieFilter"] = GenFilter();
        }

        public static Keywords GetOne(long id)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                return db.Keywords.SingleOrDefault(s => s.Id == id);
            }
        }

        public static List<Keywords> GetList(ref PageParams pp, string txtSearch = null)
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var temp = db.Keywords.OrderByDescending(o => o.Sort);

                if (!string.IsNullOrEmpty(txtSearch))
                {
                    temp = temp.Where(w => w.KeyName.Contains(txtSearch)).OrderByDescending(o => o.Sort);
                }

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

        public static List<Keywords> GetList()
        {
            PageParams pp = new PageParams(false);
            return GetList(ref pp);
        }





        static TrieFilter tf = new TrieFilter();

        public static TrieFilter GenFilter()
        {
            using (DataClassesDataContext db = new DataClassesDataContext())
            {
                var entity = db.Keywords.OrderByDescending(o => o.Sort).ThenByDescending(o => o.Id).ToList();
                foreach (var item in entity)
                {
                    tf.AddKey(item.KeyName);
                }
            }

            HttpContext.Current.Application["TrieFilter"] = tf;
            return tf;
        }


        public static TrieFilter GetFilter()
        {
            if (HttpContext.Current.Application["TrieFilter"] != null)
            {
                tf = HttpContext.Current.Application["TrieFilter"] as TrieFilter;
            }
            else
            {
                tf = GenFilter();
            }
            return tf;
        }


    }

    #region 关键字过滤

    public class TrieNode
    {
        public bool m_end;
        public Dictionary<Char, TrieNode> m_values;
        public TrieNode()
        {
            m_values = new Dictionary<Char, TrieNode>();
        }
    }

    public class TrieFilter : TrieNode
    {
        /// <summary>
        /// 添加关键字
        /// </summary>
        /// <param name="key"></param>
        public void AddKey(string key)
        {
            if (string.IsNullOrEmpty(key))
            {
                return;
            }
            TrieNode node = this;
            for (int i = 0; i < key.Length; i++)
            {
                char c = key[i];
                TrieNode subnode;
                if (!node.m_values.TryGetValue(c, out subnode))
                {
                    subnode = new TrieNode();
                    node.m_values.Add(c, subnode);
                }
                node = subnode;
            }
            node.m_end = true;
        }

        /// <summary>
        /// 检查是否包含非法字符
        /// </summary>
        /// <param name="text">输入文本</param>
        /// <returns>找到的第1个非法字符.没有则返回string.Empty</returns>
        public bool HasBadWord(string text)
        {
            for (int i = 0; i < text.Length; i++)
            {
                TrieNode node;
                if (m_values.TryGetValue(text[i], out node))
                {
                    for (int j = i + 1; j < text.Length; j++)
                    {
                        if (node.m_values.TryGetValue(text[j], out node))
                        {
                            if (node.m_end)
                            {
                                return true;
                            }
                        }
                        else
                        {
                            break;
                        }
                    }
                }
            }
            return false;
        }

        /// <summary>
        /// 检查是否包含非法字符
        /// </summary>
        /// <param name="text">输入文本</param>
        /// <returns>找到的第1个非法字符.没有则返回string.Empty</returns>
        public string FindOne(string text)
        {
            for (int i = 0; i < text.Length; i++)
            {
                char c = text[i];
                TrieNode node;
                if (m_values.TryGetValue(c, out node))
                {
                    for (int j = i + 1; j < text.Length; j++)
                    {
                        if (node.m_values.TryGetValue(text[j], out node))
                        {
                            if (node.m_end)
                            {
                                return text.Substring(i, j + 1 - i);
                            }
                        }
                        else
                        {
                            break;
                        }
                    }
                }
            }
            return string.Empty;
        }

        //查找所有非法字符
        public IEnumerable<string> FindAll(string text)
        {
            for (int i = 0; i < text.Length; i++)
            {
                TrieNode node;
                if (m_values.TryGetValue(text[i], out node))
                {
                    for (int j = i + 1; j < text.Length; j++)
                    {
                        if (node.m_values.TryGetValue(text[j], out node))
                        {
                            if (node.m_end)
                            {
                                yield return text.Substring(i, (j + 1 - i));
                            }
                        }
                        else
                        {
                            break;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 替换非法字符
        /// </summary>
        /// <param name="text"></param>
        /// <param name="c">用于代替非法字符</param>
        /// <returns>替换后的字符串</returns>
        public string Replace(string text, char c = '*')
        {
            char[] chars = null;
            for (int i = 0; i < text.Length; i++)
            {
                TrieNode subnode;
                if (m_values.TryGetValue(text[i], out subnode))
                {
                    if (subnode.m_end)
                    {
                        if (chars == null) chars = text.ToCharArray();
                        chars[i] = c;
                    }
                    else
                    {

                        for (int j = i + 1; j < text.Length; j++)
                        {
                            if (subnode.m_values.TryGetValue(text[j], out subnode))
                            {
                                if (subnode.m_end)
                                {
                                    if (chars == null) chars = text.ToCharArray();
                                    for (int t = i; t <= j; t++)
                                    {
                                        chars[t] = c;
                                    }
                                    i = j;
                                }
                            }
                            else
                            {
                                break;
                            }
                        }

                    }

                }
            }
            return chars == null ? text : new string(chars);
        }


        /// <summary>
        /// 高亮关键字
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public string HighLight(string text)
        {
            List<string> list = null;

            var len = text.Length;
            for (int i = 0; i < len; i++)
            {
                TrieNode subnode;
                if (m_values.TryGetValue(text[i], out subnode))
                {
                    if (subnode.m_end)
                    {
                        list = text.ToCharArray().Select(s => s.ToString()).ToList();//每次重新生成list
                        list.Insert(i, "<em>");//4
                        list.Insert(i + 1 + 1, "</em>");//5
                        //更新长度和指针
                        text = string.Join("", list);
                        len = text.Length;
                        i += 9;//i+4+5
                    }
                    else
                    {
                        for (int j = i + 1; j < len; j++)
                        {
                            if (subnode.m_values.TryGetValue(text[j], out subnode))
                            {
                                if (subnode.m_end)
                                {
                                    list = text.ToCharArray().Select(s => s.ToString()).ToList();//每次重新生成list
                                    list.Insert(i, "<em>");//4
                                    list.Insert(j + 1 + 1, "</em>");//5
                                    //更新长度和指针
                                    text = string.Join("", list);
                                    len = text.Length;
                                    j += 9;//j+4+5
                                    i = j;
                                }
                            }
                            else
                            {
                                break;
                            }
                        }

                    }

                }
            }
            return list == null ? text : string.Join("", list);
        }

    }

    #endregion 关键字过滤


}

