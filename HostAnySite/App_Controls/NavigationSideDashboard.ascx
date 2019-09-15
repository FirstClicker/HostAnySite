<%@ Control Language="VB" ClassName="NavigationSideDashboard" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Trim(UCase(Session("Usertype"))) = "ADMINISTRATOR" Or Trim(UCase(Session("Usertype"))) = "MODERATOR" Then
            hyperlinkadmins.Visible = True
        Else
            hyperlinkadmins.Visible = False
        End If

        PanelForum.Visible = WebAppSettings.HasApp_Forum_IsEnabled
        PanelBlog.Visible = WebAppSettings.HasApp_Blog_IsEnabled
        PanelQuestion.Visible = WebAppSettings.HasApp_Question_IsEnabled
        PanelCompare.Visible = WebAppSettings.HasApp_CompareList_IsEnabled

    End Sub
</script>


<nav class="navbar navbar-light border navbar-expand-md mt-2 mb-2 p-0 BoxEffect1">
    <asp:HyperLink ID="HyperLink8" CssClass="navbar-brand navbar-link d-md-none ml-2" NavigateUrl="~/Dashboard/" runat="server"><i class="fas fa-home fa-fw"></i>&nbsp;Dashboard</asp:HyperLink>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarWEX" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="navbar-collapse collapse flex-column " id="navbarWEX">
        <div class="list-group w-100">
            <div class="list-group-item list-group-item-dark font-weight-bold d-none d-md-block">
                <asp:HyperLink ID="HyperLink5" NavigateUrl="~/Dashboard/" runat="server"><i class="fas fa-home fa-fw"></i>&nbsp;Dashboard</asp:HyperLink>
            </div>

            <div class="list-group-item">
                <i class="far fa-envelope"></i>&nbsp;<asp:HyperLink runat="server" ID="hyperlinkInbox" NavigateUrl="~/dashboard/Inbox.aspx">Inbox</asp:HyperLink>
            </div>


            <asp:panel runat ="server" ID="PanelBlog" cssclass="list-group-item">
                <i class="fab fa-blogger"></i>&nbsp;<a href="#BlogGroup" class="Change-DropDown-Icon" data-toggle="collapse">Blogs<i class="fa fa-chevron-circle-down float-right"></i></a>
            </asp:panel>
            <div class="collapse pl-2" id="BlogGroup">
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Blog/Write.aspx"><i class="far fa-edit"></i>&nbsp;Write Blog</asp:HyperLink>
                <asp:HyperLink ID="HyperLink2" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Blog/MyBlogs.aspx"><i class="far fa-list-alt"></i>&nbsp;My Blogs</asp:HyperLink>
            </div>

            <asp:panel runat ="server" ID="PanelForum" cssclass="list-group-item">
                <i class="fab fa-foursquare"></i>&nbsp;<a href="#ForumGroup" class="Change-DropDown-Icon" data-toggle="collapse">Forum<i class="fa fa-chevron-circle-down float-right"></i></a>
            </asp:panel>
            <div class="collapse pl-2" id="ForumGroup">
                <asp:HyperLink ID="HyperLink4" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Forum/Create.aspx"><i class="far fa-edit"></i>&nbsp;Create Forum</asp:HyperLink>
                <asp:HyperLink ID="HyperLink3" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Forum/MyForums.aspx"><i class="far fa-list-alt"></i>&nbsp;My Forums</asp:HyperLink>
            </div>

            <asp:panel runat ="server" ID="PanelCompare" cssclass="list-group-item">
                <i class="fa fa-balance-scale" aria-hidden="true"></i>&nbsp;<a href="#CompareGroup" class="Change-DropDown-Icon" data-toggle="collapse">Compare<i class="fa fa-chevron-circle-down float-right"></i></a>
            </asp:panel>
            <div class="collapse pl-2" id="CompareGroup">
                <asp:HyperLink ID="HyperLink6" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Compare/CreateList.aspx"><i class="far fa-edit"></i>&nbsp;Create Compare</asp:HyperLink>
                <asp:HyperLink ID="HyperLink9" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Compare/MyCompareList.aspx"><i class="far fa-list-alt"></i>&nbsp;My Compare List</asp:HyperLink>

            </div>

            <asp:panel runat ="server" ID="PanelQuestion" cssclass="list-group-item">
                <i class="fas fa-question"></i>&nbsp;<a href="#QuestionGroup" class="Change-DropDown-Icon" data-toggle="collapse">Question<i class="fa fa-chevron-circle-down float-right"></i></a>
            </asp:panel>
            <div class="collapse pl-2" id="QuestionGroup">
                <asp:HyperLink ID="HyperLink7" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Question/ask.aspx"><i class="far fa-edit"></i>&nbsp;Ask Question</asp:HyperLink>
                <asp:HyperLink ID="HyperLink10" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Question/MyQuestions.aspx"><i class="far fa-list-alt"></i>&nbsp;My Questions</asp:HyperLink>

            </div>

            <div class="list-group-item">
                <i class="fas fa-cogs"></i>&nbsp;<a href="#Settings" class="Change-DropDown-Icon" data-toggle="collapse">Settings<i class="fa fa-chevron-circle-down float-right"></i></a>

            </div>
            <div class="collapse pl-2" id="Settings">
                <asp:HyperLink ID="HyperLinkss" runat="server" CssClass="list-group-item" NavigateUrl="~/Dashboard/Settings/ProfileSettings.aspx"><i class="fas fa-cog"></i>&nbsp;Profile Settings</asp:HyperLink>
            </div>

            <asp:HyperLink runat="server" ID="hyperlinkadmins" NavigateUrl="~/adminpanel/" CssClass="list-group-item" Visible="False"><i class="fas fa-user-secret" aria-hidden="true"></i>&nbsp;Admin Panel</asp:HyperLink>
        </div>


    </div>
</nav>

