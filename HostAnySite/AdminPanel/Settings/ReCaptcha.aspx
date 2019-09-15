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
            Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting_ReCaptcha
            websetting = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadReCaptchaSetting(WebAppSettings.DBCS)
            If websetting.Result = True Then
                CheckBoxRecaptchaEnabled.Checked = websetting.ReCaptcha_IsEnabled
                PanelReCaptchaSettings.Visible = websetting.ReCaptcha_IsEnabled
                TextBoxRecaptcha_SiteKey.Text = websetting.Recaptcha_SiteKey
                TextBoxRecaptcha_SecretKey.Text = websetting.Recaptcha_SecretKey
            Else
                ' add the entry
                websetting = FirstClickerService.Version1.WebSetting.WEBAppSetting_AddReCaptchaBlankSetting(WebAppSettings.DBCS)
            End If
        End If
    End Sub

    Protected Sub CheckBoxRecaptchaEnabled_CheckedChanged(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update("ReCaptcha_IsEnabled", CheckBoxRecaptchaEnabled.Checked.ToString, WebAppSettings.DBCS)
        PanelReCaptchaSettings.Visible = CheckBoxRecaptchaEnabled.Checked
        WebAppSettings.ReCaptcha_IsEnabled = CheckBoxRecaptchaEnabled.Checked
        Try
            hbehr.recaptcha.ReCaptcha.Configure(TextBoxRecaptcha_SiteKey.Text, TextBoxRecaptcha_SecretKey.Text)
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub ButtonSaveRecaptchaSettings_Click(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update("Recaptcha_SiteKey", TextBoxRecaptcha_SiteKey.Text, WebAppSettings.DBCS)
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update("Recaptcha_SecretKey", TextBoxRecaptcha_SecretKey.Text, WebAppSettings.DBCS)
        Try
            hbehr.recaptcha.ReCaptcha.Configure(TextBoxRecaptcha_SiteKey.Text, TextBoxRecaptcha_SecretKey.Text)
        Catch ex As Exception

        End Try


    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:navigationsideadminpanel runat="server" id="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header">
                    ReCaptcha Settings
                </div>
                <div class="card-body ">
                    <div class="form-group">
                        <div class="checkbox">
                            <label>
                                <asp:CheckBox ID="CheckBoxRecaptchaEnabled" runat="server" OnCheckedChanged="CheckBoxRecaptchaEnabled_CheckedChanged" AutoPostBack="True" CausesValidation="True" />
                                Enable ReCaptcha</label>
                        </div>
                        <asp:Panel runat="server" ID="PanelReCaptchaSettings" class="card mb-4 ml-3">
                            <div class="card-header ">
                                <span class="card-link ">ReCaptcha Settings</span>
                            </div>
                            <div class="card-body ">
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Recaptcha SiteKey</label>
                                    <asp:TextBox ID="TextBoxRecaptcha_SiteKey" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="exampleFormControlInput1" class="col-form-label-sm ">Recaptcha SecretKey</label>
                                    <asp:TextBox ID="TextBoxRecaptcha_SecretKey" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                                 
                            </div>
                             <div class="card-footer p-1">
                                <asp:Button ID="ButtonSaveRecaptchaSettings" CssClass="btn btn-sm btn-info float-lg-right m-0" runat="server" Text="Save Settings" OnClick="ButtonSaveRecaptchaSettings_Click" />
                            </div>
                        </asp:Panel>
                    </div> 
                </div>
            </div>
        </div>
    </div> 
</asp:Content>

