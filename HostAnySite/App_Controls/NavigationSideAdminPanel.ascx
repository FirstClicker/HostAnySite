<%@ Control Language="VB" ClassName="NavigationSideAdminPanel" EnableViewState="false" %>

<script runat="server">
    ' version 09/05/2019 # 8.15

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If
    End Sub
</script>


<nav class="navbar navbar-light border navbar-expand-lg mt-2 mb-2 p-0 BoxEffect1">
    <asp:HyperLink ID="HyperLink4" NavigateUrl="~/adminPanel/" CssClass="navbar-brand navbar-link d-md-none ml-2" runat="server"><i class="fas fa-user-secret" aria-hidden="true"></i>&nbsp;Admin Panel</asp:HyperLink>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarWEX" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="navbar-collapse collapse flex-column " id="navbarWEX">
        <div class="list-group w-100">

            <div class="list-group-item list-group-item-dark font-weight-bold d-none d-md-block">
                <asp:HyperLink ID="HyperLink8" NavigateUrl="~/adminPanel/" runat="server"><i class="fas fa-user-secret" aria-hidden="true"></i>&nbsp;Admin Panel</asp:HyperLink>
            </div>


            <a href="#GroupAdminUser" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" ><i class="far fa-address-book"></i>User<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse" id="GroupAdminUser" style="padding-left: 10px">
                <asp:HyperLink ID="HyperLink11" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/user/ListOfUsers.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;User List</asp:HyperLink>
            </div>

            <a href="#GroupAdminBlog" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" ><i class="fab fa-blogger"></i>&nbsp;Blog<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse pl-2" id="GroupAdminBlog" >
                <asp:HyperLink ID="HyperLink7" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/blog/ListOfBlogs.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Blog List</asp:HyperLink>
            </div>


            <a href="#GroupAdminImage" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" ><i class="far fa-images"></i>&nbsp;Image<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse pl-2" id="GroupAdminImage" >
                <asp:HyperLink ID="HyperLink16" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/image/DeleteImage.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Delete Image</asp:HyperLink>
                <asp:HyperLink ID="HyperLink14" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/image/DeleteTempImage.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Delete Temp Image</asp:HyperLink>
                <asp:HyperLink ID="HyperLink17" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/image/AddTagToImageByName.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Add Tag By Searching Name</asp:HyperLink>
                <asp:HyperLink ID="HyperLink18" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/image/TagSeoForImage.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Tag Seo For Image</asp:HyperLink>
            </div>
            
            <a href="#GroupTags" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" ><i class="fas fa-tags"></i>&nbsp;Tags<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse" id="GroupTags" style="padding-left: 10px">
                <asp:HyperLink ID="HyperLink12" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/tags/editTag.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Edit Tag</asp:HyperLink>
            </div>

            <a href="#GroupAdminSysEmail" class="list-group-item Change-DropDown-Icon" data-toggle="collapse"><i class="far fa-envelope"></i>&nbsp;System Emails<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse pl-2" id="GroupAdminSysEmail" >
                <asp:HyperLink ID="HyperLink2" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Emails/EmailDetails.aspx"><i class="fas fa-at"></i>&nbsp;Email Details</asp:HyperLink>
                 <asp:HyperLink ID="HyperLink3" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Emails/EmailQueue.aspx"><i class="fas fa-hourglass-end"></i>&nbsp;Email Uueue</asp:HyperLink>
            </div>

            <a href="#GroupAdminSettings" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" ><i class="fa fa-cogs" aria-hidden="true"></i>&nbsp;Setting<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse pl-2" id="GroupAdminSettings">
                <asp:HyperLink ID="HyperLink13" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Settings/General.aspx"><i class="fas fa-cog"></i>&nbsp;General Setting</asp:HyperLink>
                <asp:HyperLink ID="HyperLink6" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Settings/Theme.aspx"><i class="fas fa-palette"></i>&nbsp;Theme</asp:HyperLink>
                <asp:HyperLink ID="HyperLink10" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Settings/UserSignIn.aspx"><i class="fas fa-user-md"></i>&nbsp;User SignIn</asp:HyperLink>
                <asp:HyperLink ID="HyperLink9" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Settings/ReCaptcha.aspx"><i class="far fa-check-square"></i>&nbsp;ReCaptcha</asp:HyperLink>
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Settings/StaticPage.aspx"><i class="far fa-file-alt"></i>&nbsp;Static Page</asp:HyperLink>
            </div>

            
             <a href="#GroupAdminErrors" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" ><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;Errors<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse pl-2" id="GroupAdminErrors" >
                <asp:HyperLink ID="HyperLink5" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Errors/"><i class="fas fa-arrow-circle-right"></i>&nbsp;All Errors</asp:HyperLink>
                <asp:HyperLink ID="HyperLink15" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/Errors/GroupBy.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Group By</asp:HyperLink>
            </div>

            <a href="#GroupAdminContactUs" class="list-group-item Change-DropDown-Icon" data-toggle="collapse" ><i class="far fa-envelope"></i>&nbsp;Contact Us<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse pl-2" id="GroupAdminContactUs" >
                <asp:HyperLink ID="HyperLinkError" runat="server" CssClass="list-group-item" NavigateUrl="~/AdminPanel/ContactUs/feedback.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Message</asp:HyperLink>
            </div>

            <asp:HyperLink runat="server" ID="hyperlinkadmin" NavigateUrl="~/Dashboard/" class="list-group-item " data-parent="#MainMenu"><i class="fas fa-home fa-fw"></i>&nbsp;Dashboard</asp:HyperLink>

        </div>
    </div>
</nav>
