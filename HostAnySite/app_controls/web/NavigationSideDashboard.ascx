<%@ Control Language="VB" ClassName="NavigationSideDashboard" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Trim(UCase(Session("Usertype"))) = "ADMINISTRATOR" Or Trim(UCase(Session("Usertype"))) = "MODERATOR" Then
            hyperlinkadmins.Visible = True
        Else
            hyperlinkadmins.Visible = False
        End If


    End Sub
</script>


<div class="sidebar-nav">
    <div class="navbar navbar-default" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#FC-sidebar-navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

                <asp:HyperLink ID="HyperLink7" NavigateUrl="~/Dashboard/" CssClass ="navbar-brand visible-xs" runat="server"><i class="fa fa-dashboard" aria-hidden="true"></i>&nbsp;Dashboard</asp:HyperLink>

        </div>

        <div class="navbar-collapse collapse" id="FC-sidebar-navbar-collapse" style="padding: 0px;">
            <div class="list-group panel-default" style="margin: 0px;">
                <div class="hidden-xs list-group-item">
                    <strong>
                        <asp:HyperLink ID="HyperLink8" NavigateUrl="~/Dashboard/" runat="server"><i class="fa fa-dashboard" aria-hidden="true"></i>&nbsp;Dashboard</asp:HyperLink></strong>
                </div>

                <a href="#Blog" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" data-parent="#MainMenu"><i class="fa fa-book" aria-hidden="true"></i>&nbsp;Blog Board<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
                <div class="collapse" id="Blog" style="padding-left: 10px">
                    <!--   <asp:HyperLink ID="HyperLink4" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/BlogBoard/BlogBoard.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;Blog Board</asp:HyperLink> -->
                    <asp:HyperLink ID="HyperLink2" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/BlogBoard/myBlogs.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;My Blogs</asp:HyperLink>
                    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/BlogBoard/Blog-Submit.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;Submit Blog</asp:HyperLink>
                </div>

                <a href="#Forum" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" data-parent="#MainMenu"><i class="fa fa-book" aria-hidden="true"></i>&nbsp;Forum Board<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
                <div class="collapse" id="Forum" style="padding-left: 10px">
                   <!--    <asp:HyperLink ID="HyperLink5" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/ForumBoard/ForumBoard.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;My Board</asp:HyperLink> -->
                    <asp:HyperLink ID="HyperLink3" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/ForumBoard/Forum.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;My Forum</asp:HyperLink>
                </div>


                <a href="#Settings" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" data-parent="#MainMenu"><span class="glyphicon glyphicon-wrench"></span>&nbsp;Settings<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
                <div class="collapse" id="Settings" style="padding-left: 10px">
                    <asp:HyperLink ID="HyperLinkss" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Settings/ProfileDetails.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;Profile Details</asp:HyperLink>
                </div>


                 

                <asp:HyperLink runat="server" ID="hyperlinkInbox" NavigateUrl="~/dashboard/Message/" class="list-group-item" data-parent="#MainMenu"><span class="glyphicon glyphicon-envelope"></span> Inbox</asp:HyperLink>


                <asp:HyperLink runat="server" ID="hyperlinkadmins" NavigateUrl="~/adminpanel/" CssClass="list-group-item" data-parent="#MainMenu" Visible="False"><span class="glyphicon glyphicon-tower"></span>&nbsp;Admin Panel</asp:HyperLink>
            </div>

        </div>
    </div>
    <!--/.nav-collapse -->
</div>
