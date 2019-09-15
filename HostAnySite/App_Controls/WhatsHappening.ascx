<%@ Control Language="VB" ClassName="WhatsHappening" %>
<%@ Import Namespace="System.ComponentModel" %>

<%@ Register Src="~/app_controls/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>

<script runat="server">
    Public Property UserId_Except() As String
        Get
            Return LabelUserId_Except.Text
        End Get
        Set(ByVal value As String)
            LabelUserId_Except.Text = value
        End Set
    End Property

    Public Property Pagesize() As Long
        Get
            Return Val(LabelPagesize.Text)
        End Get
        Set(ByVal value As Long)
            LabelPagesize.Text = value
        End Set
    End Property




    Protected Sub Page_PreRender(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        DataPagerNotification.PageSize = Pagesize
    End Sub
</script>
<asp:Label ID="LabelPagesize" runat="server" Text="5" Visible="false"></asp:Label>
<asp:Label ID="LabelUserId_Except" runat="server" Text="0" Visible="false"></asp:Label>

<asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="wallID" DataSourceID="SqlDataSource1">
    <EmptyDataTemplate>
        <div class="card-body ">No user activity.</div>
    </EmptyDataTemplate>
    <ItemTemplate>
        <uc1:UserWallEntry runat="server" ID="UserWallEntry" UserID='<%# Eval("UserID")%>' RoutUserName='<%# Eval("RoutUserName")%>' UserName='<%# Eval("UserName")%>' WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' WallHeading='<%# Eval("Heading") %>' WallDatetime='<%# Eval("postdate")%>' WallMessage='<%# Eval("Message") %>' WallPostImageID='<%# Eval("PostImageID")%>' WallPostImageName='<%# Eval("PostImageName")%>' WallPostImageURL='<%# "~/storage/image/" + Eval("PostImageFilename")%>' WallID='<%# Eval("wallId")%>' Wall_UserId='<%# Eval("Wall_UserId")%>' Wall_UserName='<%# Eval("Wall_UserName")%>' Wall_RoutUserName='<%# Eval("Wall_RoutUserName")%>' PreviewType='<%# [Enum].Parse(GetType(FirstClickerService.Version1.UserWall.PreviewTypeEnum), Eval("Preview_Type"), True) %>' Preview_ID='<%# Eval("Preview_ID")%>' Preview_Heading='<%# Eval("Preview_Heading")%>' Preview_TargetURL='<%# Eval("Preview_TargetURL")%>' Preview_ImageURL='<%# Eval("Preview_ImageURL")%>' Preview_BodyText='<%# Eval("Preview_BodyText")%>' numberofcomment='<%# Eval("numberofcomment")%>' />
    </ItemTemplate>
    <LayoutTemplate>
        <div id="itemPlaceholderContainer" runat="server">
            <div runat="server" id="itemPlaceholder" />
        </div>
    </LayoutTemplate>
</asp:ListView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" CancelSelectOnNullParameter="false"
    SelectCommand="SELECT t.Wallid, t.heading, t.message, t.ImageID as PostImageID, t1.ImageName as PostImageName, t1.ImageFileName as PostImageFilename, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userid, t2.RoutUserName, t2.UserName, t3.ImageFileName as userimagefilename, t.Wall_userid, t4.userName as Wall_userName, t4.RoutuserName as Wall_RoutuserName, t.Preview_Type, t.Preview_ID, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, count(TUWC.wallId) as numberofcomment 
                        FROM [Table_UserWall] T
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left JOIN table_User t4 on t.Wall_userid = t4.userid
                        left join table_userwallComment TUWC on t.wallid=TUWC.wallId
                        where (t.[UserId] != @UserId_Except) and (t.[Wall_UserId] != 0)
                        group by t.Wallid, t.heading, t.message, t.imageid, t1.ImageName, t1.ImageFileName , t3.ImageFileName, t.postdate, t.userid, t2.RoutUserName, t2.UserName, t.Wall_userid, t4.userName, t4.RoutuserName, t.Preview_Type, t.Preview_ID, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText
                        ORDER BY t.[postdate] DESC">
    <SelectParameters>
        <asp:ControlParameter ControlID="LabelUserId_Except" Name="UserId_Except" PropertyName="Text" Type="Decimal" />
        <asp:SessionParameter SessionField="userid" Name="userid" Type="String" DefaultValue="0" />

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


