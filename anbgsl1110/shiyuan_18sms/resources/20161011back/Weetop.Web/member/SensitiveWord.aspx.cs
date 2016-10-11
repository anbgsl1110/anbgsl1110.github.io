using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Weetop.DAL;

namespace Weetop.Web.member
{
    public partial class SensitiveWord : FrontBasic
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string text = Request["text"];
                if (!string.IsNullOrEmpty(text))
                {
                    TrieFilter tf = SiteKeywords.GetFilter();

                    string newTxt = tf.HighLight(text);

                    Response.Write(newTxt);
                    Response.End();
                }
            }
        }

    }
}