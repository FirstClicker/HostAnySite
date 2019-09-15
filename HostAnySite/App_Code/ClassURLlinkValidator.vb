Imports Microsoft.VisualBasic
Imports HtmlAgilityPack
Imports System.Web

Public Class ClassURLlinkValidator

    Structure StructureURL
        Public URL As String     '200
        Public Title As String         '250
        Public Description As String
        Public ImageURL As List(Of String)

        Public Result As Boolean
        Public Sys_Error_Num As String
        Public Sys_Error_message As String
        Public My_Error_Num As String
        Public My_Error_message As String
    End Structure


    Public Shared Function LinkDetails(Url As String) As StructureURL
        LinkDetails = Nothing

        LinkDetails.URL = Url

        Dim getHtmlDoc = New HtmlWeb()
        Dim document As HtmlDocument
        Try
            document = getHtmlDoc.Load(Url)
            LinkDetails.Result = True
        Catch ex As Exception
            LinkDetails.Result = False
            Exit Function
        End Try

        Dim metaTags = document.DocumentNode.SelectNodes("//meta")
        If metaTags IsNot Nothing Then
            For Each sitetag In metaTags
                If sitetag.Attributes("name") IsNot Nothing AndAlso sitetag.Attributes("content") IsNot Nothing AndAlso sitetag.Attributes("name").Value.ToLower = "description" Then
                    LinkDetails.Description = sitetag.Attributes("content").Value
                End If
            Next
        End If


        Dim metaTitleTag = document.DocumentNode.SelectSingleNode("//head/title")
        LinkDetails.Title = metaTitleTag.FirstChild.InnerText

        Dim slist As New List(Of String)
        For Each imgee As HtmlAgilityPack.HtmlNode In document.DocumentNode.SelectNodes("//img")
            If imgee.Attributes("src").Value.StartsWith("http") Then
                slist.Add(imgee.Attributes("src").Value)
            End If
        Next

        LinkDetails.ImageURL = slist
    End Function




End Class
