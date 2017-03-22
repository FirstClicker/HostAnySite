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
                <uc1:userwallentry runat="server" id="UserWallEntry" UserID='<%# Eval("UserID")%>' RoutUserName='<%# Eval("RoutUserName")%>' UserName='<%# Eval("UserName")%>' WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' wallheading='<%# Eval("Heading") %>' walldatetime='<%# Eval("postdate")%>' wallmessage='<%# Eval("Message") %>' WallPostImageID='<%# Eval("PostImageID")%>' WallPostImageURL='<%# "~/storage/image/" + Eval("PostImageFilename")%>' wallid='<%# Eval("wallId")%>' Wall_UserId ='<%# Eval("Wall_UserId")%>' Wall_UserName ='<%# Eval("Wall_UserName")%>' Wall_RoutUserName ='<%# Eval("Wall_RoutUserName")%>' PreviewType='<%# [Enum].Parse(GetType(ClassHostAnySite.UserWall.PreviewTypeEnum), Eval("Preview_Type"), True) %>' Preview_Heading='<%# Eval("Preview_Heading")%>' Preview_TargetURL='<%# Eval("Preview_TargetURL")%>' Preview_ImageURL ='<%# Eval("Preview_ImageURL")%>' Preview_BodyText='<%# Eval("Preview_BodyText")%>' numberofcomment='<%# Eval("numberofcomment")%>' />
            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server">
                    <div runat="server" id="itemPlaceholder" />
                </div>
            </LayoutTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                        SelectCommand="SELECT t.Wallid, t.heading, t.message, t.ImageID as PostImageID, t1.ImageFileName as PostImageFilename, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userid, t2.RoutUserName, t2.UserName, t3.ImageFileName as userimagefilename, t.Wall_userid, t4.userName as Wall_userName, t4.RoutuserName as Wall_RoutuserName, t.Preview_Type, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, count(TUWC.wallId) as numberofcomment 
                        FROM [Table_UserWall] T
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left JOIN table_User t4 on t.Wall_userid = t4.userid
                        left join table_userwallComment TUWC on t.wallid=TUWC.wallId
                        where (t.[UserId] <> @UserId) and (t.[Wall_UserId]<>0)
                        group by t.Wallid, t.heading, t.message, t.imageid, t1.ImageFileName , t3.ImageFileName, t.postdate, t.userid, t2.RoutUserName, t2.UserName, t.Wall_userid, t4.userName, t4.RoutuserName, t.Preview_Type, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText
                        ORDER BY t.[postdate] DESC">
            <SelectParameters>
                 <asp:SessionParameter SessionField="userid" Name="userid" Type="String" DefaultValue="0" />
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

