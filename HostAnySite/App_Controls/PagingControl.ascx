<%@ Control Language="VB" ClassName="PagingControl" %>

<script runat="server">
    Public Property BaseURL() As String
        Get
            Return LabelBaseURL.Text
        End Get
        Set(ByVal value As String)
            LabelBaseURL.Text = value
        End Set
    End Property


    Public Property CurrentPage() As String
        Get
            Return LabelCurrentPage.Text
        End Get
        Set(ByVal value As String)
            LabelCurrentPage.Text = value
        End Set
    End Property


    Public Property LastPage() As String
        Get
            Return LabelLastPage.Text
        End Get
        Set(ByVal value As String)
            LabelLastPage.Text = value
        End Set
    End Property

    Protected Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        LinkButtonFirst.NavigateUrl = BaseURL & "/" & 1 & "/"

        LinkButtonPre.NavigateUrl = BaseURL & "/" & 2 & "/"
        LinkButtonPre.Text = 2

        LinkButtonCurr.NavigateUrl = BaseURL & "/" & 3 & "/"
        LinkButtonCurr.Text = 3

        LinkButtonNext.NavigateUrl = BaseURL & "/" & 4 & "/"
        LinkButtonNext.Text = 4


        LinkButtonLast.NavigateUrl = BaseURL & "/" & LastPage & "/"
        LinkButtonLast.Text = LastPage

        Select Case Val(LastPage)
            Case 1
                Me.Visible = False
            Case 2
                LinkButtonPre.Visible = False
                LinkButtonCurr.Visible = False
                LinkButtonNext.Visible = False

            Case 3
                LinkButtonCurr.Visible = False
                LinkButtonNext.Visible = False

            Case 4
                LinkButtonNext.Visible = False
        End Select


        Select Case Val(CurrentPage)

            Case >= 4
                If Val(LastPage) > 5 Then
                    If Val(LastPage) > Val(CurrentPage) + 1 Then
                        LinkButtonPre.NavigateUrl = BaseURL & "/" & Val(CurrentPage) - 1 & "/"
                        LinkButtonPre.Text = Val(CurrentPage) - 1

                        LinkButtonCurr.NavigateUrl = BaseURL & "/" & Val(CurrentPage) & "/"
                        LinkButtonCurr.Text = Val(CurrentPage)

                        LinkButtonNext.NavigateUrl = BaseURL & "/" & Val(CurrentPage) + 1 & "/"
                        LinkButtonNext.Text = Val(CurrentPage) + 1
                    ElseIf Val(LastPage) = Val(CurrentPage) + 1 Then
                        LinkButtonPre.NavigateUrl = BaseURL & "/" & Val(CurrentPage) - 2 & "/"
                        LinkButtonPre.Text = Val(CurrentPage) - 2

                        LinkButtonCurr.NavigateUrl = BaseURL & "/" & Val(CurrentPage) - 1 & "/"
                        LinkButtonCurr.Text = Val(CurrentPage) - 1

                        LinkButtonNext.NavigateUrl = BaseURL & "/" & Val(CurrentPage) & "/"
                        LinkButtonNext.Text = Val(CurrentPage)

                    ElseIf Val(LastPage) = Val(CurrentPage) Then
                        LinkButtonPre.NavigateUrl = BaseURL & "/" & Val(CurrentPage) - 3 & "/"
                        LinkButtonPre.Text = Val(CurrentPage) - 3

                        LinkButtonCurr.NavigateUrl = BaseURL & "/" & Val(CurrentPage) - 2 & "/"
                        LinkButtonCurr.Text = Val(CurrentPage) - 2

                        LinkButtonNext.NavigateUrl = BaseURL & "/" & Val(CurrentPage) - 1 & "/"
                        LinkButtonNext.Text = Val(CurrentPage) - 1
                    End If
                End If
        End Select
    End Sub

</script>

<asp:Label ID="LabelBaseURL" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelCurrentPage" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelLastPage" runat="server" Text="" Visible="False"></asp:Label>
<div class="btn-group btn-group-sm ">
    <asp:hyperlink CssClass="btn btn-sm btn-info" ID="LinkButtonFirst" runat="server">1</asp:hyperlink>
    <asp:hyperlink CssClass="btn btn-sm btn-info" ID="LinkButtonPre" runat="server"></asp:hyperlink>
    <asp:hyperlink CssClass="btn btn-sm btn-info" ID="LinkButtonCurr" runat="server"></asp:hyperlink>
    <asp:hyperlink CssClass="btn btn-sm btn-info" ID="LinkButtonNext" runat="server"></asp:hyperlink>
    <asp:hyperlink CssClass="btn btn-sm btn-info" ID="LinkButtonLast" runat="server"></asp:hyperlink>
</div>
