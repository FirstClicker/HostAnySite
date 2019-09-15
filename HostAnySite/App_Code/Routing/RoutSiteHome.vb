Imports System.Web
Imports Microsoft.VisualBasic
Imports System.Web.Routing
Imports System.Web.Compilation
Imports System.Web.UI


Public Class RoutSiteHome
    Implements IRouteHandler

    Public Sub New()
    End Sub

    Private _virtualPath As String
    Public Sub New(ByVal virtualPath As String)
        _virtualPath = virtualPath
    End Sub


    Public Function GetHttpHandler(ByVal requestContext As RequestContext) As IHttpHandler Implements IRouteHandler.GetHttpHandler

        Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutSiteHomeInterface)
        If display IsNot Nothing Then
            Return display
        Else
            Return Nothing
        End If
       
    End Function
End Class




