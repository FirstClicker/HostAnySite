<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/app_controls/web/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/app_controls/web/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>
<%@ Register Src="~/app_controls/web/BlogManageViewInListView.ascx" TagPrefix="uc1" TagName="BlogManageViewInListView" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="row">
        <div class="col-md-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-lg-9">
                    <div class="panel panel-default">
                <div class="panel-heading clearfix ">
                    <h1 class="panel-title">Blog List</h1>
                </div>
              
                    <asp:ListView ID="ListViewUserDetails" runat="server" DataSourceID="SqlDataSourceUserlist" DataKeyNames="Blogid">
                        <EmptyDataTemplate>
                            <span>No blog found.</span>
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
                        SelectCommand="SELECT * FROM [Table_Blog]
                        where userid=@UserId
                         ORDER BY [PostDate] DESC"
                        >
                         <SelectParameters>
                        <asp:SessionParameter SessionField="UserId" Name="UserId" Type="Decimal"></asp:SessionParameter>
                    </SelectParameters>
                       
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
        </div> </div> 
</asp:Content>

