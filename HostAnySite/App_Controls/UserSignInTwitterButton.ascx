<%@ Control Language="VB" ClassName="UserSignTwitterButton" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Import Namespace="TweetSharp" %>

<script runat="server">

    Public Property returnurl() As String
        Get
            Return LabelReturnURL.Text
        End Get
        Set(ByVal value As String)
            LabelReturnURL.Text = value
        End Set
    End Property

    Public Property ShowText() As Boolean
        Get
            Return LabelTwitterText.Visible
        End Get
        Set(ByVal value As Boolean)
            LabelTwitterText.Visible = value
        End Set
    End Property

    Public Property TwitterLogin_IsEnabled() As Boolean
        Get
            Return Not ButtonTwitterICon.Disabled
        End Get
        Set(ByVal value As Boolean)
            ButtonTwitterICon.Disabled = Not value
        End Set
    End Property

    Public Property TwitterLogin_ConsumerKey() As String
        Get
            Return LabelConsumerKey.Text
        End Get
        Set(ByVal value As String)
            LabelConsumerKey.Text = value
        End Set
    End Property

    Public Property TwitterLogin_ConsumerSecret() As String
        Get
            Return LabelConsumerSecret.Text
        End Get
        Set(ByVal value As String)
            LabelConsumerSecret.Text = value
        End Set
    End Property

    Public Property TwitterLogin_RedirectURL() As String
        Get
            Return LabelRedirectURL.Text
        End Get
        Set(ByVal value As String)
            LabelRedirectURL.Text = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim LoadTwitterLoginSetting As FirstClickerService.Version1.WebSetting.StructureWebSetting_TwitterlogIn = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadTwitterLoginSetting(WebAppSettings.DBCS)
        If LoadTwitterLoginSetting.Result = False Then
            TwitterLogin_IsEnabled = False

            'Create Blank Settings
            FirstClickerService.Version1.WebSetting.WEBAppSetting_AddTwitterLoginBlankSetting(WebAppSettings.DBCS)

            Exit Sub
        Else
            If LoadTwitterLoginSetting.TwitterLogin_IsEnabled = False Then
                TwitterLogin_IsEnabled = False
                Exit Sub
            Else
                TwitterLogin_IsEnabled = True
                TwitterLogin_ConsumerKey = LoadTwitterLoginSetting.TwitterLogin_ConsumerKey
                TwitterLogin_ConsumerSecret = LoadTwitterLoginSetting.TwitterLogin_ConsumerSecret
                TwitterLogin_RedirectURL = LoadTwitterLoginSetting.TwitterLogin_RedirectURL

            End If
        End If
    End Sub

    Protected Sub ButtonTwitter_Click(sender As Object, e As EventArgs)
        If Trim(returnurl) = "" Then
            returnurl = Trim(Request.QueryString("returnURL"))
            If returnurl = "" Then
                returnurl = "~" & Request.RawUrl
            End If
        End If

        Dim service As New TwitterService(TwitterLogin_ConsumerKey, TwitterLogin_ConsumerSecret)
        Dim requestToken As OAuthRequestToken = service.GetRequestToken(TwitterLogin_RedirectURL & "?returnurl=" & returnurl)
        Dim uri As Uri = service.GetAuthorizationUri(requestToken)
        Response.Redirect(uri.ToString(), False)
    End Sub


</script>

<asp:Label ID="LabelReturnURL" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelConsumerKey" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelConsumerSecret" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelRedirectURL" runat="server" Text="" Visible="False"></asp:Label>

<button runat="server" id="ButtonTwitterICon" class="btn btn-outline-dark" type="button" onserverclick="ButtonTwitter_Click" >
  <i class="fab fa-twitter fa-lg"></i>
    <asp:Label ID="LabelTwitterText" runat="server" Text=" SignIn with Twitter" Visible="false"></asp:Label>
</button>