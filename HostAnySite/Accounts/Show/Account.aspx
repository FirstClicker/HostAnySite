<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Register Src="~/App_Controls/NavigationSideAccounts.ascx" TagPrefix="uc1" TagName="NavigationSideAccounts" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        Dim accountDetails As FirstClickerService.Version2.AccountPack.Account.StructureAccount
        accountDetails = FirstClickerService.Version2.AccountPack.Account.GetAccount_ByAccountID(Val(Trim(Request.QueryString("AccountID"))), WebAppSettings.DBCS)
        If accountDetails.Result = False Then
            Response.Redirect("~/Accounts/show/AccountList.aspx")
        Else
            HyperLinkAccountName.Text = accountDetails.AccountName
            LabelAccountId.Text = accountDetails.AccountID
        End If


    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAccounts runat="server" ID="NavigationSideAccounts" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card ">
                <div class="card-header ">
                    <asp:HyperLink ID="HyperLinkAccountName" runat="server"></asp:HyperLink>&nbsp;<asp:Label ID="LabelAccountId" runat="server" Text="0"></asp:Label>

                </div>
                <div class="card-body ">
                    <asp:ListView ID="ListViewJuarnalEntry" runat="server" DataSourceID="SqlDataSourceJournalEntry" DataKeyNames="JournalID">
                      
                       
                        <EmptyDataTemplate>
                            <span>No data was returned.</span>
                        </EmptyDataTemplate>
                      
                        <ItemTemplate>
                            <span style="">JournalID:
                                <asp:Label Text='<%# Eval("JournalID") %>' runat="server" ID="JournalIDLabel" /><br />
                                EntryDate:
                                <asp:Label Text='<%# Eval("EntryDate") %>' runat="server" ID="EntryDateLabel" /><br />
                                Heading:
                                <asp:Label Text='<%# Eval("Heading") %>' runat="server" ID="HeadingLabel" /><br />
                                Comment:
                                <asp:Label Text='<%# Eval("Comment") %>' runat="server" ID="CommentLabel" /><br />
                                CreditAccountID:
                                <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("CreditAccountName") %>' NavigateUrl='<%# "~/accounts/show/account.aspx?accountid=" & Eval("CreditAccountID") %>'></asp:HyperLink>
                                <br />
                                Amount:
                                <asp:Label Text='<%# Eval("Amount") %>' runat="server" ID="AmountLabel" /><br />
                                DebitAccountBalance:
                                <asp:Label Text='<%# Eval("DebitAccountBalance") %>' runat="server" ID="DebitAccountBalanceLabel" /><br />

                                <br />
                            </span>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style="">
                                <span runat="server" id="itemPlaceholder" />
                            </div>
                            <div style="">
                                <asp:DataPager runat="server" ID="DataPager1">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                    </Fields>
                                </asp:DataPager>

                            </div>
                        </LayoutTemplate>
                     
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceJournalEntry" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' 
                        SelectCommand="SELECT JB.*, Ad.accountName as CreditAccountName 
                        FROM [Table_Acc_JournalBook] JB
                        Left join Table_Acc_AccountDetails AD on Ad.AccountID=JB.CreditAccountID
                        WHERE ((JB.[DebitAccountID] = @DebitAccountID) or (JB.[CreditAccountID] = @CreditAccountID)) 
                        ORDER BY JB.[EntryDate] asc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="LabelAccountId" PropertyName="Text" Name="DebitAccountID" Type="String"></asp:ControlParameter>
                            <asp:ControlParameter ControlID="LabelAccountId" PropertyName="Text" Name="CreditAccountID" Type="String"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div> 

</asp:Content>

