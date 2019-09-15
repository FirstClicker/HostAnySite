<%@ Control Language="VB" ClassName="UserSignInNeededButton" %>
<%@ Register Src="~/app_controls/UserSignInFacebookButton.ascx" TagPrefix="uc1" TagName="UserSignInFacebookButton" %>
<%@ Register Src="~/app_controls/UserSignInGoogleButton.ascx" TagPrefix="uc1" TagName="UserSignInGoogleButton" %>
<%@ Register Src="~/app_controls/UserSignInTwitterButton.ascx" TagPrefix="uc1" TagName="UserSignInTwitterButton" %>

<script runat="server">

    Public Property UserNotificationMsg() As String
        Get
            Return LabelUserNotificationMsg.Text
        End Get
        Set(ByVal value As String)
            LabelUserNotificationMsg.Text = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Session("username") <> "" Then
            Me.Visible = False
        End If
    End Sub

    Protected Sub ButtonSignUp_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/signup.aspx?ReturnURL=" & "~" & Request.RawUrl)
    End Sub

    Protected Sub ButtonSignIn_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/signin.aspx?ReturnURL=" & "~" & Request.RawUrl)
    End Sub
</script>


<asp:Panel runat="server" ID="PanelQuickLogin" CssClass="card-footer clearfix">
    <div class="float-left mb-2">
        <asp:Label ID="LabelUserNotificationMsg" CssClass ="bold" runat="server" Text="Please SignIn..."></asp:Label>
    </div>
    <div class="float-right mb-2">
        <div class="btn-group btn-group-sm">
            <asp:Button ID="ButtonSignUp" runat="server" class="btn btn-info" Text="Sign Up" OnClick ="ButtonSignUp_Click" />
            <asp:Button ID="ButtonSignIn" runat="server" class="btn btn-success" Text="Sign In" OnClick ="ButtonSignIn_Click" />

            <uc1:UserSignInGoogleButton runat="server" ID="UserSignInGoogleButton" />
            <uc1:UserSignInFacebookButton runat="server" ID="UserSignInFacebookButton" />
            <uc1:UserSignInTwitterButton runat="server" ID="UserSignInTwitterButton" />
        </div>
    </div>
</asp:Panel>