<%@ Application Language="VB" %>

<script runat="server">
    ' version 09-05-2019 # 4.27 PM

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
        If Trim(ConfigurationManager.ConnectionStrings("AppConnectionString").ConnectionString) = "AppConnectionStringValue" Then
            If IO.File.Exists(Server.MapPath("~/App_Data/AppConnectionString.txt")) Then
                ' rewrite  
                Dim ReadCS As String = IO.File.ReadAllText(Server.MapPath("~/App_Data/AppConnectionString.txt"))
                Dim TempWebConfig As String = My.Computer.FileSystem.ReadAllText(Server.MapPath("~/web.config"))
                TempWebConfig = TempWebConfig.Replace("AppConnectionStringValue", ReadCS) ' replace dosenot ignore case.. need to be carefull
                My.Computer.FileSystem.WriteAllText(Server.MapPath("~/web.config"), TempWebConfig, False)

                System.Web.HttpRuntime.UnloadAppDomain()

                Response.Clear()
                Response.Redirect("~/")
            Else
                ' install
                System.Web.Routing.RouteTable.Routes.Add("SiteHome", New System.Web.Routing.Route("", New RoutSiteHome("~/install/Default.aspx")))
                Exit Sub
            End If


        End If

        WebAppSettings.loadWebAppStartingSettings()
        RoutRegister.Register()


    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs

        Dim urlreffere = Request.UrlReferrer
        Dim urlref As String = ""
        If urlreffere IsNot Nothing Then
            urlref = urlreffere.ToString
        End If

        Dim exc As Exception = Server.GetLastError    'get last error
        FirstClickerService.Version1.ReportError.ReportError(exc, WebAppSettings.DBCS, urlref)
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
        Session("UserName") = ""
        Session("RoutUserName") = ""
        Session("UserID") = ""
        Session("UserType") = ""

        If Trim(ConfigurationManager.ConnectionStrings("AppConnectionString").ConnectionString) = "AppConnectionStringValue" Then Exit Sub
        Dim cookie As HttpCookie
        cookie = Request.Cookies.Get("HASApp")
        If Not (cookie Is Nothing) Then
            Dim userinfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_RoutUserName(cookie.Item("RoutUserName"), WebAppSettings.DBCS)
            If userinfo.Result = True Then
                Session("UserName") = userinfo.UserName
                Session("RoutUserName") = userinfo.RoutUserName
                Session("UserID") = userinfo.UserID
                Session("UserType") = userinfo.UserType
            End If


        End If
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

</script>