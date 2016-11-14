<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>

<script runat="server" >
sub Page_Load
if Not Page.IsPostBack
    dim myCountries = new DataSet
    myCountries.ReadXml(MaPath("../XMLFile1.xml"))
    rb.DataSource = myCountries
    rb.DataValueField = "value"
    rb.DataTextField = "text"
    rb.BindData()
end if
end sub    
</script>

<!Doctype html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <title>webform-xml练习</title>
</head>
<body>
    <form id="form1" runat="server">
       <RadioButtonList id="rb" runat="server" AutoPostBack="True"> 
    </form>
</body>
</html>