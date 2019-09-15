<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface ="RoutSiteHomeInterface"  %>

<%@ Register Src="~/App_Controls/TagOfAllForums.ascx" TagPrefix="uc1" TagName="TagOfAllForums" %>
<%@ Register Src="~/App_Controls/PagingControl.ascx" TagPrefix="uc1" TagName="PagingControl" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>




<script runat="server">
    ' version 14/08/2018 # 1.27 AM


    Protected Sub Page_Load(sender As Object, e As EventArgs)

        If IsPostBack = False Then

            PagingControl.CurrentPage = 1
            PagingControl.BaseURL = "~/Forum/"

        End If

        Dim pageinfo As FirstClickerService.Version1.StaticPage.StructureStaticPage
        pageinfo = FirstClickerService.Version1.StaticPage.StaticPage_Get(FirstClickerService.Version1.StaticPage.PageNameList.Site_Forum_Default, WebAppSettings.DBCS)

        PanelPagebody.Controls.Add(New LiteralControl(pageinfo.PageBody))
        ' as dinamic LiteralControl used in above, need to load on every post back 

        HyperLinkHeading.Text = pageinfo.Title

        Dim mytitle As String
        Dim myDescription As String

        mytitle = pageinfo.Title
        myDescription = Page.MetaDescription


        Title = mytitle
        MetaDescription = myDescription



    End Sub

    Protected Sub SqlDataSourcePubicForum_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        PagingControl.LastPage = CInt(e.AffectedRows / DataPagerForom.PageSize)
        If e.AffectedRows > Val(PagingControl.LastPage) * DataPagerForom.PageSize Then
            PagingControl.LastPage = Val(PagingControl.LastPage) + 1
        End If

        If e.AffectedRows <= DataPagerForom.PageSize Then
            panelfooter.Visible = False
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="horizontal" />

            <div class="card BoxEffect6 mt-2">
                <div class="card-header p-2 clearfix">
                    <div class="float-right">
                        <asp:HyperLink ID="HyperLink2" NavigateUrl="~/Dashboard/Forum/Create.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Create Forum</asp:HyperLink>
                    </div>
                    <h5 class="card-title m-0 ">
                        <i class="fab fa-foursquare"></i>&nbsp;<asp:HyperLink ID="HyperLinkHeading" runat="server" NavigateUrl="~/Forum/">Forum</asp:HyperLink>
                    </h5>
                </div>
            </div>
            <div class="card-body">
                <asp:ListView ID="ListViewPublicForom" runat="server" DataSourceID="SqlDataSourcePubicForum" DataKeyNames="ForumId">
                    <EmptyDataTemplate>
                        <div class="table-responsive ">
                            <table runat="server" class="table">
                                <thead>
                                    <tr runat="server">
                                        <th runat="server" class="text-left ">Forum Heading</th>
                                        <th runat="server" class="text-center">Topics</th>
                                        <th runat="server" class="text-center">Posts</th>
                                        <th runat="server" class="d-none d-md-block">Create On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server">
                                        <td>No forum found.</td>
                                        <td></td>
                                        <td></td>
                                        <td class="d-none d-md-block"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="text-left ">
                                 <h4 class="text-primary">
                                    <asp:HyperLink Text='<%# Eval("Heading") %>' CssClass=" text-capitalize " NavigateUrl='<%#"~/forum/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("ForumId") %>' runat="server" ID="HeadingLabel" /><br>
                                </h4>
                                <p>
                                    <asp:Label Text='<%# Eval("Drescption") %>' CssClass=" text-capitalize " runat="server" ID="DrescptionLabel" />
                                </p> 
                                <div class="d-md-none">
                                    <asp:HyperLink ID="HyperLink1" CssClass=" text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                    <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                        <asp:Label ID="Label1" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("CreateDate")) %>' /></small>
                                </div>
                            </td>
                            <td class="text-center">
                                <asp:Label ID="LabelTC" runat="server" CssClass="label label-success" Text='<%# Eval("TopicCount") %>' />
                            </td>
                            <td class="text-center">
                                <asp:Label ID="LabelTRC" runat="server" CssClass="label label-info" Text='<%# Eval("TopicReplyCount") %>' />
                            </td>
                            <td class="d-none d-md-block">
                                <asp:HyperLink ID="HyperLinkUserName" CssClass=" text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                    <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("CreateDate")) %>' /></small>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div class="table-responsive ">
                            <table runat="server" class="table">
                                <thead>
                                    <tr runat="server">
                                        <th runat="server" class="text-left ">Forum Heading</th>
                                        <th runat="server" class="text-center">Topics</th>
                                        <th runat="server" class="text-center">Posts</th>
                                        <th runat="server" class="d-none d-md-block">Create On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </tbody>
                            </table>
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourcePubicForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' OnSelected ="SqlDataSourcePubicForum_Selected"
                    SelectCommand="SELECT t.ForumId, t.Heading, t.Drescption, t.UserId, CONVERT(VARCHAR(19), t.CreateDate, 120) AS CreateDate, TU.username, TU.routusername, TUI.ImageFileName, count(DISTINCT TFT.topicid) as TopicCount, COUNT(DISTINCT TFTR.Id) as TopicReplyCount
                          FROM [Table_Forum] t
                          left JOIN table_User TU on TU.userid = t.userid
                          left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                          left JOIN Table_ForumTopic TFT on t.forumid = TFT.forumid
                          left JOIN Table_ForumTopicReply TFTR on TFT.TopicId = TFTR.TopicId
                          Group By  t.ForumId, t.Heading, t.Drescption, t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY t.[CreateDate] DESC"></asp:SqlDataSource>
            
            </div>
          
                <asp:panel runat ="server" ID="panelfooter" cssclass="card-footer clearfix">
                    <div class="float-right">
                        <uc1:PagingControl runat="server" ID="PagingControl" />
                        <asp:DataPager runat="server" ID="DataPagerForom" QueryStringField="Page" PagedControlID="ListviewPublicForom" Visible="false">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <div class="float-Left"></div>
                </asp:panel>
           
        </div>
         <div class="col-12 col-sm-12 col-md-12 col-lg-4 col-xl-4">
                       <div class ="card">
              <asp:Panel ID="PanelPagebody" CssClass ="card-body " runat="server"></asp:Panel></div>
             <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat="rectangle" />
             <uc1:TagOfAllForums runat="server" ID="TagOfAllForums" />
        </div>
    </div> 
</asp:Content>

