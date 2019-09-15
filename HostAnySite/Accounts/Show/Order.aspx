<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAccounts.ascx" TagPrefix="uc1" TagName="NavigationSideAccounts" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim orderdetails As FirstClickerService.Version2.AccountPack.OrderBook.StructureOrderBook = FirstClickerService.Version2.AccountPack.OrderBook.GetOrderDetails(Val(Trim(Request.QueryString("OrderId"))), WebAppSettings.DBCS)
            If orderdetails.Result = False Then
                Response.Redirect("~/accounts/")
            Else
                LabelOrderId.Text = orderdetails.OrderID
            End If
        End If
    End Sub

    Protected Sub ButtonExecuteOrder_Click(sender As Object, e As EventArgs)
        Dim orderDetails As FirstClickerService.Version2.AccountPack.OrderBook.StructureOrderBook = FirstClickerService.Version2.AccountPack.OrderBook.GetOrderDetails(LabelOrderId.Text, WebAppSettings.DBCS)
        Dim OrderBookItems As List(Of FirstClickerService.Version2.AccountPack.OrderBook.StructureOrderBookItem) = FirstClickerService.Version2.AccountPack.OrderBook.GetOrderBookItems(LabelOrderId.Text, WebAppSettings.DBCS)



        If OrderBookItems.Count > 0 Then

            For i As Integer = 0 To OrderBookItems.Count - 1
                Dim LastJaurnalOFDebitAc As FirstClickerService.Version2.AccountPack.JournalBook.StructureJournal = FirstClickerService.Version2.AccountPack.JournalBook.LastJournalEntry_ByAccountID(orderDetails.AccountID, WebAppSettings.DBCS)
                Dim LastJaurnalOFCreditAc As FirstClickerService.Version2.AccountPack.JournalBook.StructureJournal = FirstClickerService.Version2.AccountPack.JournalBook.LastJournalEntry_ByAccountID(FirstClickerService.Version2.AccountPack.Account.SystemAccountsEnum.SalesBook, WebAppSettings.DBCS)


                Dim newdebitACBalance As Double
                Dim newCreditACBalance As Double

                If LastJaurnalOFDebitAc.DebitAccountID = orderDetails.AccountID Then
                    newdebitACBalance = LastJaurnalOFDebitAc.DebitAccountBalance + (OrderBookItems(i).Quantity * OrderBookItems(i).Rate)
                Else
                    newdebitACBalance = LastJaurnalOFDebitAc.CreditAccountBalance + (OrderBookItems(i).Quantity * OrderBookItems(i).Rate)
                End If

                If LastJaurnalOFCreditAc.DebitAccountID = FirstClickerService.Version2.AccountPack.Account.SystemAccountsEnum.SalesBook Then
                    newCreditACBalance = LastJaurnalOFCreditAc.DebitAccountBalance + (OrderBookItems(i).Quantity * OrderBookItems(i).Rate)
                Else
                    newCreditACBalance = LastJaurnalOFCreditAc.CreditAccountBalance + (OrderBookItems(i).Quantity * OrderBookItems(i).Rate)
                End If


                Dim JournalEntry As FirstClickerService.Version2.AccountPack.JournalBook.StructureJournal = FirstClickerService.Version2.AccountPack.JournalBook.AddJournal(Now, "Credit Sale to " & orderDetails.Heading, " ", orderDetails.AccountID, FirstClickerService.Version2.AccountPack.Account.SystemAccountsEnum.SalesBook, OrderBookItems(i).Quantity * OrderBookItems(i).Rate, newdebitACBalance, newCreditACBalance, WebAppSettings.DBCS)


                FirstClickerService.Version2.AccountPack.StockBook.AddStockbookEntry(OrderBookItems(i).ProductID, FirstClickerService.Version2.AccountPack.StockBook.TransactionTypeEnum.Sale, OrderBookItems(i).Quantity, 0, JournalEntry.JournalID, Session("UserId"), "", Now, WebAppSettings.DBCS)
            Next

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

            <div class="card ">
                <div class="card-header ">Order Details :
                    <asp:Label ID="LabelOrderId" runat="server" Text="0"></asp:Label></div>
                <div class="card-body ">
                    <asp:ListView ID="ListViewOrderDetails" runat="server" DataSourceID="SqlDataSourceOrderDetails" DataKeyNames="OrderID">

                        <EmptyDataTemplate>
                            <span>No data was returned.</span>
                        </EmptyDataTemplate>

                        <ItemTemplate>
                            <span style="">Heading:
                                <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("Heading") %>' NavigateUrl='<%# "~/Accounts/show/Account.aspx?AccountID=" & Eval("AccountID") %>'></asp:HyperLink>
                                <asp:Label runat="server" ID="HeadingLabel" /><br />
                                OrderDate:
                                <asp:Label Text='<%# Eval("OrderDate") %>' runat="server" ID="OrderDateLabel" /><br />
                                DeliveryDate:
                                <asp:Label Text='<%# Eval("DeliveryDate") %>' runat="server" ID="DeliveryDateLabel" /><br />
                                UserID:
                                <asp:Label Text='<%# Eval("UserID") %>' runat="server" ID="UserIDLabel" /><br />
                                Status:
                                <asp:Label Text='<%# Eval("Status") %>' runat="server" ID="StatusLabel" /><br />
                                Bill_ID:
                                <asp:Label Text='<%# Eval("Bill_ID") %>' runat="server" ID="Bill_IDLabel" /><br />
                                OrderNote:
                                <asp:Label Text='<%# Eval("OrderNote") %>' runat="server" ID="OrderNoteLabel" /><br />
                                <br />
                            </span>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                            <div style="">
                            </div>
                        </LayoutTemplate>

                    </asp:ListView>

                    <asp:SqlDataSource runat="server" ID="SqlDataSourceOrderDetails" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' SelectCommand="SELECT * FROM [Table_Acc_OrderBook] WHERE ([OrderID] = @OrderID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="LabelOrderId" PropertyName="Text" Name="OrderID" Type="Decimal"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <br />
                <div class="card-body ">
                       <asp:ListView ID="ListViewOrderItem" runat="server" DataSourceID="SqlDataSourceOrderItem" DataKeyNames="OrderItemID">

                    <EmptyDataTemplate>
                        <table runat="server" style="">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>

                    <ItemTemplate>
                        <tr style="">

                            <td>
                                <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="ProductIDLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("Rate") %>' runat="server" ID="RateLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("UserID") %>' runat="server" ID="UserIDLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("Status") %>' runat="server" ID="StatusLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("Message") %>' runat="server" ID="MessageLabel" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div class="card">
                            <div class="card-header ">
                            </div>
                            <table runat="server" id="itemPlaceholderContainer" class="table table-bordered ">
                                <thead>
                                    <tr runat="server" style="">

                                        <th runat="server">Product</th>
                                        <th runat="server">Quantity</th>
                                        <th runat="server">Rate</th>
                                        <th runat="server">UserID</th>
                                        <th runat="server">Status</th>
                                        <th runat="server">Message</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </tbody>
                            </table>
                            <div class="card-footer ">
                            </div>
                        </div>
                     
                    </LayoutTemplate>
                   
                </asp:ListView>

                <asp:SqlDataSource runat="server" ID="SqlDataSourceOrderItem" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' 
                    SelectCommand="SELECT OBI.* , PD.Name 
                    FROM [Table_Acc_OrderBookItems] OBI
                    Left Join Table_Acc_ProductDetails PD on PD.ProductID=OBI.ProductID
                    WHERE ([OrderID] = @OrderID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="labelOrderID" PropertyName="Text" Name="OrderID" Type="Decimal"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                </div>
                <br />
                <div class="card-footer ">
                    <asp:Button ID="ButtonExecuteOrder" runat="server" Text="Execute" OnClick ="ButtonExecuteOrder_Click" />
                </div>
             
            </div>
        </div>
    </div>


</asp:Content>

