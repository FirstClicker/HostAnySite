<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>
<%@ Register Src="~/App_Controls/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>


<script runat="server">
    ' version 24/06/2019 # 4.27 AM

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            DropDownListShowInHome.DataSource = System.Enum.GetValues(GetType(FirstClickerService.Version1.UserWall.ShowInHomeEnum))
            DropDownListShowInHome.DataBind()


            If Request.QueryString("ShowInHome") = Nothing Or Trim(Request.QueryString("ShowInHome")) = "" Then
                Response.Redirect("~/adminpanel/wall/?ShowInHome=Pending")
            End If

            Dim ListItem As ListItem = DropDownListShowInHome.Items.FindByValue(Trim(Request.QueryString("ShowInHome")))

            If (ListItem IsNot Nothing) Then
                DropDownListShowInHome.ClearSelection()
                DropDownListShowInHome.Items.FindByValue(Trim(Request.QueryString("ShowInHome"))).Selected = True
            End If

        End If

    End Sub

    Protected Sub DropDownListShowInHome_SelectedIndexChanged(sender As Object, e As EventArgs)
        Response.Redirect("~/adminpanel/wall/?ShowInHome=" & DropDownListShowInHome.SelectedValue)
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
          <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix ">
                    <div class="float-right ">
                        <asp:DropDownList ID="DropDownListShowInHome" CssClass ="form-control" runat="server" OnSelectedIndexChanged="DropDownListShowInHome_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                    </div>
                    <h5 class="card-title m-0 ">
                        Review Wall Post
                    </h5>
                </div>
            </div>


            <asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="wallID" DataSourceID="SqlDataSource1">
                <EmptyDataTemplate>
                    <div class="card-body ">No user activity.</div>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <uc1:UserWallEntry runat="server" ID="UserWallEntry" UserID='<%# Eval("UserID")%>' RoutUserName='<%# Eval("RoutUserName")%>' UserName='<%# Eval("UserName")%>' WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' WallHeading='<%# Eval("Heading") %>' WallDatetime='<%# Eval("postdate")%>' WallMessage='<%# Eval("Message") %>' WallPostImageID='<%# Eval("PostImageID")%>' WallPostImageName='<%# Eval("PostImageName")%>' WallPostImageURL='<%# "~/storage/image/" + Eval("PostImageFilename")%>' WallID='<%# Eval("wallId")%>' Wall_UserId='<%# Eval("Wall_UserId")%>' Wall_UserName='<%# Eval("Wall_UserName")%>' Wall_RoutUserName='<%# Eval("Wall_RoutUserName")%>' PreviewType='<%#  Eval("Preview_Type") %>' Preview_ID='<%# Eval("Preview_ID")%>' Preview_Heading='<%# Eval("Preview_Heading")%>' Preview_TargetURL='<%# Eval("Preview_TargetURL")%>' Preview_ImageURL='<%# Eval("Preview_ImageURL")%>' Preview_BodyText='<%# Eval("Preview_BodyText")%>' ShowInHome='<%# [Enum].Parse(GetType(FirstClickerService.Version1.UserWall.ShowInHomeEnum), Eval("ShowInHome"), True) %>' numberofcomment='<%# Eval("numberofcomment")%>' />
                </ItemTemplate>
                <LayoutTemplate>
                    <div id="itemPlaceholderContainer" runat="server">
                        <div runat="server" id="itemPlaceholder" />
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" CancelSelectOnNullParameter="false"
                SelectCommand="SELECT t.Wallid, t.heading, t.message, t.ImageID as PostImageID, t1.ImageName as PostImageName, t1.ImageFileName as PostImageFilename, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userid, t2.RoutUserName, t2.UserName, t3.ImageFileName as userimagefilename, t.Wall_userid, t4.userName as Wall_userName, t4.RoutuserName as Wall_RoutuserName, t.Preview_Type, t.Preview_ID, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, t.ShowInHome, count(TUWC.wallId) as numberofcomment 
                        FROM [Table_UserWall] T
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left JOIN table_User t4 on t.Wall_userid = t4.userid
                        left join table_userwallComment TUWC on t.wallid=TUWC.wallId
                        where (T.ShowInHome=@ShowInHome) and (wall_userId != '0')
                        group by t.Wallid, t.heading, t.message, t.imageid, t1.ImageName, t1.ImageFileName , t3.ImageFileName, t.postdate, t.userid, t2.RoutUserName, t2.UserName, t.Wall_userid, t4.userName, t4.RoutuserName, t.Preview_Type, t.Preview_ID, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, t.ShowInHome
                        ORDER BY t.[postdate] DESC">
                <SelectParameters>
                   <asp:QueryStringParameter Name ="ShowInHome" QueryStringField ="ShowInHome" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <div class="card-footer clearfix">
                <div class="float-right">
                    <asp:DataPager runat="server" ID="DataPagerNotification" PagedControlID="ListViewNotification" PageSize="5" QueryStringField="WallPage">
                        <Fields>
                            <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>

        </div>
    </div>




</asp:Content>

