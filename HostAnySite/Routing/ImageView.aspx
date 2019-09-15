<%@ Page Language="VB" MasterPageFile="~/Default.master" Title="Untitled Page" %>
<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/app_controls/TagOfAllImages.ascx" TagPrefix="uc1" TagName="TagOfAllImages" %>
<%@ Register Src="~/App_Controls/TagOfImage.ascx" TagPrefix="uc1" TagName="TagOfImage" %>
<%@ Register Src="~/App_Controls/UserWallOnPostSubmitBox.ascx" TagPrefix="uc1" TagName="UserWallOnPostSubmitBox" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>
<%@ Register Src="~/App_Controls/ImageResizeDownload.ascx" TagPrefix="uc1" TagName="ImageResizeDownload" %>
<%@ Register Src="~/App_Controls/ImageIconDownload.ascx" TagPrefix="uc1" TagName="ImageIconDownload" %>
<%@ Register Src="~/App_Controls/UserLikeDisLikeAction.ascx" TagPrefix="uc1" TagName="UserLikeDisLikeAction" %>
<%@ Register Src="~/App_Controls/FacebookPluginsPage.ascx" TagPrefix="uc1" TagName="FacebookPluginsPage" %>


<script runat="server">
    ' version 12/09/2018 # 1.27 AM

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
            m_RoutIFace_Heading = FirstClickerService.Common.ConvertDass2Space(value)
        End Set
    End Property

    Private m_RoutIFace_ID As String
    Public Property RoutIFace_ID() As String Implements RoutBoardUniInterface.RoutIFace_String3
        Get
            Return m_RoutIFace_ID
        End Get
        Set(ByVal value As String)
            m_RoutIFace_ID = Val(value)
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
        Dim Imagedetails As FirstClickerService.Version1.Image.StructureImage = FirstClickerService.Version1.Image.ImageDetails_BYID(RoutIFace_ID, WebAppSettings.DBCS)
        If Imagedetails.Result = True Then
            TagOfImage.imageid = Imagedetails.ImageId
            TagOfImage.ImageUserId = Imagedetails.userId

            ImageResizeDownload.ImageFileName = Imagedetails.ImageFileName
            ImageResizeDownload.ImageSizes = "1366x768, 1920x1080, 1024x768, 1280x1024, 1600x900, 1080x1920, 1280x800, 1440x900, 640x360, 568x320, 667x375"

            ImageIconDownload.Visible = False
            'ImageIconDownload.ImageFileName = Imagedetails.ImageFileName
            'ImageIconDownload.IconSizes = "8x8, 16x16, 32x32, 64x64, 128x128"

            UserLikeDisLikeAction.LikeOnID = Imagedetails.ImageId

            HyperHeading.Text = Imagedetails.ImageName
            HyperHeading.NavigateUrl = Request.Url.ToString
            Labeldescription.Text = Imagedetails.Drescption
            LabelDatetime.Text = FirstClickerService.Common.ConvertDateTime4Use(Imagedetails.PostDate.ToString("yyyy-MM-dd HH:mm:ss"))

            UserWallOnPostSubmitBox.PreviewType = FirstClickerService.Version1.UserWall.PreviewTypeEnum.Image
            UserWallOnPostSubmitBox.Preview_ID = Imagedetails.ImageId
            UserWallOnPostSubmitBox.HeadingEndPart = "on image <a href='http://" & Request.Url.Host & "/image/" & Imagedetails.ImageId & "/" & FirstClickerService.Common.ConvertSpace2Dass(Imagedetails.ImageName) & "'>" & Imagedetails.ImageName & "</a>"


            Dim userinfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_UserID(Imagedetails.userId, WebAppSettings.DBCS)
            LabelUserID.Text = userinfo.UserID
            HyperLinkUsername.Text = userinfo.UserName
            HyperLinkUsername.NavigateUrl = "~/user/" & userinfo.RoutUserName



            Blogimage.ImageUrl = "~/storage/image/" & Imagedetails.ImageFileName
        Else
            Response.Redirect("~/image/")
        End If

        Me.Title = HyperHeading.Text
        Me.MetaDescription = Mid(Labeldescription.Text, 1, 250)
        Me.MetaKeywords = ""
    End Sub


    Protected Sub UserWallPost_PostedSuccessfully_Notifier(sender As Object, e As EventArgs)
        'Notify Blog User

    End Sub

    Protected Sub UserWallOnPostSubmitBox_PostedSuccessfully_Notifier(sender As Object, e As EventArgs)
        Dim notificatidetails As FirstClickerService.Version1.UserNotification.StructureNotification
        notificatidetails = FirstClickerService.Version1.UserNotification.Notification_Add(Session("UserId"), LabelUserID.Text, "Posted comment on your Image.", Request.Url.ToString, 0, WebAppSettings.DBCS)
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <meta property="og:site_name" content="Bengali Clicker" />
    <meta property="og:image" content="<%=  Blogimage.ImageUrl.Replace("~", Request.Url.Scheme & Request.Url.SchemeDelimiter + Request.Url.Host.Replace("www.", "")) %>" />
    <meta property="og:title" content="<%=HyperHeading.Text%>" />
    <meta property="og:url" content="<%=HyperHeading.NavigateUrl%>" />
    <meta property="og:description" content="<%= Labeldescription.Text%>" />
    <meta property="og:type" content="article" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelUserID" runat="server" Text="" Visible="False"></asp:Label>

    <div class="row">
        <div class="col-lg-8 col-md-12 col-sm-12 ">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="horizontal" />
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header">
                    <h5 class="card-title m-0 ">
                        <i class="far fa-images"></i>&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Image/">Images</asp:HyperLink>
                    </h5>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="card mt-2 mb-2">

                        <div class="card-body ">
                            <div class="clearfix ">
                                <div class="float-left">
                                    <h3 class="card-title ">
                                        <asp:HyperLink ID="HyperHeading" CssClass="text-capitalize " runat="server"></asp:HyperLink></h3>
                                </div>
                                <div class="float-right "></div>
                            </div>


                            <div class="clearfix ">
                                <div class="float-left">
                                    <p>
                                        <i class="fas fa-user-circle"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUsername" runat="server" CssClass="text-capitalize"></asp:HyperLink>
                                        &nbsp;|&nbsp;<i class="far fa-calendar-alt"></i>&nbsp;Posted on&nbsp;<asp:Label ID="LabelDatetime" runat="server" Text="Label"></asp:Label>
                                    </p>
                                </div>
                                <div class="float-right ">
                                    <uc1:UserLikeDisLikeAction runat="server" ID="UserLikeDisLikeAction" LikeOn="Image" />
                                </div>
                            </div>
                        </div>

                        <div class="text-center ">
                            <asp:Image runat="server" ID="Blogimage" CssClass="img-fluid " />
                        </div>


                        <div class="card-body">
                            <p class="lead">
                                <asp:Label ID="Labeldescription" runat="server" Text=""></asp:Label>
                            </p>
                            <uc1:TagOfImage runat="server" ID="TagOfImage" />

                        </div>
                        <uc1:ImageResizeDownload runat="server" ID="ImageResizeDownload" />
                        <uc1:ImageIconDownload runat="server" ID="ImageIconDownload" />
                    </div>
                    <uc1:AdsenseAds runat="server" ID="AdsenseAds2" Adsformat="rectangle"   />

                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <uc1:UserWallOnPostSubmitBox runat="server" ID="UserWallOnPostSubmitBox" OnPostedSuccessfully_Notifier="UserWallOnPostSubmitBox_PostedSuccessfully_Notifier" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-12 col-sm-12">
            <uc1:FacebookPluginsPage runat="server" ID="FacebookPluginsPage" FBPageName ="BestHDPics" FBPageURL ="https://facebook.com/BestHDPics" />
            <uc1:AdsenseAds runat="server" ID="AdsenseAds1"  Adsformat ="rectangle"  />
            <uc1:TagOfAllImages runat="server" ID="TagOfAllImages" />
        </div>
    </div>

</asp:Content>

