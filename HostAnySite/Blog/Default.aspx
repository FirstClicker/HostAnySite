<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/app_controls/web/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/app_controls/web/NavigationSideMain.ascx" TagPrefix="uc1" TagName="NavigationSideMain" %>
<%@ Register Src="~/app_controls/web/BlogInListView.ascx" TagPrefix="uc1" TagName="BlogInListView" %>
<%@ Register Src="~/app_controls/web/WhatsHappening.ascx" TagPrefix="uc1" TagName="WhatsHappening" %>



<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)



    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-8">
            
            <div class="panel panel-default ">
                <div class="panel-heading">Blogs</div>
                <div class="panel-body UserWall-Body">
                    <asp:ListView ID="ListViewBlog" runat="server" DataSourceID="SqlDataSourceBlog" DataKeyNames="Blogid">

                        <EmptyDataTemplate>
                            <span>No blog found.</span>
                        </EmptyDataTemplate>

                        <ItemTemplate>
                                              <uc1:BlogInListView runat="server" ID="BlogInListView" UserId ='<%# Eval("UserId") %>' UserName ='<%# Eval("UserName") %>' RoutUserName ='<%# Eval("RoutUserName") %>' BlogId ='<%# Eval("BlogId") %>' Heading ='<%# Eval("Heading") %>' Highlight ='<%# Eval("Highlight") %>' BlogImageId ='<%# Eval("ImageId") %>' BlogImageFileName ='<%# Eval("PostImageFilename") %>' PostDate ='<%# Eval("PostDate") %>' />

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" class="row">
                                <div runat="server" id="itemPlaceholder" />

                            </div>

                        </LayoutTemplate>

                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceBlog" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT t.Blogid, t.Heading, t.Highlight, t.Containt, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userId, t2.username, t2.routusername, t1.ImageFileName as PostImageFilename, t.imageid  
                        FROM [Table_Blog] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        ORDER BY [PostDate] DESC"></asp:SqlDataSource>
                </div>
                <div class="panel-footer clearfix">
                    <div class="pull-right">
                        <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ListViewBlog" PageSize="4">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <uc1:NavigationSideMain runat="server" ID="NavigationSideMain" />
            <uc1:WhatsHappening runat="server" ID="WhatsHappening" />
        </div>
    </div>


</asp:Content>

