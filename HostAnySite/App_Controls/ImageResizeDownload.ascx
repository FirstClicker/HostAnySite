<%@ Control Language="VB" ClassName="ImageResizeDownload" %>

<script runat="server">
    Public Property ImageFileName() As String
        Get
            Return LabelImagefilename.Text
        End Get
        Set(ByVal value As String)
            LabelImagefilename.Text = value
        End Set
    End Property

    Public Property ImageSizes() As String
        Get
            Return LabelImageSizes.Text
        End Get
        Set(ByVal value As String)
            LabelImageSizes.Text = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Sizes As String() = ImageSizes.Split(",")
        Dim r As Integer
        For r = 0 To Sizes.Length - 1
            LabelViewer.Text = LabelViewer.Text & "<A class=""btn btn-sm btn-outline-primary m-2"" HREF=""" & ResolveUrl("~/download/Image.aspx?Imagefilename=" & ImageFileName & "&resolution=" & Trim(Sizes(r)) & "") & """>" & Sizes(r) & "</A>"
        Next
    End Sub

</script>

 <asp:Label ID="LabelImagefilename" runat="server" Visible="False" />
 <asp:Label ID="LabelImageSizes" runat="server" Visible="False" />

<div class="card mt-2 mb-2 ">
    <div class="card-header">
        Download By Resolution
    </div>
    <div class="list-group">
        <div class=" list-group-item ">
            <i class="fa fa-tags"></i>&nbsp;Popular:&nbsp;
                            <hr class="m-1" />
            <asp:Label ID="LabelViewer" runat="server" Text=""></asp:Label>
        </div>
    </div>
</div> 
