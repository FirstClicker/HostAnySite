<%@ Control Language="VB" ClassName="AdminTagDrescptionFinder" EnableViewState="false" %>

<script runat="server">
    ' version 26/08/2018 # 4.27 AM

    Public Property TagName() As String
        Get
            Return LabelTagName.Text
        End Get
        Set(ByVal value As String)
            LabelTagName.Text = value
        End Set
    End Property

    Public Property TagType() As String
        Get
            Return LabelTagType.Text
        End Get
        Set(ByVal value As String)
            LabelTagType.Text = value
        End Set
    End Property

    Public Property IncludeKeyword() As String
        Get
            Return LabelTagIncludeKeyword.Text
        End Get
        Set(ByVal value As String)
            LabelTagIncludeKeyword.Text = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Trim(TagName) = "" Then
            Me.Visible = False
            Exit Sub
        End If
        If IsPostBack = False Then

            Dim textfound As String() = FirstClickerService.ArticleTextBySearch.bing_SearchText(TagName & " " & TagType)
            For r = 0 To textfound.Length - 1
                Dim Excludekeywords = {".com", ".org", ".net", ".us"}
                Dim IncludeKeywords As String() = IncludeKeyword.Split(",")

                If CompareMultiple(textfound(r).ToLower, Excludekeywords) = False Then
                    If CompareMultiple(textfound(r).ToLower, IncludeKeywords) = True Then
                        Dim sentances As String() = textfound(r).Split(".")
                        If (sentances.Length - 1) >= 2 Then ' atlest having two sentance
                            ListBoxDrescption.Items.Add(sentances(0) & ". " & sentances(1) & ".")
                        End If
                    End If
                End If
            Next

            If ListBoxDrescption.Items.Count >= 1 Then
                LabelDrescption.Text = ListBoxDrescption.Items.Item(FirstClickerService.Common.GetRandomNumber(0, ListBoxDrescption.Items.Count - 1)).Text
                If LabelDrescption.Text.Contains("We did not find results") = False Then
                    'save drescption
                    Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.GetDetails_BYTagName(TagName, WebAppSettings.DBCS)
                    If tagdetails.Result = True Then
                        FirstClickerService.Version1.TagSEO.UpdateSeoDrescption_BYTagID(tagdetails.TagId, FirstClickerService.Version1.TagSEO.TagSEOForEnum.Image, LabelDrescption.Text, WebAppSettings.DBCS)

                    End If
                End If
            End If

        End If





    End Sub

    Public Function CompareMultiple(ByVal str As String, ByVal ParamArray values As String()) As Boolean
        For Each value In values
            If str.Contains(value) Then
                Return True
                Exit Function
            End If
        Next
        Return False
    End Function

</script>

<asp:Label ID="LabelTagName" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelTagType" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelTagIncludeKeyword" runat="server" Text="" Visible="false"></asp:Label>


<asp:ListBox ID="ListBoxDrescption" runat="server" Visible="false"></asp:ListBox>
<asp:Label ID="LabelDrescption" runat="server" Text=""></asp:Label>