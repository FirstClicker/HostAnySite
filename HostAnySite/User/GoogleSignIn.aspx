<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Import Namespace ="ASPSnippets.GoogleAPI"  %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim LoadGoogleLoginSetting As FirstClickerService.Version1.WebSetting.StructureWebSetting_GooglelogIn = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadGoogleLoginSetting(WebAppSettings.DBCS)
        If LoadGoogleLoginSetting.Result = False Then
        Else
            GoogleConnect.ClientId = LoadGoogleLoginSetting.GoogleLogin_GoogleClientId
            GoogleConnect.ClientSecret = LoadGoogleLoginSetting.GoogleLogin_GoogleClientSecret
            GoogleConnect.RedirectUri = LoadGoogleLoginSetting.GoogleLogin_GoogleRedirectUri
        End If



        If Not String.IsNullOrEmpty(Request.QueryString("code")) Then
            Dim code As String = Request.QueryString("code")
            Dim json As String = GoogleConnect.Fetch("me", code)
            Dim profile As GoogleProfile = New Script.Serialization.JavaScriptSerializer().Deserialize(Of GoogleProfile)(json)
            lblId.Text = profile.Id
            lblName.Text = profile.DisplayName
            lblEmail.Text = profile.Emails.Find(Function(email) email.Type = "account").Value
            lblGender.Text = profile.Gender
            lblType.Text = profile.ObjectType
            ProfileImage.ImageUrl = profile.Image.Url
            pnlProfile.Visible = True
            '  btnLogin.Enabled = False
            ' Exit Sub
            Dim SignIn_SocialUser As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.SignIn_SocialUser(profile.Emails.Find(Function(email) email.Type = "account").Value, profile.DisplayName, 0, 0, profile.Id, WebAppSettings.DBCS)
            If SignIn_SocialUser.Result = False Then
                'failed
                Labelem.Text = SignIn_SocialUser.Sys_Error_message
            Else
                Session("UserName") = SignIn_SocialUser.UserName
                Session("RoutUserName") = SignIn_SocialUser.RoutUserName
                Session("UserID") = SignIn_SocialUser.UserID
                Session("UserType") = SignIn_SocialUser.UserType.ToString


                'capture the userimage
                If SignIn_SocialUser.Imageid = 11111111 Then
                    Dim usertwitterimage As FirstClickerService.Version1.Image.StructureImageFunction = FirstClickerService.Version1.Image.GetImageFromURL(profile.Image.Url)
                    If usertwitterimage.result = True Then
                        Dim SubmitWall As FirstClickerService.Version1.Image.StructureImage

                        Dim Wallid As String = FirstClickerService.Version1.Image.NewImageId(WebAppSettings.DBCS)
                        Dim filename As String = FirstClickerService.common.ConvertSpace2Dass(Session("UserName").ToString.Trim) & "-" & Wallid & ".jpg"

                        usertwitterimage.Image.Save(Server.MapPath("~/storage/Image/" & filename))
                        FirstClickerService.Version1.Image.ImageResize_withCompression(Server.MapPath("~/storage/Image/" & filename), Server.MapPath("~/storage/Image/" & filename), 300, 400, 95)

                        SubmitWall = FirstClickerService.Version1.Image.SubmitImageByWeb(Wallid, filename, Session("UserName").ToString, Session("UserName").ToString, Session("userid").ToString, FirstClickerService.Version1.Image.StatusEnum.Visible, WebAppSettings.DBCS)
                        If SubmitWall.Result = False Then
                            'report the error

                            '    ClassReportError.reportError(SubmitWall.ex, WebAppSettings.dbcs)
                        Else
                            FirstClickerService.Version1.User.User_AddImageId(Session("userid"), Wallid, WebAppSettings.DBCS)
                        End If
                    End If
                End If

                '  ClassActivity.AddNewActivity("User " & Session("UserName") & " Signed in by facebook.", Now, Session("Userid"))

                FirstClickerService.Version1.User.UserlogedinEntry(SignIn_SocialUser.UserID, WebAppSettings.DBCS)

                Dim returnurl As String = Trim(Request.QueryString("returnurl"))
                If returnurl = "" Then
                    Response.Redirect("~/")
                Else
                    Response.Redirect(returnurl)
                End If

            End If
        End If
        If Request.QueryString("error") = "access_denied" Then
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "alert", "alert('Access denied.')", True)
        End If
    End Sub

    Protected Sub Login(sender As Object, e As EventArgs)
        GoogleConnect.Authorize("profile", "email")
    End Sub
    Protected Sub Clear(sender As Object, e As EventArgs)
        GoogleConnect.Clear()
    End Sub

    Public Class GoogleProfile
        Public Property Id() As String
            Get
                Return m_Id
            End Get
            Set(value As String)
                m_Id = value
            End Set
        End Property
        Private m_Id As String
        Public Property DisplayName() As String
            Get
                Return m_DisplayName
            End Get
            Set(value As String)
                m_DisplayName = value
            End Set
        End Property
        Private m_DisplayName As String
        Public Property Image() As Image
            Get
                Return m_Image
            End Get
            Set(value As Image)
                m_Image = value
            End Set
        End Property
        Private m_Image As Image
        Public Property Emails() As List(Of Email)
            Get
                Return m_Emails
            End Get
            Set(value As List(Of Email))
                m_Emails = value
            End Set
        End Property
        Private m_Emails As List(Of Email)
        Public Property Gender() As String
            Get
                Return m_Gender
            End Get
            Set(value As String)
                m_Gender = value
            End Set
        End Property
        Private m_Gender As String
        Public Property ObjectType() As String
            Get
                Return m_ObjectType
            End Get
            Set(value As String)
                m_ObjectType = value
            End Set
        End Property
        Private m_ObjectType As String
    End Class

    Public Class Email
        Public Property Value() As String
            Get
                Return m_Value
            End Get
            Set(value As String)
                m_Value = value
            End Set
        End Property
        Private m_Value As String
        Public Property Type() As String
            Get
                Return m_Type
            End Get
            Set(value As String)
                m_Type = value
            End Set
        End Property
        Private m_Type As String
    End Class

    Public Class Image
        Public Property Url() As String
            Get
                Return m_Url
            End Get
            Set(value As String)
                m_Url = value
            End Set
        End Property
        Private m_Url As String
    End Class


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  
    <div>
        <asp:Button ID="btnLogin" runat="server" OnClick="Login" Text="Login" Visible="False" />
        <asp:Panel ID="pnlProfile" runat="server" Visible="false">
            <hr />
            <table>
                <tr>
                    <td rowspan="6" valign="top">
                        <asp:Image ID="ProfileImage" runat="server" Height="50" Width="50" />
                    </td>
                </tr>
                <tr>
                    <td>ID:
                        <asp:Label ID="lblId" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Name:
                        <asp:Label ID="lblName" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Email:
                        <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Gender:
                        <asp:Label ID="lblGender" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Type:
                        <asp:Label ID="lblType" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button runat="server" OnClick="Clear" Text="Clear" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Label ID="Labelem" runat="server" Text=""></asp:Label>
    </div>
  
</asp:Content>

