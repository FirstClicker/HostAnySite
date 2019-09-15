<%@ Control Language="VB" ClassName="TagOfAllBlogs" %>

<script runat="server">
' version 25/08/2018 # 4.27 AM

</script>
<div class="card mt-2 BoxEffect6 ">
    <div class="card-header">
        Blog Tags
    </div>
    <asp:ListView ID="ListViewTagList" runat="server" DataSourceID="SqlDataSourceTag">
        <EmptyDataTemplate>
            <div class="list-group-item ">Tag Not found.</div>
        </EmptyDataTemplate>
        <ItemTemplate>
            <div class="list-group-item ">
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/Blog/" & Eval("Tagname").ToString.Replace(" ", "-") %>' Text='<%# Eval("Tagname") %>'></asp:HyperLink>
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" id="itemPlaceholderContainer" class="list-group ">
                <div runat="server" id="itemPlaceholder" />
            </div>
            <div class="card-footer">
                <asp:DataPager runat="server" ID="DataPager2" QueryStringField="NavPage" PageSize="20">
                    <Fields>
                        <asp:NumericPagerField></asp:NumericPagerField>
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceTag" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
        SelectCommand="SELECT TTOB.TagID, tt. tagname FROM [Table_TagOfBlog] TTOB 
            left join table_Tag TT on TTOB.tagId= tt.Tagid
                where tt.status='Active'
            group by TTOB.TagID, tt. tagname"></asp:SqlDataSource>
</div>
