<%@ Control Language="VB" ClassName="UserRelationStatusButton" %>

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

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            loadstatus()
        End If
    End Sub



    Private Function loadstatus() As Boolean
        loadstatus = False

        If Val(Session("userid")) > 10 And Val(UserID) <> Val(Session("userid")) Then
            Dim UserRelStatus As ClassHostAnySite.UserRelation.StructureUserRelation
            UserRelStatus = ClassHostAnySite.UserRelation.UserRelation_GetInOrder(Session("userid"), UserID, ClassAppDetails.DBCS)

            If UserRelStatus.FollowStatus = ClassHostAnySite.UserRelation.FollowStatusEnum.Following Or UserRelStatus.FollowStatus = ClassHostAnySite.UserRelation.FollowStatusEnum.Connected Then
                LinkButtonFollow.Text = ClassHostAnySite.UserRelation.FollowerActionEnum.Unfollow.ToString
            Else
                LinkButtonFollow.Text = ClassHostAnySite.UserRelation.FollowerActionEnum.Follow.ToString
            End If

            If UserRelStatus.FriendStatus = ClassHostAnySite.UserRelation.FriendStatusEnum.Friend Then
                buttonAddFriend.Text = ClassHostAnySite.UserRelation.FriendStatusEnum.Friend.ToString
                buttonAddFriend.Enabled = False

                LinkButtonFriend.Text = ClassHostAnySite.UserRelation.FriendActionEnum.Remove_Friend.ToString.Replace("_", " ")
            ElseIf UserRelStatus.FriendStatus = ClassHostAnySite.UserRelation.FriendStatusEnum.RequestReceived Then
                buttonAddFriend.Text = ClassHostAnySite.UserRelation.FriendActionEnum.Accept_Friend_Request.ToString.Replace("_", " ")
                LinkButtonFriend.Text = ClassHostAnySite.UserRelation.FriendActionEnum.Reject_Friend_Request.ToString.Replace("_", " ")
            ElseIf UserRelStatus.FriendStatus = ClassHostAnySite.UserRelation.FriendStatusEnum.Unknown Then
                buttonAddFriend.Text = ClassHostAnySite.UserRelation.FriendActionEnum.Add_Friend.ToString.Replace("_", " ")
                LinkButtonFriend.Visible = False
            ElseIf UserRelStatus.FriendStatus = ClassHostAnySite.UserRelation.FriendStatusEnum.RequestSent Then
                buttonAddFriend.Text = ClassHostAnySite.UserRelation.FriendActionEnum.Cancel_Friend_Request.ToString.Replace("_", " ")
                LinkButtonFriend.Visible = False
            End If
        Else ' same user or no user
            LinkButtonFollow.Enabled = False
            LinkButtonFollow.Text = ClassHostAnySite.UserRelation.FollowerActionEnum.Follow.ToString

            buttonAddFriend.Enabled = False
            buttonAddFriend.Text = ClassHostAnySite.UserRelation.FriendActionEnum.Add_Friend.ToString.Replace("_", " ")

            LinkButtonFriend.Visible = False
            buttonMessage.Enabled = False
        End If
    End Function


    Protected Sub buttonAddFriend_Click(sender As Object, e As EventArgs)
        Dim friendAction As ClassHostAnySite.UserRelation.FriendActionEnum
        ClassHostAnySite.UserRelation.FriendActionEnum.TryParse(buttonAddFriend.Text.Replace(" ", "_"), friendAction)

        Dim SubmitUserRelation As ClassHostAnySite.UserRelation.StructureUserRelation
        SubmitUserRelation = ClassHostAnySite.UserRelation.UserRelation_FriendAction(Session("userid"), UserID, Session("UserName"), UserName, friendAction, ClassAppDetails.DBCS)
        If SubmitUserRelation.Result = False Then

        Else
            loadstatus()
            UpdatePanelAction.Update()

        End If
    End Sub

    Protected Sub LinkButtonFriend_Click(sender As Object, e As EventArgs)
        Dim friendAction As ClassHostAnySite.UserRelation.FriendActionEnum
        ClassHostAnySite.UserRelation.FriendActionEnum.TryParse(LinkButtonFriend.Text.Replace(" ", "_"), friendAction)

        Dim SubmitUserRelation As ClassHostAnySite.UserRelation.StructureUserRelation
        SubmitUserRelation = ClassHostAnySite.UserRelation.UserRelation_FriendAction(Session("userid"), UserID, Session("UserName"), UserName, friendAction, ClassAppDetails.DBCS)
        If SubmitUserRelation.Result = False Then

            'report error

        Else
            loadstatus()
            UpdatePanelAction.Update()
        End If
    End Sub

    Protected Sub LinkButtonFollow_Click(sender As Object, e As EventArgs)
        Dim FollowAction As ClassHostAnySite.UserRelation.FollowerActionEnum
        ClassHostAnySite.UserRelation.FollowerActionEnum.TryParse(LinkButtonFollow.Text.Replace(" ", "_"), FollowAction)

        Dim SubmitUserRelation As ClassHostAnySite.UserRelation.StructureUserRelation
        SubmitUserRelation = ClassHostAnySite.UserRelation.UserRelation_FollowAction(Session("userid"), UserID, Session("UserName"), UserName, FollowAction, ClassAppDetails.DBCS)

        loadstatus()
        UpdatePanelAction.Update()

    End Sub


    Protected Sub buttonMessage_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/message/" & RoutUserName)
    End Sub

</script>

<asp:Label ID="LabelUserId" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
<asp:HyperLink ID="HyperLinkUserName" runat="server" Visible="False"></asp:HyperLink>

<asp:UpdatePanel ID="UpdatePanelAction" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div class="btn-group pull-right">
            <asp:Button ID="buttonMessage" CssClass="btn btn-danger btn-sm" runat="server" Text="Message" OnClick="buttonMessage_Click" />
            <div class="dropdown pull-right">
                <div class="btn-group pull-right">
                    <asp:Button ID="buttonAddFriend" CssClass="btn btn-sm btn-success " runat="server" Text="Add Friend" OnClick="buttonAddFriend_Click" />
                    <button type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown">
                        <span class="caret"></span>
                        <span class="sr-only">Toggle Dropdown</span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <!-- here is the asp.net link button to make post back -->
                        <li>
                            <asp:LinkButton ID="LinkButtonFriend" runat="server" CssClass="btn btn-sm" OnClick="LinkButtonFriend_Click">Action</asp:LinkButton></li>
                        <li>
                            <asp:LinkButton ID="LinkButtonFollow" runat="server" CssClass="btn btn-sm" OnClick="LinkButtonFollow_Click">Action</asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

    </ContentTemplate>
</asp:UpdatePanel>
