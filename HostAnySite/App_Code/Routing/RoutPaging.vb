Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Routing
Imports System.Web.Compilation
Imports System.Web.UI



Public Class RoutPaging
    Implements IRouteHandler

    Public Sub New()
    End Sub

    Private _virtualPath As String
    Public Sub New(ByVal virtualPath As String)
        _virtualPath = virtualPath
    End Sub


    Public Function GetHttpHandler(ByVal requestContext As RequestContext) As Web.IHttpHandler Implements IRouteHandler.GetHttpHandler

        If requestContext.RouteData.Values("Pagenum") IsNot Nothing Then
            Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutPagingInterface)
            If display IsNot Nothing Then
                display.RoutIFace_TagName = FirstClickerService.Common.ConvertDass2Space(Trim(requestContext.RouteData.Values("TagName")))
                display.RoutIFace_PageNum = Val(TryCast(requestContext.RouteData.Values("Pagenum"), String))

                Return display
            Else
                Return Nothing
            End If
        Else
            Return Nothing
        End If
    End Function


End Class


