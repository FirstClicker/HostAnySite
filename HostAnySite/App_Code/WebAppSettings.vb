Imports Microsoft.VisualBasic

Public Class WebAppSettings

    Public Shared DBCS As String

    Public Shared WebSiteName As String
    Public Shared CopyRightText As String
    Public Shared WebSiteCurrentTheme As String
    Public Shared UserEmailVerificationRequired As Boolean
    Public Shared ReCaptcha_IsEnabled As Boolean

    Public Shared GoogleAnalytics_ID As String
    Public Shared GoogleAdsense_AutoAdsID As String
    Public Shared GoogleAdsense_DataAdClient As String
    Public Shared GoogleAdsense_DataAdSlot As String


    Public Shared DefaultImgID_UserAvtar As Long
    Public Shared DefaultImgID_ProfileBanner As Long
    Public Shared DefaultImgID_ComparisonEntry As Long

    Public Shared HasApp_Blog_IsEnabled As Boolean
    Public Shared HasApp_Forum_IsEnabled As Boolean
    Public Shared HasApp_Question_IsEnabled As Boolean
    Public Shared HasApp_CompareList_IsEnabled As Boolean

    Public Shared GoogleCSE_IsEnabled As Boolean
    Public Shared GoogleCSE_cxID As String

    Public Shared ADDthis_MasterCode As String


    Public Shared Sub loadWebAppStartingSettings()

        DBCS = System.Configuration.ConfigurationManager.ConnectionStrings("AppConnectionString").ConnectionString

        DefaultImgID_UserAvtar = Val(DefaultImg_UserAvtar().OutPutString)
        DefaultImgID_ProfileBanner = Val(DefaultImg_ProfileBanner().OutPutString)
        DefaultImgID_ComparisonEntry = Val(DefaultImg_ComparisonEntry().OutPutString)

        Dim StarterBasicSettingDetailas As FirstClickerService.Version1.WebSetting.StructureWebSetting_StarterBasic = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadStarterBasicSetting(DBCS)
        If StarterBasicSettingDetailas.Result = True Then
            WebSiteName = StarterBasicSettingDetailas.WebSiteName
            CopyRightText = StarterBasicSettingDetailas.CopyRightText
            WebSiteCurrentTheme = StarterBasicSettingDetailas.WebSiteCurrentTheme
            UserEmailVerificationRequired = StarterBasicSettingDetailas.UserEmailVerificationRequired

            GoogleAnalytics_ID = StarterBasicSettingDetailas.GoogleAnalytics_ID
            GoogleAdsense_AutoAdsID = StarterBasicSettingDetailas.GoogleAdsense_AutoAdsID
            GoogleAdsense_DataAdClient = StarterBasicSettingDetailas.GoogleAdsense_DataAdClient
            GoogleAdsense_DataAdSlot = StarterBasicSettingDetailas.GoogleAdsense_DataAdSlot

            ReCaptcha_IsEnabled = StarterBasicSettingDetailas.ReCaptcha_IsEnabled
            If ReCaptcha_IsEnabled = True Then
                Dim recaptchadetails As FirstClickerService.Version1.WebSetting.StructureWebSetting_ReCaptcha
                recaptchadetails = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadReCaptchaSetting(DBCS)
                If recaptchadetails.Result = True Then
                    Try
                        hbehr.recaptcha.ReCaptcha.Configure(recaptchadetails.Recaptcha_SiteKey, recaptchadetails.Recaptcha_SecretKey)
                    Catch ex As Exception
                        'disable recaptcha
                        Dim websettingRecap As FirstClickerService.Version1.WebSetting.StructureWebSetting
                        websettingRecap = FirstClickerService.Version1.WebSetting.WebSetting_Update("ReCaptcha_IsEnabled", "False", DBCS)
                        'report error
                    End Try
                Else
                    recaptchadetails = FirstClickerService.Version1.WebSetting.WEBAppSetting_AddReCaptchaBlankSetting(DBCS)
                    'disable recaptcha
                    Dim websettingRecap As FirstClickerService.Version1.WebSetting.StructureWebSetting
                    websettingRecap = FirstClickerService.Version1.WebSetting.WebSetting_Update("ReCaptcha_IsEnabled", "False", DBCS)
                End If
            End If

            HasApp_Blog_IsEnabled = StarterBasicSettingDetailas.HasApp_Blog_IsEnabled
            HasApp_Forum_IsEnabled = StarterBasicSettingDetailas.HasApp_Forum_IsEnabled
            HasApp_Question_IsEnabled = StarterBasicSettingDetailas.HasApp_Question_IsEnabled
            HasApp_CompareList_IsEnabled = StarterBasicSettingDetailas.HasApp_CompareList_IsEnabled

            GoogleCSE_IsEnabled = StarterBasicSettingDetailas.GoogleCSE_IsEnabled
            GoogleCSE_cxID = StarterBasicSettingDetailas.GoogleCSE_cxID

            ' code it to database
            ADDthis_MasterCode = "<Script type = ""text/javascript"" src=""//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5ac619d7dbf10d4d""></script>"

        Else
            FirstClickerService.Version1.WebSetting.WEBAppSetting_AddStarterBasicBlankSetting(DBCS)
        End If
    End Sub


    Public Shared Function DefaultImg_UserAvtar() As FirstClickerService.Common.StructureResult
        DefaultImg_UserAvtar = Nothing

        DefaultImg_UserAvtar.Result = True
        DefaultImg_UserAvtar.OutPutString = "11111111"

        Dim imagedetails As FirstClickerService.Version1.Image.StructureImage
        ' Check if Default avatar exist
        imagedetails = FirstClickerService.Version1.Image.ImageDetails_BYID("11111111", WebAppSettings.DBCS)
        If imagedetails.Result = False Then
            'add the entry
            imagedetails = FirstClickerService.Version1.Image.SubmitImageByWeb("11111111", "UserAvtar-11111111.png", "UserAvtar", " ", "11111111", FirstClickerService.Version1.Image.StatusEnum.System, WebAppSettings.DBCS)
            If imagedetails.Result = True Then
                If IO.File.Exists(HttpContext.Current.Server.MapPath("~/storage/image/UserAvtar-11111111.png")) = False Then
                    IO.File.Copy(HttpContext.Current.Server.MapPath("~/Content/image/UserAvtar.png"), HttpContext.Current.Server.MapPath("~/storage/image/UserAvtar-11111111.png"))
                End If
            Else
                'Report Error

                DefaultImg_UserAvtar.Result = False
            End If
        Else
            If IO.File.Exists(HttpContext.Current.Server.MapPath("~/storage/image/" & imagedetails.ImageFileName)) = False Then
                IO.File.Copy(HttpContext.Current.Server.MapPath("~/Content/image/UserAvtar.png"), HttpContext.Current.Server.MapPath("~/storage/image/UserAvtar-11111111.png"))
            End If
        End If
    End Function


    Public Shared Function DefaultImg_ProfileBanner() As FirstClickerService.Common.StructureResult
        DefaultImg_ProfileBanner = Nothing

        DefaultImg_ProfileBanner.Result = True
        DefaultImg_ProfileBanner.OutPutString = "11111112"


        Dim imagedetails As FirstClickerService.Version1.Image.StructureImage
        ' Check if Default Profile Banner exist
        imagedetails = FirstClickerService.Version1.Image.ImageDetails_BYID("11111112", WebAppSettings.DBCS)
        If imagedetails.Result = False Then
            'add the entry
            imagedetails = FirstClickerService.Version1.Image.SubmitImageByWeb("11111112", "ProfileBanner-11111112.png", "ProfileBanner", " ", "11111111", FirstClickerService.Version1.Image.StatusEnum.System, WebAppSettings.DBCS)
            If imagedetails.Result = True Then
                If IO.File.Exists(HttpContext.Current.Server.MapPath("~/storage/image/ProfileBanner-11111112.png")) = False Then
                    IO.File.Copy(HttpContext.Current.Server.MapPath("~/Content/image/ProfileBanner.png"), HttpContext.Current.Server.MapPath("~/storage/image/ProfileBanner-11111112.png"))
                End If
            Else
                'Report Error
                DefaultImg_ProfileBanner.Result = False
            End If
        Else
            If IO.File.Exists(HttpContext.Current.Server.MapPath("~/storage/image/ProfileBanner-11111112.png")) = False Then
                IO.File.Copy(HttpContext.Current.Server.MapPath("~/Content/image/ProfileBanner.png"), HttpContext.Current.Server.MapPath("~/storage/image/ProfileBanner-11111112.png"))
            End If
        End If
    End Function


    Public Shared Function DefaultImg_ComparisonEntry() As FirstClickerService.Common.StructureResult
        DefaultImg_ComparisonEntry = Nothing

        DefaultImg_ComparisonEntry.Result = True
        DefaultImg_ComparisonEntry.OutPutString = "11111113"


        Dim imagedetails As FirstClickerService.Version1.Image.StructureImage
        ' Check if Default Profile Banner exist
        imagedetails = FirstClickerService.Version1.Image.ImageDetails_BYID("11111113", WebAppSettings.DBCS)
        If imagedetails.Result = False Then
            'add the entry
            imagedetails = FirstClickerService.Version1.Image.SubmitImageByWeb("11111113", "ComparisonEntry-11111113.png", "ComparisonEntry", " ", "11111111", FirstClickerService.Version1.Image.StatusEnum.System, WebAppSettings.DBCS)
            If imagedetails.Result = True Then
                If IO.File.Exists(HttpContext.Current.Server.MapPath("~/storage/image/ComparisonEntry-11111113.png")) = False Then
                    IO.File.Copy(HttpContext.Current.Server.MapPath("~/Content/image/ComparisonEntry.png"), HttpContext.Current.Server.MapPath("~/storage/image/ComparisonEntry-11111113.png"))
                End If
            Else
                'Report Error
                DefaultImg_ComparisonEntry.Result = False
            End If
        Else
            If IO.File.Exists(HttpContext.Current.Server.MapPath("~/storage/image/ComparisonEntry-11111113.png")) = False Then
                IO.File.Copy(HttpContext.Current.Server.MapPath("~/Content/image/ComparisonEntry.png"), HttpContext.Current.Server.MapPath("~/storage/image/ComparisonEntry-11111113.png"))
            End If
        End If
    End Function


End Class
