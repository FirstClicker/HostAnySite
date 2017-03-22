<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Import Namespace="ClassHostAnySite" %>
<%@ Register Src="~/app_controls/web/NavigationSideMain.ascx" TagPrefix="uc1" TagName="NavigationSideMain" %>


<script runat="server">

    Protected Sub ButtonPostForum_Click(sender As Object, e As EventArgs)
        Dim createforum As Forum.StructureForum
        createforum = Forum.Create_Forum(TextBoxHeading.Text, TextBoxDrescption.Text, "0", Session("UserID"), Forum.ForumVisibleToEnum.EveryOne, ClassAppDetails.DBCS)
        If createforum.Result = True Then
            Dim newForumURL As String = "~/forum/" & createforum.Forum_Id & "/" & ClassHostAnySite.HostAnySite.ConvertSpace2Dass(createforum.Heading)
            If CheckBoxPostToMyWall.Checked = True Then
                'post to userwall
                Dim submituserwall2 As ClassHostAnySite.UserWall.StructureUserWall
                submituserwall2 = ClassHostAnySite.UserWall.UserWall_Add(" ", "A new Forum posted", 0, Session("userId"), Session("userid"), 0, 0, "active", ClassAppDetails.DBCS, ClassHostAnySite.UserWall.PreviewTypeEnum.MediaView, TextBoxHeading.Text.Replace("'", "''"), newForumURL.Replace("'", "''"), Mid(TextBoxDrescption.Text, 1, 500).Replace("'", "''"))
            End If
            Response.Redirect(newForumURL)
        Else
            LabelEM.Text = createforum.My_Error_message
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
        End If
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-8 col-md-8">
            <div class="panel panel-default">
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
                                <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# Eval("CreateDate")%>' /></small>
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
                          Group By  t.Forum_Id, t.Heading, t.Drescption, t.ForumBoard_Id, t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY t.[CreateDate] DESC"></asp:SqlDataSource>
                <div class="panel-footer clearfix">
                    <div class="pull-right">
                        <asp:DataPager runat="server" ID="DataPagerPublicForom" PagedControlID="ListviewPublicForom">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <div class="pull-Left"></div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-4">

            <uc1:NavigationSideMain runat="server" ID="NavigationSideMain" />
            <div class="panel panel-default">
                <div class="panel-heading">Create New Forum</div>
                <div class="panel-body">
                    <div class="form">
                        <div class="form-group">
                            <label for="TextBoxHeading" class="sr-only">Heading</label>
                            <asp:TextBox ID="TextBoxHeading" runat="server" CssClass="form-control" placeholder="Forum Heading"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="TextBoxDrescption" class="sr-only">Drescption</label>
                            <asp:TextBox ID="TextBoxDrescption" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Forum Drescption"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="LabelEM" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>
                        <div class="form-group">
                            <div class="pull-right">
                                <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass="text-info text-muted" Text="Share on my wall" runat="server" Checked ="true"  />
                                <asp:Button ID="ButtonPostForum" runat="server" Text="Create Forum" class="btn btn-primary" OnClick="ButtonPostForum_Click" />
                            </div>
                        </div> 
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

