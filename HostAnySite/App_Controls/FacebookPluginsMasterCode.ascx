<%@ Control Language="VB" ClassName="FacebookPluginsMasterCode" EnableViewState="false" %>

<script runat="server">
    ' version 24/10/2018 

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim mwebsetting As FirstClickerService.Version1.WebSetting.StructureWebSetting = FirstClickerService.Version1.WebSetting.WebSetting_Get(FirstClickerService.Version1.WebSetting.RequiredSettingName.FBLogIn_AppId.ToString, WebAppSettings.DBCS)
        If mwebsetting.Result = True Then
            LabelFBAppID.Text = mwebsetting.SettingValue
        End If

        If Val(LabelFBAppID.Text) < 1000 Then
            Me.Visible = False
        End If
    End Sub
</script>

<asp:Label ID="LabelFBAppID" runat="server" Text="0" Visible="false"></asp:Label>

<div id="fb-root"></div>
<script>(function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = 'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.1&appId=<%=LabelFBAppID.Text%>&autoLogAppEvents=1';
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));</script>
