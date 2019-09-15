<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Implements Interface="RoutSiteHomeInterface" %>

<%@ Register Src="~/App_Controls/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/App_Controls/BlogListByRecent.ascx" TagPrefix="uc1" TagName="BlogListByRecent" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>




<script runat="server">
    ' version 24/06/2019 # 4.27 AM

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim pageinfo As FirstClickerService.Version1.StaticPage.StructureStaticPage
        pageinfo = FirstClickerService.Version1.StaticPage.StaticPage_Get(FirstClickerService.Version1.StaticPage.PageNameList.Site_Default, WebAppSettings.DBCS)

        PanelPagebody.Controls.Add(New LiteralControl(pageinfo.PageBody))

        Title = pageinfo.Title
        MetaKeywords = pageinfo.Keyword
        MetaDescription = Page.MetaDescription
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
            <div class="row ">
                <div class ="col-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">
                    <asp:Panel ID="PanelPagebody" runat="server"></asp:Panel>
                </div>
            </div>



            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="horizontal" />
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
                        FROM [Table_UserWall] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left JOIN table_User t4 on t.Wall_userid = t4.userid
                        left join table_userwallComment TUWC on t.wallid=TUWC.wallId
                        where (T.ShowInHome='True') and (wall_userId != '0')
                        group by t.Wallid, t.heading, t.message, t.imageid, t1.ImageName, t1.ImageFileName , t3.ImageFileName, t.postdate, t.userid, t2.RoutUserName, t2.UserName, t.Wall_userid, t4.userName, t4.RoutuserName, t.Preview_Type, t.Preview_ID, t.Preview_Heading, t.Preview_TargetURL, t.Preview_ImageURL, t.Preview_BodyText, t.ShowInHome
                        ORDER BY t.[postdate] DESC">
                <SelectParameters>
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
        <div class="col-12 col-sm-12 col-md-12 col-lg-4 col-xl-4">
            <uc1:BlogListByRecent runat="server" ID="BlogListByRecent" />
            <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat="rectangle" />
            <div class="card  BoxEffect6 mt-2 mb-4">
                <div class="card-header bg-info">
                    Recent Forums
                </div>
                <asp:ListView ID="ListViewPublicForom" runat="server" DataSourceID="SqlDataSourcePubicForum" DataKeyNames="ForumId">
                    <EmptyDataTemplate>

                        <tr runat="server">
                            <td>
                                <div class="list-group-item bg-light">No forum found.</div>
                            </td>
                            <td></td>
                        </tr>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="text-left ">
                                <h5>
                                    <asp:HyperLink Text='<%# Eval("Heading") %>' CssClass=" text-capitalize " NavigateUrl='<%#"~/forum/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("ForumId")  %>' runat="server" ID="HeadingLabel" /><br>
                                    <small>
                                        <asp:Label Text='<%# Eval("Drescption") %>' CssClass=" text-capitalize " runat="server" ID="DrescptionLabel" />
                                    </small>
                                </h5>
                                <div>
                                    <asp:HyperLink ID="HyperLink1" CssClass=" text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                    <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                        <asp:Label ID="Label1" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("CreateDate")) %>' /></small>
                                </div>
                            </td>
                            <td class="text-center">
                                <asp:Label ID="LabelTC" runat="server" CssClass="label label-success" Text='<%# Eval("TopicCount") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div class="card-body">
                            <div class="table-responsive ">
                                <table runat="server" class="table">
                                    <thead>
                                        <tr runat="server">
                                            <th runat="server" class="text-left ">Forum Heading</th>
                                            <th runat="server" class="text-center">Topics</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourcePubicForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                    SelectCommand="SELECT t.ForumId, t.Heading, t.Drescption, t.UserId, CONVERT(VARCHAR(19), t.CreateDate, 120) AS CreateDate, TU.username, TU.routusername, TUI.ImageFileName, count(DISTINCT TFT.topicid) as TopicCount, COUNT(DISTINCT TFTR.Id) as TopicReplyCount
                          FROM [Table_Forum] t
                          left JOIN table_User TU on TU.userid = t.userid
                          left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                          left JOIN Table_ForumTopic TFT on t.forumid = TFT.forumid
                          left JOIN Table_ForumTopicReply TFTR on TFT.TopicId = TFTR.TopicId
                          Group By  t.ForumId, t.Heading, t.Drescption,  t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY t.[CreateDate] DESC"></asp:SqlDataSource>
                <div class="card-footer clearfix" hidden="hidden">
                    <div class="float-right">
                        <asp:DataPager runat="server" ID="DataPagerPublicForom" QueryStringField="Page" PagedControlID="ListviewPublicForom" PageSize="5">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <div class="float-Left"></div>
                </div>
            </div>



        </div>
    </div>



</asp:Content>

