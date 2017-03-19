<%@ Control Language="VB" ClassName="NavigationSideAdmin" %>

<script runat="server">

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
            <span class="visible-xs navbar-brand">
                <asp:HyperLink ID="HyperLink4" NavigateUrl="~/adminPanel/" runat="server"><i class="fa fa-user-secret" aria-hidden="true"></i>&nbsp;Admin Panel</asp:HyperLink>
            </span>
        </div>

        <div class="navbar-collapse collapse" id="FC-sidebar-navbar-collapse" style="padding: 0px;">
            <div class="list-group panel-default" style="margin: 0px;">
                <div class="hidden-xs panel-heading">
                    <strong>Admin Panel</strong>
                </div>
            </div>


            <a href="#User" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" data-parent="#MainMenu"><span class="glyphicon glyphicon-user"></span>&nbsp;User<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
            <div class="collapse" id="User" style ="padding-left :10px">
                <asp:HyperLink ID="HyperLink11" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/user/List.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;List</asp:HyperLink>
            </div>

            <a href="#Blog" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" data-parent="#MainMenu"><span class="glyphicon glyphicon-file"></span>&nbsp;Blog<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
            <div class="collapse" id="Blog" style ="padding-left :10px">
                <asp:HyperLink ID="HyperLink7" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/blog/list.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;List</asp:HyperLink>
            </div>

            <a href="#Content" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" data-parent="#MainMenu"><span class="glyphicon glyphicon-file"></span>&nbsp;Content<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
            <div class="collapse" id="Content" style ="padding-left :10px">
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Content/text.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;Text</asp:HyperLink>
                <asp:HyperLink ID="HyperLink3" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Content/image.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;Images</asp:HyperLink>
                    <asp:HyperLink ID="HyperLink5" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Content/Defaultimage.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;Default Pictures</asp:HyperLink>
            </div>

            <a href="#Setting" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" data-parent="#MainMenu"><span class="glyphicon glyphicon-file"></span>&nbsp;Setting<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
            <div class="collapse" id="Setting" style ="padding-left :10px">
                <asp:HyperLink ID="HyperLink2" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Setting/email.aspx"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;Email</asp:HyperLink>
                <asp:HyperLink ID="HyperLink6" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Setting/Theme.aspx"><i class="fa fa-css3" aria-hidden="true"></i>&nbsp;Theme</asp:HyperLink>
            </div>

             <a href="#Errors" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" data-parent="#MainMenu"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;Errors<i class="glyphicon glyphicon-chevron-right pull-right"></i></a>
                <div class="collapse" id="Errors" style="padding-left: 10px">
                    <asp:HyperLink ID="HyperLinkError" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Error/"><i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>&nbsp;List</asp:HyperLink>
                </div>

            <asp:HyperLink runat="server" ID="hyperlinkadmin" NavigateUrl="~/Dashboard/" class="list-group-item " data-parent="#MainMenu"><span class="glyphicon glyphicon-dashboard"></span>&nbsp;Dashboard</asp:HyperLink>

        </div>

    </div>
</div>
