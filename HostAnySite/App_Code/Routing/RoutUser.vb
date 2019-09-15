Imports System.Web
Imports System.Web.Routing
Imports System.Web.Compilation
Imports System.Web.UI


Public Class RoutUser
    Implements IRouteHandler

    Public Sub New()
    End Sub

    Private _virtualPath As String
    Public Sub New(ByVal virtualPath As String)
        _virtualPath = virtualPath
    End Sub


    Public Function GetHttpHandler(ByVal requestContext As RequestContext) As IHttpHandler Implements IRouteHandler.GetHttpHandler
        If requestContext.RouteData.Values("RoutUserName") IsNot Nothing Then
            Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutUserInterface)
            If display IsNot Nothing Then
                display.RoutIFace_RoutUserName = requestContext.RouteData.Values("RoutUserName")
                Return display
            Else
                Return Nothing
            End If
        Else
            Return Nothing
        End If
    End Function
End Class