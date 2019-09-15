<%@ Page Language="VB" MasterPageFile="~/Default.master" Title="Untitled Page" %>
<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/app_controls/NavigationSideUserProfile.ascx" TagPrefix="uc1" TagName="NavigationSideUserProfile" %>
<%@ Register Src="~/App_Controls/UserWallOnPostSubmitBox.ascx" TagPrefix="uc1" TagName="UserWallOnPostSubmitBox" %>
<%@ Register Src="~/App_Controls/TagOfBlog.ascx" TagPrefix="uc1" TagName="TagOfBlog" %>
<%@ Register Src="~/App_Controls/TagOfAllBlogs.ascx" TagPrefix="uc1" TagName="TagOfAllBlogs" %>
<%@ Register Src="~/App_Controls/BlogListByRecent.ascx" TagPrefix="uc1" TagName="BlogListByRecent" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>
<%@ Register Src="~/App_Controls/UserLikeDisLikeAction.ascx" TagPrefix="uc1" TagName="UserLikeDisLikeAction" %>
<%@ Register Src="~/App_Controls/AddThisInLine.ascx" TagPrefix="uc1" TagName="AddThisInLine" %>



<script runat="server">
    ' version 01/10/2018 # 1.27 AM

    Private m_RoutIFace_String1 As String
    Public Property RoutIFace_String1 As String Implements RoutBoardUniInterface.RoutIFace_String1
        Get
            Return m_RoutIFace_String1
        End Get
        Set(value As String)
            m_RoutIFace_String1 = value
        End Set
    End Property

    Private m_RoutIFace_Heading As String
    Public Property RoutIFace_Heading() As String Implements RoutBoardUniInterface.RoutIFace_String2
        Get
            Return m_RoutIFace_Heading
        End Get
        Set(ByVal value As String)
            m_RoutIFace_Heading = value
        End Set
    End Property

    Private m_RoutIFace_ID As String
    Public Property RoutIFace_ID() As String Implements RoutBoardUniInterface.RoutIFace_String3
        Get
            Return m_RoutIFace_ID
        End Get
        Set(ByVal value As String)
            m_RoutIFace_ID = value
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


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim blogdetails As FirstClickerService.Version1.Blog.StructureBlog = FirstClickerService.Version1.Blog.Blog_Get(RoutIFace_ID, WebAppSettings.DBCS)
        If blogdetails.Result = True Then
            TagOfBlog.BlogId = blogdetails.BlogId
            TagOfBlog.BlogUserId = blogdetails.userid

            UserLikeDisLikeAction.LikeOnID = blogdetails.BlogId
            UserLikeDisLikeAction.LikeOn = FirstClickerService.Version1.UserLike.LikeOnEnum.Blog

            HyperHeading.Text = blogdetails.Heading
            HyperHeading.NavigateUrl = Request.Url.ToString
            LabelBlog.Text = blogdetails.Containt
            Labelheighlight.Text = blogdetails.Highlight
            Blogimage.Visible = CBool(blogdetails.Imageid)
            LabelDatetime.Text = FirstClickerService.Common.ConvertDateTime4Use(blogdetails.PostDate.ToString("yyyy-MM-dd HH:mm:ss"))

            UserWallOnPostSubmitBox.PreviewType = FirstClickerService.Version1.UserWall.PreviewTypeEnum.Blog
            UserWallOnPostSubmitBox.Preview_ID = blogdetails.BlogId
            UserWallOnPostSubmitBox.HeadingEndPart = "on blog "



            Dim userinfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_UserID(blogdetails.userid, WebAppSettings.DBCS)

            LabelUserID.Text = userinfo.UserID

            NavigationSideUserProfile.UserName = Trim(userinfo.UserName)
            NavigationSideUserProfile.ImageFileName = userinfo.UserImage.ImageFileName
            NavigationSideUserProfile.RoutUserName = userinfo.RoutUserName
            NavigationSideUserProfile.UserID = userinfo.UserID

            If Blogimage.Visible = True Then
                Blogimage.ImageUrl = "~/storage/image/" & blogdetails.blogImage.ImageFileName
            End If
        Else
            Response.Redirect("~/blog/")
        End If


        Me.Title = HyperHeading.Text
        Me.MetaDescription = Mid(Labelheighlight.Text, 1, 250)
        Me.MetaKeywords = ""

    End Sub



    Protected Sub UserWallOnPostSubmitBox_PostedSuccessfully_Notifier(sender As Object, e As EventArgs)
        'Notify Blog User
        Dim notificatidetails As FirstClickerService.Version1.UserNotification.StructureNotification
        notificatidetails = FirstClickerService.Version1.UserNotification.Notification_Add(Session("UserId"), LabelUserID.Text, "Posted comment on your blog.", Request.Url.ToString, 0, WebAppSettings.DBCS)
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <meta property="og:site_name" content="Bengali Clicker" />
    <meta property="og:image" content='<%=Request.Url.Scheme + Request.Url.SchemeDelimiter + Request.Url.Host.Replace("www.", "") & ResolveUrl(Blogimage.ImageUrl)%>' />
    <meta property="og:title" content="<%=HyperHeading.Text%>" />
    <meta property="og:url" content="<%= ResolveClientUrl(HyperHeading.NavigateUrl)%>" />
    <meta property="og:description" content="<%= Labelheighlight.Text%>" />
    <meta property="og:type" content="article" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelUserID" runat="server" Text="" Visible="False"></asp:Label>
    <div class="row">
        <div class="col-xl-8 col-lg-12 col-md-12 col-sm-12 ">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="horizontal" />
            <div class="card mt-2 mb-4 BoxEffect6 ">
                <div class="card-header clearfix ">
                    <div class="float-right ">
                        <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Dashboard/Blog/write.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Write Blog</asp:HyperLink>
                    </div>
                    <h5 class="card-title m-0 ">
                        <i class="fab fa-blogger"></i>&nbsp;<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Blog/">Blogs</asp:HyperLink>
                    </h5>
                </div>
            </div>
            <div class="row">
                <div class="col-12 ">
                    <div class="card-body p-1">
                        <h1>
                            <asp:HyperLink ID="HyperHeading" runat="server"></asp:HyperLink><small>&nbsp;&nbsp;<span class="text-success lead text-nowrap"><i class="far fa-calendar-alt"></i>&nbsp;<asp:Label ID="LabelDatetime" runat="server" Text=""></asp:Label></span></small>
                        </h1>
                    </div>
                </div>

                <div class="col-lg-3 col-md-3 col-sm-12">
                    <uc1:NavigationSideUserProfile runat="server" ID="NavigationSideUserProfile" />
                </div>
                <div class="col-lg-9 col-md-9 col-sm-12">
                  
                    <div class="card-body p-1">
                        <div class="">
                            <asp:Image runat="server" ID="Blogimage" CssClass=" img-fluid  rounded " />
                        </div>
                        <hr class="m-1" />
                        <div class="clearfix ">
                            <div class="float-left">
                                <uc1:AddThisInLine runat="server" ID="AddThisInLine" />
                            </div>
                            <div class="float-right ">
                                <uc1:UserLikeDisLikeAction runat="server" ID="UserLikeDisLikeAction" />
                            </div>
                        </div>

                        <!-- Post Content -->
                        <p class="text-muted">
                            <asp:Label ID="Labelheighlight" runat="server" Text="" Visible="False"></asp:Label>
                            <asp:Label ID="LabelBlog" runat="server" Text=""></asp:Label>
                        </p>
                        <uc1:TagOfBlog runat="server" ID="TagOfBlog" />
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <uc1:UserWallOnPostSubmitBox runat="server" ID="UserWallOnPostSubmitBox" OnPostedSuccessfully_Notifier="UserWallOnPostSubmitBox_PostedSuccessfully_Notifier" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="col-xl-4 col-lg-12 col-md-12 col-sm-12">
            <uc1:BlogListByRecent runat="server" ID="BlogListByRecent" />
            <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat="rectangle" />
            <uc1:TagOfAllBlogs runat="server" ID="TagOfAllBlogs" />
        </div>
    </div>
</asp:Content>

