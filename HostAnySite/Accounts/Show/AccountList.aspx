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

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            If FirstClickerService.Version2.AccountPack.Account.CreateBasicAccounts(WebAppSettings.DBCS).Result = False Then
                'Report Fatal error
            End If


            DropDownListAccountType.DataSource = System.Enum.GetValues(GetType(FirstClickerService.Version2.AccountPack.Account.AccountTypeEnum))
            DropDownListAccountType.DataBind()
        End If
    End Sub


    Protected Sub ButtonCreateAccount_Click(sender As Object, e As EventArgs)
        Dim accounttype As FirstClickerService.Version2.AccountPack.Account.AccountTypeEnum
        accounttype = [Enum].Parse(GetType(FirstClickerService.Version2.AccountPack.Account.AccountTypeEnum), Trim(DropDownListAccountType.SelectedItem.Text), True)

        Dim createaccount As FirstClickerService.Version2.AccountPack.Account.StructureAccount
        createaccount = FirstClickerService.Version2.AccountPack.Account.AddAccount(TextBoxName.Text, accounttype, TextBoxDrescption.Text, WebAppSettings.DBCS)
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
            <div class="card">
                <div class="card-header">
                    <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Accounts/Show/AccountList.aspx" runat="server">List Of Account</asp:HyperLink>
                    <a href="#<%= PanelcollapseCreateAccount.ClientID %>" class="Change-DropDown-Icon float-right" data-toggle="collapse"><i class="far fa-edit"></i>&nbsp;Add Account&nbsp;&nbsp;<i class="fa fa-chevron-circle-right"></i></a>
                </div>
                <asp:Panel runat="server" ID="PanelcollapseCreateAccount" CssClass="card-collapse collapse">
                    <div class="card-body">
                        <div class="form">
                            <div class="form-group">
                                <label for="TextBoxName" class="sr-only">Account Name</label>
                                <asp:TextBox ID="TextBoxName" runat="server" CssClass="form-control" placeholder="Product Name"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="TextBoxDrescption" class="sr-only">Type</label>
                                <asp:DropDownList ID="DropDownListAccountType" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label for="TextBoxDrescption" class="sr-only">Description</label>
                                <asp:TextBox ID="TextBoxDrescption" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Description"></asp:TextBox>
                            </div>


                            <div class="form-group">
                                <asp:Label ID="LabelEm" runat="server" ForeColor="Maroon"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer clearfix border border-bottom-1 ">
                        <div class="float-right">
                            <asp:Button ID="ButtonCreateAccount" runat="server" Text="Create Account" class="btn btn-sm btn-info" OnClick="ButtonCreateAccount_Click" />
                        </div>
                    </div>
                </asp:Panel>
                <div class="card-body m-0">

                    <asp:ListView ID="ListViewAccounts" runat="server" DataSourceID="SqlDataSourceAccounts" DataKeyNames="AccountID">

                        <EmptyDataTemplate>
                            <span>No data was returned.</span>
                        </EmptyDataTemplate>

                        <ItemTemplate>
                            <span style="">
                                AccountName:
                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/Accounts/Show/Account.aspx?AccountID=" & Eval("AccountID") %>' Text ='<%# Eval("AccountName") %>'></asp:HyperLink>
                               <br />
                                AccountType:
                                <asp:Label Text='<%# Eval("AccountType") %>' runat="server" ID="AccountTypeLabel" /><br />
                                Derescption:
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DerescptionLabel" /><br />
                                <br />
                            </span>

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                            <div style="">
                                <asp:DataPager runat="server" ID="DataPager1">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                        <asp:NumericPagerField></asp:NumericPagerField>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                    </Fields>
                                </asp:DataPager>
                            </div>
                        </LayoutTemplate>

                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceAccounts" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' SelectCommand="SELECT * FROM [Table_Acc_AccountDetails]"></asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>

    
</asp:Content>

