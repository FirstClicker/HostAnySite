<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>
<%@ Import Namespace="TweetSharp" %>

<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim LoadTwitterLoginSetting As FirstClickerService.Version1.WebSetting.StructureWebSetting_TwitterlogIn = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadTwitterLoginSetting(WebAppSettings.DBCS)

        If IsPostBack = False Then
            If Request.QueryString("oauth_token") = Nothing Or Trim(Request.QueryString("oauth_token")) = "" Then
                'failed
                LabelEM.Text = "Outh Token Failed."
                Exit Sub
            End If
            If Request.QueryString("oauth_verifier") = Nothing Or Trim(Request.QueryString("oauth_verifier")) = "" Then
                'failed
                LabelEM.Text = "Outh verifier Failed."
                Exit Sub
            End If

            Dim oauth_token = New OAuthRequestToken() With {.Token = Request.QueryString("oauth_token")}
            Dim oauth_verifier As String = Request.QueryString("oauth_verifier")

            Dim tw As New TwitterService(LoadTwitterLoginSetting.TwitterLogin_ConsumerKey, LoadTwitterLoginSetting.TwitterLogin_ConsumerSecret)
            Dim accessToken As OAuthAccessToken = tw.GetAccessToken(oauth_token, oauth_verifier)

            tw.AuthenticateWith(accessToken.Token, accessToken.TokenSecret)


            Dim tw_user As TwitterUser = tw.GetUserProfile(New GetUserProfileOptions())
            Dim TwitterUserDetails As ClassTwitterUser = ClassTwitter.GetUserDetails(accessToken.Token, accessToken.TokenSecret, LoadTwitterLoginSetting.TwitterLogin_ConsumerKey, LoadTwitterLoginSetting.TwitterLogin_ConsumerSecret, tw_user.ScreenName)

            If tw_user <> Nothing Then
                Dim SignIn_SocialUser As FirstClickerService.Version1.User.StructureUser
                SignIn_SocialUser = FirstClickerService.Version1.User.SignIn_SocialUser(TwitterUserDetails.Email, tw_user.ScreenName, 0, tw_user.Id, 0, WebAppSettings.DBCS)
                If SignIn_SocialUser.Result = False Then
                    LabelEM.Text = "Social signup with twitter failed.."
                Else
                    Session("UserName") = SignIn_SocialUser.UserName
                    Session("RoutUserName") = SignIn_SocialUser.RoutUserName
                    Session("UserID") = SignIn_SocialUser.UserID
                    Session("UserType") = SignIn_SocialUser.UserType.ToString

                    'capture the userimage
                    If SignIn_SocialUser.Imageid = 11111111 Then
                        Dim usertwitterimage As FirstClickerService.Version1.Image.StructureImageFunction = FirstClickerService.Version1.Image.GetImageFromURL(tw_user.ProfileImageUrl.Replace("_normal", ""))
                        If usertwitterimage.result = True Then
                            Dim SubmitWall As FirstClickerService.Version1.Image.StructureImage

                            Dim Wallid As String = FirstClickerService.Version1.Image.NewImageId(WebAppSettings.DBCS)
                            Dim filename As String = FirstClickerService.common.ConvertSpace2Dass(Session("UserName").ToString.Trim) & "-" & Wallid & ".jpg"

                            usertwitterimage.Image.Save(Server.MapPath("~/storage/Image/" & filename))
                            FirstClickerService.Version1.Image.ImageResize_withCompression(Server.MapPath("~/storage/Image/" & filename), Server.MapPath("~/storage/Image/" & filename), 300, 400, 95)

                            SubmitWall = FirstClickerService.Version1.Image.SubmitImageByWeb(Wallid, filename, Session("UserName").ToString, Session("UserName").ToString, Session("userid").ToString, FirstClickerService.Version1.Image.StatusEnum.Visible, WebAppSettings.DBCS)
                            If SubmitWall.Result = False Then
                                'report the error
                            Else
                                FirstClickerService.Version1.User.User_AddImageId(Session("userid"), Wallid, WebAppSettings.DBCS)
                            End If

                        End If
                    End If

                    ' save details
                    ' SayzzClass.TwitterUser.SaveTwitterAuthDetails(tw_user.Id, tw_user.ScreenName, accessToken.Token, accessToken.TokenSecret, SayzzClass.TwitterUser.OauthStatusEnum.Success, SignIn_SocialUser.UserID, WebAppSettings.DBCS)


                    FirstClickerService.Version1.User.UserlogedinEntry(SignIn_SocialUser.UserID, WebAppSettings.DBCS)


                    Dim returnurl As String = HttpUtility.ParseQueryString(Request.Url.Query).Get("returnURL")
                    If returnurl = "" Then
                        Response.Redirect("~/")
                    Else
                        Response.Redirect(returnurl)
                    End If
                End If
            Else
                LabelEM.Text = "Unable to get userdata."
            End If
        End If

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-lg-8">
            <asp:Label ID="LabelEM" runat="server" Text=""></asp:Label>
    
        </div>
        <div class="col-md-4">
        
        </div>
    </div>
</asp:Content>
