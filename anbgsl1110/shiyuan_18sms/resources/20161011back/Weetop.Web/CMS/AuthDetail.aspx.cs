using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web.CMS
{
    public partial class AuthDetail : CmsBase
    {
        protected int validState = (int)AuthValidState.未认证;

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
                Guid guid;
                if (!Guid.TryParse(Request["uid"], out guid))
                {
                    Response.Write(Common.SmartErr("无效参数"));
                    Response.End();
                }

                var ac = Request["action"];
                switch (ac)
                {
                    case "1":
                        Save();
                        break;
                    default:
                        //加载数据
                        var entity = SiteUserAuth.GetOne(guid);
                        if (entity != null)
                        {
                            litAccEmail.Text = SiteUser.GetUserEmail(guid);
                            litAuthType.Text = ((AuthType)entity.AuthType.Value).ToString();

                            var imgHeight = 100;

                            if (entity.AuthType == (int)AuthType.企业开发者)
                            {
                                Panel2.Visible = false;

                                litCName.Text = entity.AuthCName;
                                litCAddr.Text = entity.AuthCAddr;
                                litAuCType.Text = ((AuthCType)entity.AuthCType.Value).ToString();

                                if (entity.AuthCType != null && entity.AuthCType == (int)AuthCType.普通证件)
                                {
                                    Panel4.Visible = false;
                                    ImgCFileS.ImageUrl = basePath + entity.AuthCFileS;
                                    ImgCFileS.Height = imgHeight;
                                    lnkCFileS.NavigateUrl = ImgCFileS.ImageUrl;
                                    lnkCFileS.Target = "_blank";

                                    ImgCFileY.ImageUrl = basePath + entity.AuthCFileY;
                                    ImgCFileY.Height = imgHeight;
                                    lnkCFileY.NavigateUrl = ImgCFileY.ImageUrl;
                                    lnkCFileY.Target = "_blank";

                                    ImgCFileZ.ImageUrl = basePath + entity.AuthCFileZ;
                                    ImgCFileZ.Height = imgHeight;
                                    lnkCFileZ.NavigateUrl = ImgCFileZ.ImageUrl;
                                    lnkCFileZ.Target = "_blank";
                                }
                                else if (entity.AuthCType != null && entity.AuthCType == (int)AuthCType.三证合一)
                                {
                                    Panel3.Visible = false;
                                    ImgCFileQ.ImageUrl = basePath + entity.AuthCFile3in1;
                                    ImgCFileQ.Height = imgHeight;
                                    lnkCFileQ.NavigateUrl = ImgCFileZ.ImageUrl;
                                    lnkCFileQ.Target = "_blank";
                                }
                                
                                litCLegalPeo.Text = entity.AuthCLegalPeo;
                                litCPhone.Text = entity.AuthCPhone;
                                litCPeoName.Text = entity.AuthCPeoName;

                                var img = entity.AuthCPeoPic;
                                if (string.IsNullOrEmpty(img))
                                {
                                    ImgPeoPic.Visible = false;
                                    lnkPeoPic.Visible = false;
                                }
                                else
                                {
                                    ImgPeoPic.ImageUrl = basePath + entity.AuthCPeoPic;
                                    ImgPeoPic.Height = imgHeight;
                                    lnkPeoPic.NavigateUrl = ImgPeoPic.ImageUrl;
                                    lnkPeoPic.Target = "_blank";
                                }

                            }
                            if (entity.AuthType == (int)AuthType.个人开发者)
                            {
                                Panel1.Visible = false;

                                litPName.Text = entity.AuthPName;
                                litPType.Text = ((AuthPType)entity.AuthPType.Value).ToString();
                                litPFileNum.Text = entity.AuthPFileNum;

                                ImgPFile.ImageUrl = basePath + entity.AuthPFile;
                                ImgPFile.Height = imgHeight;
                                lnkPFile.NavigateUrl = ImgPFile.ImageUrl;
                                lnkPFile.Target = "_blank";

                            }

                            //认证状态
                            Dictionary<int, string> dic = new Dictionary<int, string>();
                            dic.Add((int)AuthValidState.待认证, AuthValidState.待认证.ToString());
                            dic.Add((int)AuthValidState.已认证, AuthValidState.已认证.ToString());
                            dic.Add((int)AuthValidState.认证失败, AuthValidState.认证失败.ToString());

                            ddlCheckStatus.DataSource = dic;
                            ddlCheckStatus.DataTextField = "Value";
                            ddlCheckStatus.DataValueField = "Key";
                            ddlCheckStatus.DataBind();
                            ddlCheckStatus.SelectedValue = entity.ValidState.Value.ToString();

                            validState = entity.ValidState.Value;
                            if (validState == (int)AuthValidState.已认证)
                                litValidState.Text = "认证日期：" + entity.ValidDate.Value.ToString("yyyy-MM-dd");

                            //管理员反馈
                            txtFeedback.Text = entity.ValidMsg;

                            //数据ID
                            hidAuId.Value = entity.Id.ToString();
                        }
                        else
                        {
                            Response.Write(Common.SmartErr("无效参数"));
                            Response.End();
                        }

                        break;
                }

            }
        }


        private void Save()
        {
            Response.ContentType = "application/json";

            var sel = Common.ToInt(Request["sel"]);
            var vl = Request["vl"];
            var auid = Common.ToLong(Request["auid"]);
            var entity = SiteUserAuth.GetOne(auid);
            if (entity == null || entity.UserId.ToString() != Request["uid"])
            {
                Response.Write(Common.SmartErr("无效参数"));
                Response.End();
            }

            if (sel > 0)
            {
                entity.ValidState = sel;
                entity.ValidDate = DateTime.Now;

                if (sel == (int)AuthValidState.已认证)
                {
                    //TODO 送代金券
                }
            }

            entity.ValidMsg = vl;//标注

            SiteUserAuth.Update(entity);

            Response.Write(Common.Json("OK", "保存成功"));
            Response.End();

        }
    }
}