Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web


Public Interface RoutPagingInterface
    Inherits IHttpHandler

    Property RoutIFace_TagName() As String
    Property RoutIFace_PageNum() As String

End Interface

