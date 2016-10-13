using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;
using Wuqi.Webdiyer;
using OctoLib;
using System.IO;
using NPOI.SS.UserModel;
using NPOI.HSSF.UserModel;
using NPOI.SS.Util;
namespace Weetop.Web.CMS
{
    public partial class UserList : CmsBase
    {
        public List<ModulePrivilege> list = new List<ModulePrivilege>();
        protected View_AdminInfo VAdmin = null;//包含角色信息
        public bool isState = false;
        protected List<View_AdminInfo> VAdminList = new List<View_AdminInfo>();
        protected static string baseFilePath = Common.IfNullOrWhiteThen(Common.AppSettings["DownloadFilePath"], "File/xlsfiles/");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("HYGL"))
            {
                //直接使用IIS自定义错误捕捉
                Response.StatusCode = (int)HttpStatusCode.Forbidden;
                //强制输出自定义消息
                //Response.TrySkipIisCustomErrors = true;
                //Response.Write(Common.SmartMsg("您没有访问权限"));
                Response.End();
            }

            if (!IsPostBack)
            {
                string ac = Request["action"];
                switch (ac)
                {
                    case "1"://add
                             //Add();
                        break;
                    case "2":
                        //Edit();
                        break;
                    case "3"://del
                        Delete();
                        break;
                    case "4"://toggle
                        Toggle();
                        break;
                    case "5":
                        GetUserJson();
                        break;
                    case "6":
                        //GetOwner();
                        break;
                    case "7":
                        GetJson();
                        break;
                    case "8":
                        AssortServicePerson();
                        break;
                    case "export"://toggle
                        ExportData();
                        break;
                    default:
                        VAdmin = SiteAdmin.GetAdminView(Admin.UserId);
                        GetModulePrivilegeByRoleId();
                        //VAdminList = SiteAdmin.GetAllAdminViewList();
                        //VAdminList.Insert(0, new View_AdminInfo { RealName = "", UserId = Guid.Empty });
                        //ddlAdminList.DataSource = VAdminList;
                        //ddlAdminList.DataTextField = "RealName";
                        //ddlAdminList.DataValueField = "UserId";
                        //ddlAdminList.DataBind();

                        var entity = SiteUserAuth.GetOne(Admin.UserId);
                        if (entity != null && entity.ValidState != null)
                        {
                            string ValidState = Enum.GetName(typeof(AuthValidState), entity.ValidState);
                            if (ValidState == "待认证" || ValidState == "已认证")
                            {
                                isState = true;
                            }
                            else
                            {
                                isState = false;
                            }
                        }
                        Dictionary<int, string> dic = new Dictionary<int, string>();
                        dic.Add(-1, "");//chosen 留空
                        dic.Add((int)AuthValidState.未认证, AuthValidState.未认证.ToString());
                        dic.Add((int)AuthValidState.待认证, AuthValidState.待认证.ToString());
                        dic.Add((int)AuthValidState.已认证, AuthValidState.已认证.ToString());
                        dic.Add((int)AuthValidState.认证失败, AuthValidState.认证失败.ToString());
                        ddlCheckStatus.DataSource = dic;
                        ddlCheckStatus.DataTextField = "Value";
                        ddlCheckStatus.DataValueField = "Key";
                        ddlCheckStatus.DataBind();
                        //BindData();//有UpdatePanel的OnLoad方法时不需要这个，会重复执行
                        break;
                }
            }
            else
            {
                //PostBack时会执行，第一执行
                //string title = Page.Title;
            }
        }
        private void ExportData()
        {
            List<UserInfo> ui = SiteUser.GetAllUserInfoList();
            string strFileName = Server.MapPath(baseFilePath);
            if (!Directory.Exists(strFileName))
            {
                Directory.CreateDirectory(strFileName);
            }
            string fileName = DateTime.Today.ToString("yyyyMMdd") + new Random(DateTime.Now.Millisecond).Next(10000).ToString() + ".xls";
            string strFilePath = strFileName + fileName;
            string sName = ExportToList(ui, "用户信息", strFilePath);
            Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(fileName));
            Response.ContentType = "application/ms-excel";// 指定返回的是一个不能被客户端读取的流，必须被下载 
            Response.WriteFile(sName); // 把文件流发送到客户端 
            Response.End();
        }
        public static string ExportToList(List<UserInfo> list, string strHeaderText, string strFilePath)
        {
            using (MemoryStream ms = UserInfoExprotToList(list, strHeaderText))
            {
                using (FileStream fs = new FileStream(strFilePath, FileMode.Create, FileAccess.Write))
                {
                    byte[] data = ms.ToArray();
                    fs.Write(data, 0, data.Length);
                    fs.Flush();
                }
                return strFilePath;
            }
        }
        public static MemoryStream UserInfoExprotToList(List<UserInfo> list, string strHeaderName)
        {

            HSSFWorkbook workbook = new HSSFWorkbook();
            ISheet sheet = workbook.CreateSheet();

            //创建样式

            ICellStyle cellStyle = workbook.CreateCellStyle();
            IDataFormat dataFormat = workbook.CreateDataFormat();
            cellStyle.DataFormat = dataFormat.GetFormat("yyyy-MM-dd");

            //IRow headerRow = sheet.CreateRow(0);
            //headerRow.CreateCell(0).SetCellValue(strHeaderName);

            //表头样式
            IRow headerRow = sheet.CreateRow(0);
            headerRow.HeightInPoints = 25;
            headerRow.CreateCell(0).SetCellValue(strHeaderName); //填充填表

            ICellStyle headerStyle = workbook.CreateCellStyle();
            headerStyle.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;
            IFont font = workbook.CreateFont();
            font.FontHeightInPoints = 20;
            font.Boldweight = 700;
            headerStyle.SetFont(font);

            headerRow.GetCell(0).CellStyle = headerStyle;
            sheet.AddMergedRegion(new CellRangeAddress(0, 0, 0, list[0].GetType().GetProperties().Length - 1));


            IRow rows = sheet.CreateRow(1);
            rows.CreateCell(0).SetCellValue("昵称");
            rows.CreateCell(1).SetCellValue("真实姓名");
            rows.CreateCell(2).SetCellValue("性别");
            rows.CreateCell(3).SetCellValue("电话");
            rows.CreateCell(4).SetCellValue("邮箱");
            rows.CreateCell(5).SetCellValue("邮箱是否验证");
            rows.CreateCell(6).SetCellValue("QQ");
            rows.CreateCell(7).SetCellValue("最后登录");
            rows.CreateCell(8).SetCellValue("注册时间");
            rows.CreateCell(9).SetCellValue("公司名称");
            rows.CreateCell(10).SetCellValue("公司电话");
            rows.CreateCell(11).SetCellValue("公司地址");

            for (int i = 0; i < list.Count; i++)
            {
                IRow rowtemp = sheet.CreateRow(i + 2);
                rowtemp.CreateCell(0).SetCellValue(list[i].NickName);
                rowtemp.CreateCell(1).SetCellValue(list[i].RealName);
                rowtemp.CreateCell(2).SetCellValue(list[i].Sex);
                rowtemp.CreateCell(3).SetCellValue(list[i].Phone);
                rowtemp.CreateCell(4).SetCellValue(list[i].Email);
                rowtemp.CreateCell(5).SetCellValue(list[i].EmailValid);
                rowtemp.CreateCell(6).SetCellValue(list[i].QQ);
                rowtemp.CreateCell(7).SetCellValue(list[i].LastLogin.ToString());
                rowtemp.CreateCell(8).SetCellValue(list[i].CreateDate.ToString());
                rowtemp.CreateCell(9).SetCellValue(list[i].CompanyName);
                rowtemp.CreateCell(10).SetCellValue(list[i].CompanyMobile);
                rowtemp.CreateCell(11).SetCellValue(list[i].CompanyAddr);
            }

            //宽度自适应
            for (int i = 0; i < list.Count; i++)
            {
                sheet.AutoSizeColumn(i);
            }

            using (MemoryStream ms = new MemoryStream())
            {
                workbook.Write(ms);
                ms.Flush();
                ms.Position = 0;
                return ms;
            }


        }

        private void GetModulePrivilegeByRoleId()
        {
            if (Admin != null)
            {
                Role rInfo = SiteRole.GetRoleByAccountCode(Admin.AccountCode);
                List<ModulePrivilege> list2 = SiteModulePrivilege.GetListModulePrivilege("HYGL");
                list.Clear();
                foreach (var item in list2)
                {
                    if (SiteRole.CheckRolePriv(rInfo.RoleId, item.ModPrivId))
                    {
                        if (item.PrivilegeCode == "XG")
                        {
                            isState = true;
                        }
                        list.Add(item);
                    }
                }
            }
        }

        /// <summary>
        /// 认证信息链接
        /// </summary>
        /// <param name="uid"></param>
        /// <param name="page"></param>
        /// <returns></returns>
        protected string GetLink(Guid uid, int page)
        {
            var entity = SiteUserAuth.GetOne(uid);
            if (entity != null && entity.ValidState != null)
            {
                if (Admin != null)
                {
                    Role rInfo = SiteRole.GetRoleByAccountCode(Admin.AccountCode);
                    List<ModulePrivilege> list2 = SiteModulePrivilege.GetListModulePrivilege("HYGL");
                    string ValidState = Enum.GetName(typeof(AuthValidState), entity.ValidState);
                    foreach (var item in list2)
                    {
                        if (item.PrivilegeCode == "XG")
                        {
                            if (SiteRole.CheckRolePriv(rInfo.RoleId, item.ModPrivId))
                            {
                                return "<a title='{标注：" + entity.ValidMsg + "}' href=AuthDetail.aspx?uid=" + uid + "&page=" + page + ">" + ValidState + "</a>";
                            }
                        }
                    }
                    return ValidState;
                }
            }
            return AuthValidState.未认证.ToString();
        }

        private void Add()
        {
            Response.ContentType = "application/json";

            if (string.IsNullOrWhiteSpace(Request["userName"]) || string.IsNullOrWhiteSpace(Request["pwd"]))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            string userName = Request["userName"].Trim();
            if (SiteUser.CheckLoginName(userName))
            {
                Response.Write(Common.Json("Err", "登陆帐户已经存在，请重试"));
                Response.End();
            }
            var entity = new UserInfo
            {
                UserId = Guid.NewGuid(),
                Avatar = "",
                NickName = userName,
                RealName = Request["realName"],
                Pwd = Common.MD5(Request["pwd"]),
                CompanyName = Request["cmpName"],
                CompanyAddr = Request["cmpAddr"],
                CompanyMobile = Request["cmpPhone"],
                Phone = Request["phone"],
                QQ = Request["qq"],
                Email = Request["email"],
                CreateDate = DateTime.Now,
                UpdateDate = DateTime.Now,
                Enabled = true//因为不为null，故必须明确写为true，不然实体默认为false
            };
            SiteUser.AddUserInfo(entity);
            Response.Write(Common.Json("OK", "添加成功"));
            Response.End();
        }

        private void Edit()
        {
            Response.ContentType = "application/json";

            if (string.IsNullOrWhiteSpace(Request["hidUserId3"]))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            Guid guid;
            if (!Guid.TryParse(Request["hidUserId3"], out guid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            UserInfo entity = SiteUser.GetUserInfo(guid);
            entity.RealName = Request["realName"];
            if (!string.IsNullOrWhiteSpace(Request["pwd"]))
                entity.Pwd = Common.MD5(Request["pwd"]);
            entity.CompanyName = Request["cmpName"];
            entity.CompanyAddr = Request["cmpAddr"];
            entity.CompanyMobile = Request["cmpPhone"];
            entity.Phone = Request["phone"];
            entity.QQ = Request["qq"];
            entity.Email = Request["email"];
            entity.UpdateDate = DateTime.Now;
            SiteUser.UpdateUserInfo(entity);
            Response.Write(Common.Json("OK", "修改成功"));
            Response.End();
        }

        private void Delete()
        {
            Response.ContentType = "application/json";
            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            SiteUser.DeleteUserInfo(guid);
            Response.Write(Common.Json("OK", "删除成功"));
            Response.End();
        }

        private void Toggle()
        {
            Response.ContentType = "application/json";
            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            var entity = SiteUser.GetUserInfo(guid);
            if (entity == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }

            entity.Enabled = Convert.ToBoolean(Request["checked"]);
            SiteUser.UpdateUserInfo(entity);
            Response.Write(Common.Json("OK", "帐号" + (entity.Enabled ? "已 <b>启用</b>" : "已 <b>禁用</b>") + "，下次登陆时生效"));
            Response.End();
        }

        private void GetUserJson()
        {
            Response.ContentType = "application/json";
            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            JObject jo = JObject.FromObject(new
            {
                code = "OK",
                user = SiteUser.GetUserInfo(guid)
            });
            Response.Write(jo.ToString());
            Response.End();
        }

        private void GetOwner()
        {
            if (Request["id"] == "")
            {
                Response.Write("");
                Response.End();
            }
            Guid guid;
            if (!Guid.TryParse(Request["id"], out guid))
            {
                Response.Write("");
                Response.End();
            }
            Response.Write(SiteAdmin.GetAdminName(guid));
            Response.End();
        }

        private void Valid()
        {
            //Response.ContentType = "application/json";

            //Guid guid;
            //if (!Guid.TryParse(Request["id"], out guid))
            //{
            //    Response.Write(Common.Json("Err", "参数错误"));
            //    Response.End();
            //}
            //var entity = SiteUser.GetUserInfo(guid);
            //if (entity == null)
            //{
            //    Response.Write(Common.Json("Err", "参数错误"));
            //    Response.End();
            //}

            //entity.InfoValid = Convert.ToBoolean(Request["checked"]);
            //SiteUser.UpdateUserInfo(entity);
            //Response.Write(Common.Json("OK", "帐号" + (entity.InfoValid ? " <b>已认证</b>" : " <b>未认证</b>") + ""));
            //Response.End();
        }

        //根据ID获取对应的SiteUser对象信息
        private void GetJson()
        {
            Response.ContentType = "application/json";
            var item = SiteUser.GetUserInfo(Guid.Parse(Request["id"]));
            if (item == null)
            {
                Response.Write(Common.Json("Err", "参数错误"));
                Response.End();
            }
            var temp = new
            {
                name = item.Phone,
            };
            Response.Write(Common.Json("OK", "操作成功", temp));
            Response.End();
        }

        //分配咨询服务服务人员
        private void AssortServicePerson()
        {
            Response.ContentType = "application/json";

            Response.Write(Common.Json("Err", "参数错误"));
            Response.End();
        }

        private void BindData()
        {
            //从url加载参数，方便从详情页跳回列表
            var pg = Common.ToInt(Request["page"]);
            if (pg != 0) AspNetPager1.CurrentPageIndex = pg;
            //TODO 添加查询条件参数，不然会有bug
            GetModulePrivilegeByRoleId();
            PageParams pp = new PageParams(AspNetPager1.CurrentPageIndex);
            int cType = Common.ToInt(ddlCheckStatus.SelectedValue);
            string searchText = txtSearch.Value.Trim();
            string timeRange = txtDateRange.Value.Trim();
            //string aSaler = ddlAdminList.SelectedValue;
            List<UserInfo> list = SiteUser.GetAllUserInfoList(ref pp, cType, searchText, timeRange);
            AspNetPager1.PageSize = pp.PageSize;
            AspNetPager1.RecordCount = pp.TotalCount;
            AspNetPager1.CurrentPageIndex = pp.PageIndex;
            Repeater1.DataSource = list;
            Repeater1.DataBind();
        }

        protected void AspNetPager1_PageChanging(object src, PageChangingEventArgs e)
        {
            //第三执行
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            BindData();
        }

        //可用于前端JS调用PostBack时执行
        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            //不管是不是PostBack都会执行，第二执行
            BindData();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            //第三执行
        }
    }
}