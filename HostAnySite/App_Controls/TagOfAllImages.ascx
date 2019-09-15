<%@ Control Language="VB" ClassName="TagOfAllImages" %>

<script runat="server">
' version 25/08/2018 # 4.27 AM

</script>
<div class="card mt-2 BoxEffect6 ">
    <div class="card-header">
        Image Tags
    </div>
    <asp:ListView ID="ListViewTagList" runat="server" DataSourceID="SqlDataSourceTag">
        <EmptyDataTemplate>
            <div class="list-group-item ">Tag Not found.</div>
        </EmptyDataTemplate>
        <ItemTemplate>
            <div class="list-group-item d-flex justify-content-between align-items-center">
                <asp:HyperLink ID="HyperLink2" runat="server" CssClass ="text-capitalize" NavigateUrl='<%# "~/image/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Tagname")) %>' Text='<%# Eval("Tagname") %>'></asp:HyperLink>
             <span class="badge badge-primary badge-pill">
                 <asp:Label ID="Label1" runat="server" Text='<%# Eval("ImageCount") %>'></asp:Label></span>
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
        SelectCommand="SELECT TTOI.TagID, tt.tagname, TT.importance, count(TTOI.imageid) as ImageCount FROM [Table_TagOfImage] TTOI 
        left join table_Tag TT on TTOI.tagId= TT.Tagid
        where (TT.[STATUS] = 'Active')
        group by TTOI.TagID, TT.tagname, TT.importance 
        order by TT.Importance desc, ImageCount desc"></asp:SqlDataSource>
</div>
