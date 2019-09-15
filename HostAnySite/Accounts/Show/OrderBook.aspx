<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAccounts.ascx" TagPrefix="uc1" TagName="NavigationSideAccounts" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        If IsPostBack = False Then
            LabelPendingOrder.Text = FirstClickerService.Version2.AccountPack.OrderBook.OrderCount_ByStatus(FirstClickerService.Version2.AccountPack.OrderBook.StatusEnum.Order_Taken, WebAppSettings.DBCS).OutPutString
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
                <div class="card-header ">
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Accounts/Show/OrderBook.aspx">Order Book</asp:HyperLink>
                    <asp:HyperLink ID="HyperLinkCreateOrder" runat="server" CssClass="float-right " NavigateUrl="~/Accounts/Submit/Order.aspx">Create Order</asp:HyperLink>
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

                    <asp:ListView ID="ListViewOrderBook" runat="server" DataSourceID="SqlDataSourceOrderBook" DataKeyNames="OrderID">

                        <EmptyDataTemplate>
                            <span>No data was returned.</span>
                        </EmptyDataTemplate>

                        <ItemTemplate>

                            <div class="card">
                                <div class="card-body">
                                    <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("Heading") %>' NavigateUrl='<%# "~/Accounts/Show/Order.aspx?OrderID=" & Eval("OrderID") %>'> Details</asp:HyperLink>
                                    <br />
                                    DeliveryDate:
                                <asp:Label Text='<%# FirstClickerService.Version2.DateTimeFunction.ConvertDateTime4Use(Eval("DeliveryDate")).ResultDate.ToLongDateString   %>' runat="server" ID="DeliveryDateLabel" /><br />
                                    OrderDate:
                                <asp:Label Text='<%# FirstClickerService.Version2.DateTimeFunction.ConvertDateTime4Use(Eval("OrderDate")).ResultDate.ToLongDateString %>' runat="server" ID="OrderDateLabel" /><br />
                                    TotalOrder:
                                <asp:Label Text='<%# Eval("TotalOrder") %>' runat="server" ID="Label1" /><br />
                                    OrderNote:
                                <asp:Label Text='<%# Eval("OrderNote") %>' runat="server" ID="OrderNoteLabel" /><br />
                                </div>
                            </div>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer">
                                <div runat="server" id="itemPlaceholder" />
                            </div>

                        </LayoutTemplate>

                    </asp:ListView>


                    <asp:SqlDataSource runat="server" ID="SqlDataSourceOrderBook" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT OB.OrderID, OB.Heading, CONVERT(VARCHAR(19), OB.DeliveryDate, 120) AS DeliveryDate, CONVERT(VARCHAR(19), OB.OrderDate, 120) AS OrderDate , OB.OrderNote, OBI.TotalOrder
                    FROM [Table_Acc_OrderBook] OB 
                    left join (select OrderID, sum(Quantity) as TotalOrder from Table_Acc_OrderBookItems group By OrderID) OBI on OBI.OrderID=OB.OrderID
                    ORDER BY [DeliveryDate] DESC"></asp:SqlDataSource>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

