Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Public Class ClassAppDetails
    Public Shared DBCS As String = System.Configuration.ConfigurationManager.ConnectionStrings("AppConnectionString").ConnectionString
    Public Shared WebSiteName As String
    Public Shared CopyRight As String
    Public Shared DatabaseVersion As String
    Public Shared CurrentTheme As String


    Public Shared Function loadAppValiable() As Boolean
        Dim apploaddetailas As ClassHostAnySite.WebSetting.StructureLoadWebSetting = ClassHostAnySite.WebSetting.LoadAppSetting(ClassAppDetails.DBCS)

        ClassAppDetails.WebSiteName = apploaddetailas.WebSiteName
        ClassAppDetails.CopyRight = apploaddetailas.CopyRight
        ClassAppDetails.DatabaseVersion = apploaddetailas.DatabaseVersion
        ClassAppDetails.CurrentTheme = apploaddetailas.CurrentTheme
    End Function

End Class
