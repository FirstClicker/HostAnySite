<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Register Src="~/app_controls/web/ForumTopicVisibleTo.ascx" TagPrefix="uc1" TagName="ForumTopicVisibleTo" %>

<%@ Import Namespace="ClassHostAnySite" %>
<%@ Implements Interface="ClassHostAnySite.RoutForumInterface" %>

<script runat="server">

    Private m_RoutFace_Forum_Id As String
    Public Property RoutFace_Forum_Id() As String Implements ClassHostAnySite.RoutForumInterface.RoutFace_Forum_Id
        Get
            Return m_RoutFace_Forum_Id
        End Get
        Set(ByVal value As String)
            m_RoutFace_Forum_Id = value
        End Set
    End Property


    Private m_RoutFace_RoutHeading As String
    Public Property RoutFace_RoutHeading() As String Implements ClassHostAnySite.RoutForumInterface.RoutFace_RoutHeading
        Get
            Return m_RoutFace_RoutHeading
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutHeading = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim foruminfo As Forum.StructureForum = Forum.Get_Forum_ByID(RoutFace_Forum_Id, ClassAppDetails.DBCS)
            LabelForumid.Text = foruminfo.Forum_Id
            LabelHeading.Text = foruminfo.Heading
            LabelUserID.Text = foruminfo.UserID
            LabelForumShowInHome.Text = foruminfo.ShowInHome.ToString

            Dim userInfo As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.UserDetail_UserID(foruminfo.UserID, ClassAppDetails.DBCS)
            HyperLinkUserName.Text = userInfo.UserName
            HyperLinkUserName.NavigateUrl = "~/user/" & userInfo.RoutUserName
            ImageForumUser.ImageUrl = "~/Storage/Image/" & userInfo.UserImage.ImageFileName

            LabelDate.Text = foruminfo.CreateDate
            LabelDrescption.Text = foruminfo.Drescption
        End If

    End Sub


    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim Cusertype As New ClassHostAnySite.User.UserType
            Try
                Cusertype = [Enum].Parse(GetType(ClassHostAnySite.User.UserType), Trim(Session("UserType")), True)
                If Cusertype = ClassHostAnySite.User.UserType.Administrator Or Cusertype = ClassHostAnySite.User.UserType.Moderator Then
                    LIActionFeatured.Visible = True
                    LIActionDelete.Visible = True
                End If
            Catch ex As Exception

            End Try

            If Val(LabelUserID.Text) > 10 And Val(LabelUserID.Text) = Val(Session("UserID")) Then
                LIActionDelete.Visible = True
            End If
        End If
    End Sub


    Protected Sub ButtonPostTopic_Click(sender As Object, e As EventArgs)
        Dim posttopic As ForumTopic.StructureTopic
        posttopic = ForumTopic.Create_Topic(TextBoxCreatetopicHeading.Text, HtmlEditorTextBoxCreatetopicBody.Text, Session("UserID"), LabelForumid.Text, ForumTopic.TopicVisibleToEnum.EveryOne, TextBoxCreatetopicTag.Text, ClassAppDetails.DBCS)
        If posttopic.Result = True Then
            ' post to user wall

            Dim submituserwall2 As ClassHostAnySite.UserWall.StructureUserWall
            submituserwall2 = ClassHostAnySite.UserWall.UserWall_Add(" ", "A new Forum topic created", 0, Session("userId"), Session("userid"), 0, 0, "active", ClassAppDetails.DBCS, ClassHostAnySite.UserWall.PreviewTypeEnum.MediaView, TextBoxCreatetopicHeading.Text.Replace("'", "''"), HttpContext.Current.Request.Url.ToString.Replace("'", "''"), Mid(HtmlEditorTextBoxCreatetopicBody.Text, 1, 500).Replace("'", "''"))



            LabelCreateTopicEm.Text = "Topic Created Successfully."
            TextBoxCreatetopicHeading.Text = ""
            HtmlEditorTextBoxCreatetopicBody.Text = ""
            TextBoxCreatetopicTag.Text = ""

            Response.Redirect(Request.RawUrl)
        Else
            LabelCreateTopicEm.Text = "Failed To Create Topic." & posttopic.My_Error_message
        End If
    End Sub

    Protected Sub LinkButtonFeatured_Click(sender As Object, e As EventArgs)
        If LabelForumShowInHome.Text.ToLower = "yes" Then
            ClassHostAnySite.Forum.Forum_ShowinHome(LabelForumid.Text, ClassHostAnySite.Forum.ShowInHomeEnum.No, ClassAppDetails.DBCS)
        Else
            ClassHostAnySite.Forum.Forum_ShowinHome(LabelForumid.Text, ClassHostAnySite.Forum.ShowInHomeEnum.Yes, ClassAppDetails.DBCS)
        End If
    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)
        ClassHostAnySite.Forum.Forum_Delete(LabelForumid.Text, ClassAppDetails.DBCS)
        Response.Redirect("~/forum/")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-8">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="dropdown pull-right">
                        <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                        <ul class="dropdown-menu">
                            <li runat="server" id="LIActionFeatured" visible="false">
                                <asp:LinkButton ID="LinkButtonFeatured" runat="server" OnClick="LinkButtonFeatured_Click"><small>Show In Home</small></asp:LinkButton>
                            </li>
                            <li runat="server" id="LIActionDelete" visible="false">
                                <asp:LinkButton ID="LinkButtonDelete" OnClick="LinkButtonDelete_Click" OnClientClick="return confirm('You can not recover it back!! Are you sure you want to delete? ');" runat="server"><small>Delete</small></asp:LinkButton>
                            </li>
                            <li runat="server" id="LIActionReport">
                                <asp:LinkButton ID="LinkButtonReport" runat="server"><small>Report</small> </asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                    <h1 class="panel-title ">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Forum/Default.aspx">Forum</asp:HyperLink>
                    </h1>
                       
                </div>
                <div class="list-group-item">
                    <div class="media">
                        <a class="pull-left" href="#">
                            <asp:Image ID="ImageForumUser" runat="server" class="media-object"
                                ImageUrl="~/App_Themes/Default/images/Logo.png" Width="75" Height="100" /><!-- 64x64 -->
                        </a>
                        <div class="media-body">
                            <h2 class="media-heading text-primary ">
                                <asp:Label ID="LabelHeading" runat="server" Text="" />
                                <asp:Label ID="LabelForumid" runat="server" Text="" Visible="False"></asp:Label>
                            </h2>
                            <p>
                                <asp:HyperLink ID="HyperLinkUserName" CssClass ="text-capitalize " runat="server"></asp:HyperLink>
                                <asp:Label ID="LabelUserID" runat="server" Text="" Visible ="false" ></asp:Label>
                                 <asp:Label ID="LabelForumShowInHome" runat="server" Text="" Visible ="false" ></asp:Label>
                                <small>
                                    <asp:Label ID="LabelDate" runat="server" Text="" />
                                </small>
                            </p>
                               <p>
                                <asp:Label ID="LabelDrescption" runat="server" Text="" />
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Forum Topic</div>

                    <asp:ListView ID="ListViewTopic" runat="server" DataSourceID="SqlDataSourceTopic" DataKeyNames="Topic_Id">

                        <EmptyDataTemplate>
                             <div class="table-responsive ">
                            <table runat="server" class="table">
                                <thead>
                                    <tr runat="server">
                                        <th runat="server" class="text-left ">Topic Heading</th>
                                        <th runat="server" class="text-center hidden-xs hidden-sm">Posts</th>
                                        <th runat="server" class="hidden-xs hidden-sm">Create On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" >
                                        <td>No topic found.</td>
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
                                        <asp:HyperLink Text='<%# Eval("Heading") %>' CssClass="text-capitalize " NavigateUrl='<%#"~/forum/topic/" & Eval("Topic_id") & "/" & Eval("Heading2")%>' runat="server" ID="HeadingLabel" /><br>
                                        <small>
                                            <asp:Label Text='<%# Eval("body")%>' CssClass="text-capitalize " runat="server" ID="DrescptionLabel" />
                                        </small>
                                    </h4>
                                </td>

                                <td class="text-center hidden-xs hidden-sm">
                                <asp:Label ID="LabelTRC" runat="server" cssclass="label label-info" Text='<%# Eval("TopicReplyCount") %>' />
                                </td>
                                <td class="hidden-xs hidden-sm">
                                    <asp:HyperLink ID="HyperLinkUserName" CssClass="text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                    <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                        <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# Eval("PostDate")%>' /></small>

                                </td>
                            </tr>




                        </ItemTemplate>
                        <LayoutTemplate>
                            <div class="table-responsive ">
                                <table runat="server" class="table">
                                    <thead>
                                        <tr runat="server">
                                            <th runat="server" class="text-left ">Topic Heading</th>
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
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceTopic" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT t.[Topic_Id], t.[Heading], replace(t.[Heading],' ','-') as [Heading2], t.[Body], t.[UserId], t.[PostDate], t.[Forum_Id], t.[VisibleTo], t.[Status], t.[Tag], TU.username, TU.routusername, TUI.ImageFileName, count(TTR.Topic_id) as TopicReplyCount 
                        FROM [Table_ForumTopic] t 
                        left JOIN table_User TU on TU.userid = t.userid
                        left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                        left JOIN Table_ForumTopicReply TTR on t.Topic_Id = TTr.Topic_Id
                        WHERE (t.[Forum_Id] = @Forum_Id) 
                        Group By t.[Topic_Id], t.[Heading], t.[Body], t.[UserId], t.[PostDate], t.[Forum_Id], t.[VisibleTo], t.[Status], t.[Tag], TU.username, TU.routusername, TUI.ImageFileName
                        ORDER BY t.[PostDate] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="LabelForumid" PropertyName="Text" Name="Forum_Id" Type="Decimal"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>

                <div class="panel-footer clearfix">
                    <div class="pull-right">
                        <asp:DataPager runat="server" ID="DataPagerTopic" PagedControlID="ListViewTopic">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>

        </div>
        <div class="col-md-4">
            <asp:Panel ID="panelCreateTopic" runat="server" CssClass="panel panel-default" Visible="true">
                <div class="panel-heading">Create new topic</div>
                <div class="panel-body">
                    <div class="form">
                        <div class="form-group">
                            <label for="TextBoxCreatetopicHeading" class="sr-only">Topic Heading</label>
                            <asp:TextBox ID="TextBoxCreatetopicHeading" runat="server" CssClass="form-control" placeholder="Topic Heading"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="HtmlEditorTextBoxCreatetopicBody" class="sr-only">Drescption</label>
                            <asp:TextBox ID="HtmlEditorTextBoxCreatetopicBody" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Drescption"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="TextBoxCreatetopicTag" class="sr-only">Tag</label>
                            <asp:TextBox ID="TextBoxCreatetopicTag" runat="server" CssClass="form-control" placeholder="Topic Tag"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Visible To </label>
                            <uc1:ForumTopicVisibleTo runat="server" ID="ForumTopicVisibleTo" enable="False" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="LabelCreateTopicEm" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>
                        <asp:Button ID="ButtonPostTopic" runat="server" Text="Create Topic" class="btn btn-lg btn-primary btn-block" OnClick="ButtonPostTopic_Click" />
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>

