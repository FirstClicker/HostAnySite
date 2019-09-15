<%@ Control Language="VB" ClassName="NavigationSideUserProfile" %>
<%@ Register Src="~/App_Controls/UserRelationStatusAction.ascx" TagPrefix="uc1" TagName="UserRelationStatusAction" %>


<script runat="server">
    ' version 09/05/2019 # 11.27 PM


    Public Property ImageFileName() As String
        Get
            Return LabelImageFileName.Text
        End Get
        Set(ByVal value As String)
            LabelImageFileName.Text = value
            ImageUserImage.ImageUrl = "~/storage/image/" & value
            ImageUserImage2.ImageUrl = "~/storage/image/" & value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return LabelUsername.Text
        End Get
        Set(ByVal value As String)
            LabelUsername.Text = value
            UserRelationStatusAction.UserName = value
            UserRelationStatusAction1.UserName = value
        End Set
    End Property

    Public Property UserID() As Long
        Get
            Return LabelUserid.Text
        End Get
        Set(ByVal value As Long)
            LabelUserid.Text = value
            UserRelationStatusAction.UserID = value
            UserRelationStatusAction1.UserID = value
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUserName.Text = value

            UserRelationStatusAction.RoutUserName = value
            UserRelationStatusAction1.RoutUserName = value

            HyperLinkFollower.NavigateUrl = "~/user/" & value & "/Follower/"
            HyperLinkFollowing.NavigateUrl = "~/user/" & value & "/Following/"

            HyperLinkFriend.NavigateUrl = "~/user/" & value & "/Friend/"
            HyperLinkFriendRQSent.NavigateUrl = "~/user/" & value & "/Friendship_Requested"
            HyperLinkFriendRQReceived.NavigateUrl = "~/user/" & value & "/Friendship_Request_Received"

            HyperLinkBlog.NavigateUrl = "~/user/" & value & "/Blog/"
            HyperLinkForum.NavigateUrl = "~/user/" & value & "/Forum/"
            HyperLinkQuestion.NavigateUrl = "~/user/" & value & "/Question/"
            HyperLinkImage.NavigateUrl = "~/user/" & value & "/Image/"
        End Set
    End Property



    Protected Sub Page_PreRender(sender As Object, e As EventArgs)

        If RoutUserName.ToLower <> Trim(Session("routuserName")).ToLower Then
            HyperLinkMessage.NavigateUrl = "~/message/" & RoutUserName

            HyperLinkFriendRQSent.Visible = False
            HyperLinkFriendRQReceived.Visible = False
        Else

        End If

        HyperLinkForum.Visible = WebAppSettings.HasApp_Forum_IsEnabled
        HyperLinkBlog.Visible = WebAppSettings.HasApp_Blog_IsEnabled
        HyperLinkQuestion.Visible = WebAppSettings.HasApp_Question_IsEnabled

    End Sub

</script>
<asp:Label ID="LabelImageFileName" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelUsername" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelUserid" runat="server" Text="" Visible="False"></asp:Label>




<nav class="navbar navbar-light border navbar-expand-md mt-2 mb-2 p-0 BoxEffect1">
    
   <div class="navbar-brand navbar-link d-md-none ml-2">
        <asp:Image ID="ImageUserImage" runat="server" Height="40" ImageUrl="~/Content/image/UserAvtar.png" CssClass ="p-1" />
       <uc1:UserRelationStatusAction runat="server" ID="UserRelationStatusAction" Control_CSSClass="d-inline" />
    </div>
      

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarWEX" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
   
    <div class="navbar-collapse collapse flex-column " id="navbarWEX">
        <div class="list-group w-100">



            <div class="list-group-item d-none d-md-block p-0">
                <asp:Image ID="ImageUserImage2" runat="server" class="img-thumbnail border-0" ImageUrl="~/Content/image/UserAvtar.png" />
            </div>

            <uc1:UserRelationStatusAction runat="server" ID="UserRelationStatusAction1" Control_CSSClass ="list-group-item d-none d-md-block" />
            <asp:HyperLink ID="HyperLinkMessage" CssClass="list-group-item" runat="server" NavigateUrl="~/dashboard/inbox.aspx"><i class="fas fa-envelope" aria-hidden="true"></i>&nbsp;Message</asp:HyperLink>


            <div class="list-group-item">
                <i class="far fa-address-card"></i>&nbsp;<a href="#GroupFollower" class=" Change-DropDown-Icon" data-toggle="collapse">Friends<i class="fa fa-chevron-circle-down float-right"></i></a>
            </div>
            <div class="collapse" id="GroupFollower" style="padding-left: 10px;">
                <asp:HyperLink ID="HyperLinkFriend" runat="server" class="list-group-item" NavigateUrl="#"><i class="far fa-user-circle"></i>&nbsp;Friends</asp:HyperLink>
                <asp:HyperLink ID="HyperLinkFriendRQSent" runat="server" class="list-group-item" NavigateUrl="#"><i class="far fa-user-circle"></i>&nbsp;Request Sent</asp:HyperLink>
                <asp:HyperLink ID="HyperLinkFriendRQReceived" runat="server" class="list-group-item" NavigateUrl="#"><i class="far fa-user-circle"></i>&nbsp;Request Received</asp:HyperLink>

                <asp:HyperLink ID="HyperLinkFollower" runat="server" class="list-group-item" NavigateUrl="#"><i class="far fa-user-circle"></i>&nbsp;Followers</asp:HyperLink>
                <asp:HyperLink ID="HyperLinkFollowing" runat="server" class="list-group-item" NavigateUrl="#"><i class="far fa-user-circle"></i>&nbsp;Following</asp:HyperLink>
            </div>

              

            <asp:HyperLink ID="HyperLinkBlog" CssClass="list-group-item" runat="server" NavigateUrl="#"><i class="fab fa-blogger"></i>&nbsp;Blog</asp:HyperLink>
            <asp:HyperLink ID="HyperLinkForum" CssClass="list-group-item" runat="server" NavigateUrl="#"><i class="fab fa-foursquare"></i>&nbsp;Forum</asp:HyperLink>
            <asp:HyperLink ID="HyperLinkQuestion" CssClass="list-group-item" runat="server" NavigateUrl="#"><i class="fas fa-question"></i>&nbsp;Question</asp:HyperLink>
            <asp:HyperLink ID="HyperLinkImage" CssClass="list-group-item" runat="server" NavigateUrl="#"><i class="far fa-images"></i>&nbsp;Image</asp:HyperLink>



        </div>
    </div>
</nav>
