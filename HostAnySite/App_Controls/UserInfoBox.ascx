<%@ Control Language="VB" ClassName="UserInfoBox" %>
<%@ Register Src="~/App_Controls/UserRelationStatusAction.ascx" TagPrefix="uc1" TagName="UserRelationStatusAction" %>



<script runat="server">
    Public Property UserName() As String
        Get
            Return HyperLinkUserName.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUserName.Text = value
            UserRelationStatusAction.UserName = value
        End Set
    End Property

    Public Property UserType() As String
        Get
            Return LabelUserType.Text
        End Get
        Set(ByVal value As String)
            LabelUserType.Text = value

            If Trim(value) = "" Then
                LabelUserType.Visible = False
            Else
                LabelUserType.Visible = True
            End If
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUserName.Text = value
            HyperLinkUserName.NavigateUrl = "~/User/" & FirstClickerService.common.ConvertSpace2Dass(value)
            UserRelationStatusAction.RoutUserName = value
        End Set
    End Property

    Public Property UserId() As String
        Get
            Return LabelUserId.Text
        End Get
        Set(ByVal value As String)
            LabelUserId.Text = value
            UserRelationStatusAction.UserID = value
        End Set
    End Property

    Public Property ImageFileName() As String
        Get
            Return ImageUserImage.AlternateText
        End Get
        Set(ByVal value As String)
            ImageUserImage.AlternateText = value
            ImageUserImage.ImageUrl = "~/storage/image/" & value
        End Set
    End Property

    Public Property FriendCount() As String
        Get
            Return LabelFriendsCount.Text
        End Get
        Set(ByVal value As String)
            LabelFriendsCount.Text = value
        End Set
    End Property

    Public Property FollowerCount() As String
        Get
            Return LabelFollowersCount.Text
        End Get
        Set(ByVal value As String)
            LabelFollowersCount.Text = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub
    Protected Sub Page_PreRender(sender As Object, e As EventArgs)

    End Sub
</script>


<asp:Label ID="LabelUserId" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelUserType" runat="server" Text="User" Visible="false"></asp:Label>
<asp:HyperLink ID="HyperLinkUserName" CssClass="text-capitalize" runat="server" Visible="False">User Name</asp:HyperLink>


<div class="media">
    <asp:Image ID="ImageUserImage" runat="server" CssClass="m-1 border rounded" Height="50" Width="50" />
    <div class="media-body ml-1 mt-1">
        <uc1:UserRelationStatusAction runat="server" ID="UserRelationStatusAction" />
        <p>
            <span class="badge badge-pill badge-light">Followers <span class="badge badge-light">
                <asp:Label ID="LabelFollowersCount" runat="server" Text="0"></asp:Label></span>
            </span>
            <span class="badge badge-pill badge-light">Friends <span class="badge badge-light">
                <asp:Label ID="LabelFriendsCount" runat="server" Text="0"></asp:Label></span>
            </span>
        </p>
    </div>
</div>


