## 数据绑定
我们可以通过数据绑定（Data Binding）来完成带有可选项目的列表，这些可选列表来自与某个可选项目的数据源，例如数据库，XML或者脚本

### 支持数据绑定的列表
* asp:RadioButtonList
* asp:CheckBoxList
* asp:DropDownList
* asp:ListBox 

## ArrayList
对象包含单个数据集的项目的集合

## HashTable
对象包含用键值对表示的项目，键被用作索引，通过搜索键，可以实现对值的快速搜索。

## SortedList
SortedList对象包含用键值对表示的项目，SortedList对象按照字母顺序或者数字顺序自动的对项目进行排序。

## DataList
DataList对象类似于Repeater,用于显示绑定在该控件上的项目的重复列表。不过DataList控件会默认的在数据项目中添加表格。

<code><form id="myform" runat="server">
<asp:DataList id="DataList1" runat="server">
    <HeaderTemplate>
    </HeaderTemplate>
    <ItemTemple>
    </ItemTemplate>
    <FooterTemplate>
    </FooterTemplate>
</asp:DataList>
</form></code>

