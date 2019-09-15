<%@ Control Language="VB" ClassName="NavigationSideAccounts" EnableViewState="false" %>

<script runat="server">
    ' version 12/08/2018 # 8.15

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If
    End Sub
</script>


<nav class="navbar navbar-light border navbar-expand-lg mt-2 mb-2 p-0 BoxEffect1">
    <asp:HyperLink ID="HyperLink4" NavigateUrl="~/Accounts/" CssClass="navbar-brand navbar-link d-md-none ml-2" runat="server"><i class="fas fa-user-secret" aria-hidden="true"></i>&nbsp;Accounts</asp:HyperLink>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarWEX" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="navbar-collapse collapse flex-column " id="navbarWEX">
        <div class="list-group w-100">

            <div class="list-group-item list-group-item-dark font-weight-bold d-none d-md-block">
                <asp:HyperLink ID="HyperLink8" NavigateUrl="~/Accounts/" runat="server"><i class="fas fa-user-secret" aria-hidden="true"></i>&nbsp;Accounts</asp:HyperLink>
            </div>

            <a href="#Financial" class="list-group-item Change-DropDown-Icon" data-toggle="collapse"><i class="fab fa-blogger"></i>&nbsp;Financial<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse" id="Financial" style="padding-left: 10px">
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="list-group-item" NavigateUrl="~/accounts/show/OrderBook.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Order Book</asp:HyperLink>
                <asp:HyperLink ID="HyperLink9" runat="server" CssClass="list-group-item" NavigateUrl="~/accounts/show/SalesBook.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Sales Book</asp:HyperLink>
                <asp:HyperLink ID="HyperLink7" runat="server" CssClass="list-group-item" NavigateUrl="~/accounts/show/AccountList.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Account List</asp:HyperLink>
                <asp:HyperLink ID="HyperLink6" runat="server" CssClass="list-group-item" NavigateUrl="~/accounts/show/JournalEntry.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Journal Book</asp:HyperLink>
                <asp:HyperLink ID="HyperLink5" runat="server" CssClass="list-group-item" NavigateUrl="~/accounts/Submit/JournalEntrySales.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Journal Entry Sales</asp:HyperLink>
            </div>

            <a href="#Production" class="list-group-item Change-DropDown-Icon" data-toggle="collapse"><i class="fab fa-blogger"></i>&nbsp;Production<i class="fa fa-chevron-circle-down float-right"></i></a>
            <div class="collapse" id="Production" style="padding-left: 10px">
                <asp:HyperLink ID="HyperLink2" runat="server" CssClass="list-group-item" NavigateUrl="~/accounts/Show/Productlist.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Product List</asp:HyperLink>
                <asp:HyperLink ID="HyperLink3" runat="server" CssClass="list-group-item" NavigateUrl="~/accounts/Show/Productionlist.aspx"><i class="fas fa-arrow-circle-right"></i>&nbsp;Production List</asp:HyperLink>
            </div>

            <asp:HyperLink runat="server" ID="hyperlinkadmin" NavigateUrl="~/Dashboard/" class="list-group-item " data-parent="#MainMenu"><i class="fas fa-home fa-fw"></i>&nbsp;Dashboard</asp:HyperLink>

        </div>
    </div>
</nav>
