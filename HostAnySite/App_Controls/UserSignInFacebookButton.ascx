<%@ Control Language="VB" ClassName="UserSignInFacebookButton" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Import Namespace="ASPSnippets.FaceBookAPI" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>

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
            Return LabelFacebookText.Visible
        End Get
        Set(ByVal value As Boolean)
            LabelFacebookText.Visible = value
        End Set
    End Property

    Public Property FBLogin_IsEnabled() As Boolean
        Get
            Return Not ButtonFacebookICon.Disabled
        End Get
        Set(ByVal value As Boolean)
            ButtonFacebookICon.Disabled = Not value
        End Set
    End Property

    Public Property FBLogIn_AppId() As String
        Get
            Return LabelFBAppId.Text
        End Get
        Set(ByVal value As String)
            LabelFBAppId.Text = value
        End Set
    End Property

    Public Property FBLogIn_AppSecret() As String
        Get
            Return LabelFBAppSecret.Text
        End Get
        Set(ByVal value As String)
            LabelFBAppSecret.Text = value
        End Set
    End Property

    Public Property FBLogIn_ExtendedPermissions() As String
        Get
            Return LabelFBExtendedPermissions.Text
        End Get
        Set(ByVal value As String)
            LabelFBExtendedPermissions.Text = value
        End Set
    End Property

    Public Property FBLogIn_OuthRedirectURL() As String
        Get
            Return LabelFBOuthRedirectURL.Text
        End Get
        Set(ByVal value As String)
            LabelFBOuthRedirectURL.Text = value
        End Set
    End Property


    Public Class FaceBookUser
        Public Property Id() As String
            Get
                Return m_Id
            End Get
            Set(value As String)
                m_Id = value
            End Set
        End Property
        Private m_Id As String
        Public Property Name() As String
            Get
                Return m_Name
            End Get
            Set(value As String)
                m_Name = value
            End Set
        End Property
        Private m_Name As String
        Public Property UserName() As String
            Get
                Return m_UserName
            End Get
            Set(value As String)
                m_UserName = value
            End Set
        End Property
        Private m_UserName As String
        Public Property PictureUrl() As String
            Get
                Return m_PictureUrl
            End Get
            Set(value As String)
                m_PictureUrl = value
            End Set
        End Property
        Private m_PictureUrl As String
        Public Property Email() As String
            Get
                Return m_Email
            End Get
            Set(value As String)
                m_Email = value
            End Set
        End Property
        Private m_Email As String
    End Class





    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim LoadFBLoginSetting As FirstClickerService.Version1.WebSetting.StructureWebSetting_FBlogIn = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadFBLoginSetting(WebAppSettings.DBCS)
        If LoadFBLoginSetting.Result = False Then
            FBLogin_IsEnabled = False

            'Create Blank Settings
            FirstClickerService.Version1.WebSetting.WEBAppSetting_AddFBLoginBlankSetting(WebAppSettings.DBCS)

            Exit Sub
        Else
            If LoadFBLoginSetting.FBLogin_IsEnabled.ToString = False Then
                FBLogin_IsEnabled = False
                Exit Sub
            Else
                FBLogin_IsEnabled = True
                FBLogIn_AppId = LoadFBLoginSetting.FBLogIn_AppId
                FBLogIn_AppSecret = LoadFBLoginSetting.FBLogIn_AppSecret
                FBLogIn_ExtendedPermissions = LoadFBLoginSetting.FBLogIn_ExtendedPermissions
                FBLogIn_OuthRedirectURL = LoadFBLoginSetting.FBLogIn_OuthRedirectURL


                FaceBookConnect.API_Key = FBLogIn_AppId
                FaceBookConnect.API_Secret = FBLogIn_AppSecret
                If Not IsPostBack Then
                    If Request.QueryString("error") = "access_denied" Then
                        'user has access denied

                    End If

                    Dim code As String = Request.QueryString("code")
                    If Not String.IsNullOrEmpty(code) Then
                        Dim data As String = FaceBookConnect.Fetch(code, "me?fields=id,name,email")
                        Dim faceBookUser As FaceBookUser = New JavaScriptSerializer().Deserialize(Of FaceBookUser)(data)
                        faceBookUser.PictureUrl = String.Format("https://graph.facebook.com/{0}/picture", faceBookUser.Id)

                        'got the data

                        Dim faceBookUser_Id As String = faceBookUser.Id
                        '      lblUserName.Text = faceBookUser.UserName
                        Dim faceBookUser_Name = faceBookUser.Name
                        Dim faceBookUser_Email As String = faceBookUser.Email
                        Dim profilePictureUrl As String = faceBookUser.PictureUrl

                        Dim SignIn_SocialUser As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.SignIn_SocialUser(faceBookUser_Email, faceBookUser_Name, faceBookUser_Id, "0", "0", WebAppSettings.DBCS)
                        If SignIn_SocialUser.Result = False Then
                            'failed to login

                        Else
                            Session("UserName") = SignIn_SocialUser.UserName
                            Session("RoutUserName") = SignIn_SocialUser.RoutUserName
                            Session("UserID") = SignIn_SocialUser.UserID
                            Session("UserType") = SignIn_SocialUser.UserType.ToString


                            'capture the userimage
                            If SignIn_SocialUser.Imageid = 11111111 Then
                                Dim usertwitterimage As FirstClickerService.Version1.Image.StructureImageFunction = FirstClickerService.Version1.Image.GetImageFromURL(profilePictureUrl)
                                If usertwitterimage.result = True Then
                                    Dim SubmitWall As FirstClickerService.Version1.Image.StructureImage

                                    Dim Wallid As String = FirstClickerService.Version1.Image.NewImageId(WebAppSettings.DBCS)
                                    Dim filename As String = FirstClickerService.Common.ConvertSpace2Dass(Session("UserName").ToString.Trim) & "-" & Wallid & ".jpg"

                                    usertwitterimage.Image.Save(Server.MapPath("~/storage/Image/" & filename))
                                    FirstClickerService.Version1.Image.ImageResize_withCompression(Server.MapPath("~/storage/Image/" & filename), Server.MapPath("~/storage/Image/" & filename), 300, 400, 95)

                                    SubmitWall = FirstClickerService.Version1.Image.SubmitImageByWeb(Wallid, filename, Session("UserName").ToString, Session("UserName").ToString, Session("userid").ToString, FirstClickerService.Version1.Image.StatusEnum.Visible, WebAppSettings.DBCS)
                                    If SubmitWall.Result = False Then
                                        'report the error

                                        '  SayzzClass.ReportError.reportError(SubmitWall.ex, WebAppSettings.dbcs)
                                    Else
                                        FirstClickerService.Version1.User.User_AddImageId(Session("userid"), Wallid, WebAppSettings.DBCS)
                                    End If
                                End If
                            End If


                            FirstClickerService.Version1.User.UserlogedinEntry(SignIn_SocialUser.UserID, WebAppSettings.DBCS)


                        End If




                    End If
                End If


            End If
        End If








    End Sub


    Protected Sub ButtonFacebook_Click(sender As Object, e As EventArgs)
        FaceBookConnect.Authorize("user_photos,email", Request.Url.AbsoluteUri.Split("?"c)(0))
    End Sub


</script>

<asp:Label ID="LabelFBAppId" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelFBAppSecret" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelReturnURL" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelFBExtendedPermissions" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelFBOuthRedirectURL" runat="server" Text="" Visible="False"></asp:Label>

<button runat="server" id="ButtonFacebookICon" class="btn btn-outline-dark" type="button" onserverclick="ButtonFacebook_Click">
    <i class="fab fa-facebook-f fa-lg"></i>
    <asp:Label ID="LabelFacebookText" runat="server" Text=" SignIn with Facebook" Visible="false"></asp:Label>
</button>


