<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Implements Interface="RoutUserInterface" %>

<%@ Register Src="~/App_Controls/NavigationSideUserProfile.ascx" TagPrefix="uc1" TagName="NavigationSideUserProfile" %>
<%@ Register Src="~/App_Controls/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/App_Controls/UserWallSubmitBox.ascx" TagPrefix="uc1" TagName="UserWallSubmitBox" %>


<script runat="server">
    ' version 24/06/2019 # 4.27 AM

    Private m_RoutFace_RoutUserName As String
    Public Property RoutFace_RoutUserName() As String Implements RoutUserInterface.RoutIFace_RoutUserName
        Get
            Return m_RoutFace_RoutUserName
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutUserName = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim userinfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_RoutUserName(RoutFace_RoutUserName, WebAppSettings.DBCS)
            If userinfo.Result = False Then
                Response.Redirect("~/")
                Exit Sub
            End If

            NavigationSideUserProfile.UserName = Trim(userinfo.UserName)
            NavigationSideUserProfile.ImageFileName = userinfo.UserImage.ImageFileName
            NavigationSideUserProfile.RoutUserName = userinfo.RoutUserName
            NavigationSideUserProfile.UserID = userinfo.UserID

            ImageUserBanner.ImageUrl = "~/storage/image/" & userinfo.BannerImage.ImageFileName


            UserWallSubmitBox.Wall_UserId = userinfo.UserID
        End If

        Me.Title = NavigationSideUserProfile.UserName & "' profile"
        Me.MetaDescription = NavigationSideUserProfile.UserName & "' profile"
        Me.MetaKeywords = ""
    End Sub

    Protected Sub SqlDataSource1_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        If e.AffectedRows <= 0 Then panelDataPager.Visible = False
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <div class="card  m-1 BoxEffect8">
                <asp:Image ID="ImageUserBanner" ImageUrl="~/Content/image/ProfileBanner.png" CssClass="img-fluid" runat="server" />
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideUserProfile runat="server" ID="NavigationSideUserProfile" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <uc1:UserWallSubmitBox runat="server" ID="UserWallSubmitBox" />
            <asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="Wallid" DataSourceID="SqlDataSource1">
                <EmptyDataTemplate>
                    <div class="card m-3 ">
                        <div class="card-body">
                            Nothing posted yet...
                            <br />
                            Vist some time after or message him/her directly...
                        </div>
                    </div>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <uc1:UserWallEntry runat="server" ID="UserWallEntry" UserID='<%# Eval("UserID")%>' RoutUserName='<%# Eval("RoutUserName")%>' UserName='<%# Eval("UserName")%>' WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' WallHeading='<%# Eval("Heading") %>' WallDatetime='<%# Eval("postdate") %>' WallMessage='<%# Eval("Message") %>' WallPostImageID='<%# Eval("PostImageID") %>' WallPostImageName='<%# Eval("PostImageName")%>' WallPostImageURL='<%# "~/storage/image/" + Eval("PostImageFilename")%>' WallID='<%# Eval("Wallid")%>' Wall_UserId='<%# Eval("Wall_UserId")%>' Wall_UserName='<%# Eval("Wall_UserName")%>' Wall_RoutUserName='<%# Eval("Wall_RoutUserName")%>' PreviewType='<%# Eval("Preview_Type") %>' Preview_ID='<%# Eval("Preview_ID")%>' Preview_Heading='<%# Eval("Preview_Heading")%>' Preview_TargetURL='<%# Eval("Preview_TargetURL")%>' Preview_ImageURL='<%# Eval("Preview_ImageURL")%>' Preview_BodyText='<%# Eval("Preview_BodyText")%>' numberofcomment='<%# Eval("numberofcomment")%>' />
                </ItemTemplate>
                <LayoutTemplate>
                    <div id="itemPlaceholderContainer" runat="server">
                        <div runat="server" id="itemPlaceholder" />
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelected="SqlDataSource1_Selected"
                SelectCommand="SELECT t.Wallid, t.heading, t.message, t.ImageID as PostImageID, t1.ImageName as PostImageName, t1.ImageFileName as PostImageFilename, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userid, t2.RoutUserName, t2.UserName, t3.ImageFileName as userimagefilename, t.Wall_userid, t4.userName as Wall_userName, t4.RoutuserName as Wall_RoutuserName, t.Preview_Type, t.preview_ID, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, count(TUWC.wallId) as numberofcomment 
                        FROM [Table_UserWall] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left JOIN table_User t4 on t.Wall_userid = t4.userid
                        left join table_userwallComment TUWC on t.Wallid=TUWC.wallId
                        WHERE (t.wall_userid = @UserID) 
                        group by t.Wallid, t.heading, t.message, t.imageid, t1.ImageName, t1.ImageFileName , t3.ImageFileName, t.postdate, t.userid, t2.RoutUserName, t2.UserName, t.Wall_userid, t4.userName, t4.RoutuserName, t.Preview_Type, t.preview_ID, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText
                        ORDER BY t.[postdate] DESC">
                <SelectParameters>
                    <asp:ControlParameter ControlID="NavigationSideUserProfile" PropertyName="userid" Name="UserID" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:panel runat ="server" ID="PanelDataPager" cssclass="card">
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
            </asp:panel>
        </div>
    </div>

</asp:Content>

