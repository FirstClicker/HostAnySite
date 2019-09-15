<%@ Control Language="VB" ClassName="BlogPreviewInList" %>
<%@ Register Src="~/App_Controls/TagOfBlog.ascx" TagPrefix="uc1" TagName="TagOfBlog" %>


<script runat="server">
    ' version 26/06/2019 # 4.27 AM


    Public Property UserId() As String
        Get
            Return LabelUserId.Text
        End Get
        Set(ByVal value As String)
            LabelUserId.Text = value
            TagOfBlog.BlogUserId = Val(value)
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
            TagOfBlog.BlogId = Val(value)
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
            LabelPostDate.Text = FirstClickerService.Common.ConvertDateTime4Use(value)
        End Set
    End Property

    Public Property ShowBlogBody() As Boolean
        Get
            Return PanelblogBody.Visible
        End Get
        Set(ByVal value As Boolean)
            PanelblogBody.Visible = value
        End Set
    End Property


    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkUsername.NavigateUrl = "~/user/" & RoutUserName
        HyperLinkHeading.NavigateUrl = "~/blog/" & FirstClickerService.Common.ConvertSpace2Dass(Heading) & "/" & BlogId
        HyperLinkmore.NavigateUrl = HyperLinkHeading.NavigateUrl

        Panelpostimage.Visible = CBool(BlogImageId)
        PostImage.ImageUrl = "~/storage/image/" & BlogImageFileName

        'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        Dim Cusertype As New FirstClickerService.Version1.User.UserType
        Try
            Cusertype = [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Trim(Session("UserType")), True)
            If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
                LIActionDelete.Visible = True
            End If
        Catch ex As Exception
        End Try

        If Val(UserId) > 10 And Val(UserId) = Val(Session("UserID")) Then
            LIActionDelete.Visible = True
        End If
        'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

    End Sub


    Protected Sub LinkButtonmore_Click(sender As Object, e As EventArgs)
        Response.Redirect(HyperLinkHeading.NavigateUrl)
    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)
        Dim deleteblog As FirstClickerService.Version1.Blog.StructureBlog = FirstClickerService.Version1.Blog.Blog_DeleteByBlogID(BlogId, WebAppSettings.DBCS)
        If deleteblog.Result = True Then
            Me.Visible = False
        End If


    End Sub
</script>

<asp:Label ID="LabelUserId" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="false"></asp:Label>

<asp:Label ID="LabelBlogId" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelBlogImageID" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelBlogImageFileName" runat="server" Text="" Visible="false"></asp:Label>


<div class="card BoxEffect6 mb-2 mt-1">
    <div class="card-body">
        <div class="row">
            <div class="col-12">
            
                <div class="dropdown float-right">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li runat="server" id="LIActionFeatured" class="dropdown-item" visible="false">
                            <asp:LinkButton ID="LinkButtonFeatured" runat="server"><small>Featured</small></asp:LinkButton>
                        </li>
                        <li runat="server" id="LIActionDelete" class="dropdown-item" visible="false">
                            <asp:LinkButton ID="LinkButtonDelete" OnClick="LinkButtonDelete_Click" runat="server"><small>Delete</small></asp:LinkButton>
                        </li>
                        <li runat="server" id="LIActionReport" class="dropdown-item">
                            <asp:LinkButton ID="LinkButtonReport" runat="server"><small>Report</small> </asp:LinkButton>
                        </li>
                    </ul>
                </div>
                    <h4>
                    <asp:HyperLink ID="HyperLinkHeading" runat="server"></asp:HyperLink>
                </h4>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 border-top border-bottom">
                <i class="fas fa-user-circle"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUsername" runat="server" CssClass="text-capitalize"></asp:HyperLink>
                &nbsp;|&nbsp;<i class="far fa-calendar-alt"></i>&nbsp;<asp:Label ID="LabelPostDate" runat="server" Text=""></asp:Label>
                &nbsp;|&nbsp;<i class="far fa-comments"></i><a href="#">&nbsp;3 Comments</a>
            </div>
        </div>
        <asp:Panel runat="server" ID="PanelblogBody" CssClass="row">
            <div class="col-md-12">
                <asp:Panel ID="Panelpostimage" runat="server" CssClass="text-center m-2">
                    <asp:Image ID="PostImage" runat="server" CssClass="img-fluid" />
                </asp:Panel>
            </div>
            <div class="col-12">
                <p>
                    <asp:Label runat="server" CssClass="text-muted" ID="LabelHighlight"></asp:Label>
                </p>

                <div>
                    <div class="float-left">
                        <uc1:TagOfBlog runat="server" ID="TagOfBlog" />
                    </div>

                    <asp:HyperLink ID="HyperLinkmore" runat="server" CssClass="btn btn-sm btn-primary float-right">read more</asp:HyperLink>
                </div>
            </div>
        </asp:Panel>
    </div>

</div>
