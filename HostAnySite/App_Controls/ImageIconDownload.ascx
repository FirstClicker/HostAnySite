<%@ Control Language="VB" ClassName="ImageIconDownload" %>

<script runat="server">
    Public Property ImageFileName() As String
        Get
            Return LabelImagefilename.Text
        End Get
        Set(ByVal value As String)
            LabelImagefilename.Text = value
        End Set
    End Property

    Public Property IconSizes() As String
        Get
            Return LabelImageSizes.Text
        End Get
        Set(ByVal value As String)
            LabelImageSizes.Text = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Sizes As String() = IconSizes.Split(",")
        Dim r As Integer
        For r = 0 To Sizes.Length - 1
            LabelViewer.Text = LabelViewer.Text & "<A HREF=""" & ResolveUrl("~/download/icon.aspx?Imagefilename=" & ImageFileName & "&resolution=" & Trim(Sizes(r)) & "") & """>" & Sizes(r) & "</A> , "
        Next
    End Sub

</script>

    <asp:Label ID="LabelImagefilename" runat="server" Visible="False" />
 <asp:Label ID="LabelImageSizes" runat="server" Visible="False" />

<div class="card mt-2 mb-2 ">
    <div class="card-header">
        Download As Icon File
    </div>
    <div class="list-group">
        <div class=" list-group-item ">
            <i class="fa fa-tags"></i>&nbsp;Popular Format:&nbsp;
                            <hr class="m-1" />
            <asp:Label ID="LabelViewer" runat="server" Text=""></asp:Label>
        </div>
    </div>
</div> 
