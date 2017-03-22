<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Register Src="~/app_controls/web/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/app_controls/web/UserWallPost.ascx" TagPrefix="uc1" TagName="UserWallPost" %>
<%@ Register Src="~/app_controls/web/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/app_controls/web/UserWallPostBox.ascx" TagPrefix="uc1" TagName="UserWallPostBox" %>
<%@ Register Src="~/app_controls/web/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>


<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        UserWallPostBox.Wall_UserId = Session("UserId")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="row">
        <div class="col-md-3 col-sm-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-md-9 col-sm-9">
            <div class="row">
                <div class="col-xs-12">
                    <uc1:UserWallPostBox runat="server" ID="UserWallPostBox" />
                </div>
            </div>

            <div class="row">
                <div class="col-xs-12">
                    <asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="Wallid" DataSourceID="SqlDataSource1">
                        <EmptyDataTemplate>
                            <span>Nothing found.</span>
                        </EmptyDataTemplate>

                        <ItemTemplate>
                            <uc1:UserWallEntry runat="server" ID="UserWallEntry" UserID='<%# Eval("UserID")%>' RoutUserName='<%# Eval("RoutUserName")%>' UserName='<%# Eval("UserName")%>' WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' WallHeading='<%# Eval("Heading") %>' WallDatetime='<%# Eval("postdate") %>' WallMessage='<%# Eval("Message") %>'  WallPostImageURL='<%# "~/storage/image/" + Eval("PostImageFilename")%>' WallPostImageID ='<%# Eval("ImageID")%>' WallID='<%# Eval("Wallid")%>' Wall_UserId ='<%# Eval("Wall_UserId")%>' Wall_UserName ='<%# Eval("Wall_UserName")%>' Wall_RoutUserName ='<%# Eval("Wall_RoutUserName")%>' PreviewType='<%# [Enum].Parse(GetType(ClassHostAnySite.UserWall.PreviewTypeEnum), Eval("Preview_Type"), True) %>' Preview_Heading='<%# Eval("Preview_Heading")%>' Preview_TargetURL='<%# Eval("Preview_TargetURL")%>'  Preview_ImageURL ='<%# Eval("Preview_ImageURL")%>' Preview_BodyText='<%# Eval("Preview_BodyText")%>' numberofcomment='<%# Eval("numberofcomment")%>' />
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div id="itemPlaceholderContainer" runat="server">
                                <div runat="server" id="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>

                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                        SelectCommand="SELECT t.Wallid, t.heading, t.message, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userid, t.imageid, t.Wall_userid, t6.userName as Wall_userName, t6.RoutuserName as Wall_RoutuserName, t.Preview_Type, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, t2.RoutUserName, t2.UserName, t1.ImageFileName as PostImageFilename, t3.ImageFileName as userimagefilename, count(TUWC.wallId) as numberofcomment 
                        FROM [Table_UserWall] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left JOIN table_User t6 on t.Wall_userid = t6.userid
                        left JOIN Table_UserRelation t4 on t4.First_UserId = t.Wall_UserId
                        left JOIN Table_UserRelation t5 on t5.Second_UserId = t.Wall_UserId
                        left join table_userwallComment TUWC on t.Wallid=TUWC.wallId
                        WHERE (((t4.Second_UserId = @UserID) or (t5.First_UserId = @UserID)) or (t.Wall_UserId = @UserID)) and (t.wall_userid<>'0' ) 
                        group by t.Wallid, t.heading, t.message, t.postdate, t.userid, t.imageid, t.Wall_userid, t6.userName, t6.RoutuserName, t.Preview_Type, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, t2.RoutUserName, t2.UserName, t1.ImageFileName , t3.ImageFileName
                        ORDER BY t.[postdate] DESC">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="userid" Name="userid" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <div class="panel panel-default">
                        <div class="panel-footer clearfix">
                            <div class="pull-right">
                                <asp:DataPager runat="server" ID="DataPagerNotification" PagedControlID="ListViewNotification" PageSize="5">
                                    <Fields>
                                        <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                                    </Fields>
                                </asp:DataPager>
                            </div>
                            <div class="pull-Left"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

