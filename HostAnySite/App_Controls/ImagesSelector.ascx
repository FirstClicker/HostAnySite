<%@ Control Language="VB" ClassName="ImagesSelector" %>

<script runat="server">
    Public Property ImageURL As List(Of String)
        Get
            Dim arr As New List(Of String)
            For i As Integer = 0 To ListBoxImageURL.Items.Count - 1
                arr.Add(ListBoxImageURL.Items(i).ToString())
            Next
            Return arr
        End Get
        Set(ByVal value As List(Of String))
            For i As Integer = 0 To value.Count - 1
                ListBoxImageURL.Items.Add(value(i).ToString())
            Next
            PostImage.ImageUrl = ListBoxImageURL.Items(0).ToString
            ButtonCount.Text = value.Count
        End Set
    End Property

    Public Property SelectedImageURL() As String
        Get
            Return PostImage.ImageUrl
        End Get
        Set(ByVal value As String)
            PostImage.ImageUrl = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Buttonpre_Click(sender As Object, e As EventArgs)
        If ListBoxImageURL.SelectedIndex >= 1 Then
            ListBoxImageURL.SelectedIndex = ListBoxImageURL.SelectedIndex - 1
            PostImage.ImageUrl = ListBoxImageURL.Items(ListBoxImageURL.SelectedIndex).ToString
        End If
    End Sub

    Protected Sub Buttonnext_Click(sender As Object, e As EventArgs)
        If ListBoxImageURL.Items.Count > ListBoxImageURL.SelectedIndex + 1 Then
            ListBoxImageURL.SelectedIndex = ListBoxImageURL.SelectedIndex + 1
            PostImage.ImageUrl = ListBoxImageURL.Items(ListBoxImageURL.SelectedIndex).ToString
        End If
    End Sub

    Protected Sub ListBoxImageURL_SelectedIndexChanged(sender As Object, e As EventArgs)
        PostImage.ImageUrl = ListBoxImageURL.Items(ListBoxImageURL.SelectedIndex).ToString
    End Sub
</script>


<asp:ListBox ID="ListBoxImageURL" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="ListBoxImageURL_SelectedIndexChanged"></asp:ListBox>
<div class="card">
    <div class="list-group-item p-1" style="height: 100px;">
        <asp:Panel ID="Panelpostimage" runat="server">
            <asp:Image ID="PostImage" runat="server" CssClass="img-fluid img-thumbnail" ImageUrl="~/Content/Image/image-not-found.png" />
        </asp:Panel>
    </div>
     <div class="list-group-item p-0 m-0 clearfix" >
          <div class="btn-group btn-sm m-0 float-right">
            <asp:Button ID="Buttonpre" CssClass="btn btn-sm btn-info" runat="server" Text="<" OnClick="Buttonpre_Click" /><asp:Button ID="ButtonCount" CssClass ="btn btn-sm"  runat="server" Text="0" Enabled="false" /><asp:Button ID="Buttonnext" CssClass="btn btn-sm btn-info" runat="server" Text=">" OnClick="Buttonnext_Click" />
        </div>
     </div>
</div>

