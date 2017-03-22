<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Implements Interface="ClassHostAnySite.RoutUserInterface" %>
<%@ Register Src="~/app_controls/web/UserWallPost.ascx" TagPrefix="uc1" TagName="UserWallPost" %>
<%@ Register Src="~/app_controls/web/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/app_controls/web/UserWallPostBox.ascx" TagPrefix="uc1" TagName="UserWallPostBox" %>
<%@ Register Src="~/app_controls/web/MenuUserProfile.ascx" TagPrefix="uc1" TagName="MenuUserProfile" %>
<%@ Register Src="~/app_controls/web/UserRelationStatusButton.ascx" TagPrefix="uc1" TagName="UserRelationStatusButton" %>
<%@ Register Src="~/app_controls/web/WhatsHappening.ascx" TagPrefix="uc1" TagName="WhatsHappening" %>


<script runat="server">
    Private m_RoutFace_RoutUserName As String
    Public Property RoutFace_RoutUserName() As String Implements ClassHostAnySite.RoutUserInterface.RoutIFace_RoutUserName
        Get
            Return m_RoutFace_RoutUserName
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutUserName = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim userinfo As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.UserDetail_RoutUserName(RoutFace_RoutUserName, ClassAppDetails.DBCS)
            If userinfo.Result = False Then
                Response.Redirect("~/")
                Exit Sub
            End If

            MenuUserProfile.UserName = Trim(userinfo.UserName)
            MenuUserProfile.ImageFileName = userinfo.UserImage.ImageFileName
            MenuUserProfile.RoutUserName = userinfo.RoutUserName

            ImageUserBanner.ImageUrl = "~/storage/image/" & userinfo.BannerImage.ImageFileName

            UserRelationStatusButton.UserID = userinfo.UserID
            UserRelationStatusButton.UserName = Trim(userinfo.UserName)
            UserRelationStatusButton.RoutUserName = userinfo.RoutUserName

            UserWallPostBox.Wall_UserId = userinfo.UserID
        End If

        Me.Title = MenuUserProfile.UserName
        Me.MetaDescription = MenuUserProfile.UserName & "' profile"
        Me.MetaKeywords = ""
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-9">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-default" style="margin: 0px;">
                        <asp:Image ID="ImageUserBanner" ImageUrl="http://firstclicker.com/Service/Image/social-banner.png" CssClass="img-responsive" runat="server" />
                    </div>
                </div>
                <div class="col-sm-12">
                    <div style="margin: 15px;">
                        <uc1:UserRelationStatusButton runat="server" ID="UserRelationStatusButton" />
                    </div>
                </div>
            </div>
            <div class="row"></div>
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-3">
                    <uc1:MenuUserProfile runat="server" ID="MenuUserProfile" />
                </div>
                <div class="col-lg-9 col-md-9 col-sm-9">
                    <uc1:UserWallPostBox runat="server" ID="UserWallPostBox" />
                    <asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="Wallid" DataSourceID="SqlDataSource1">
                        <EmptyDataTemplate>
                            <span>Nothing posted yet.</span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <!-- Comment -->
                            <uc1:UserWallEntry runat="server" ID="UserWallEntry" UserID='<%# Eval("UserID")%>' RoutUserName='<%# Eval("RoutUserName")%>' UserName='<%# Eval("UserName")%>'  WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' WallHeading='<%# Eval("Heading") %>' WallDatetime='<%# Eval("postdate") %>' WallMessage='<%# Eval("Message") %>' WallPostImageID='<%# Eval("PostImageID") %>'  WallPostImageURL='<%# "~/storage/image/" + Eval("PostImageFilename")%>'  WallID='<%# Eval("Wallid")%>' Wall_UserId ='<%# Eval("Wall_UserId")%>' Wall_UserName ='<%# Eval("Wall_UserName")%>' Wall_RoutUserName ='<%# Eval("Wall_RoutUserName")%>' PreviewType='<%# [Enum].Parse(GetType(ClassHostAnySite.UserWall.PreviewTypeEnum), Eval("Preview_Type"), True) %>' Preview_Heading='<%# Eval("Preview_Heading")%>' Preview_TargetURL='<%# Eval("Preview_TargetURL")%>' Preview_ImageURL='<%# Eval("Preview_ImageURL")%>' Preview_BodyText='<%# Eval("Preview_BodyText")%>' numberofcomment='<%# Eval("numberofcomment")%>' />
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div id="itemPlaceholderContainer" runat="server">
                                <div runat="server" id="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                        SelectCommand="SELECT t.Wallid, t.heading, t.message, t.ImageID as PostImageID, t1.ImageFileName as PostImageFilename, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userid, t2.RoutUserName, t2.UserName, t3.ImageFileName as userimagefilename, t.Wall_userid, t4.userName as Wall_userName, t4.RoutuserName as Wall_RoutuserName, t.Preview_Type, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, count(TUWC.wallId) as numberofcomment 
                        FROM [Table_UserWall] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left JOIN table_User t4 on t.Wall_userid = t4.userid
                        left join table_userwallComment TUWC on t.Wallid=TUWC.wallId
                        WHERE (t.wall_userid = @UserID) 
                        group by t.Wallid, t.heading, t.message, t.imageid, t1.ImageFileName , t3.ImageFileName, t.postdate, t.userid, t2.RoutUserName, t2.UserName, t.Wall_userid, t4.userName, t4.RoutuserName, t.Preview_Type, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText
                        ORDER BY t.[postdate] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="UserRelationStatusButton" PropertyName="userid" Name="UserID" Type="String"></asp:ControlParameter>
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
        <div class="col-lg-3">
            <uc1:WhatsHappening runat="server" ID="WhatsHappening" />
        </div>
    </div>
</asp:Content>