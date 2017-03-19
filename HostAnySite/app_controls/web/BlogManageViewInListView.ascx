<%@ Control Language="VB" ClassName="BlogManageViewInListView" %>

<script runat="server">

    Public Property UserId() As String
        Get
            Return LabelUserId.Text
        End Get
        Set(ByVal value As String)
            LabelUserId.Text = value
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

    Public Property ShowinHome() As String
        Get
            Return LabelShowInHome.Text
        End Get
        Set(ByVal value As String)
            LabelShowInHome.Text = value
        End Set
    End Property

    Public Property Heading() As String
        Get
            Return HyperLinkBlogHeading.Text
        End Get
        Set(ByVal value As String)
            HyperLinkBlogHeading.Text = value
        End Set
    End Property

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            HyperLinkBlogHeading.NavigateUrl = "~/blog/" & BlogId & "/" & ClassHostAnySite.HostAnySite.ConvertSpace2Dass(Heading)


            Dim Cusertype As New ClassHostAnySite.User.UserType
            Try
                Cusertype = [Enum].Parse(GetType(ClassHostAnySite.User.UserType), Trim(Session("UserType")), True)
                If Cusertype = ClassHostAnySite.User.UserType.Administrator Or Cusertype = ClassHostAnySite.User.UserType.Moderator Then
                    LIActionFeatured.Visible = True
                    LIActionDelete.Visible = True
                End If
            Catch ex As Exception

            End Try

            If Val(UserId) > 10 And Val(UserId) = Val(Session("UserID")) Then
                LIActionDelete.Visible = True
            End If
        End If
    End Sub



    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)
        ClassHostAnySite.Blog.Blog_Delete(BlogId, ClassAppDetails.DBCS)
        PanelContainer.Visible = False
        Me.Visible = False
    End Sub

    Protected Sub LinkButtonFeatured_Click(sender As Object, e As EventArgs)
        If ShowinHome.ToLower = "yes" Then
            ClassHostAnySite.Blog.Blog_ShowinHome(BlogId, ClassHostAnySite.Blog.ShowInHomeEnum.No, ClassAppDetails.DBCS)
        Else
            ClassHostAnySite.Blog.Blog_ShowinHome(BlogId, ClassHostAnySite.Blog.ShowInHomeEnum.Yes, ClassAppDetails.DBCS)
        End If
    End Sub
</script>

<asp:Label ID="LabelUserId" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelBlogId" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelShowInHome" runat="server" Text="" Visible="false"></asp:Label>
<asp:panel runat ="server" ID="PanelContainer" cssclass="list-group-item">
    <div class="dropdown pull-right">
        <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
        <ul class="dropdown-menu">
            <li runat="server" id="LIActionFeatured" visible="false">
                <asp:LinkButton ID="LinkButtonFeatured" runat="server" OnClick ="LinkButtonFeatured_Click"><small>Show In Home</small></asp:LinkButton>
            </li>
            <li runat="server" id="LIActionDelete" visible="false">
                <asp:LinkButton ID="LinkButtonDelete" OnClick="LinkButtonDelete_Click" OnClientClick="return confirm('You can not recover it back!! Are you sure you want to delete? ');" runat="server"><small>Delete</small></asp:LinkButton>
            </li>
            <li runat="server" id="LIActionReport">
                <asp:LinkButton ID="LinkButtonReport" runat="server"><small>Report</small> </asp:LinkButton>
            </li>
        </ul>
    </div>
    <h4 class="list-group-item-heading">
        <asp:HyperLink ID="HyperLinkBlogHeading" runat="server"></asp:HyperLink>
    </h4>
    <p class="list-group-item-text">
    </p>
</asp:panel>
