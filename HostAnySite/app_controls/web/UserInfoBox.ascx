<%@ Control Language="VB" ClassName="UserInfoBox" %>
<%@ Register Src="~/app_controls/web/UserRelationStatusButton.ascx" TagPrefix="uc1" TagName="UserRelationStatusButton" %>


<script runat="server">
    Public Property UserName() As String
        Get
            Return HyperLinkUserName.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUserName.Text = value
            UserRelationStatusButton.UserName = value
        End Set
    End Property

    Public Property UserType() As String
        Get
            Return LabelUserType.Text
        End Get
        Set(ByVal value As String)
            LabelUserType.Text = value

            If Trim(value) = "" Then
                LabelUserType.Visible = False
            Else
                LabelUserType.Visible = True
            End If
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUserName.Text = value
            HyperLinkUserName.NavigateUrl = "~/User/" & ClassHostAnySite.HostAnySite.ConvertSpace2Dass(value)
            UserRelationStatusButton.RoutUserName = value
        End Set
    End Property

    Public Property UserId() As String
        Get
            Return LabelUserId.Text
        End Get
        Set(ByVal value As String)
            LabelUserId.Text = value
            UserRelationStatusButton.UserID = value
        End Set
    End Property

    Public Property ImageFileName() As String
        Get
            Return ImageUserImage.AlternateText
        End Get
        Set(ByVal value As String)
            ImageUserImage.AlternateText = value
            ImageUserImage.ImageUrl = "~/storage/image/" & value
        End Set
    End Property



    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub

</script>




<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
    <asp:Label ID="LabelUserId" runat="server" Text="" Visible="False"></asp:Label>
    <asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
    <asp:Label ID="LabelUserType" runat="server" Text="User" Visible ="false" ></asp:Label>

    <div class="well well-sm clearfix">
        <div class="media">
            <asp:HyperLink ID="imagehyp" runat="server" CssClass="media-left">
                <asp:Image ID="ImageUserImage" runat="server" CssClass="media-object" Height="40" Width="30" />
            </asp:HyperLink>

            <div class="media-body">
                <h4 class="media-heading">
                    <asp:HyperLink ID="HyperLinkUserName" CssClass="text-capitalize" runat="server">User Name</asp:HyperLink></h4>
                <p><span class="label label-info">0 Followers</span> <span class="label label-warning">0 Friends</span></p>
            </div>
        </div>
        <uc1:UserRelationStatusButton runat="server" ID="UserRelationStatusButton" />
    </div>
</div>

