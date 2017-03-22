<%@ Control Language="VB" ClassName="BlogInListView" %>

<script runat="server">
    Public Property UserId() As String
        Get
            Return LabelUserId.Text
        End Get
        Set(ByVal value As String)
            LabelUserId.Text = value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return HyperLinkUsername.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUsername.Text = value
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUserName.Text = value
        End Set
    End Property





    Public Property BlogId() As String
        Get
            Return LabelBlogId.Text
        End Get
        Set(ByVal value As String)
            LabelBlogId.Text = value
        End Set
    End Property

    Public Property Heading() As String
        Get
            Return HyperLinkHeading.Text
        End Get
        Set(ByVal value As String)
            HyperLinkHeading.Text = value
        End Set
    End Property

    Public Property BlogImageId() As String
        Get
            Return LabelBlogImageID.Text
        End Get
        Set(ByVal value As String)
            LabelBlogImageID.Text = value
        End Set
    End Property

    Public Property BlogImageFileName() As String
        Get
            Return LabelBlogImageFileName.Text
        End Get
        Set(ByVal value As String)
            LabelBlogImageFileName.Text = value
        End Set
    End Property

    Public Property Highlight() As String
        Get
            Return LabelHighlight.Text
        End Get
        Set(ByVal value As String)
            LabelHighlight.Text = value
        End Set
    End Property

    Public Property PostDate() As String
        Get
            Return LabelPostDate.Text
        End Get
        Set(ByVal value As String)
            LabelPostDate.Text = ClassHostAnySite.HostAnySite.ConvertDateTime4Use(value)
        End Set
    End Property


    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkUsername.NavigateUrl = "~/user/" & RoutUserName
        HyperLinkHeading.NavigateUrl = "~/blog/" & BlogId & "/" & ClassHostAnySite.HostAnySite.ConvertSpace2Dass(Heading)
        Panelpostimage.Visible = CBool(BlogImageId)
        PostImage.ImageUrl = "~/storage/image/" & BlogImageFileName
    End Sub




</script>

<asp:Label ID="LabelUserId" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="false"></asp:Label>

<asp:Label ID="LabelBlogId" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelBlogImageID" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelBlogImageFileName" runat="server" Text="" Visible="false"></asp:Label>

<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 thumb">
    <div class="panel panel-default">
        <div class="panel-body" style="height: 360px; overflow: hidden;">
            <h4>
                <asp:HyperLink ID="HyperLinkHeading" runat="server"></asp:HyperLink>
            </h4>
            <asp:Panel ID="Panelpostimage" runat="server" CssClass="thumbnail" Style="border-style: none; margin: 2px;" >

                <asp:Image ID="PostImage" runat="server" Style="max-height: 160px;" />

            </asp:Panel>
            <asp:Label runat="server" ID="LabelHighlight" ></asp:Label> 
        </div>
        <div class="panel-footer clearfix ">
            <div class="pull-left">
                <small>
                    <asp:HyperLink ID="HyperLinkUsername" runat="server" CssClass="text-capitalize"></asp:HyperLink>
                    <br />
                    <span class="glyphicon glyphicon-time"></span>
                    <asp:Label ID="LabelPostDate" runat="server" Text=""></asp:Label>
                </small>
            </div>
            <div class="pull-right ">
                <asp:LinkButton ID="LinkButtonmore" runat="server" CssClass="btn btn-primary btn-block" Text="read more"></asp:LinkButton>
            </div>
        </div>
    </div>
</div>