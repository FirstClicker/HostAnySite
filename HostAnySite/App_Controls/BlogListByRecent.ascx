<%@ Control Language="VB" ClassName="BlogListByRecent" %>

<script runat="server">
' version 03/08/2019 # 4.27 AM

</script>
<div class="card BoxEffect6 mt-2 mb-4">
    <div class="card-header bg-info">
        Recent blogs
    </div>
    <asp:ListView ID="ListViewRecentBlogs" runat="server" DataSourceID="SqlDataSourceRecentBlogs" DataKeyNames="BlogId">
        <EmptyDataTemplate>
            <div class="list-group-item bg-light">No blog found.</div>
        </EmptyDataTemplate>
        <ItemTemplate>
            <div class="list-group-item bg-light">
                <asp:HyperLink ID="HyperLink3" runat="server" Text='<%# Eval("Heading") %>' NavigateUrl='<%# "~/blog/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("BlogId") %>'></asp:HyperLink>
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" id="itemPlaceholderContainer" class="list-group ">
                <div runat="server" id="itemPlaceholder" />
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceRecentBlogs" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' SelectCommand="SELECT [Heading], [BlogId], [UserID] FROM [Table_Blog] order by PostDate desc"></asp:SqlDataSource>
</div>