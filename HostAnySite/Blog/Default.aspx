<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface ="RoutSiteHomeInterface"  %>

<%@ Register Src="~/App_Controls/BlogPreviewInList.ascx" TagPrefix="uc1" TagName="BlogPreviewInList" %>
<%@ Register Src="~/App_Controls/TagOfAllBlogs.ascx" TagPrefix="uc1" TagName="TagOfAllBlogs" %>
<%@ Register Src="~/App_Controls/PagingControl.ascx" TagPrefix="uc1" TagName="PagingControl" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>



<script runat="server">
    ' version 19/08/2018 # 4.27 PM

    Protected Sub SqlDataSourceBlog_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        PagingControl.LastPage = CInt(e.AffectedRows / DataPagerBlog.PageSize)
        If e.AffectedRows > Val(PagingControl.LastPage) * DataPagerBlog.PageSize Then
            PagingControl.LastPage = Val(PagingControl.LastPage) + 1
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            PagingControl.CurrentPage = 1
            PagingControl.BaseURL = "~/blog/"
        End If

        Dim pageinfo As FirstClickerService.Version1.StaticPage.StructureStaticPage
        pageinfo = FirstClickerService.Version1.StaticPage.StaticPage_Get(FirstClickerService.Version1.StaticPage.PageNameList.Site_Blog_Default, WebAppSettings.DBCS)

        PanelPagebody.Controls.Add(New LiteralControl(pageinfo.PageBody))
        ' as dinamic LiteralControl used in above, need to load on every post back 

        HyperLinkHeading.Text = pageinfo.Title

        Dim mytitle As String
        Dim myDescription As String

        mytitle = pageinfo.Title
        myDescription = Page.MetaDescription


        Title = mytitle
        MetaDescription = myDescription

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-8 col-lg-8 col-xl-8">

            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix ">
                    <div class="float-right ">
                        <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Dashboard/Blog/write.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Write Blog</asp:HyperLink>
                    </div>
                    <h5 class="card-title m-0 ">
                        <i class="fab fa-blogger"></i>&nbsp;<asp:HyperLink ID="HyperLinkHeading" runat="server" NavigateUrl="~/Blog/">Recent Blogs</asp:HyperLink>
                    </h5>
                </div>
            </div>

            <div class="card-body">
                <asp:ListView ID="ListViewBlog" runat="server" DataSourceID="SqlDataSourceBlog" DataKeyNames="Blogid">
                    <EmptyDataTemplate>
                        <span>First blog not posted yet..</span>
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
                <asp:SqlDataSource runat="server" ID="SqlDataSourceBlog" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' OnSelected ="SqlDataSourceBlog_Selected"
                    SelectCommand="SELECT t.Blogid, t.Heading, t.Highlight, t.Containt, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userId, t2.username, t2.routusername, t1.ImageFileName as PostImageFilename, t.imageid  
                        FROM [Table_Blog] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        ORDER BY [PostDate] DESC"></asp:SqlDataSource>
            </div>
            <div class="card-footer clearfix">
                <div class="float-right">
                    <uc1:PagingControl runat="server" ID="PagingControl" />
                    <asp:DataPager runat="server" ID="DataPagerBlog" PagedControlID="ListViewBlog" PageSize="4" Visible ="false" >
                        <Fields>
                            <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>

        </div>
        <div class="col-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
                      <div class ="card">
              <asp:Panel ID="PanelPagebody" CssClass ="card-body " runat="server"></asp:Panel></div>
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="rectangle" />
            <uc1:TagOfAllBlogs runat="server" ID="TagOfAllBlogs" />
        </div>

    </div>
</asp:Content>

