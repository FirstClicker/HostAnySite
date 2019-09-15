<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Implements Interface="RoutUserInterface" %>

<%@ Register Src="~/App_Controls/NavigationSideUserProfile.ascx" TagPrefix="uc1" TagName="NavigationSideUserProfile" %>
<%@ Register Src="~/App_Controls/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/App_Controls/BlogPreviewInList.ascx" TagPrefix="uc1" TagName="BlogPreviewInList" %>




<script runat="server">
    Private m_RoutFace_RoutUserName As String
    Public Property RoutFace_RoutUserName() As String Implements RoutUserInterface.RoutIFace_RoutUserName
        Get
            Return m_RoutFace_RoutUserName
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutUserName = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim userinfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_RoutUserName(RoutFace_RoutUserName, WebAppSettings.DBCS)
            If userinfo.Result = False Then
                Response.Redirect("~/")
                Exit Sub
            End If

            NavigationSideUserProfile.UserName = Trim(userinfo.UserName)
            NavigationSideUserProfile.ImageFileName = userinfo.UserImage.ImageFileName
            NavigationSideUserProfile.RoutUserName = userinfo.RoutUserName
            NavigationSideUserProfile.UserID = userinfo.UserID

            ImageUserBanner.ImageUrl = "~/storage/image/" & userinfo.BannerImage.ImageFileName

            HyperLinkPageHeading.Text = userinfo.UserName & "'s Blogs"
            HyperLinkPageHeading.NavigateUrl = "~/user/" & userinfo.RoutUserName & "/Blog"
        End If

        Me.Title = NavigationSideUserProfile.UserName & "'s Blogs"
        Me.MetaDescription = NavigationSideUserProfile.UserName & "'s Blogs"
        Me.MetaKeywords = ""
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <div class="card  m-1 BoxEffect8">
                <asp:Image ID="ImageUserBanner" ImageUrl="~/Content/image/ProfileBanner.png" CssClass="img-fluid" runat="server" />
            </div>
        </div>
    </div>

 
            <div class="row">
                <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
                    <uc1:NavigationSideUserProfile runat="server" ID="NavigationSideUserProfile" />
                </div>
                <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">

                    <div class="card mt-2 BoxEffect6 ">
                        <div class="card-header clearfix ">
                            <div class="float-right ">
                                <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Dashboard/Blog/write.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Write Blog</asp:HyperLink>
                            </div>
                            <h5 class="card-title m-0 ">
                                <asp:HyperLink ID="HyperLinkPageHeading" runat="server" NavigateUrl="~/blog/" Text="Blog"></asp:HyperLink>
                            </h5>
                        </div>
                    </div>
                        <div class="card-body">
                            <asp:ListView ID="ListViewBlog" runat="server" DataSourceID="SqlDataSourceBlog" DataKeyNames="Blogid">
                                <EmptyDataTemplate>
                                    <span>You have not posted your first blog yet..</span>
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <div class="col-12">
                                        <uc1:BlogPreviewInList runat="server" ID="BlogPreviewInList" UserId='<%# Eval("UserId") %>' UserName='<%# Eval("UserName") %>' RoutUserName='<%# Eval("RoutUserName") %>' BlogId='<%# Eval("BlogId") %>' Heading='<%# Eval("Heading") %>' Highlight='<%# Eval("Highlight") %>' BlogImageId='<%# Eval("ImageId") %>' BlogImageFileName='<%# Eval("PostImageFilename") %>' PostDate='<%# Eval("PostDate") %>' />
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
                           WHERE (t.userid = @UserID) 
                        ORDER BY [PostDate] DESC">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="NavigationSideUserProfile" PropertyName="userid" Name="UserID" Type="String"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
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
    

</asp:Content>

