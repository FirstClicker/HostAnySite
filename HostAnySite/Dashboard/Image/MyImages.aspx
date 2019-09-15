<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>
<%@ Register Src="~/App_Controls/ImageThumb.ascx" TagPrefix="uc1" TagName="ImageThumb" %>


<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            DropDownListStatus.DataSource = System.Enum.GetValues(GetType(FirstClickerService.Version1.Image.StatusEnum))
            DropDownListStatus.DataBind()
        End If

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix ">
                    <h5 class="card-title m-0 float-left">
                        <asp:HyperLink ID="HyperLinkPageHeading" runat="server" NavigateUrl="~/Image/Default.aspx" Text="Image"></asp:HyperLink>
                    </h5>
                    <div class="float-right ">
                        <asp:DropDownList ID="DropDownListStatus" runat="server" CssClass="form-control" AutoPostBack="True" CausesValidation="True"></asp:DropDownList>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <asp:ListView ID="ListViewImage" runat="server" DataSourceID="SqlDataSourceImage" DataKeyNames="ImageId">
                    <EmptyDataTemplate>
                        <span>No data was returned.</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <uc1:ImageThumb runat="server" ID="ImageThumb" ImageId='<%# Eval("ImageId") %>' ImageName='<%# Eval("ImageName") %>' ImageFileName='<%# Eval("ImageFileName") %>' PostDate='<%# Eval("PostDatef") %>' UserId='<%# Eval("UserId") %>' UserName='<%# Eval("UserName") %>' RoutUserName='<%# Eval("RoutUserName") %>' />
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholderContainer" class="row">
                            <div runat="server" id="itemPlaceholder" />
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceImage" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                    SelectCommand="SELECT Ti.*, CONVERT(VARCHAR(19), TI.postdate, 120) AS PostDatef, tu.userid, tu.username, tu.routusername 
                        FROM [Table_Image] TI 
                        left join table_user TU on Tu.userid=Ti.userId
                        WHERE ([STATUS] = @STATUS)  and (TU.[UserID] = @UserID) 
                        ORDER BY [PostDate] DESC">
                    <SelectParameters>
                       <asp:SessionParameter SessionField="UserId" Name="UserId" Type="Decimal"></asp:SessionParameter>
                     <asp:ControlParameter ControlID="DropDownListStatus" PropertyName="SelectedValue" Name="STATUS" Type="String"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <div class="card-footer clearfix">
                <div class="float-right">
                    <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ListViewImage" PageSize="12" QueryStringField="page">
                        <Fields>
                            <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

