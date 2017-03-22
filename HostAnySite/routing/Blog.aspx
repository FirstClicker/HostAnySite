<%@ Page Language="VB" MasterPageFile="~/Default.master" Title="Untitled Page" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Implements Interface="ClassHostAnySite.RoutBlogInterface" %>
<%@ Register Src="~/app_controls/web/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Src="~/app_controls/web/UserWallPost.ascx" TagPrefix="uc1" TagName="UserWallPost" %>
<%@ Register Src="~/app_controls/web/MenuUserProfile.ascx" TagPrefix="uc1" TagName="MenuUserProfile" %>
<%@ Register Src="~/app_controls/web/WhatsHappening.ascx" TagPrefix="uc1" TagName="WhatsHappening" %>






<script runat="server">

    Private m_RoutIFace_BlogId As String
    Public Property RoutIFace_BlogId() As String Implements ClassHostAnySite.RoutBlogInterface.RoutIFace_BlogID
        Get
            Return m_RoutIFace_BlogId
        End Get
        Set(ByVal value As String)
            m_RoutIFace_BlogId = value
        End Set
    End Property

    Private m_RoutIFace_Heading As String
    Public Property RoutIFace_Heading() As String Implements ClassHostAnySite.RoutBlogInterface.RoutIFace_Heading
        Get
            Return m_RoutIFace_Heading
        End Get
        Set(ByVal value As String)
            m_RoutIFace_Heading = value
        End Set
    End Property



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim blogdetails As ClassHostAnySite.Blog.StructureBlog = ClassHostAnySite.Blog.Blog_Get(RoutIFace_BlogId, ClassAppDetails.DBCS)
        If blogdetails.Result = True Then
            HyperHeading.Text = blogdetails.Heading
            HyperHeading.NavigateUrl = Request.Url.ToString
            LabelBlog.Text = blogdetails.Containt
            Labelheighlight.Text = blogdetails.Highlight
            Blogimage.Visible = CBool(blogdetails.Imageid)
            LabelDatetime.Text = blogdetails.PostDate.ToShortDateString

            UserWallPost.Wall_BlogId = blogdetails.BlogId
            UserWallPost.HeadingEndPart = "on blog <a href='http://" & Request.Url.Host & "/blog/" & blogdetails.BlogId & "/" & blogdetails.Heading.Replace(" ", "-") & "'>" & blogdetails.Heading & "</a>"


            UserWallPost.PreviewType = ClassHostAnySite.UserWall.PreviewTypeEnum.MediaView
            UserWallPost.Preview_Heading = blogdetails.Heading
            UserWallPost.Preview_TargetURL = "http://" & Request.Url.Host & "/blog/" & blogdetails.BlogId & "/" & blogdetails.Heading.Replace(" ", "-")
            UserWallPost.Preview_BodyText = Mid(Labelheighlight.Text, 1, 500)
            If Blogimage.Visible = True Then
                UserWallPost.Preview_ImageURL = "http://" & Request.Url.Host & "/storage/image/" & blogdetails.blogImage.ImageFileName
            End If


            Dim userinfo As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.UserDetail_UserID(blogdetails.userid, ClassAppDetails.DBCS)
            Hyperuser.Text = userinfo.UserName
            Hyperuser.NavigateUrl = "~/user/" & userinfo.RoutUserName
            LabelUserID.Text = userinfo.UserID

            MenuUserProfile.UserName = Trim(userinfo.UserName)
            MenuUserProfile.ImageFileName = userinfo.UserImage.ImageFileName
            MenuUserProfile.RoutUserName = userinfo.RoutUserName



            If Blogimage.Visible = True Then
                Blogimage.ImageUrl = "~/storage/image/" & blogdetails.blogImage.ImageFileName
            End If

        End If



        Me.Title = HyperHeading.Text
        Me.MetaDescription = Mid(Labelheighlight.Text, 1, 250)
        Me.MetaKeywords = ""

    End Sub



    Protected Sub ButtonAddFavoriteList_Click(sender As Object, e As EventArgs)

    End Sub



    Protected Sub ButtonCreatelist_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/User/" & Session("routusername") & "/list/")
    End Sub

    Protected Sub ButtonPDF_Click(sender As Object, e As EventArgs)


    End Sub


    Protected Sub UserWallPost_PostedSuccessfully_Notifier(sender As Object, e As EventArgs)
        'Notify Blog User
        Dim notificatidetails As ClassHostAnySite.UserNotification.StructureNotification
        notificatidetails = ClassHostAnySite.UserNotification.Notification_Add(Session("UserId"), LabelUserID.Text, "Posted comment on your blog.", Request.Url.ToString, 0, ClassAppDetails.DBCS)
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <meta property="og:site_name" content="Bengali Clicker" />
    <meta property="og:image" content="<%=Blogimage.ImageUrl%>" />
    <meta property="og:title" content="<%=HyperHeading.Text%>" />
    <meta property="og:url" content="<%=HyperHeading.NavigateUrl%>" />
    <meta property="og:description" content="<%= Labelheighlight.Text%>" />
    <meta property="og:type" content="article" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-9 col-md-9 col-sm-12 ">
            <div class="col-lg-3 col-md-3 col-sm-3">
                <uc1:MenuUserProfile runat="server" ID="MenuUserProfile" />
            </div>
            <div class="col-lg-9 col-md-9 col-sm-9">
                <div class="panel">
                    <div class="panel-body ">
                        <!-- Title -->
                        <h1>
                            <asp:HyperLink ID="HyperHeading" runat="server"></asp:HyperLink></h1>

                        <hr />
                        <asp:Image runat="server" ID="Blogimage" CssClass="img-rounded img-responsive " />

                        <!-- Post Content -->
                        <p class="lead">
                            <asp:Label ID="Labelheighlight" runat="server" Text="" Visible="False"></asp:Label>
                            <br />
                            <asp:Label ID="LabelBlog" runat="server" Text="Label"></asp:Label>
                        </p>
                        <hr />
                        <div class="clearfix ">
                            <div class="pull-left ">
                                <p class="lead">
                                    By
                            <asp:HyperLink ID="Hyperuser" CssClass=" text-capitalize " runat="server">User Name</asp:HyperLink>
                                </p>
                                <asp:Label ID="LabelUserID" runat="server" Text="" Visible ="false" ></asp:Label>
                            </div>
                            <div class="pull-right ">
                                <p>
                                    <span class="glyphicon glyphicon-time"></span>Posted on
                        <asp:Label ID="LabelDatetime" runat="server" Text="Label"></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <uc1:UserWallPost runat="server" ID="UserWallPost" OnPostedSuccessfully_Notifier ="UserWallPost_PostedSuccessfully_Notifier" />
                    </ContentTemplate>
                </asp:UpdatePanel>


            </div>
        </div>
        <div class="col-lg-3 col-md-3 col-sm-12">
            <uc1:WhatsHappening runat="server" ID="WhatsHappening" />
        </div>
    </div>



</asp:Content>

