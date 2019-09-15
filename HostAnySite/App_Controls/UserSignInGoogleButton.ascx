<%@ Control Language="VB" ClassName="UserSignGoogleButton" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Import Namespace="ASPSnippets.GoogleAPI" %>

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
            Return LabelGoogleText.Visible
        End Get
        Set(ByVal value As Boolean)
            LabelGoogleText.Visible = value
        End Set
    End Property

    Public Property GoogleLogin_IsEnabled() As Boolean
        Get
            Return Not ButtongoogleICon.Disabled
        End Get
        Set(ByVal value As Boolean)
            ButtonGoogleICon.Disabled = Not value
        End Set
    End Property

    Public Property GoogleLogin_GoogleClientId() As String
        Get
            Return LabelGoogleClientId.Text
        End Get
        Set(ByVal value As String)
            LabelGoogleClientId.Text = value
        End Set
    End Property

    Public Property GoogleLogin_GoogleClientSecret() As String
        Get
            Return LabelGoogleClientSecret.Text
        End Get
        Set(ByVal value As String)
            LabelGoogleClientSecret.Text = value
        End Set
    End Property

    Public Property GoogleLogin_GoogleRedirectUri() As String
        Get
            Return LabelGoogleRedirectUri.Text
        End Get
        Set(ByVal value As String)
            LabelGoogleRedirectUri.Text = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim LoadGoogleLoginSetting As FirstClickerService.Version1.WebSetting.StructureWebSetting_GooglelogIn = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadGoogleLoginSetting(WebAppSettings.DBCS)
        If LoadGoogleLoginSetting.Result = False Then
            GoogleLogin_IsEnabled = False

            'Create Blank Settings
            FirstClickerService.Version1.WebSetting.WEBAppSetting_AddGoogleLoginBlankSetting(WebAppSettings.DBCS)

            Exit Sub
        Else
            If LoadGoogleLoginSetting.GoogleLogin_IsEnabled = False Then
                GoogleLogin_IsEnabled = False
                Exit Sub
            Else
                GoogleLogin_IsEnabled = True
                GoogleLogin_GoogleClientId = LoadGoogleLoginSetting.GoogleLogin_GoogleClientId
                GoogleLogin_GoogleClientSecret = LoadGoogleLoginSetting.GoogleLogin_GoogleClientSecret
                GoogleLogin_GoogleRedirectUri = LoadGoogleLoginSetting.GoogleLogin_GoogleRedirectUri
            End If
        End If
    End Sub




    Protected Sub ButtonGoogleICon_ServerClick(sender As Object, e As EventArgs)
        If Trim(returnurl) = "" Then
            returnurl = Trim(Request.QueryString("returnURL"))
            If returnurl = "" Then
                returnurl = "~" & Request.RawUrl
            End If
        End If

        GoogleConnect.ClientId = GoogleLogin_GoogleClientId
        GoogleConnect.ClientSecret = GoogleLogin_GoogleClientSecret
        GoogleConnect.RedirectUri = GoogleLogin_GoogleRedirectUri

        GoogleConnect.Authorize("profile", "email")
    End Sub


</script>
<asp:Label ID="LabelReturnURL" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelGoogleClientId" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelGoogleClientSecret" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelGoogleRedirectUri" runat="server" Text="" Visible="False"></asp:Label>

<button runat="server" id="ButtonGoogleICon" class="btn btn-outline-dark" type="button" onserverclick="ButtonGoogleICon_ServerClick" >
    <i class="fab fa-google fa-lg"></i>
    <asp:Label ID="LabelGoogleText" runat="server" Text=" SignIn with Google" Visible="false"></asp:Label>
</button>
