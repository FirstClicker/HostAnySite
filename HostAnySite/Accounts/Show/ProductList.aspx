<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAccounts.ascx" TagPrefix="uc1" TagName="NavigationSideAccounts" %>

<script runat="server">

    Protected Sub ButtonAddProduct_Click(sender As Object, e As EventArgs)

    End Sub

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
            <div class="card ">
              
                <div class="card-header">
                    <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Accounts/Show/ProductList.aspx" runat="server">List Of Product</asp:HyperLink>
                    <a href="#<%= PanelcollapseCreateProduct.ClientID %>" class="Change-DropDown-Icon float-right" data-toggle="collapse"><i class="far fa-edit"></i>&nbsp;Add Product&nbsp;&nbsp;<i class="fa fa-chevron-circle-right"></i></a>
                </div>
                <asp:Panel runat="server" ID="PanelcollapseCreateProduct" CssClass="card-collapse collapse">
                    <div class="card-body">
                        <div class="form">
                            <div class="form-group">
                                <label for="TextBoxName" class="sr-only">Name</label>
                                <asp:TextBox ID="TextBoxName" runat="server" CssClass="form-control" placeholder="Product Name"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="TextBoxDrescption" class="sr-only">Drescption</label>
                                <asp:TextBox ID="TextBoxDrescption" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Drescption"></asp:TextBox>
                            </div>


                            <div class="form-group">
                                <asp:Label ID="LabelEm" runat="server" ForeColor="Maroon"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer clearfix border border-bottom-1 ">
                        <div class="float-right">
                            <asp:Button ID="ButtonAddProduct" runat="server" Text="Add Product" class="btn btn-sm btn-info" OnClick="ButtonAddProduct_Click" />
                        </div>
                    </div>
                </asp:Panel>
                <div class="card-body m-0">
                    <asp:ListView ID="ListViewProductList" runat="server" DataSourceID="SqlDataSourceProductList" DataKeyNames="ProductID">


                    
                       
                        <EmptyDataTemplate>
                            <span>No data was returned.</span>

                        </EmptyDataTemplate>

                      
                        <ItemTemplate>
                            <span style="">
                                Name:
                                <asp:HyperLink ID="HyperLink2" runat="server" Text='<%# Eval("Name") %>' NavigateUrl='<%# "~/Accounts/Show/Product.aspx?ProductId=" & Eval("ProductID")  %>' ></asp:HyperLink>
                                <br />
                                Drescption:
                                <asp:Label Text='<%# Eval("Drescption") %>' runat="server" ID="DrescptionLabel" /><br />
                                <br />
                            </span>

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                            <div style="">
                            </div>

                        </LayoutTemplate>

                      
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceProductList" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'  SelectCommand="SELECT * FROM [Table_Acc_ProductDetails] ORDER BY [Name]"></asp:SqlDataSource>
                </div>
                <div class="card-footer ">
                   
                </div>
            </div>
        </div>
    </div>
</asp:Content>

