<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/App_Controls/TagOfAllBlogs.ascx" TagPrefix="uc1" TagName="TagOfAllBlogs" %>
<%@ Register Src="~/App_Controls/BlogPreviewInList.ascx" TagPrefix="uc1" TagName="BlogPreviewInList" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>


<script runat="server">
    ' version 07/10/2018 # 1.27 AM

    Private m_RoutIFace_String1 As String
    Public Property RoutIFace_String1 As String Implements RoutBoardUniInterface.RoutIFace_String1
        Get
            Return m_RoutIFace_String1
        End Get
        Set(value As String)
            m_RoutIFace_String1 = value
        End Set
    End Property

    Private m_RoutIFace_TagName As String
    Public Property RoutIFace_TagName() As String Implements RoutBoardUniInterface.RoutIFace_String2
        Get
            Return m_RoutIFace_TagName
        End Get
        Set(ByVal value As String)
            m_RoutIFace_TagName = FirstClickerService.Common.ConvertDass2Space(value)
        End Set
    End Property


    Private m_RoutIFace_Pagenum As String
    Public Property RoutIFace_Pagenum() As String Implements RoutBoardUniInterface.RoutIFace_String3
        Get
            Return m_RoutIFace_Pagenum
        End Get
        Set(ByVal value As String)
            m_RoutIFace_Pagenum = Val(value)
        End Set
    End Property

    Private m_RoutIFace_String4 As String
    Public Property RoutIFace_String4 As String Implements RoutBoardUniInterface.RoutIFace_String4
        Get
            Return m_RoutIFace_String4
        End Get
        Set(value As String)
            m_RoutIFace_String4 = value
        End Set
    End Property



    Protected Sub ListViewTagList_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.CheckandAddTag(RoutIFace_TagName, WebAppSettings.dbcs)
        If tagdetails.Result = True Then
            LabelTagID.Text = tagdetails.TagId

            HyperLinkKeyword.Text = tagdetails.TagName
            HyperLinkKeyword.NavigateUrl = "~/blog/" & FirstClickerService.Common.ConvertSpace2Dass(tagdetails.TagName)
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelTagID" runat="server" Text="0" Visible="False"></asp:Label>
    <div class="row">
        <div class="col-12">
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-sm-12 col-md-8 col-lg-8 col-xl-8">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="horizontal" />
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix ">
                    <div class="float-right ">
                        <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Dashboard/Blog/write.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Write Blog</asp:HyperLink>
                    </div>

                    <ul class="list-inline m-0 ">
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 "><i class="fab fa-blogger"></i>&nbsp;<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Blog/">Blogs</asp:HyperLink></h5>
                        </li>
                        <li class="list-inline-item">/</li>
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 ">
                                <asp:HyperLink ID="HyperLinkKeyword" runat="server"></asp:HyperLink></h5>
                        </li>
                    </ul>

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
                        left join Table_tagOfBlog TTOB on TTOB.BlogId=T.BlogId 
                       WHERE TTOB.tagId=@tagID ORDER BY [PostDate] DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="LabelTagID" PropertyName="Text" Name="TagID" Type="Decimal"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div class="card-footer clearfix">
                <div class="float-right">
                    <asp:DataPager runat="server" ID="DataPager2" PagedControlID="ListViewBlog" PageSize="4">
                        <Fields>
                            <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>

        </div>
        <div class="col-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
            <uc1:TagOfAllBlogs runat="server" ID="TagOfAllBlogs" />
            <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat="rectangle" />
        </div>
    </div>
</asp:Content>

