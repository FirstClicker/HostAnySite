<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Register Src="~/app_controls/web/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/app_controls/web/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>


<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />

    <div class="row">
        <div class="col-md-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-md-9">
            <div class="panel panel-default">
                <asp:ListView ID="ListViewForum" runat="server" DataSourceID="SqlDataSourceForum" DataKeyNames="Forum_Id">

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
                                    <tr runat="server" >
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
                            <td>
                                <h4>
                                    <asp:HyperLink Text='<%# Eval("Heading") %>' CssClass=" text-capitalize " NavigateUrl='<%#"~/forum/" & Eval("Forum_Id") & "/" & ClassHostAnySite.HostAnySite.ConvertSpace2Dass(Eval("Heading"))%>' runat="server" ID="HeadingLabel" /><br>
                                    <small>
                                        <asp:Label Text='<%# Eval("Drescption") %>' CssClass=" text-capitalize " runat="server" ID="DrescptionLabel" />
                                    </small>
                                </h4>
                            </td>
                            <td class="text-center hidden-xs hidden-sm">
                                <asp:Label ID="LabelTC" runat="server" Text='<%# Eval("TopicCount") %>' />
                            </td>
                            <td class="text-center hidden-xs hidden-sm">
                                <a href="#">0</a>
                            </td>
                            <td class="hidden-xs hidden-sm">
                                <asp:HyperLink ID="HyperLinkUserName" CssClass=" text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                    <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# Eval("CreateDate")%>' /></small>

                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div class="table-responsive">
                            <table runat="server" class="table">
                                <thead>
                                    <tr runat="server">
                                        <th runat="server">
                                            <strong>Forum Heading</strong>
                                        </th>
                                        <th runat="server" class="cell-stat text-center hidden-xs hidden-sm">Topics</th>
                                        <th runat="server" class="cell-stat text-center hidden-xs hidden-sm">Posts</th>
                                        <th runat="server" class="cell-stat-2x hidden-xs hidden-sm">Create On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </tbody>
                            </table>
                        </div>
                    </LayoutTemplate>

                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' DeleteCommand="DELETE FROM [Table_Forum] WHERE [Forum_Id] = @Forum_Id"
                    SelectCommand="SELECT t.Forum_Id, t.Heading, t.Drescption, t.ForumBoard_Id, t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName, count(TFT.forum_id) as TopicCount  
                          FROM [Table_Forum] t
                          left JOIN table_User TU on TU.userid = t.userid
                          left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                          left JOIN Table_ForumTopic TFT on t.forum_id = TFT.forum_id
                        where t.userid=@UserId
                          Group By  t.Forum_Id, t.Heading, t.Drescption, t.ForumBoard_Id, t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY t.[CreateDate] DESC">
                    <DeleteParameters>
                        <asp:Parameter Name="Forum_Id" Type="Decimal"></asp:Parameter>
                    </DeleteParameters>

                    <SelectParameters>
                        <asp:SessionParameter SessionField="UserId" Name="UserId" Type="Decimal"></asp:SessionParameter>
                    </SelectParameters>

                </asp:SqlDataSource>


                <div class="panel-footer clearfix">
                    <div class="pull-right">
                        <asp:DataPager runat="server" ID="DataPagerPublicForom" PagedControlID="ListviewForum">
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



</asp:Content>

