Imports Microsoft.VisualBasic
Imports System.Web.Routing
Imports System.Web.Compilation
Imports System.Web
Imports System.Web.UI

Public Class RoutTag
    Implements IRouteHandler

    Public Sub New()
    End Sub

    Private _virtualPath As String
    Public Sub New(ByVal virtualPath As String)
        _virtualPath = virtualPath
    End Sub


    Public Function GetHttpHandler(ByVal requestContext As RequestContext) As Web.IHttpHandler Implements IRouteHandler.GetHttpHandler
        If requestContext.RouteData.Values("TagName") IsNot Nothing Then
            Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutTagInterface)
            If display IsNot Nothing Then
                display.RoutIFace_TagName = requestContext.RouteData.Values("TagName").ToString.Replace("-", " ")

                Return display
            Else
                Return Nothing
            End If
        Else
            Return Nothing
        End If
    End Function
End Class
