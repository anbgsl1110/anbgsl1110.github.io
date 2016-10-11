using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;
using Weetop.Model;

namespace Weetop.Web.member
{
    public partial class Invoice : FrontBasic
    {
        //可索取发票金额
        public decimal availableInvoice = 0m;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string action = Request["ac"];
                switch (action)
                {
                    case "1": //add
                        Add();
                        break;
                    case "2"://search
                        //GetPage();
                        break;
                    default:
                        availableInvoice = GetAvaiInvoice();
                        break;
                }

            }
        }

        /// <summary>
        /// 可索取发票金额=用户充值成功记录金额汇总-用户待开已开发票金额汇总，并保存
        /// </summary>
        /// <returns></returns>
        private decimal GetAvaiInvoice()
        {
            availableInvoice = SiteFundsHistory.GetSuccMoney(TUser.UserId) ?? 0m;
            if (availableInvoice > 0)
            {
                var temp = SiteApply4Invo.GetLockedMoney(TUser.UserId) ?? 0m;
                availableInvoice -= temp;
            }
            return availableInvoice;
        }

        private void Add()
        {
            Response.ContentType = "application/json";

            var avaiInvoice = GetAvaiInvoice();//可开发票金额
            if (avaiInvoice <= 0)
            {
                Response.Write(Common.Json("Err", "可开发票金额不足，无法开票"));
                Response.End();
            }

            var invoType = Common.ToInt(Request["InvoType"]);//开票类型
            if (invoType != (int)InvoType.个人 && invoType != (int)InvoType.公司小规模纳税人 && invoType != (int)InvoType.公司一般纳税人)
            {
                Response.Write(Common.Json("Err", "无效参数"));
                Response.End();
            }

            var fmoney = Common.ToDecimal(Request["fmoney"]);//开票金额
            var ftitle = Request["ftitle"];//发票抬头

            var ftaxcode = Request["ftaxcode"];//统一社会信用代码/税务登记号
            var fbank = Request["fbank"];//开户银行
            var fbankcode = Request["fbankcode"];//开户银行帐号
            var fbusphone = Request["fbusphone"];//营业电话
            var fbusaddr = Request["fbusaddr"];//营业执照地址
            //string dbPathName1 = null;//营业执照/税务登记证扫描件
            //string dbPathName2 = null;//一般纳税人资格认证扫描件

            var faddr = Request["faddr"];//发票寄往详细地址
            var province = Request["province"];//发票寄往省
            var city = Request["city"];//发票寄往市
            var county = Request["county"];//发票寄往区县
            string dbPathName3 = null;//其他文件
            var fremark = Request["fremark"];//备注

            if ((fmoney <= 0 || fmoney > avaiInvoice) ||
                string.IsNullOrEmpty(ftitle) ||
                string.IsNullOrEmpty(faddr))
            {
                Response.Write(Common.Json("Err", "无效参数"));
                Response.End();
            }


            #region 公司小规模纳税人证件验证
            //if (invoType == (int)InvoType.公司小规模纳税人)
            //{

            //    #region 上传文件


            //    #region 文件验证

            //    HttpPostedFile file1 = Request.Files["filetax"];//营业执照/税务登记证扫描件

            //    if (file1 == null || file1.ContentLength <= 0)
            //    {
            //        Response.Write(Common.Json("Err", "请上传营业执照/税务登记证扫描件(size>0)"));
            //        Response.End();
            //    }

            //    string[] imgExts = imageTypes.Split('|');

            //    //文件验证
            //    if (file1.ContentLength > maxImageByte)
            //    {
            //        Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
            //        Response.End();
            //    }
            //    if (!file1.ContentType.ToLower().StartsWith("image"))
            //    {
            //        Response.Write(Common.Json("Err", "文件格式不正确"));
            //        Response.End();
            //    }
            //    string fileExt1 = Path.GetExtension(file1.FileName);
            //    if (!imgExts.Contains(fileExt1))
            //    {
            //        Response.Write(Common.Json("Err", "文件格式不正确"));
            //        Response.End();
            //    }

            //    #endregion 文件验证

            //    //创建目录
            //    string dirPath = DateTime.Now.ToString("yyyyMM");
            //    string path = HttpContext.Current.Server.MapPath("~/" + basePath + dirPath);
            //    if (!Directory.Exists(path))
            //    {
            //        try
            //        {
            //            Directory.CreateDirectory(path);
            //        }
            //        catch (Exception ex)
            //        {
            //            Response.Write(Common.Json("Err", ex.Message));
            //            Response.End();
            //        }
            //    }

            //    #region 保存文件

            //    //批量时注意随机文件名可能相同，使用不同的种子
            //    var newFileName1 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(1000, 2998).ToString() + fileExt1;

            //    try
            //    {
            //        file1.SaveAs(path + "/" + newFileName1);
            //        dbPathName1 = dirPath + "/" + newFileName1;
            //    }
            //    catch (Exception ex)
            //    {
            //        Response.Write(Common.Json("Err", ex.Message));
            //        Response.End();
            //    }

            //    #endregion 保存文件


            //    #endregion 上传文件

            //} 
            #endregion

            #region 公司一般纳税人
            //if (invoType == (int)InvoType.公司一般纳税人)
            //{
            //    if (string.IsNullOrEmpty(ftaxcode) ||
            //        string.IsNullOrEmpty(fbank) ||
            //        string.IsNullOrEmpty(fbankcode) ||
            //        string.IsNullOrEmpty(fbusphone) ||
            //        string.IsNullOrEmpty(fbusaddr))
            //    {
            //        Response.Write(Common.Json("Err", "无效参数"));
            //        Response.End();
            //    }

            //    #region 上传文件


            //    #region 文件验证

            //    HttpPostedFile file1 = Request.Files["filetax"];//营业执照/税务登记证扫描件
            //    HttpPostedFile file2 = Request.Files["filenormal"];//一般纳税人资格认证扫描件

            //    if ((file1 == null || file1.ContentLength <= 0) || (file2 == null || file2.ContentLength <= 0))
            //    {
            //        Response.Write(Common.Json("Err", "请上传证件扫描件(size>0)"));
            //        Response.End();
            //    }

            //    string[] imgExts = imageTypes.Split('|');

            //    //文件验证
            //    if (file1.ContentLength > maxImageByte || file2.ContentLength > maxImageByte)
            //    {
            //        Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
            //        Response.End();
            //    }
            //    if (!file1.ContentType.ToLower().StartsWith("image") || !file2.ContentType.ToLower().StartsWith("image"))
            //    {
            //        Response.Write(Common.Json("Err", "文件格式不正确"));
            //        Response.End();
            //    }
            //    string fileExt1 = Path.GetExtension(file1.FileName);
            //    string fileExt2 = Path.GetExtension(file2.FileName);
            //    if (!imgExts.Contains(fileExt1) || !imgExts.Contains(fileExt2))
            //    {
            //        Response.Write(Common.Json("Err", "文件格式不正确"));
            //        Response.End();
            //    }

            //    #endregion 文件验证

            //    //创建目录
            //    string dirPath = DateTime.Now.ToString("yyyyMM");
            //    string path = HttpContext.Current.Server.MapPath("~/" + basePath + dirPath);
            //    if (!Directory.Exists(path))
            //    {
            //        try
            //        {
            //            Directory.CreateDirectory(path);
            //        }
            //        catch (Exception ex)
            //        {
            //            Response.Write(Common.Json("Err", ex.Message));
            //            Response.End();
            //        }
            //    }

            //    #region 保存文件

            //    //批量时注意随机文件名可能相同，使用不同的种子
            //    var newFileName1 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(1000, 2998).ToString() + fileExt1;
            //    var newFileName2 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(2999, 4998).ToString() + fileExt2;

            //    try
            //    {
            //        file1.SaveAs(path + "/" + newFileName1);
            //        dbPathName1 = dirPath + "/" + newFileName1;
            //        file2.SaveAs(path + "/" + newFileName2);
            //        dbPathName2 = dirPath + "/" + newFileName2;
            //    }
            //    catch (Exception ex)
            //    {
            //        Response.Write(Common.Json("Err", ex.Message));
            //        Response.End();
            //    }

            //    #endregion 保存文件


            //    #endregion 上传文件

            //} 
            #endregion


            #region 上传其他文件，可选

            HttpPostedFile file4 = Request.Files["fileother"];//其他文件

            if (file4 != null && file4.ContentLength > 0)
            {

                #region 文件验证

                if (file4.ContentLength > maxImageByte)
                {
                    Response.Write(Common.Json("Err", "文件超出上传大小，不得超过 " + (maxImageByte / 1024 / 1024) + "M"));
                    Response.End();
                }
                if (!file4.ContentType.ToLower().StartsWith("image"))
                {
                    Response.Write(Common.Json("Err", "文件格式不正确"));
                    Response.End();
                }
                string[] imgExts = imageTypes.Split('|');
                string fileExt4 = Path.GetExtension(file4.FileName);
                if (!imgExts.Contains(fileExt4))
                {
                    Response.Write(Common.Json("Err", "文件格式不正确"));
                    Response.End();
                }

                #endregion 文件验证

                //创建目录
                string dirPath = DateTime.Now.ToString("yyyyMM");
                string path = HttpContext.Current.Server.MapPath("~/" + basePath + dirPath);
                if (!Directory.Exists(path))
                {
                    try
                    {
                        Directory.CreateDirectory(path);
                    }
                    catch (Exception ex)
                    {
                        Response.Write(Common.Json("Err", ex.Message));
                        Response.End();
                    }
                }

                #region 保存文件

                //批量时注意随机文件名可能相同，使用不同的种子
                string newFileName4 = DateTime.Now.ToString("yyMMddhhmmss") + new Random().Next(6999, 8998).ToString() + fileExt4;

                try
                {
                    file4.SaveAs(path + "/" + newFileName4);
                    dbPathName3 = dirPath + "/" + newFileName4;
                }
                catch (Exception ex)
                {
                    Response.Write(Common.Json("Err", ex.Message));
                    Response.End();
                }

                #endregion 保存文件

            }

            #endregion 上传文件其他文件，可选


            //发票信息表
            var entity = new InvoiceInfo()
            {
                CreateDate = DateTime.Now,
                UpdateDate = DateTime.Now,
                UserId = TUser.UserId,
                InvoType = invoType,
                FTitle = ftitle,
                FAddr = faddr,
                FileOther = dbPathName3,
                FRemark = fremark,
                province = province,
                city=city,
                District = county,
                FullAddress = faddr
            };

            switch (invoType)
            {
                case (int)InvoType.个人:
                    //none
                    break;
                case (int)InvoType.公司小规模纳税人:
                    entity.FileTax = null;
                    break;
                case (int)InvoType.公司一般纳税人:
                    entity.FileTax = null;
                    entity.FileNormal = null;
                    entity.FTaxCode = ftaxcode;
                    entity.FBank = fbank;
                    entity.FBankCode = fbankcode;
                    entity.FBusPhone = fbusphone;
                    entity.FBusAddr = fbusaddr;
                    break;
            }

            SiteInvoice.Add(entity);


            //发票申请记录表
            var app4inv = new Apply4Invoice()
            {
                CreateDate = DateTime.Now,
                UpdateDate = DateTime.Now,
                UserId = TUser.UserId,
                InvoInfoId = entity.Id,//发票信息ID
                FMoney = fmoney,
                FTitle = ftitle,
                ReceiveWay = (int)ReceiveWay.快递,
                FStatus = (int)InvoStatus.待开发票
            };

           SiteApply4Invo.Add(app4inv);


            Response.Write(Common.Json("OK", "提交成功"));
            Response.End();

        }

    }
}