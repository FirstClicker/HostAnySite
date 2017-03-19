<%@ Control Language="VB" ClassName="WhatsHappening" %>
<%@ Register Src="~/app_controls/web/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>

<script runat="server">

</script>
<div class="panel panel-default">
    <div class="panel-heading">What's Happening?</div>
    <div class="list-group">
        <asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="wallID" DataSourceID="SqlDataSource1">
            <EmptyDataTemplate>
                <div class="panel-body ">No user activity.</div>
            </EmptyDataTemplate>
            <ItemTemplate>
                <uc1:userwallentry runat="server" id="UserWallEntry" walluserurl='<%# "~/user/" + Eval("RoutUserName")%>' walluserimage='<%# "~/storage/image/" + Eval("userimagefilename")%>' wallheading='<%# Eval("Heading") %>' walldatetime='<%# Eval("postdate")%>' wallmessage='<%# Eval("Message") %>' wallpostimage='<%# "~/storage/image/" + Eval("PostImageFilename")%>'    wallid='<%# Eval("wallId")%>' numberofcomment='<%# Eval("numberofcomment")%>' UserID ='<%# Eval("UserID")%>' />
            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server">
                    <div runat="server" id="itemPlaceholder" />
                </div>
            </LayoutTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT t.wallid, t.heading, t.message, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userid, t.imageid, t2.RoutUserName, t1.ImageFileName as PostImageFilename, t3.ImageFileName as userimagefilename, count(TUWC.wallId) as numberofcomment 
                        FROM [Table_UserWall] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left join table_userwallComment TUWC on t.wallid=TUWC.wallId
                        where (t.[UserId] <> @UserId)
                        group by t.wallid, t.heading, t.message, t.postdate, t.userid, t.imageid, t2.RoutUserName, t1.ImageFileName , t3.ImageFileName  
                        ORDER BY t.[postdate] DESC">
            <SelectParameters>
                 <asp:SessionParameter SessionField="userid" Name="userid" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <div class="panel-footer clearfix">
        <div class="pull-right">
            <asp:DataPager runat="server" ID="DataPagerNotification" PagedControlID="ListViewNotification" PageSize="5">
                <Fields>
                    <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                </Fields>
            </asp:DataPager>
        </div>
    </div>
</div>

