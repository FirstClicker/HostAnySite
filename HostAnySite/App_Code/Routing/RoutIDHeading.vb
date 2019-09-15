Imports Microsoft.VisualBasic
Imports System.Web.Routing
Imports System.Web.Compilation
Imports System.Web
Imports System.Web.UI

Public Class RoutIDHeading
    Implements IRouteHandler

    Public Sub New()
    End Sub

    Private _virtualPath As String
    Public Sub New(ByVal virtualPath As String)
        _virtualPath = virtualPath
    End Sub


    Public Function GetHttpHandler(ByVal requestContext As RequestContext) As Web.IHttpHandler Implements IRouteHandler.GetHttpHandler
        If requestContext.RouteData.Values("ID") IsNot Nothing Then
            Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutIDHeadingInterface)
            If display IsNot Nothing Then
                display.RoutIFace_ID = requestContext.RouteData.Values("ID")
                display.RoutIFace_Heading = FirstClickerService.Common.ConvertDass2Space(requestContext.RouteData.Values("Heading"))
                Return display
            Else
                Return Nothing
            End If
        Else
            Return Nothing
        End If
    End Function
End Class
