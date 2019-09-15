<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>



<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        If IsPostBack = False Then
            Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
            websetting = FirstClickerService.Version1.WebSetting.WebSetting_Get("UserEmailVerificationRequired", WebAppSettings.DBCS)
            If websetting.Result = True Then
                CheckBoxEmailverification.Checked = CBool(websetting.SettingValue)
            Else
                ' add the entry
            End If

            Dim fbloginsetting As FirstClickerService.Version1.WebSetting.StructureWebSetting_FBlogIn
            fbloginsetting = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadFBLoginSetting(WebAppSettings.DBCS)
            If fbloginsetting.Result = True Then
                CheckBoxFacebookLogin.Checked = fbloginsetting.FBLogin_IsEnabled
                PanelFBLogInSettings.Visible = fbloginsetting.FBLogin_IsEnabled
                TextBoxFBLogIn_AppId.Text = fbloginsetting.FBLogIn_AppId
                TextBoxFBLogIn_AppSecret.Text = fbloginsetting.FBLogIn_AppSecret
                TextBoxFBLogIn_ExtendedPermissions.Text = fbloginsetting.FBLogIn_ExtendedPermissions
                TextBoxFBLogIn_OuthRedirectURL.Text = fbloginsetting.FBLogIn_OuthRedirectURL
            End If

            Dim Googleloginsetting As FirstClickerService.Version1.WebSetting.StructureWebSetting_GooglelogIn
            Googleloginsetting = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadGoogleLoginSetting(WebAppSettings.DBCS)
            If fbloginsetting.Result = True Then
                CheckBoxGoogleLogin.Checked = Googleloginsetting.GoogleLogin_IsEnabled
                PanelGoogleLogInSettings.Visible = Googleloginsetting.GoogleLogin_IsEnabled
                TextBoxGoogleLogin_GoogleClientId.Text = Googleloginsetting.GoogleLogin_GoogleClientId
                TextBoxGoogleLogin_GoogleClientSecret.Text = Googleloginsetting.GoogleLogin_GoogleClientSecret
                TextBoxGoogleLogin_GoogleRedirectUri.Text = Googleloginsetting.GoogleLogin_GoogleRedirectUri
            End If

            Dim Twitterloginsetting As FirstClickerService.Version1.WebSetting.StructureWebSetting_TwitterlogIn
            Twitterloginsetting = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadTwitterLoginSetting(WebAppSettings.DBCS)
            If fbloginsetting.Result = True Then
                CheckBoxTwitterLogin.Checked = Twitterloginsetting.TwitterLogin_IsEnabled
                PanelTwitterLogInSettings.Visible = Twitterloginsetting.TwitterLogin_IsEnabled
                TextBoxTwitterLogin_ConsumerKey.Text = Twitterloginsetting.TwitterLogin_ConsumerKey
                TextBoxTwitterLogin_ConsumerSecret.Text = Twitterloginsetting.TwitterLogin_ConsumerSecret
                TextBoxTwitterLogin_RedirectURL.Text = Twitterloginsetting.TwitterLogin_RedirectURL
            End If
        End If
    End Sub

    Protected Sub CheckBoxEmailverification_CheckedChanged(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update("UserEmailVerificationRequired", CheckBoxEmailverification.Checked.ToString, WebAppSettings.DBCS)
    End Sub

    Protected Sub CheckBoxFacebookLogin_CheckedChanged(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update("FBLogin_IsEnabled", CheckBoxFacebookLogin.Checked.ToString, WebAppSettings.DBCS)
        PanelFBLogInSettings.Visible = CheckBoxFacebookLogin.Checked
    End Sub

    Protected Sub CheckBoxGoogleLogin_CheckedChanged(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update("GoogleLogin_IsEnabled", CheckBoxGoogleLogin.Checked.ToString, WebAppSettings.DBCS)
        PanelGoogleLogInSettings.Visible = CheckBoxGoogleLogin.Checked
    End Sub

    Protected Sub CheckBoxTwitterLogin_CheckedChanged(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update("TwitterLogin_IsEnabled", CheckBoxTwitterLogin.Checked.ToString, WebAppSettings.DBCS)
        PanelTwitterLogInSettings.Visible = CheckBoxTwitterLogin.Checked
    End Sub

    Protected Sub ButtonSaveFbSettings_Click(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.FBLogIn_AppId.ToString, TextBoxFBLogIn_AppId.Text, WebAppSettings.DBCS)
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.FBLogIn_AppSecret.ToString, TextBoxFBLogIn_AppSecret.Text, WebAppSettings.DBCS)
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.FBLogIn_ExtendedPermissions.ToString, TextBoxFBLogIn_ExtendedPermissions.Text, WebAppSettings.DBCS)
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.FBLogIn_OuthRedirectURL.ToString, TextBoxFBLogIn_OuthRedirectURL.Text, WebAppSettings.DBCS)
    End Sub

    Protected Sub ButtonSaveGoogleSettings_Click(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.GoogleLogin_GoogleClientId.ToString, TextBoxGoogleLogin_GoogleClientId.Text, WebAppSettings.DBCS)
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.GoogleLogin_GoogleClientSecret.ToString, TextBoxGoogleLogin_GoogleClientSecret.Text, WebAppSettings.DBCS)
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.GoogleLogin_GoogleRedirectUri.ToString, TextBoxGoogleLogin_GoogleRedirectUri.Text, WebAppSettings.DBCS)
    End Sub

    Protected Sub ButtonSaveTwitterSettings_Click(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.TwitterLogin_ConsumerKey.ToString, TextBoxTwitterLogin_ConsumerKey.Text, WebAppSettings.DBCS)
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.TwitterLogin_ConsumerSecret.ToString, TextBoxTwitterLogin_ConsumerSecret.Text, WebAppSettings.DBCS)
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.TwitterLogin_RedirectURL.ToString, TextBoxTwitterLogin_RedirectURL.Text, WebAppSettings.DBCS)
    End Sub


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header">
                    SignIn Settings
                </div>
                <div class="card-body ">
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <asp:CheckBox ID="CheckBoxEmailverification" runat="server" OnCheckedChanged="CheckBoxEmailverification_CheckedChanged" AutoPostBack="True" CausesValidation="True" />
                                Email verification required on registering new account</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <asp:CheckBox ID="CheckBoxFacebookLogin" runat="server" OnCheckedChanged="CheckBoxFacebookLogin_CheckedChanged" AutoPostBack="True" CausesValidation="True" />
                                Enable social login by facebook</label>
                        </div>
                        <asp:Panel runat="server" ID="PanelFBLogInSettings" class="card mb-4 ml-3">
                            <div class="card-header ">
                                <span class="card-link ">Facebook Login Settings</span>
                            </div>
                            <div class="card-body ">
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">App ID</label>
                                    <asp:TextBox ID="TextBoxFBLogIn_AppId" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">App Secret</label>
                                    <asp:TextBox ID="TextBoxFBLogIn_AppSecret" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Extended Permissions</label>
                                    <asp:TextBox ID="TextBoxFBLogIn_ExtendedPermissions" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Redirect URL</label>
                                    <asp:TextBox ID="TextBoxFBLogIn_OuthRedirectURL" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="card-footer p-1">
                                <asp:Button ID="ButtonSaveFbSettings" CssClass="btn btn-sm btn-info float-lg-right m-0" runat="server" Text="Save Settings" OnClick="ButtonSaveFbSettings_Click" />
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <asp:CheckBox ID="CheckBoxGoogleLogin" runat="server" OnCheckedChanged="CheckBoxGoogleLogin_CheckedChanged" AutoPostBack="True" CausesValidation="True" />
                                Enable social login by Google</label>
                        </div>
                        <asp:Panel runat="server" ID="PanelGoogleLogInSettings" class="card mb-4 ml-3">
                            <div class="card-header ">
                                <span class="card-link ">Google Login Settings</span>
                            </div>
                            <div class="card-body ">
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Client ID</label>
                                    <asp:TextBox ID="TextBoxGoogleLogin_GoogleClientId" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Client Secret</label>
                                    <asp:TextBox ID="TextBoxGoogleLogin_GoogleClientSecret" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Redirect URL</label>
                                    <asp:TextBox ID="TextBoxGoogleLogin_GoogleRedirectUri" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>

                            </div>
                            <div class="card-footer p-1">
                                <asp:Button ID="ButtonSaveGoogleSettings" CssClass="btn btn-sm btn-info float-lg-right m-0" runat="server" Text="Save Settings" OnClick="ButtonSaveGoogleSettings_Click" />
                            </div>
                        </asp:Panel>
                    </div>
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <asp:CheckBox ID="CheckBoxTwitterLogin" runat="server" OnCheckedChanged="CheckBoxTwitterLogin_CheckedChanged" AutoPostBack="True" CausesValidation="True" />
                                Enable social login by Twitter</label>
                        </div>
                        <asp:Panel runat="server" ID="PanelTwitterLogInSettings" class="card mb-4 ml-3">
                            <div class="card-header ">
                                <span class="card-link ">Twitter Login Settings</span>
                            </div>
                            <div class="card-body ">
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Consumer Key</label>
                                    <asp:TextBox ID="TextBoxTwitterLogin_ConsumerKey" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Consumer Secret</label>
                                    <asp:TextBox ID="TextBoxTwitterLogin_ConsumerSecret" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Redirect URL</label>
                                    <asp:TextBox ID="TextBoxTwitterLogin_RedirectURL" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="card-footer p-1">
                                <asp:Button ID="ButtonSaveTwitterSettings" CssClass="btn btn-sm btn-info float-lg-right m-0" runat="server" Text="Save Settings" OnClick="ButtonSaveTwitterSettings_Click" />
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

