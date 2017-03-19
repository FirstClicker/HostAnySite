<%@ WebService Language="VB" Class="UserAutoComplete" %>

Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data.SqlClient

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
 Public Class UserAutoComplete
    Inherits System.Web.Services.WebService
    
    <WebMethod()> _
    Public Function GetUserList(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim conn As SqlConnection = New SqlConnection
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("AppConnectionString").ConnectionString
        Dim cmd As SqlCommand = New SqlCommand
        cmd.CommandText = "select RoutUserName, UserId from Table_User where Username like @SearchText + '%'"
        cmd.Parameters.AddWithValue("@SearchText", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim customers As List(Of String) = New List(Of String)
        Dim sdr As SqlDataReader = cmd.ExecuteReader
        While sdr.Read
            Dim item As String = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("RoutUserName").ToString, sdr("UserId").ToString)
            customers.Add(item)
        End While
        conn.Close()
        Return customers
    End Function

End Class
