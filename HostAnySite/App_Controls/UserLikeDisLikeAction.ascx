<%@ Control Language="VB" ClassName="UserLikeDisLikeAction" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Register Src="~/App_Controls/UserSignInNeededButton.ascx" TagPrefix="uc1" TagName="UserSignInNeededButton" %>

<script runat="server">
    ' version 19/06/2019 # 12.27 AM


    Public Property NumberofLike() As String
        Get
            Return LabelLikeCount.Text
        End Get
        Set(ByVal value As String)
            LabelLikeCount.Text = value
        End Set
    End Property

    Public Property NumberofDisLike() As String
        Get
            Return LabelDisLikeCount.Text
        End Get
        Set(ByVal value As String)
            LabelDisLikeCount.Text = value
        End Set
    End Property

    Public Property LikeOnID() As Long
        Get
            Return Val(LabelLikeOnID.Text)
        End Get
        Set(ByVal value As Long)
            LabelLikeOnID.Text = value
        End Set
    End Property

    Public Property NotifyAboutLike() As Boolean
        Get
            Return LabelNotifyAboutLike.Enabled
        End Get
        Set(ByVal value As Boolean)
            LabelNotifyAboutLike.Enabled = value
        End Set
    End Property

    'alloaw only for image
    Public Property AllowFreeVote() As Boolean
        Get
            Return LabelAllowFreeVote.Enabled
        End Get
        Set(ByVal value As Boolean)
            LabelAllowFreeVote.Enabled = value
        End Set
    End Property



    Public Property LikeOn() As FirstClickerService.Version1.UserLike.LikeOnEnum
        Get
            Return [Enum].Parse(GetType(FirstClickerService.Version1.UserLike.LikeOnEnum), LabelLikeOn.Text, True)
        End Get
        Set(ByVal value As FirstClickerService.Version1.UserLike.LikeOnEnum)
            LabelLikeOn.Text = value.ToString
        End Set
    End Property


    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        Dim SQlStringPart As String = ""

        Select Case LikeOn
            Case FirstClickerService.Version1.UserLike.LikeOnEnum.Blog
                SQlStringPart = " (Blogid='" & LikeOnID & "')"
            Case FirstClickerService.Version1.UserLike.LikeOnEnum.Forum
                SQlStringPart = " (Forumid='" & LikeOnID & "')"
            Case FirstClickerService.Version1.UserLike.LikeOnEnum.ForumTopic
                SQlStringPart = " (ForumTopicid='" & LikeOnID & "')"
            Case FirstClickerService.Version1.UserLike.LikeOnEnum.Image
                SQlStringPart = " (Imageid='" & LikeOnID & "')"
            Case FirstClickerService.Version1.UserLike.LikeOnEnum.Question
                SQlStringPart = " (Questionid='" & LikeOnID & "')"
            Case FirstClickerService.Version1.UserLike.LikeOnEnum.QuestionAnswer
                SQlStringPart = " (QuestionAnswerid='" & LikeOnID & "')"
            Case FirstClickerService.Version1.UserLike.LikeOnEnum.Wall
                SQlStringPart = " (Wallid='" & LikeOnID & "')"
            Case FirstClickerService.Version1.UserLike.LikeOnEnum.WallComment
                SQlStringPart = " (WallCommentid='" & LikeOnID & "')"
        End Select

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myConn.Open()


        myCmd.CommandText = "SELECT count(*) as lc FROM Table_Userlike where " & SQlStringPart & " and (IsLike='True')"
        myReader = myCmd.ExecuteReader
        myReader.Read()
        NumberofLike = NumberofLike + Val(myReader.Item("lc"))

        myReader.Close()
        myCmd.CommandText = "SELECT count(*) as lc FROM Table_Userlike where " & SQlStringPart & " and (IsLike='False')"
        myReader = myCmd.ExecuteReader
        myReader.Read()
        NumberofDisLike = NumberofDisLike + Val(myReader.Item("lc"))

        myReader.Close()
        myConn.Close()
    End Sub


    Protected Sub BtnLike_ServerClick(sender As Object, e As EventArgs)
        If LikeOnID < 2 Then
            Exit Sub
        End If




        If Val(Trim(Session("userId"))) <= 100 Then
            If AllowFreeVote = False Then
                LabelPop.Text = "Please signin to use this function."
                UserSignInNeededButton.Visible = True
                ModalPopupExtender1.Show()
                Exit Sub
            Else
                FirstClickerService.Version1.Image.Image_UpdateFreeVote(LikeOnID, "1", WebAppSettings.DBCS)
                BtnLike.Disabled = True
                BtnDisLike.Disabled = True

                LabelLikeCount.Text = Val(LabelLikeCount.Text) + 1
                Exit Sub
            End If
        End If


        Dim submitlike As New FirstClickerService.Version1.UserLike.StructureUserLike
        submitlike = FirstClickerService.Version1.UserLike.UserLike_Add(Val(Session("userId")), True, 1, LikeOnID, LikeOn, WebAppSettings.DBCS)

        If submitlike.Result = True Then
            LabelLikeCount.Text = Val(LabelLikeCount.Text) + submitlike.Vote

            If NotifyAboutLike = True Then

            End If
        Else
            LabelPop.Text = submitlike.My_Error_message
            ModalPopupExtender1.Show()
        End If
    End Sub

    Protected Sub BtnDisLike_ServerClick(sender As Object, e As EventArgs)
        If LikeOnID < 2 Then
            Exit Sub
        End If

        If Val(Trim(Session("userId"))) <= 100 Then

            If AllowFreeVote = False Then
                LabelPop.Text = "Please signin to use this function."
                UserSignInNeededButton.Visible = True
                ModalPopupExtender1.Show()
                Exit Sub
            Else
                FirstClickerService.Version1.Image.Image_UpdateFreeVote(LikeOnID, "1", WebAppSettings.DBCS)
                BtnLike.Disabled = True
                BtnDisLike.Disabled = True

                LabelLikeCount.Text = Val(LabelLikeCount.Text) - 1
                Exit Sub
            End If
        End If



        Dim submitlike As New FirstClickerService.Version1.UserLike.StructureUserLike
        submitlike = FirstClickerService.Version1.UserLike.UserLike_Add(Val(Session("userId")), False, 1, LikeOnID, LikeOn, WebAppSettings.DBCS)

        If submitlike.Result = True Then
            LabelDisLikeCount.Text = Val(LabelDisLikeCount.Text) + submitlike.Vote

            If NotifyAboutLike = True Then

            End If
        Else
            LabelPop.Text = submitlike.My_Error_message
            ModalPopupExtender1.Show()
        End If
    End Sub


</script>

<asp:Label ID="LabelLikeOnID" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelLikeOn" runat="server" Text="wall" Visible="False"></asp:Label>
<asp:Label ID="LabelNotifyAboutLike" runat="server" Text="" Visible="False" Enabled="false"></asp:Label>
<asp:Label ID="LabelAllowFreeVote" runat="server" Text="" Visible="false" Enabled="false"></asp:Label>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <button runat="server" id="BtnLike" class="btn btn-sm btn-outline-success" type="button" onserverclick="BtnLike_ServerClick">
            <i class="far fa-thumbs-up"></i>&nbsp;<asp:Label ID="LabelLikeCount" runat="server" Text="0"></asp:Label>
        </button>
        <button runat="server" id="BtnDisLike" class="btn btn-sm btn-outline-danger" type="button" onserverclick="BtnDisLike_ServerClick">
            <i class="far fa-thumbs-down"></i>&nbsp;<asp:Label ID="LabelDisLikeCount" runat="server" Text="0"></asp:Label>
        </button>




<asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>

<ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
    PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground" CancelControlID="btnHide">
</ajaxToolkit:ModalPopupExtender>
<asp:Panel ID="pnlPopup" runat="server" CssClass="card text-white bg-primary BoxEffect1" Style="display: none; min-width: 300px;">
    <div class="card-header ">
        Message:
         <div class="float-right clearfix">
             <asp:Button ID="btnHide" runat="server" CssClass="btn btn-sm btn-danger" Text="Cancel" />
         </div>
    </div>
    <div class="card-body ">
        <asp:Label ID="LabelPop" runat="server" Text="message:"></asp:Label>
    </div>
    <uc1:UserSignInNeededButton runat="server" ID="UserSignInNeededButton" Visible="false" />
</asp:Panel>



    </ContentTemplate>
</asp:UpdatePanel>




