<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAccounts.ascx" TagPrefix="uc1" TagName="NavigationSideAccounts" %>

<script runat="server">



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAccounts runat="server" ID="NavigationSideAccounts" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">


            <asp:ListView ID="ListViewJournalEntry" runat="server" DataSourceID="SqlDataSourceJournalEntry" DataKeyNames="JournalID">
                <AlternatingItemTemplate>
                    <span style="">JournalID:
                        <asp:Label Text='<%# Eval("JournalID") %>' runat="server" ID="JournalIDLabel" /><br />
                        EntryDate:
                        <asp:Label Text='<%# Eval("EntryDate") %>' runat="server" ID="EntryDateLabel" /><br />
                        Heading:
                        <asp:Label Text='<%# Eval("Heading") %>' runat="server" ID="HeadingLabel" /><br />
                        Comment:
                        <asp:Label Text='<%# Eval("Comment") %>' runat="server" ID="CommentLabel" /><br />
                        DebitAccountID:
                        <asp:Label Text='<%# Eval("DebitAccountID") %>' runat="server" ID="DebitAccountIDLabel" /><br />
                        CreditAccountID:
                        <asp:Label Text='<%# Eval("CreditAccountID") %>' runat="server" ID="CreditAccountIDLabel" /><br />
                        Amount:
                        <asp:Label Text='<%# Eval("Amount") %>' runat="server" ID="AmountLabel" /><br />
                        DebitAccountBalance:
                        <asp:Label Text='<%# Eval("DebitAccountBalance") %>' runat="server" ID="DebitAccountBalanceLabel" /><br />
                        CreditAccountBalance:
                        <asp:Label Text='<%# Eval("CreditAccountBalance") %>' runat="server" ID="CreditAccountBalanceLabel" /><br />
                        <br />
                    </span>


                </AlternatingItemTemplate>

                <EditItemTemplate>
                    <span style="">JournalID:
                        <asp:Label Text='<%# Eval("JournalID") %>' runat="server" ID="JournalIDLabel1" /><br />
                        EntryDate:
                        <asp:TextBox Text='<%# Bind("EntryDate") %>' runat="server" ID="EntryDateTextBox" /><br />
                        Heading:
                        <asp:TextBox Text='<%# Bind("Heading") %>' runat="server" ID="HeadingTextBox" /><br />
                        Comment:
                        <asp:TextBox Text='<%# Bind("Comment") %>' runat="server" ID="CommentTextBox" /><br />
                        DebitAccountID:
                        <asp:TextBox Text='<%# Bind("DebitAccountID") %>' runat="server" ID="DebitAccountIDTextBox" /><br />
                        CreditAccountID:
                        <asp:TextBox Text='<%# Bind("CreditAccountID") %>' runat="server" ID="CreditAccountIDTextBox" /><br />
                        Amount:
                        <asp:TextBox Text='<%# Bind("Amount") %>' runat="server" ID="AmountTextBox" /><br />
                        DebitAccountBalance:
                        <asp:TextBox Text='<%# Bind("DebitAccountBalance") %>' runat="server" ID="DebitAccountBalanceTextBox" /><br />
                        CreditAccountBalance:
                        <asp:TextBox Text='<%# Bind("CreditAccountBalance") %>' runat="server" ID="CreditAccountBalanceTextBox" /><br />
                        <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" /><asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" /><br />
                        <br />
                    </span>

                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No data was returned.</span>


                </EmptyDataTemplate>

                <InsertItemTemplate>
                    <span style="">JournalID:
                        <asp:TextBox Text='<%# Bind("JournalID") %>' runat="server" ID="JournalIDTextBox" /><br />
                        EntryDate:
                        <asp:TextBox Text='<%# Bind("EntryDate") %>' runat="server" ID="EntryDateTextBox" /><br />
                        Heading:
                        <asp:TextBox Text='<%# Bind("Heading") %>' runat="server" ID="HeadingTextBox" /><br />
                        Comment:
                        <asp:TextBox Text='<%# Bind("Comment") %>' runat="server" ID="CommentTextBox" /><br />
                        DebitAccountID:
                        <asp:TextBox Text='<%# Bind("DebitAccountID") %>' runat="server" ID="DebitAccountIDTextBox" /><br />
                        CreditAccountID:
                        <asp:TextBox Text='<%# Bind("CreditAccountID") %>' runat="server" ID="CreditAccountIDTextBox" /><br />
                        Amount:
                        <asp:TextBox Text='<%# Bind("Amount") %>' runat="server" ID="AmountTextBox" /><br />
                        DebitAccountBalance:
                        <asp:TextBox Text='<%# Bind("DebitAccountBalance") %>' runat="server" ID="DebitAccountBalanceTextBox" /><br />
                        CreditAccountBalance:
                        <asp:TextBox Text='<%# Bind("CreditAccountBalance") %>' runat="server" ID="CreditAccountBalanceTextBox" /><br />
                        <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /><asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" /><br />
                        <br />
                    </span>

                </InsertItemTemplate>
                <ItemTemplate>
                    <span style="">JournalID:
                        <asp:Label Text='<%# Eval("JournalID") %>' runat="server" ID="JournalIDLabel" /><br />
                        EntryDate:
                        <asp:Label Text='<%# Eval("EntryDate") %>' runat="server" ID="EntryDateLabel" /><br />
                        Heading:
                        <asp:Label Text='<%# Eval("Heading") %>' runat="server" ID="HeadingLabel" /><br />
                        Comment:
                        <asp:Label Text='<%# Eval("Comment") %>' runat="server" ID="CommentLabel" /><br />
                        DebitAccountID:
                        <asp:Label Text='<%# Eval("DebitAccountID") %>' runat="server" ID="DebitAccountIDLabel" /><br />
                        CreditAccountID:
                        <asp:Label Text='<%# Eval("CreditAccountID") %>' runat="server" ID="CreditAccountIDLabel" /><br />
                        Amount:
                        <asp:Label Text='<%# Eval("Amount") %>' runat="server" ID="AmountLabel" /><br />
                        DebitAccountBalance:
                        <asp:Label Text='<%# Eval("DebitAccountBalance") %>' runat="server" ID="DebitAccountBalanceLabel" /><br />
                        CreditAccountBalance:
                        <asp:Label Text='<%# Eval("CreditAccountBalance") %>' runat="server" ID="CreditAccountBalanceLabel" /><br />
                        <br />
                    </span>


                </ItemTemplate>
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                    <div style="">
                        <asp:DataPager runat="server" ID="DataPager2">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                            </Fields>
                        </asp:DataPager>

                    </div>


                </LayoutTemplate>
                <SelectedItemTemplate>
                    <span style="">JournalID:
                        <asp:Label Text='<%# Eval("JournalID") %>' runat="server" ID="JournalIDLabel" /><br />
                        EntryDate:
                        <asp:Label Text='<%# Eval("EntryDate") %>' runat="server" ID="EntryDateLabel" /><br />
                        Heading:
                        <asp:Label Text='<%# Eval("Heading") %>' runat="server" ID="HeadingLabel" /><br />
                        Comment:
                        <asp:Label Text='<%# Eval("Comment") %>' runat="server" ID="CommentLabel" /><br />
                        DebitAccountID:
                        <asp:Label Text='<%# Eval("DebitAccountID") %>' runat="server" ID="DebitAccountIDLabel" /><br />
                        CreditAccountID:
                        <asp:Label Text='<%# Eval("CreditAccountID") %>' runat="server" ID="CreditAccountIDLabel" /><br />
                        Amount:
                        <asp:Label Text='<%# Eval("Amount") %>' runat="server" ID="AmountLabel" /><br />
                        DebitAccountBalance:
                        <asp:Label Text='<%# Eval("DebitAccountBalance") %>' runat="server" ID="DebitAccountBalanceLabel" /><br />
                        CreditAccountBalance:
                        <asp:Label Text='<%# Eval("CreditAccountBalance") %>' runat="server" ID="CreditAccountBalanceLabel" /><br />
                        <br />
                    </span>


                </SelectedItemTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceJournalEntry" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' SelectCommand="SELECT * FROM [Table_Acc_JournalBook] ORDER BY [EntryDate] DESC"></asp:SqlDataSource>

        </div>
    </div>

       
</asp:Content>

