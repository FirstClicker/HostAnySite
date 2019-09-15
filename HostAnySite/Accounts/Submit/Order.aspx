<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAccounts.ascx" TagPrefix="uc1" TagName="NavigationSideAccounts" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            loadAllProduct()
            loadAllAccountDetails()
        End If
    End Sub

    Private Function loadAllProduct() As Boolean
        loadAllProduct = True

        DropDownListProduct.Items.Clear()

        Dim ProductItem As New ListItem

        ProductItem.Text = "Select Product"
        ProductItem.Value = 0

        DropDownListProduct.Items.Add(ProductItem)

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "SELECT * FROM Table_acc_ProductDetails order by Name"
        myConn.Open()

        myReader = myCmd.ExecuteReader
        If myReader.HasRows = True Then
            Do While myReader.Read
                Dim ProductItem2 As New ListItem

                ProductItem2.Text = myReader.Item("Name")
                ProductItem2.Value = myReader.Item("ProductId")

                DropDownListProduct.Items.Add(ProductItem2)
            Loop
        End If
        myReader.Close()
        myConn.Close()
    End Function


    Private Function loadAllAccountDetails() As Boolean
        loadAllAccountDetails = True

        DropDownListDebitAc.Items.Clear()

        Dim ProductItem As New ListItem

        ProductItem.Text = "Select Account"
        ProductItem.Value = 0

        DropDownListDebitAc.Items.Add(ProductItem)

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "SELECT * FROM Table_acc_AccountDetails order by AccountName"
        myConn.Open()

        myReader = myCmd.ExecuteReader
        If myReader.HasRows = True Then
            Do While myReader.Read
                Dim ProductItem2 As New ListItem

                ProductItem2.Text = myReader.Item("AccountName")
                ProductItem2.Value = myReader.Item("Accountid")

                DropDownListDebitAc.Items.Add(ProductItem2)
            Loop
        End If
        myReader.Close()
        myConn.Close()
    End Function


    Protected Sub ButtonAddItem_Click(sender As Object, e As EventArgs)
        If TextBoxOrderID.Text = 0 Then

            Try
                Dim OrderDateTime As DateTime = DateTime.Parse(TextBoxOrderDate.Text)
                Dim DeliveryDateTime As DateTime = DateTime.Parse(TextBoxDeliveryDate.Text)
            Catch ex As Exception
                LabelCreateOrderEm.Text = "Order date and delivery date required."
                PanelCreateOrderEm.Visible = True
                Exit Sub
            End Try

            If DropDownListDebitAc.SelectedIndex = 0 Then
                LabelCreateOrderEm.Text = "Please select buyer's account."
                PanelCreateOrderEm.Visible = True
                Exit Sub
            End If

            If DropDownListProduct.SelectedIndex = 0 Then
                LabelCreateOrderEm.Text = "Please select a product."
                PanelCreateOrderEm.Visible = True
                Exit Sub
            End If

            If TextBoxQuentity.Text = "" Or TextBoxRate.Text = "" Then
                LabelCreateOrderEm.Text = "Product rate and quantity is required."
                PanelCreateOrderEm.Visible = True
                Exit Sub
            End If


            Dim Createorder As FirstClickerService.Version2.AccountPack.OrderBook.StructureOrderBook
            Createorder = FirstClickerService.Version2.AccountPack.OrderBook.AddOrder(DropDownListDebitAc.SelectedValue, DropDownListDebitAc.SelectedItem.Text, TextBoxOrderNote.Text, Session("UserID"), FirstClickerService.Version2.AccountPack.OrderBook.StatusEnum.Order_Taken, 0, DateTime.Parse(TextBoxOrderDate.Text), DateTime.Parse(TextBoxDeliveryDate.Text), WebAppSettings.DBCS)
            If Createorder.Result = True Then
                TextBoxOrderID.Text = Createorder.OrderID
                DropDownListDebitAc.Enabled = False



            Else
                LabelCreateOrderEm.Text = "Failed to Create order."
                PanelCreateOrderEm.Visible = True
                Exit Sub
            End If


        End If

        FirstClickerService.Version2.AccountPack.OrderBook.AddOrderBookItem(TextBoxOrderID.Text, DropDownListProduct.SelectedValue, TextBoxQuentity.Text, TextBoxRate.Text, Session("UserId"), FirstClickerService.Version2.AccountPack.OrderBook.StatusEnum.Order_Taken, " ", WebAppSettings.DBCS)
        ListViewOrderItem.DataBind()



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
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Accounts/Submit/Order.aspx">Create Order</asp:HyperLink>
                    <asp:HyperLink ID="HyperLink2" runat="server" CssClass ="float-right " NavigateUrl ="~/Accounts/Show/OrderBook.aspx" >Order List</asp:HyperLink>
                    </div>
                <div class="card-body ">



                    <div class="form-group">
                        <label for="exampleFormControlInput1">OrderID</label>
                        <asp:TextBox ID="TextBoxOrderID" runat="server" CssClass="form-control " Enabled="false" Text="0"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="email">Buyer's A/c:</label>
                        <asp:DropDownList ID="DropDownListDebitAc" runat="server" CssClass="form-control" AutoPostBack="False" CausesValidation="True"></asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label for="exampleFormControlInput1">Order Note</label>
                        <asp:TextBox ID="TextBoxOrderNote" runat="server" CssClass="form-control " TextMode="MultiLine"></asp:TextBox>
                    </div>


                    <div class="form-group">
                        <label for="pwd">
                            Ordere Date:
                        </label>
                        &nbsp;<asp:TextBox ID="TextBoxOrderDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="pwd">
                            Delivery Date:
                        </label>
                        &nbsp;<asp:TextBox ID="TextBoxDeliveryDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="card mb-3  ">
                        <div class="card-header bg-transparent  ">Order Iteams</div>
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
                                            <asp:Label Text='<%# Eval("ProductID") %>' runat="server" ID="ProductIDLabel" /></td>
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
                                    <table runat="server">
                                        <tr runat="server">
                                            <td runat="server">
                                                <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                                    <tr runat="server" style="">
                                                       
                                                        <th runat="server">ProductID</th>
                                                        <th runat="server">Quantity</th>
                                                        <th runat="server">Rate</th>
                                                        <th runat="server">UserID</th>
                                                        <th runat="server">Status</th>
                                                        <th runat="server">Message</th>
                                                    </tr>
                                                    <tr runat="server" id="itemPlaceholder"></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" style=""></td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                              
                            </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceOrderItem" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' 
                                SelectCommand="SELECT * FROM [Table_Acc_OrderBookItems] WHERE ([OrderID] = @OrderID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="TextBoxOrderID" PropertyName="Text" Name="OrderID" Type="Decimal"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                             <div class="card-footer bg-transparent ">
                    <div class="form-row">
                        <div class="col-7">
                            <asp:DropDownList ID="DropDownListProduct" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBoxQuentity" runat="server" CssClass="form-control" placeholder="Quentity"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:TextBox ID="TextBoxRate" runat="server" CssClass="form-control" placeholder="Rate"></asp:TextBox>
                        </div>
                        <div class="col">
                            <asp:Button ID="ButtonAddItem" runat="server" Text="Add" CssClass="btn btn-outline-dark " OnClick="ButtonAddItem_Click" />
                        </div>
                    </div>
                </div>

                    </div>

                    <asp:Panel runat="server" ID="PanelCreateOrderEm" CssClass="alert alert-danger" Visible="false">
                        <asp:Label ID="LabelCreateOrderEm" runat="server"></asp:Label>
                    </asp:Panel>

                </div>




           

            </div>
        </div>
    </div>
</asp:Content>

