<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>
<%@ Register Src="~/App_Controls/BlogPreviewInList.ascx" TagPrefix="uc1" TagName="BlogPreviewInList" %>




<script runat="server">


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header ">
                   Blog Lists
                    <div class="float-right ">
                     
                    </div>
                </div>
                                 <div class="card-body">
                    <asp:ListView ID="ListViewBlog" runat="server" DataSourceID="SqlDataSourceBlog" DataKeyNames="Blogid">
                        <EmptyDataTemplate>
                            <span>You have not posted your first blog yet..</span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <div class="col-12">
                        
                                <uc1:BlogPreviewInList runat="server" ID="BlogPreviewInList" UserId='<%# Eval("UserId") %>' UserName='<%# Eval("UserName") %>' RoutUserName='<%# Eval("RoutUserName") %>' BlogId='<%# Eval("BlogId") %>' Heading='<%# Eval("Heading") %>' Highlight='<%# Eval("Highlight") %>' BlogImageId='<%# Eval("ImageId") %>' BlogImageFileName='<%# Eval("PostImageFilename") %>' PostDate='<%# Eval("PostDate") %>' ShowBlogBody="false" />
                            </div>
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
                <div class="card-footer clearfix">
                    <div class="float-right">
                        <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ListViewBlog" PageSize="4">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>


        </div>
    </div>
</asp:Content>

