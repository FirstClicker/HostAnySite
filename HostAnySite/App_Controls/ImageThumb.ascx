<%@ Control Language="VB" ClassName="ImageSmallThumb" %>

<script runat="server">
    ' version 09/05/2019 # 4.27 AM


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

    Public Property ImageId() As String
        Get
            Return LabelBlogImageID.Text
        End Get
        Set(ByVal value As String)
            LabelBlogImageID.Text = value
        End Set
    End Property

    Public Property ImageName() As String
        Get
            Return HyperLinkHeading.Text
        End Get
        Set(ByVal value As String)
            HyperLinkHeading.Text = value
        End Set
    End Property

    Public Property ImageFileName() As String
        Get
            Return LabelBlogImageFileName.Text
        End Get
        Set(ByVal value As String)
            LabelBlogImageFileName.Text = value
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


    Public Property ShowUserPanel() As Boolean
        Get
            Return PanelUserDetails.Visible
        End Get
        Set(ByVal value As Boolean)
            PanelUserDetails.Visible = value
        End Set
    End Property


    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkUsername.NavigateUrl = "~/user/" & RoutUserName
        HyperLinkHeading.NavigateUrl = "~/image/" & FirstClickerService.Common.ConvertSpace2Dass(ImageName) & "/" & ImageId
        HyperLinkImage.NavigateUrl = "~/image/" & FirstClickerService.Common.ConvertSpace2Dass(ImageName) & "/" & ImageId

        If IO.File.Exists(Server.MapPath("~/storage/Thumb/" & ImageFileName)) = False Then
            Try
                FirstClickerService.Version1.Image.ImageResize_withCompression(Server.MapPath("~/storage/Image/" & ImageFileName), Server.MapPath("~/storage/Thumb/" & ImageFileName), 400, 400, 75)
            Catch ex As Exception
                'report fail
            End Try
        End If
        PostImage.ImageUrl = "~/storage/Thumb/" & ImageFileName

        'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        Dim Cusertype As New FirstClickerService.Version1.User.UserType
        Try
            Cusertype = [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Trim(Session("UserType")), True)
            If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
                LIActionDelete.Visible = True
                LIActionEdit.Visible = True
            End If
        Catch ex As Exception
        End Try

        If Val(UserId) > 10 And Val(UserId) = Val(Session("UserID")) Then
            LIActionDelete.Visible = True
            LIActionEdit.Visible = True
        End If
        'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)
        If FirstClickerService.Version1.Image.ImageForcedDelete_BYID(ImageId, WebAppSettings.DBCS).Result = True Then
            Me.Visible = False
        End If
    End Sub

    Protected Sub LinkButtonReport_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/ReportImage.aspx?Imageid=" & ImageId)
    End Sub

    Protected Sub LinkButtonEdit_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/Dashboard/Image/Edit.aspx?Imageid=" & ImageId)
    End Sub
</script>

<asp:Label ID="LabelUserId" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="false"></asp:Label>

<asp:Label ID="LabelBlogId" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelBlogImageID" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelBlogImageFileName" runat="server" Text="" Visible="false"></asp:Label>

<div class="card mb-3 BoxEffect2">

    <div class="row">
        <div class="col-12">
            <div class="list-group-item" style="height: 200px;">
                <asp:Panel ID="Panelpostimage" runat="server">
                    <asp:HyperLink ID="HyperLinkImage" runat="server">
                        <asp:Image ID="PostImage" runat="server" CssClass="imgFitinDiv" />
                    </asp:HyperLink>
                    <div runat="server" id="DivTask" class="dropdown float-right">
                        <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fas fa-cog"></i></a>
                        <ul class="dropdown-menu dropdown-menu-right">
                            <li runat="server" id="LIActionEdit" class="dropdown-item" visible="false">
                                <i class="far fa-edit"></i>&nbsp;<asp:LinkButton ID="LinkButtonEdit" runat="server" OnClick="LinkButtonEdit_Click"><small>Edit Image</small></asp:LinkButton>
                            </li>
                            <li runat="server" id="LIActionDelete" class="dropdown-item" visible="false">
                                <i class="far fa-trash-alt"></i>&nbsp;<asp:LinkButton ID="LinkButtonDelete" runat="server" OnClick="LinkButtonDelete_Click"><small>Delete</small></asp:LinkButton>
                            </li>
                             <li runat="server" id="LIActionReport" class="dropdown-item" visible="false">
                                <i class="far fa-flag"></i>&nbsp;<asp:LinkButton ID="LinkButtonReport" runat="server" OnClick="LinkButtonReport_Click"><small>Report</small></asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>

    <div class="list-group-item pt-1 pb-1 align-middle" style="height: 50px; overflow :hidden ">
        <asp:HyperLink ID="HyperLinkHeading" CssClass ="text-capitalize" runat="server"></asp:HyperLink>
    </div>
    <asp:panel ID="PanelUserDetails" runat="server"  cssclass="list-group-item pt-1 pb-1 clearfix">
        <div class="float-left">
            <small>
                <i class="fas fa-user-circle"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUsername" runat="server" CssClass="text-capitalize"></asp:HyperLink>
                <br />
                <i class="far fa-calendar-alt"></i>&nbsp;<asp:Label ID="LabelPostDate" runat="server" Text=""></asp:Label>
            </small>
        </div>
        <div class="float-right ">
        </div>
    </asp:panel>


</div>


