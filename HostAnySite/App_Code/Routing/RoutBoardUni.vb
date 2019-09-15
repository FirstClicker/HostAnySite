' version 13/10/2018 #20.27 

Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Routing
Imports System.Web.Compilation
Imports System.Web.UI

Public Class RoutBoardUni


    Implements IRouteHandler

    Public Sub New()
    End Sub

    Private _virtualPath As String
    Public Function GetHttpHandler(ByVal requestContext As RequestContext) As Web.IHttpHandler Implements IRouteHandler.GetHttpHandler

        Select Case TryCast(requestContext.RouteData.Values("String1"), String).ToLower
            Case "blog"
                If IsDigitsOnly(TryCast(requestContext.RouteData.Values("String2"), String)) = True Then
                    'is Blog page
                    _virtualPath = "~/Routing/BlogPage.aspx"
                Else
                    If Len(TryCast(requestContext.RouteData.Values("String3"), String)) < 8 Then
                        'is page num for keyword
                        _virtualPath = "~/Routing/BlogTag.aspx"
                    Else
                        'is Blog view
                        _virtualPath = "~/Routing/BlogView.aspx"
                    End If
                End If

                If requestContext.RouteData.Values("String2") IsNot Nothing Then
                    Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutBoardUniInterface)
                    If display IsNot Nothing Then
                        display.RoutIFace_String1 = TryCast(requestContext.RouteData.Values("String1"), String)
                        display.RoutIFace_String2 = TryCast(requestContext.RouteData.Values("String2"), String)
                        display.RoutIFace_String3 = TryCast(requestContext.RouteData.Values("String3"), String)
                        display.RoutIFace_String4 = TryCast(requestContext.RouteData.Values("String4"), String)
                        Return display
                    Else
                        Return Nothing
                    End If
                Else
                    Return Nothing
                End If
            Case "image"
                If IsDigitsOnly(TryCast(requestContext.RouteData.Values("String2"), String)) = True Then
                    'is image page
                    _virtualPath = "~/Routing/imagePage.aspx"
                Else
                    If Len(TryCast(requestContext.RouteData.Values("String3"), String)) < 8 Then
                        'is page num for keyword
                        _virtualPath = "~/Routing/imageTag.aspx"
                    Else
                        'is image view
                        _virtualPath = "~/Routing/imageView.aspx"
                    End If
                End If


                If requestContext.RouteData.Values("String2") IsNot Nothing Then
                    Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutBoardUniInterface)
                    If display IsNot Nothing Then
                        display.RoutIFace_String1 = TryCast(requestContext.RouteData.Values("String1"), String)
                        display.RoutIFace_String2 = TryCast(requestContext.RouteData.Values("String2"), String)
                        display.RoutIFace_String3 = TryCast(requestContext.RouteData.Values("String3"), String)
                        display.RoutIFace_String4 = TryCast(requestContext.RouteData.Values("String4"), String)
                        Return display
                    Else
                        Return Nothing
                    End If
                Else
                    Return Nothing
                End If
            Case "forum"
                'forum/{pagenum}
                'forum/{tagname}/{pagenum}
                'forum/{ForumName}/{ForumID}
                'forum/{ForumName}/{TopicName}/{TopicID}

                If IsDigitsOnly(TryCast(requestContext.RouteData.Values("String2"), String)) = True Then
                    'is Question page
                    _virtualPath = "~/Routing/ForumPage.aspx"
                Else
                    If IsDigitsOnly(Trim(TryCast(requestContext.RouteData.Values("String3"), String))) = True Then
                        If Len(TryCast(requestContext.RouteData.Values("String3"), String)) < 8 Then
                            'is page num for Tag
                            _virtualPath = "~/Routing/ForumTag.aspx"
                        Else
                            'is Forum view
                            _virtualPath = "~/Routing/ForumView.aspx"
                        End If
                    Else
                        'is Forum topic view
                        _virtualPath = "~/Routing/ForumTopicView.aspx"
                    End If
                End If


                If requestContext.RouteData.Values("String2") IsNot Nothing Then
                    Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutBoardUniInterface)
                    If display IsNot Nothing Then
                        display.RoutIFace_String1 = Trim(TryCast(requestContext.RouteData.Values("String1"), String))
                        display.RoutIFace_String2 = Trim(TryCast(requestContext.RouteData.Values("String2"), String))
                        display.RoutIFace_String3 = Trim(TryCast(requestContext.RouteData.Values("String3"), String))
                        display.RoutIFace_String4 = Trim(TryCast(requestContext.RouteData.Values("String4"), String))
                        Return display
                    Else
                        Return Nothing
                    End If
                Else
                    Return Nothing
                End If

            Case "question"
                If IsDigitsOnly(TryCast(requestContext.RouteData.Values("String2"), String)) = True Then
                    'is Question page
                    _virtualPath = "~/Routing/QuestionPage.aspx"
                Else
                    If Len(TryCast(requestContext.RouteData.Values("String3"), String)) < 8 Then
                        'is page num for keyword
                        _virtualPath = "~/Routing/QuestionTag.aspx"
                    Else
                        'is image view
                        _virtualPath = "~/Routing/QuestionView.aspx"
                    End If
                End If


                If requestContext.RouteData.Values("String2") IsNot Nothing Then
                    Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutBoardUniInterface)
                    If display IsNot Nothing Then
                        display.RoutIFace_String1 = TryCast(requestContext.RouteData.Values("String1"), String)
                        display.RoutIFace_String2 = TryCast(requestContext.RouteData.Values("String2"), String)
                        display.RoutIFace_String3 = TryCast(requestContext.RouteData.Values("String3"), String)
                        display.RoutIFace_String4 = TryCast(requestContext.RouteData.Values("String4"), String)

                        Return display
                    Else
                        Return Nothing
                    End If
                Else
                    Return Nothing
                End If

            Case Else
                _virtualPath = "~/Routing/BoardDefault.aspx"

                If requestContext.RouteData.Values("String1") IsNot Nothing Then
                    Dim display = TryCast(BuildManager.CreateInstanceFromVirtualPath(_virtualPath, GetType(Page)), RoutBoardUniInterface)
                    If display IsNot Nothing Then
                        display.RoutIFace_String1 = TryCast(requestContext.RouteData.Values("String1"), String)
                        display.RoutIFace_String2 = TryCast(requestContext.RouteData.Values("String2"), String)
                        display.RoutIFace_String3 = TryCast(requestContext.RouteData.Values("String3"), String)
                        display.RoutIFace_String4 = TryCast(requestContext.RouteData.Values("String4"), String)
                        Return display
                    Else
                        Return Nothing
                    End If
                Else
                    Return Nothing
                End If
        End Select





    End Function


    Private Function IsDigitsOnly(ByVal str As String) As Boolean
        For Each c As Char In str
            If c < "0"c OrElse c > "9"c Then Return False
        Next

        Return True
    End Function



End Class


