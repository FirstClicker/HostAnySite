<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/app_controls/web/NavigationSideAdmin.ascx" TagPrefix="uc1" TagName="NavigationSideAdmin" %>
<%@ Register Src="~/app_controls/web/ValidateAdminUserAccess.ascx" TagPrefix="uc1" TagName="ValidateAdminUserAccess" %>
<%@ Register Src="~/app_controls/web/BlogManageViewInListView.ascx" TagPrefix="uc1" TagName="BlogManageViewInListView" %>



<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub



</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateAdminUserAccess runat="server" ID="ValidateAdminUserAccess" />
    <div class="row">
        <div class="col-md-3 col-sm-3">
            <uc1:NavigationSideAdmin runat="server" ID="NavigationSideAdmin" />
        </div>
        <div class="col-md-8 col-sm-8">
            <div class="panel panel-default">
                <div class="panel-heading clearfix ">
                    <h1 class="panel-title">Blog List</h1>
                </div>
                    <asp:ListView ID="ListViewUserDetails" runat="server" DataSourceID="SqlDataSourceUserlist" DataKeyNames="Blogid">
                        <EmptyDataTemplate>
                            <div class="list-group ">
                                <div class="list-group-item">No blog found.</div>
                            </div>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <uc1:BlogManageViewInListView runat="server" ID="BlogManageViewInListView" Heading ='<%# Eval("Heading") %>' BlogId ='<%# Eval("BlogId") %>' UserId ='<%# Eval("UserId") %>' ShowinHome ='<%# Eval("ShowinHome") %>' />
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div class="list-group " id="itemPlaceholderContainer" runat="server">
                                <div runat="server" id="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceUserlist"
                        ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT * FROM [Table_Blog] ORDER BY [PostDate] DESC">
                    </asp:SqlDataSource>
                <div class="panel-footer clearfix" >
                    <div class="pull-right ">
                        <asp:DataPager ID="DataPager1" runat="server" PagedControlID="ListViewUserDetails">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

