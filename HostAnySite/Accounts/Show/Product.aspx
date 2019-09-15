<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAccounts.ascx" TagPrefix="uc1" TagName="NavigationSideAccounts" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If


        Dim productdetails As FirstClickerService.Version2.AccountPack.Product.StructureProductDetails
        productdetails = FirstClickerService.Version2.AccountPack.Product.GetProduct(Val(Trim(Request.QueryString("ProductId"))), WebAppSettings.DBCS)
        If productdetails.Result = False Then

            Exit Sub
        Else
            HyperLinkProductName.Text = productdetails.Name & " (" & Val(Request.QueryString("ProductId")) & ")"
        End If

        LabelPendingOrder.Text = FirstClickerService.Version2.AccountPack.Product.Product_PendingOrderCount(productdetails.ProductID, WebAppSettings.DBCS).OutPutString
        LabelStockValue.Text = FirstClickerService.Version2.AccountPack.StockBook.LastStockbookEntry_ByProductID(productdetails.ProductID, WebAppSettings.DBCS).ClosingValue

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
            <div class="card ">
                <div class="card-header ">
                    <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Accounts/Show/ProductList.aspx" runat="server">List Of Product</asp:HyperLink>
                    /
                    <asp:HyperLink ID="HyperLinkProductName" runat="server"></asp:HyperLink>
                </div>
                <div class="card-body ">
                    <div class="row">
                        <div class="col-12 col-sm-12 col-md-6 col-lg-6 col-xl-6">
                            <asp:Label ID="Label" runat="server" Text="Stock Value : "></asp:Label><asp:Label ID="LabelStockValue" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="col-12 col-sm-12 col-md-6 col-lg-6 col-xl-6">
                            <asp:Label ID="Label1" runat="server" Text="Pending Order : "></asp:Label><asp:Label ID="LabelPendingOrder" runat="server" Text="0"></asp:Label>

                        </div>
                    </div>
                </div>
                <div class="card-body ">
                    <div class="row">
                       
                        <div class="col-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">
                            <asp:ListView ID="ListViewStockBook" runat="server" DataSourceID="SqlDataSourceStockBook" DataKeyNames="EntryID">
                              
                              
                                <EmptyDataTemplate>
                                    <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                        <tr>
                                            <td>No data was returned.</td>
                                        </tr>
                                    </table>

                                </EmptyDataTemplate>
                              
                                <ItemTemplate>
                                    <tr >
                                        <td>
                                            <asp:Label Text='<%# FirstClickerService.Version2.DateTimeFunction.ConvertDateTime4Use(Eval("EntryDateF")).ResultDate.ToString("MMM,d,yyyy")  %>' runat="server" ID="TransactionDateLabel" />
                                       
                                        </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("TransactionType") %>' runat="server" ID="TransactionTypeLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("TransactionValue") %>' runat="server" ID="TransactionValueLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("ClosingValue") %>' runat="server" ID="ClosingValueLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("JournalID") %>' runat="server" ID="SaleIDLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("UserID") %>' runat="server" ID="UserIDLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Message") %>' runat="server" ID="MessageLabel" /></td>
                                       
                                       
                                    </tr>

                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div class="card">
                                        <div class="card-header "></div>
                                        <table runat="server" id="itemPlaceholderContainer" class="table table-bordered">
                                             <thead>
                                                 <tr runat="server">
                                                     <th runat="server">Date</th>
                                                     <th runat="server">Type</th>
                                                     <th runat="server">Value</th>
                                                     <th runat="server">ClosingValue</th>

                                                     <th runat="server">JournalID</th>
                                                     <th runat="server">User</th>
                                                     <th runat="server">Message</th>


                                                 </tr></thead> 
                                            <tbody>
                                            <tr runat="server" id="itemPlaceholder"></tr></tbody>
                                        </table>
                                        <Div class="card-footer">

                                        </Div> 
                                    </div>
                              

                                </LayoutTemplate>
                             
                            </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceStockBook" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' 
                                SelectCommand="SELECT SB.*, CONVERT(VARCHAR(19), SB.EntryDate, 120) AS EntryDateF 
                                FROM [Table_Acc_StockBook] SB 
                                WHERE ([ProductID] = @ProductID) 
                                ORDER BY [EntryDate] DESC">
                                <SelectParameters>
                                    <asp:QueryStringParameter QueryStringField="ProductId" Name="ProductID" Type="Decimal"></asp:QueryStringParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>


                </div>
                <div class="card-footer ">
                </div>
            </div>
        </div>
    </div>
</asp:Content>

