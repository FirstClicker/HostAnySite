<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>
<%@ Register Src="~/App_Controls/WebSettingUpdaterText.ascx" TagPrefix="uc1" TagName="WebSettingUpdaterText" %>
<%@ Register Src="~/App_Controls/WebSettingUpdaterBoolean.ascx" TagPrefix="uc1" TagName="WebSettingUpdaterBoolean" %>
<%@ Register Src="~/App_Controls/WebSettingUpdaterSelectHome.ascx" TagPrefix="uc1" TagName="WebSettingUpdaterSelectHome" %>




<script runat="server">

    Protected Sub ButtonRestartApp_Click(sender As Object, e As EventArgs)
        System.Web.HttpRuntime.UnloadAppDomain()
        Response.Redirect(Page.Request.Url.ToString)
    End Sub



    Protected Sub WebSettingUpdaterTextCopyRightText_Setting_UpdateSuccess(sender As Object, e As EventArgs)
        WebAppSettings.CopyRightText = WebSettingUpdaterTextCopyRightText.SettingValue
    End Sub

    Protected Sub WebSettingUpdaterTextWebSiteName_Setting_UpdateSuccess(sender As Object, e As EventArgs)
        WebAppSettings.WebSiteName = WebSettingUpdaterTextWebSiteName.SettingValue
    End Sub

    Protected Sub WebSettingUpdaterSelect_Setting_UpdateSuccess(sender As Object, e As EventArgs)
        System.Web.HttpRuntime.UnloadAppDomain()
        Response.Redirect(Page.Request.Url.ToString)
    End Sub

    Protected Sub WebSettingUpdaterBoolean4_Setting_UpdateSuccess(sender As Object, e As EventArgs)
        System.Web.HttpRuntime.UnloadAppDomain()
        Response.Redirect(Page.Request.Url.ToString)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        If IsPostBack = False Then
            PanelGoogleCSESettings.Visible = WebAppSettings.GoogleCSE_IsEnabled
        End If
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
                <div class="card-header ">
                    General Settings
                    <div class="float-right ">
                        <asp:Button ID="ButtonRestartApp" CssClass ="btn btn-dark btn-sm " OnClick ="ButtonRestartApp_Click" runat="server" Text="Restart App" />
                    </div>
                </div>
                <div class="card-body ">
                    <uc1:WebSettingUpdaterText runat="server" ID="WebSettingUpdaterTextWebSiteName" SettingName="WebSiteName" SettingHeading="WebSite Name" OnSetting_UpdateSuccess="WebSettingUpdaterTextWebSiteName_Setting_UpdateSuccess" />
                    <uc1:WebSettingUpdaterText runat="server" ID="WebSettingUpdaterTextCopyRightText" SettingName="CopyRightText" SettingHeading="Copyright Text" OnSetting_UpdateSuccess="WebSettingUpdaterTextCopyRightText_Setting_UpdateSuccess" />
                </div>
                <div class="card-body ">
                    <uc1:WebSettingUpdaterSelectHome runat="server" ID="WebSettingUpdaterSelectHome" SettingName="WebsiteHomePath" OnSetting_UpdateSuccess="WebSettingUpdaterSelect_Setting_UpdateSuccess" />
                    <div class="card">
                        <div class="card-body ">
                            <div class="row">
                                <div class="col-lg-6 ">

                                    <uc1:WebSettingUpdaterBoolean runat="server" ID="WebSettingUpdaterBoolean" SettingName="HasApp_Blog_IsEnabled" SettingHeading="  Enable Blog" />
                                    <uc1:WebSettingUpdaterBoolean runat="server" ID="WebSettingUpdaterBoolean1" SettingName="HasApp_Forum_IsEnabled" SettingHeading="  Enable Forum" />
                                </div>
                                <div class="col-lg-6 ">
                                    <uc1:WebSettingUpdaterBoolean runat="server" ID="WebSettingUpdaterBoolean2" SettingName="HasApp_Question_IsEnabled" SettingHeading="  Enable Question" />
                                    <uc1:WebSettingUpdaterBoolean runat="server" ID="WebSettingUpdaterBoolean3" SettingName="HasApp_CompareList_IsEnabled" SettingHeading="  Enable Compare List" />

                                </div>
                            </div>
                        </div>
                    </div>
                    </div> 
                 
                <div class="card-body ">
                    <uc1:WebSettingUpdaterText runat="server" ID="WebSettingUpdaterTextGoogleAnalytics_ID" SettingName="GoogleAnalytics_ID" SettingHeading="Google Analytics ID" />
                    <uc1:WebSettingUpdaterText runat="server" ID="WebSettingUpdaterTextGoogleAdsense_AutoAdsID" SettingName="GoogleAdsense_AutoAdsID" SettingHeading="Google Adsense AutoAds ID" />
                    <uc1:WebSettingUpdaterText runat="server" ID="WebSettingUpdaterTextGoogleAdsense_DataAdClient" SettingName="GoogleAdsense_DataAdClient" SettingHeading="Google Adsense DataAd Client" />
                    <uc1:WebSettingUpdaterText runat="server" ID="WebSettingUpdaterTextGoogleAdsense_DataAdSlot" SettingName="GoogleAdsense_DataAdSlot" SettingHeading="Google Adsense DataAd Slot" />
                </div> 

                <div class="card-body ">
                    <uc1:WebSettingUpdaterBoolean runat="server" ID="WebSettingUpdaterBooleanGoogleCSE_IsEnabled" SettingName="GoogleCSE_IsEnabled" SettingHeading="  Enable Google Custom Search (CSE)" OnSetting_UpdateSuccess="WebSettingUpdaterBoolean4_Setting_UpdateSuccess" />
                    <asp:Panel runat="server" ID="PanelGoogleCSESettings" class="card mb-4 ml-3">
                        <div class="card-body ">
                            <uc1:WebSettingUpdaterText runat="server" ID="WebSettingUpdaterTextGoogleCSE_cxID" SettingName="GoogleCSE_cxID" SettingHeading="Google Custom Search CX" />
                        </div>
                    </asp:Panel>
                </div> 
            </div>
        </div>
    </div>
</asp:Content>

