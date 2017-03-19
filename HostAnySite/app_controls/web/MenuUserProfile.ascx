<%@ Control Language="VB" ClassName="MenuUserProfile" %>

<script runat="server">
    Public Property ImageFileName() As String
        Get
            Return LabelImageFileName.Text
        End Get
        Set(ByVal value As String)
            LabelImageFileName.Text = value
            ImageUserImage.ImageUrl = "~/storage/image/" & value
            ImageUserImage2.ImageUrl = "~/storage/image/" & value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return HyperLinkUserName.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUserName.Text = value
            HyperLinkuserName2.Text = value
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUserName.Text = value
            HyperLinkUserName.NavigateUrl = "~/user/" & value
            HyperLinkuserName2.NavigateUrl = "~/user/" & value

            HyperLinkFollower.NavigateUrl = "~/user/" & value & "/Follower/"
            HyperLinkFollowing.NavigateUrl = "~/user/" & value & "/Following/"

            HyperLinkFriend.NavigateUrl = "~/user/" & value & "/Friend/"
            HyperLinkFriendRQSent.NavigateUrl = "~/user/" & value & "/Friend/RequestSent"
            HyperLinkFriendRQReceived.NavigateUrl = "~/user/" & value & "/Friend/RequestReceived"

            HyperLinkBlog.NavigateUrl = "~/user/" & value & "/Blog/"

        End Set
    End Property

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)

    End Sub

</script>
<asp:Label ID="LabelImageFileName" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
<div class="sidebar-nav">
    <div class="navbar navbar-default" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#FC-sidebar-navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="pull-left visible-xs" style="padding: 10px">
                <asp:Image ID="ImageUserImage" runat="server" Height="30" />
            </a>
            <span class="visible-xs navbar-brand">
                <asp:HyperLink ID="HyperLinkUserName" CssClass=" text-capitalize " runat="server"></asp:HyperLink>
            </span>
        </div>
        <div class="navbar-collapse collapse" id="FC-sidebar-navbar-collapse" style="padding: 0px;">
            <div class="list-group" style="margin: 0px;">
                <div class="list-group-item hidden-xs">
                    <asp:Image ID="ImageUserImage2" runat="server" class="img-circle img-thumbnail" />
                </div>
                <asp:HyperLink ID="HyperLinkuserName2" cssclass="list-group-item hidden-xs text-capitalize" runat="server" Font-Bold="True"></asp:HyperLink>

                <asp:HyperLink ID="HyperLink1" CssClass="list-group-item" runat="server" NavigateUrl="~/dashboard/message/"><i class="fa fa-envelope-o" aria-hidden="true"></i>&nbsp;Message</asp:HyperLink>

                <a href="#GroupFollower" class="list-group-item Change-DropDown-Icon" data-toggle="collapse"><i class="fa fa-users" aria-hidden="true"></i>&nbsp;Follower<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
                <div class="collapse" id="GroupFollower" style="padding-left: 10px;">
                    <asp:HyperLink ID="HyperLinkFollower" runat="server" class="list-group-item" NavigateUrl="#">Followers</asp:HyperLink>
                    <asp:HyperLink ID="HyperLinkFollowing" runat="server" class="list-group-item" NavigateUrl="#">Following</asp:HyperLink>
                </div>

                <a href="#GroupFriend" class="list-group-item Change-DropDown-Icon" data-toggle="collapse"><i class="fa fa-users" aria-hidden="true"></i>&nbsp;Friend<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
                <div class="collapse" id="GroupFriend" style="padding-left: 10px;">
                    <asp:HyperLink ID="HyperLinkFriend" runat="server" class="list-group-item" NavigateUrl="#">Friends</asp:HyperLink>
                    <asp:HyperLink ID="HyperLinkFriendRQSent" runat="server" class="list-group-item" NavigateUrl="#">Request Sent</asp:HyperLink>
                    <asp:HyperLink ID="HyperLinkFriendRQReceived" runat="server" class="list-group-item" NavigateUrl="#">Request Received</asp:HyperLink>
                </div>

                <asp:HyperLink ID="HyperLinkBlog" CssClass="list-group-item" runat="server" NavigateUrl="#"><i class="fa fa-book" aria-hidden="true"></i>&nbsp;Blog</asp:HyperLink>
            </div>
        </div>
    </div>
</div>
