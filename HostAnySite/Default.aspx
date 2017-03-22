<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/app_controls/web/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/app_controls/web/NavigationSideAdmin.ascx" TagPrefix="uc1" TagName="NavigationSideAdmin" %>
<%@ Register Src="~/app_controls/web/NavigationSideMain.ascx" TagPrefix="uc1" TagName="NavigationSideMain" %>
<%@ Register Src="~/app_controls/web/ImageCarousel.ascx" TagPrefix="uc1" TagName="ImageCarousel" %>
<%@ Register Src="~/app_controls/web/WhatsHappening.ascx" TagPrefix="uc1" TagName="WhatsHappening" %>
<%@ Register Src="~/app_controls/web/BlogInListView.ascx" TagPrefix="uc1" TagName="BlogInListView" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            ImageCarousel.Carousel_WebSetting = "HomeCarouselImage"
        End If

        Dim websetting As ClassHostAnySite.WebSetting.StructureWebSetting
        websetting = ClassHostAnySite.WebSetting.WebSetting_Get("HomeWelcomeNote", ClassAppDetails.DBCS)
        Panelwelcometext.Controls.Add(New LiteralControl(websetting.SettingValue))
        ' as dinamic LiteralControl used in above, need to load on every post back 
    End Sub

    Protected Sub SqlDataSourcePubicForum_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        If e.AffectedRows = 0 Then
            PanelHomeForum.Visible = False
        End If
        If e.AffectedRows <= 10 Then
            PanelHomeForumFooter.Visible = False
        End If
    End Sub

    Protected Sub SqlDataSourceBlog_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        If e.AffectedRows = 0 Then
            PanelHomeBlog.Visible = False
        End If
        If e.AffectedRows <= 10 Then
            PanelHomeBlogFooter.Visible = False
        End If
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-8">
            <div class="row">
                <div class="col-xs-12">
                    <uc1:ImageCarousel runat="server" ID="ImageCarousel" />
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12" style="margin-top: 10Px; margin-bottom: 20px;">
                    <asp:Panel ID="Panelwelcometext" runat="server"></asp:Panel>
                </div>
            </div>

            <asp:panel runat ="server" ID="PanelHomeForum" cssclass="panel panel-default">
                <asp:ListView ID="ListViewPublicForom" runat="server" DataSourceID="SqlDataSourcePubicForum" DataKeyNames="Forum_Id">
                    <EmptyDataTemplate>
                        <div class="table-responsive ">
                            <table runat="server" class="table">
                                <thead>
                                    <tr runat="server">
                                        <th runat="server" class="text-left ">Forum Heading</th>
                                        <th runat="server" class="text-center hidden-xs hidden-sm">Topics</th>
                                        <th runat="server" class="text-center hidden-xs hidden-sm">Posts</th>
                                        <th runat="server" class="hidden-xs hidden-sm">Create On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server">
                                        <td>No forum found.</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="text-left ">
                                <h4>
                                    <asp:HyperLink Text='<%# Eval("Heading") %>' CssClass=" text-capitalize " NavigateUrl='<%#"~/forum/" & Eval("Forum_Id") & "/" & ClassHostAnySite.HostAnySite.ConvertSpace2Dass(Eval("Heading"))%>' runat="server" ID="HeadingLabel" /><br>
                                    <small>
                                        <asp:Label Text='<%# Eval("Drescption") %>' CssClass=" text-capitalize " runat="server" ID="DrescptionLabel" />
                                    </small>
                                </h4>
                            </td>
                            <td class="text-center hidden-xs hidden-sm">
                                <asp:Label ID="LabelTC" runat="server" cssclass="label label-success" Text='<%# Eval("TopicCount") %>' />
                            </td>
                            <td class="text-center hidden-xs hidden-sm">
                                <asp:Label ID="LabelTRC" runat="server" cssclass="label label-info" Text='<%# Eval("TopicReplyCount") %>' />
                            </td>
                            <td class="hidden-xs hidden-sm">
                                <asp:HyperLink ID="HyperLinkUserName" CssClass=" text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                    <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# Eval("CreateDate")%>' />
                                </small>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div class="table-responsive ">
                            <table runat="server" class="table">
                                <thead>
                                    <tr runat="server">
                                        <th runat="server" class="text-left ">Forum Heading</th>
                                        <th runat="server" class="text-center hidden-xs hidden-sm">Topics</th>
                                        <th runat="server" class="text-center hidden-xs hidden-sm">Posts</th>
                                        <th runat="server" class="hidden-xs hidden-sm">Create On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </tbody>
                            </table>
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourcePubicForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                    SelectCommand="SELECT t.Forum_Id, t.Heading, t.Drescption, t.ForumBoard_Id, t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName, count(DISTINCT TFT.topic_id) as TopicCount, COUNT(DISTINCT TFTR.Id) as TopicReplyCount    
                          FROM [Table_Forum] t
                          left JOIN table_User TU on TU.userid = t.userid
                          left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                          left JOIN Table_ForumTopic TFT on t.forum_id = TFT.forum_id
                          left JOIN Table_ForumTopicReply TFTR on TFT.Topic_Id = TFTR.Topic_Id
                          where t.showinhome='Yes'
                          Group By  t.Forum_Id, t.Heading, t.Drescption, t.ForumBoard_Id, t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY t.[CreateDate] DESC" OnSelected="SqlDataSourcePubicForum_Selected"></asp:SqlDataSource>

                <asp:panel runat ="server" ID="PanelHomeForumFooter" cssclass="panel-footer clearfix">
                    <div class="pull-right">
                        <asp:DataPager runat="server" ID="DataPagerPublicForom" PagedControlID="ListviewPublicForom">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <div class="pull-Left"></div>
                </asp:panel>
            </asp:panel>
             <asp:panel runat ="server" ID="PanelHomeBlog" cssclass="panel panel-default ">
                <div class="panel-heading">Blogs</div>
                <div class="panel-body">
                    <asp:ListView ID="ListViewBlog" runat="server" DataSourceID="SqlDataSourceBlog" DataKeyNames="Blogid">
                        <EmptyDataTemplate>
                            <span>No blog found.</span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <uc1:BlogInListView runat="server" ID="BlogInListView" UserId ='<%# Eval("UserId") %>' UserName ='<%# Eval("UserName") %>' RoutUserName ='<%# Eval("RoutUserName") %>' BlogId ='<%# Eval("BlogId") %>' Heading ='<%# Eval("Heading") %>' Highlight ='<%# Eval("Highlight") %>' BlogImageId ='<%# Eval("ImageId") %>' BlogImageFileName ='<%# Eval("PostImageFilename") %>' PostDate ='<%# Eval("PostDate") %>' />
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" class="row">
                                <div runat="server" id="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceBlog" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT t.Blogid, t.Heading, t.Highlight, t.Containt, CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.userid, t2.username, t2.routusername, t1.ImageFileName as PostImageFilename, t.imageid  
                        FROM [Table_Blog] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        where t.showinhome='Yes'
                        ORDER BY [PostDate] DESC" OnSelected ="SqlDataSourceBlog_Selected">
                    </asp:SqlDataSource>
                </div>
                 <asp:panel runat ="server" ID="PanelHomeBlogFooter" cssclass="panel-footer clearfix">
                    <div class="pull-right">
                        <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ListViewBlog" PageSize="4">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </asp:panel>
            </asp:panel>
        </div>
        <div class="col-md-4">
            <uc1:NavigationSideMain runat="server" ID="NavigationSideMain" />
            <uc1:WhatsHappening runat="server" id="WhatsHappening" />
        </div>
    </div>
</asp:Content>

