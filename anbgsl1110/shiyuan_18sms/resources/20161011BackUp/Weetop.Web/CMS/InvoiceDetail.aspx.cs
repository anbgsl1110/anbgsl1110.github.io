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
    public partial class InvoiceDetail : CmsBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!BLL.PrivManager.HasPrivFWForModule("CWGL"))
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
                var ac = Request["action"];
                switch (ac)
                {
                    case "1":
                        Save();
                        break;
                    default:
                        var app4 = SiteApply4Invo.GetOne(Common.ToLong(Request["oid"]));
                        if (app4 == null)
                        {
                            Response.Write(Common.SmartErr("无效参数"));
                            Response.End();
                        }
                        //加载数据
                        var entity = SiteInvoice.GetOne(Common.ToLong(Request["did"]));
                        if (entity != null)
                        {
                            litInvoType.Text = ((InvoType)entity.InvoType.Value).ToString();
                            litFTitle.Text = entity.FTitle;
                            litFMoney.Text = "{app4.FMoney:C0}";

                            var imgHeight = 100;

                            if (entity.InvoType == (int)InvoType.个人)
                            {
                                Panel2.Visible = false;
                                Panel3.Visible = false;
                            }
                            if (entity.InvoType == (int)InvoType.公司小规模纳税人)
                            {
                                Panel3.Visible = false;

                                ImgFileTax2.ImageUrl = basePath + entity.FileTax;
                                ImgFileTax2.Height = imgHeight;
                                lnkFileTax2.NavigateUrl = ImgFileTax2.ImageUrl;
                                lnkFileTax2.Target = "_blank";
                            }
                            if (entity.InvoType == (int)InvoType.公司一般纳税人)
                            {
                                Panel2.Visible = false;

                                litFTaxCode.Text = entity.FTaxCode;
                                litFBank.Text = entity.FBank;
                                litFBankCode.Text = entity.FBankCode;
                                litFBusPhone.Text = entity.FBusPhone;
                                litFBusAddr.Text = entity.FBusAddr;

                                ImgFileTax3.ImageUrl = basePath + entity.FileTax;
                                ImgFileTax3.Height = imgHeight;
                                lnkFileTax3.NavigateUrl = ImgFileTax3.ImageUrl;
                                lnkFileTax3.Target = "_blank";

                                ImgFileNormal.ImageUrl = basePath + entity.FileNormal;
                                ImgFileNormal.Height = imgHeight;
                                lnkFileNormal.NavigateUrl = ImgFileNormal.ImageUrl;
                                lnkFileNormal.Target = "_blank";

                            }

                            litFAddr.Text = entity.FAddr;
                            litFRemark.Text = entity.FRemark;

                            var img = entity.FileOther;
                            if (string.IsNullOrEmpty(img))
                            {
                                ImgFileOther.Visible = false;
                                lnkFileOther.Visible = false;
                            }
                            else
                            {
                                ImgFileOther.ImageUrl = basePath + entity.FileOther;
                                ImgFileOther.Height = imgHeight;
                                lnkFileOther.NavigateUrl = ImgFileOther.ImageUrl;
                                lnkFileOther.Target = "_blank";
                            }


                            //状态
                            Dictionary<int, string> dic2 = new Dictionary<int, string>();
                            //dic2.Add(-1, "");//chosen 留空
                            dic2.Add((int)InvoStatus.待开发票, InvoStatus.待开发票.ToString());
                            dic2.Add((int)InvoStatus.已开发票, InvoStatus.已开发票.ToString());
                            dic2.Add((int)InvoStatus.已寄出, InvoStatus.已寄出.ToString());
                            dic2.Add((int)InvoStatus.已收到, InvoStatus.已收到.ToString());
                            dic2.Add((int)InvoStatus.已驳回, InvoStatus.已驳回.ToString());
                            dic2.Add((int)InvoStatus.已作废, InvoStatus.已作废.ToString());

                            ddlCheckStatus.DataSource = dic2;
                            ddlCheckStatus.DataTextField = "Value";
                            ddlCheckStatus.DataValueField = "Key";
                            ddlCheckStatus.DataBind();
                            ddlCheckStatus.SelectedValue = app4.FStatus.Value.ToString();

                            //管理员反馈
                            txtFeedback.Text = app4.Feedback;

                            //数据ID
                            hidApp4Id.Value = app4.Id.ToString();
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
            var oid = Common.ToLong(Request["oid"]);
            var entity = SiteApply4Invo.GetOne(oid);
            if (entity == null)
            {
                Response.Write(Common.SmartErr("无效参数"));
                Response.End();
            }

            entity.FStatus = sel;
            entity.Feedback = vl;//标注
            entity.UpdateDate = DateTime.Now;

            SiteApply4Invo.Update(entity);

            Response.Write(Common.Json("OK", "保存成功"));
            Response.End();

        }
    }
}