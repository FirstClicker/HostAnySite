<%@ Control Language="VB" ClassName="NavigationSideSupport" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub
</script>


<nav class="navbar navbar-light border navbar-expand-md mt-2 mb-2 p-0 BoxEffect1">
    <asp:HyperLink ID="HyperLink7" NavigateUrl="~/Support/" CssClass="navbar-brand navbar-link d-md-none ml-2" runat="server"><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp;Support</asp:HyperLink>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarWEX" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="navbar-collapse collapse flex-column " id="navbarWEX">
        <div class="list-group w-100">

            <div class="list-group-item list-group-item-dark font-weight-bold d-none d-md-block">
                <asp:HyperLink ID="HyperLink8" NavigateUrl="~/support/" runat="server"><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp;Support</asp:HyperLink>
            </div>

            <asp:HyperLink runat="server" ID="hyperlinkInbox" NavigateUrl="~/support/AboutUs.aspx" class="list-group-item" data-parent="#MainMenu"><i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp;About Us</asp:HyperLink>
            <asp:HyperLink runat="server" ID="hyperlink1" NavigateUrl="~/support/Terms.aspx" class="list-group-item" data-parent="#MainMenu"><i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp;Terms</asp:HyperLink>
            <asp:HyperLink runat="server" ID="hyperlink2" NavigateUrl="~/support/Privacy.aspx" class="list-group-item" data-parent="#MainMenu"><i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp;Privacy</asp:HyperLink>

                <asp:HyperLink runat="server" ID="hyperlink3" NavigateUrl="~/support/ContactUs.aspx" class="list-group-item" data-parent="#MainMenu"><i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp;Contact Us</asp:HyperLink>
        </div>
    </div>
</nav>
