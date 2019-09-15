<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>
<%@ Register Src="~/App_Controls/UserWallSubmitBox.ascx" TagPrefix="uc1" TagName="UserWallSubmitBox" %>
<%@ Register Src="~/App_Controls/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>


<script runat="server">
    ' version 24/06/2019 # 4.27 AM


    Protected Sub SqlDataSourceDashboardWall_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        If e.AffectedRows <= 0 Then panelDataPager.Visible = False
    End Sub


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <uc1:UserWallSubmitBox runat="server" ID="UserWallSubmitBox" />
            <asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="Wallid" DataSourceID="SqlDataSourceDashboardWall">
                <EmptyDataTemplate>
                    <div class="card m-3 ">
                        <div class="card-body">Nothing found...
                            <br />
                            Try following few members or content..
                        </div>
                    </div>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <uc1:UserWallEntry runat="server" ID="UserWallEntry" UserID='<%# Eval("UserID")%>' RoutUserName='<%# Eval("RoutUserName")%>' UserName='<%# Eval("UserName")%>' WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' WallHeading='<%# Eval("Heading") %>' WallDatetime='<%# Eval("postdate") %>' WallMessage='<%# Eval("Message") %>' WallPostImageID='<%# Eval("ImageID")%>'  WallPostImageName='<%# Eval("PostImageName")%>' WallPostImageURL='<%# "~/storage/image/" + Eval("PostImageFilename")%>' WallID='<%# Eval("Wallid")%>' Wall_UserId='<%# Eval("Wall_UserId")%>' Wall_UserName='<%# Eval("Wall_UserName")%>' Wall_RoutUserName='<%# Eval("Wall_RoutUserName")%>' PreviewType='<%#  Eval("Preview_Type") %>' Preview_ID='<%# Eval("Preview_ID")%>' Preview_Heading='<%# Eval("Preview_Heading")%>' Preview_TargetURL='<%# Eval("Preview_TargetURL")%>' Preview_ImageURL='<%# Eval("Preview_ImageURL")%>' Preview_BodyText='<%# Eval("Preview_BodyText")%>' numberofcomment='<%# Eval("numberofcomment")%>' />
                </ItemTemplate>
                <LayoutTemplate>
                    <div id="itemPlaceholderContainer" runat="server">
                        <div runat="server" id="itemPlaceholder" />
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource ID="SqlDataSourceDashboardWall" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelected="SqlDataSourceDashboardWall_Selected"
                SelectCommand="SELECT t.Wallid, t.heading, t.message, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userid, t.imageid, TWI.ImageName as PostImagename, TWI.ImageFileName as PostImageFilename, t.Wall_userid, TWU.userName as Wall_userName, TWU.RoutuserName as Wall_RoutuserName, t.Preview_Type, t.Preview_Id, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, TU.RoutUserName, TU.UserName, TUI.ImageFileName as userimagefilename, count(TUWC.wallId) as numberofcomment 
                        FROM [Table_UserWall] t
                        left JOIN table_image TWI ON t.ImageID=TWI.ImageID 
                        left JOIN table_User TU on t.userid = TU.userid
                        left JOIN table_image TUI on TU.Imageid = TUI.Imageid
                        left JOIN table_User TWU on t.Wall_userid = TWU.userid
                        left JOIN Table_UserRelation TURF on TURF.First_UserId = t.Wall_UserId
                        left JOIN Table_UserRelation TURS on TURS.Second_UserId = t.Wall_UserId
                        left join table_userwallComment TUWC on t.Wallid=TUWC.wallId
                        WHERE (((TURF.Second_UserId = @UserID) or (TURS.First_UserId = @UserID)) or (t.Wall_UserId = @UserID)) and (t.wall_userid != '0' )  
                        group by t.Wallid, t.heading, t.message, t.postdate, t.userid, t.imageid, t.Wall_userid, TWU.userName, TWU.RoutuserName, t.Preview_Type, t.Preview_Id, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, TU.RoutUserName, TU.UserName, TWI.ImageFileName, TWI.ImageName, TUI.ImageFileName
                        ORDER BY t.[postdate] DESC">
                <SelectParameters>
                    <asp:SessionParameter SessionField="userid" Name="userid" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel runat="server" ID="panelDataPager" CssClass="card">
                <div class="card-footer clearfix">
                    <div class="float-right">
                        <asp:DataPager runat="server" ID="DataPagerNotification" PagedControlID="ListViewNotification" PageSize="5">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <div class="float-Left"></div>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>

