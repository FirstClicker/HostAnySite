<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>

<script runat="server">

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
            <div class="card  mt-2 BoxEffect6 ">
                <div class="card-header clearfix">
                    <div class="float-right"></div>
                    <h5 class="card-title m-0 ">
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Dashboard/Forum/MyForums.aspx">My Forums</asp:HyperLink>
                    </h5>
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
                                            <h4>
                                                <asp:HyperLink Text='<%# Eval("Heading") %>' CssClass=" text-capitalize " NavigateUrl='<%#"~/forum/view/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("ForumId")  %>' runat="server" ID="HeadingLabel" /><br>
                                                <small>
                                                    <asp:Label Text='<%# Eval("Drescption") %>' CssClass=" text-capitalize " runat="server" ID="DrescptionLabel" />
                                                </small>
                                            </h4>
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
                            <asp:SqlDataSource runat="server" ID="SqlDataSourcePubicForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                SelectCommand="SELECT t.ForumId, t.Heading, t.Drescption, t.UserId, CONVERT(VARCHAR(19), t.CreateDate, 120) AS CreateDate, TU.username, TU.routusername, TUI.ImageFileName, count(DISTINCT TFT.topicid) as TopicCount, COUNT(DISTINCT TFTR.Id) as TopicReplyCount
                                    FROM [Table_Forum] t
                                    left JOIN table_User TU on TU.userid = t.userid
                                    left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                                    left JOIN Table_ForumTopic TFT on t.forumid = TFT.forumid
                                    left JOIN Table_ForumTopicReply TFTR on TFT.TopicId = TFTR.TopicId
                                    where t.userid=@UserId
                                    Group By  t.ForumId, t.Heading, t.Drescption, t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName
                                    ORDER BY t.[CreateDate] DESC">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="UserId" Name="UserId" Type="Decimal"></asp:SessionParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <div class="card-footer clearfix">
                                <div class="float-right">
                                    <asp:DataPager runat="server" ID="DataPagerPublicForom" QueryStringField="Page" PagedControlID="ListviewPublicForom">
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
    </div>
</asp:Content>

