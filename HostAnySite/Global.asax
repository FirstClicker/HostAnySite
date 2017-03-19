<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        If Trim(ClassAppDetails.DBCS) = "AppConnectionStringValue" Then
            ClassHostAnySite.RoutRegister.Registe_PreInstall()
        Else
            ClassHostAnySite.RoutRegister.Register()
            ClassAppDetails.loadAppValiable()

        End If
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
        ' Code that runs when an unhandled error occurs
        Try
            Dim urlreffere = Request.UrlReferrer
            Dim exc As Exception = Server.GetLastError    'get last error
            ClassHostAnySite.ReportError.reportError(exc, ClassAppDetails.DBCS, urlreffere.ToString)

            Server.ClearError()
        Catch ex As Exception

        End Try
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        Session("UserName") = ""
        Session("RoutUserName") = ""
        Session("UserID") = ""
        Session("UserType") = ""

        Dim cookie As HttpCookie
        cookie = Request.Cookies.Get("HASApp")
        If Not (cookie Is Nothing) Then
            Session("UserName") = cookie.Item("UserName")
            Session("RoutUserName") = cookie.Item("RoutUserName")
            Session("UserID") = cookie.Item("UserID")
            Session("UserType") = cookie.Item("UserType")
        End If


    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

</script>