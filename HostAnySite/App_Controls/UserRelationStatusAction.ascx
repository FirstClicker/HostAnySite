<%@ Control Language="VB" ClassName="UserRelationStatusAction" %>
<%@ Import Namespace="FirstClickerService" %>
<script runat="server">

    Public Property UserID() As Long
        Get
            Return Val(LabelUserId.Text)
        End Get
        Set(ByVal value As Long)
            LabelUserId.Text = value
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUserName.Text = value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return HyperLinkUserName.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUserName.Text = value
        End Set
    End Property

    Public Property Control_CSSClass() As String
        Get
            Return PanelCointainer.CssClass
        End Get
        Set(ByVal value As String)
            PanelCointainer.CssClass = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkUserName.NavigateUrl = "~/user/" & RoutUserName

        If IsPostBack = False Then
            loadstatus()
        End If
    End Sub



    Private Function loadstatus() As Boolean
        loadstatus = False

        If Val(Session("userid")) > 10 And Val(UserID) <> Val(Session("userid")) Then
            Dim UserRelStatus As Version1.UserRelation.StructureUserRelation
            UserRelStatus = Version1.UserRelation.UserRelation_GetInOrder(Session("userid"), UserID, WebAppSettings.DBCS)

            If UserRelStatus.FollowStatus = Version1.UserRelation.FollowStatusEnum.Following Or UserRelStatus.FollowStatus = Version1.UserRelation.FollowStatusEnum.Connected Then
                LinkButtonFollow.Text = Version1.UserRelation.FollowerActionEnum.Unfollow.ToString
            Else
                LinkButtonFollow.Text = Version1.UserRelation.FollowerActionEnum.Follow.ToString
            End If

            If UserRelStatus.FriendStatus = Version1.UserRelation.FriendStatusEnum.Friend Then
                buttonAddFriend.Text = Version1.UserRelation.FriendStatusEnum.Friend.ToString
                LIAddFriend.Visible = False
                dropdownarrowlink.Visible = True

                LinkButtonFriend.Text = Version1.UserRelation.FriendActionEnum.Remove_Friend.ToString.Replace("_", " ")
            ElseIf UserRelStatus.FriendStatus = Version1.UserRelation.FriendStatusEnum.RequestReceived Then
                buttonAddFriend.Text = Version1.UserRelation.FriendActionEnum.Accept_Friend_Request.ToString.Replace("_", " ")
                LinkButtonFriend.Text = Version1.UserRelation.FriendActionEnum.Reject_Friend_Request.ToString.Replace("_", " ")
            ElseIf UserRelStatus.FriendStatus = Version1.UserRelation.FriendStatusEnum.Unknown Then
                buttonAddFriend.Text = Version1.UserRelation.FriendActionEnum.Add_Friend.ToString.Replace("_", " ")
                LIFriend.Visible = False
            ElseIf UserRelStatus.FriendStatus = Version1.UserRelation.FriendStatusEnum.RequestSent Then
                buttonAddFriend.Text = Version1.UserRelation.FriendActionEnum.Cancel_Friend_Request.ToString.Replace("_", " ")
                LIFriend.Visible = False
            End If
        Else ' same user or no user
            LinkButtonFollow.Enabled = False
            LinkButtonFollow.Text = Version1.UserRelation.FollowerActionEnum.Follow.ToString

            dropdownarrowlink.Visible = False
            LIAddFriend.Visible = False
            buttonAddFriend.Text = Version1.UserRelation.FriendActionEnum.Add_Friend.ToString.Replace("_", " ")

            LIFriend.Visible = False

        End If
    End Function


    Protected Sub buttonAddFriend_Click(sender As Object, e As EventArgs)
        Dim friendAction As Version1.UserRelation.FriendActionEnum
        Version1.UserRelation.FriendActionEnum.TryParse(buttonAddFriend.Text.Replace(" ", "_"), friendAction)

        Dim SubmitUserRelation As Version1.UserRelation.StructureUserRelation
        SubmitUserRelation = Version1.UserRelation.UserRelation_FriendAction(Session("userid"), UserID, Session("UserName"), UserName, friendAction, WebAppSettings.DBCS)
        If SubmitUserRelation.Result = False Then

        Else
            loadstatus()
            UpdatePanelAction.Update()

            Dim sendNotification As Version1.UserNotification.StructureNotification
            Select Case friendAction
                Case Version1.UserRelation.FriendActionEnum.Accept_Friend_Request
                    sendNotification = Version1.UserNotification.Notification_Add(Session("userid"), UserID, "Friend request accepted", "~/user/" & Session("routusername") & "/", 0, WebAppSettings.DBCS)

                Case Version1.UserRelation.FriendActionEnum.Add_Friend
                    sendNotification = Version1.UserNotification.Notification_Add(Session("userid"), UserID, "Friend request received", "~/user/" & Session("routusername") & "/", 0, WebAppSettings.DBCS)

            End Select
        End If
    End Sub

    Protected Sub LinkButtonFriend_Click(sender As Object, e As EventArgs)
        Dim friendAction As Version1.UserRelation.FriendActionEnum
        Version1.UserRelation.FriendActionEnum.TryParse(LinkButtonFriend.Text.Replace(" ", "_"), friendAction)

        Dim SubmitUserRelation As Version1.UserRelation.StructureUserRelation
        SubmitUserRelation = Version1.UserRelation.UserRelation_FriendAction(Session("userid"), UserID, Session("UserName"), UserName, friendAction, WebAppSettings.DBCS)
        If SubmitUserRelation.Result = False Then

            'report error

        Else
            loadstatus()
            UpdatePanelAction.Update()

            'sent notification
            Select Case friendAction
                Case Version1.UserRelation.FriendActionEnum.Remove_Friend
                    LIAddFriend.Visible = True
                    dropdownarrowlink.Visible = True
                    buttonAddFriend.Text = Version1.UserRelation.FriendActionEnum.Add_Friend.ToString.Replace("_", " ")
            End Select

        End If
    End Sub

    Protected Sub LinkButtonFollow_Click(sender As Object, e As EventArgs)
        Dim FollowAction As Version1.UserRelation.FollowerActionEnum
        Version1.UserRelation.FollowerActionEnum.TryParse(LinkButtonFollow.Text.Replace(" ", "_"), FollowAction)

        Dim SubmitUserRelation As Version1.UserRelation.StructureUserRelation
        SubmitUserRelation = Version1.UserRelation.UserRelation_FollowAction(Session("userid"), UserID, Session("UserName"), UserName, FollowAction, WebAppSettings.DBCS)

        loadstatus()
        UpdatePanelAction.Update()

    End Sub



</script>

<asp:Label ID="LabelUserId" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>


<asp:UpdatePanel ID="UpdatePanelAction" runat="server" UpdateMode="Conditional" RenderMode="Inline">
    <ContentTemplate>
        <asp:Panel runat="server" ID="PanelCointainer">
            <asp:HyperLink ID="HyperLinkUserName" runat="server" CssClass ="mr-1"></asp:HyperLink>
            <div class="dropdown d-inline">
                <a runat="server" id="dropdownarrowlink" href="#" class="dropdown-toggle align-middle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fas fa-cog"></i></a>
                <div class="dropdown-menu dropdown-menu-right" >
                    <li runat ="server" id="LIAddFriend" class="dropdown-item">
                        <asp:LinkButton ID="buttonAddFriend" runat="server" CssClass="btn btn-sm" OnClick="buttonAddFriend_Click" Text="Add Friend"></asp:LinkButton>
                    </li>
                    <li runat ="server" id="LIFriend"  class="dropdown-item">
                        <asp:LinkButton ID="LinkButtonFriend" runat="server" CssClass="btn btn-sm" OnClick="LinkButtonFriend_Click">Action</asp:LinkButton>
                    </li>
                    <li runat ="server"  class="dropdown-item">
                        <asp:LinkButton ID="LinkButtonFollow" runat="server" CssClass="btn btn-sm" OnClick="LinkButtonFollow_Click">Action</asp:LinkButton>
                    </li>
                </div>
            </div>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
