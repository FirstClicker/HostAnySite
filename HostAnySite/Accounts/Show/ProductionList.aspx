<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Register Src="~/App_Controls/NavigationSideAccounts.ascx" TagPrefix="uc1" TagName="NavigationSideAccounts" %>


<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        If IsPostBack = False Then
            loadAllProduct()
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

    Protected Sub ButtonSubmit_Click(sender As Object, e As EventArgs)

        Dim submitproduction As FirstClickerService.Version2.AccountPack.Production.StructureProduction = FirstClickerService.Version2.AccountPack.Production.AddProduction(DropDownListProduct.SelectedValue, TextBoxName.Text, TextBoxWeight.Text, DateTime.Parse(TextBoxDate.Text), " ", Session("UserId"), WebAppSettings.DBCS)
        If submitproduction.Result = True Then
            Dim submitstockbook As FirstClickerService.Version2.AccountPack.StockBook.StructureStockBook
            submitstockbook = FirstClickerService.Version2.AccountPack.StockBook.AddStockbookEntry(DropDownListProduct.SelectedValue, FirstClickerService.Version2.AccountPack.StockBook.TransactionTypeEnum.Production, TextBoxWeight.Text, submitproduction.ProductionID, 0, Session("UserId"), " ", DateTime.Parse(TextBoxDate.Text), WebAppSettings.DBCS)
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

                <div class="card-header">
                    <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Accounts/Show/ProductionList.aspx" runat="server">List Of Production</asp:HyperLink>
                    <a href="#<%= PanelcollapseAddProduction.ClientID %>" class="Change-DropDown-Icon float-right" data-toggle="collapse"><i class="far fa-edit"></i>&nbsp;Add Production&nbsp;&nbsp;<i class="fa fa-chevron-circle-right"></i></a>
                </div>
                <asp:Panel runat="server" ID="PanelcollapseAddProduction" CssClass="card-collapse collapse">
                    <div class="card-body ">
                        <div class="form-group">
                            <label for="email">Product:</label>
                            <asp:DropDownList ID="DropDownListProduct" runat="server" CssClass="form-control" AutoPostBack="False" CausesValidation="True"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="pwd">Name:</label>
                            <asp:TextBox ID="TextBoxName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="pwd">Weight:</label>
                            <asp:TextBox ID="TextBoxWeight" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="pwd">
                                Date:
                            </label>
                            &nbsp;<asp:TextBox ID="TextBoxDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>


                    </div>
                    <div class="card-footer clearfix border border-bottom-1 ">
                        <div class="float-right">
                            <asp:Button ID="ButtonSubmit" runat="server" Text="Button" class="btn btn-primary" type="submit" OnClick="ButtonSubmit_Click" />
                        </div>
                    </div>
                </asp:Panel>
            </div>






            <asp:ListView ID="ListViewProductionList" runat="server" DataSourceID="SqlDataSourceProductionList" DataKeyNames="ProductionID">


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
                            <asp:Label Text='<%# FirstClickerService.Version2.DateTimeFunction.ConvertDateTime4Use(Eval("ProductionDateF")).ResultDate.ToString("MMM,d,yyyy")  %>' runat="server" ID="ProductionDateLabel" /></td>
                        <td>
                            <asp:HyperLink Text='<%# Eval("ProductName") %>' NavigateUrl='<%# "~/accounts/show/Product.aspx?ProductId=" & Eval("ProductID") %>' runat="server" ID="ProductIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("heading") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Weight") %>' runat="server" ID="WeightLabel" /></td>

                        <td>
                            <asp:Label Text='<%# Eval("Comment") %>' runat="server" ID="CommentLabel" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <div class="card">
                        <div class="card-header "></div>
                        <table runat="server" id="itemPlaceholderContainer" class="table table-bordered">
                            <thead>
                                <tr runat="server" style="">
                                    <th runat="server">Date</th>
                                    <th runat="server">Product</th>
                                    <th runat="server">Name</th>
                                    <th runat="server">Weight</th>

                                    <th runat="server">Comment</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr runat="server" id="itemPlaceholder"></tr>
                                <tbody>
                        </table>
                        <div class="card-footer ">
                            <asp:DataPager runat="server" ID="DataPager1">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                </Fields>
                            </asp:DataPager>
                        </div>
                    </div>

                </LayoutTemplate>

            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceProductionList" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                SelectCommand="SELECT TP.*, CONVERT(VARCHAR(19), TP.ProductionDate, 120) AS ProductionDateF , PD.Name As ProductName 
                FROM [Table_Acc_Production] TP
                Left Join Table_Acc_ProductDetails PD on PD.ProductID= Tp.ProductID
                ORDER BY [ProductionDate] desc"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>

