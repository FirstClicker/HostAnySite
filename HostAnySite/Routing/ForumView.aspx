<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/App_Controls/TagOfForum.ascx" TagPrefix="uc1" TagName="TagOfForum" %>
<%@ Register Src="~/App_Controls/TagOfAllForums.ascx" TagPrefix="uc1" TagName="TagOfAllForums" %>
<%@ Register Src="~/App_Controls/UserLikeDisLikeAction.ascx" TagPrefix="uc1" TagName="UserLikeDisLikeAction" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>
<%@ Register Src="~/App_Controls/AddThisInLine.ascx" TagPrefix="uc1" TagName="AddThisInLine" %>
<%@ Register Src="~/App_Controls/UserSignInNeededButton.ascx" TagPrefix="uc1" TagName="UserSignInNeededButton" %>
<%@ Register Src="~/App_Controls/ForumVisibleTo.ascx" TagPrefix="uc1" TagName="ForumVisibleTo" %>



<script runat="server">
    ' version 21/10/2018 # 20.27 

    Private m_RoutIFace_String1 As String
    Public Property RoutIFace_String1 As String Implements RoutBoardUniInterface.RoutIFace_String1
        Get
            Return m_RoutIFace_String1
        End Get
        Set(value As String)
            m_RoutIFace_String1 = value
        End Set
    End Property

    Private m_RoutIFace_Heading As String
    Public Property RoutIFace_Heading() As String Implements RoutBoardUniInterface.RoutIFace_String2
        Get
            Return m_RoutIFace_Heading
        End Get
        Set(ByVal value As String)
            m_RoutIFace_Heading = FirstClickerService.Common.ConvertDass2Space(value)
        End Set
    End Property

    Private m_RoutIFace_ID As String
    Public Property RoutIFace_ID() As String Implements RoutBoardUniInterface.RoutIFace_String3
        Get
            Return m_RoutIFace_ID
        End Get
        Set(ByVal value As String)
            m_RoutIFace_ID = Val(value)
        End Set
    End Property

    Private m_RoutIFace_String4 As String
    Public Property RoutIFace_String4 As String Implements RoutBoardUniInterface.RoutIFace_String4
        Get
            Return m_RoutIFace_String4
        End Get
        Set(value As String)
            m_RoutIFace_String4 = value
        End Set
    End Property



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim foruminfo As FirstClickerService.Version1.Forum.StructureForum = FirstClickerService.Version1.Forum.Get_Forum_ByID(RoutIFace_ID, WebAppSettings.DBCS)
            If foruminfo.Result = True Then
                LabelForumid.Text = foruminfo.ForumId
                HyperLinkHeading.Text = foruminfo.Heading
                HyperLinkHeading.NavigateUrl = "~/forum/" & FirstClickerService.Common.ConvertSpace2Dass(foruminfo.Heading) & "/" & foruminfo.ForumId

                UserLikeDisLikeAction.LikeOnID = foruminfo.ForumId

                LabelUserID.Text = foruminfo.UserID
                LabelForumShowInHome.Text = foruminfo.ShowInHome.ToString

                TagOfForum.ForumId = foruminfo.ForumId
                TagOfForum.ForumUserId = foruminfo.UserID

                LabelDate.Text = FirstClickerService.Common.ConvertDateTime4Use(foruminfo.CreateDate.ToString("yyyy-MM-dd HH:mm:ss"))
                LabelDrescption.Text = foruminfo.Drescption


                Dim userInfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_UserID(foruminfo.UserID, WebAppSettings.DBCS)
                HyperLinkUserName.Text = userInfo.UserName
                HyperLinkUserName.NavigateUrl = "~/user/" & userInfo.RoutUserName
                ImageForumUser.ImageUrl = "~/Storage/Image/" & userInfo.UserImage.ImageFileName

                ForumVisibleTo.ForumID = foruminfo.ForumId
                ForumVisibleTo.VisibleTo = foruminfo.VisibleTo
                Select Case foruminfo.VisibleTo
                    Case FirstClickerService.Version1.Forum.ForumVisibleToEnum.Every_One
                        PanelTopicList.Visible = True

                    Case FirstClickerService.Version1.Forum.ForumVisibleToEnum.Forum_Members
                        If Val(Trim(Session("userid"))) > 100 Then

                        Else
                            PanelTopicList.Visible = False
                            PanelPrivateForum.Visible = True
                        End If


                    Case FirstClickerService.Version1.Forum.ForumVisibleToEnum.Site_Members
                        If Val(Trim(Session("userid"))) > 100 Then
                            PanelTopicList.Visible = True
                        Else
                            PanelTopicList.Visible = False
                            PanelPrivateForum.Visible = True
                        End If
                End Select


            Else
                Response.Redirect("~/forum/")
            End If
        End If

        Me.Title = HyperLinkHeading.Text
        Me.MetaDescription = Mid(LabelDrescption.Text, 1, 250)
        Me.MetaKeywords = ""
    End Sub


    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim Cusertype As New FirstClickerService.Version1.User.UserType
            Try
                Cusertype = [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Trim(Session("UserType")), True)
                If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
                    LIActionFeatured.Visible = True
                    LIActionDelete.Visible = True
                    PanelForumSettings.Visible = True
                End If
            Catch ex As Exception

            End Try

            If Val(LabelUserID.Text) > 10 And Val(LabelUserID.Text) = Val(Session("UserID")) Then
                LIActionDelete.Visible = True
                PanelForumSettings.Visible = True
            End If
        End If
    End Sub


    Protected Sub ButtonPostTopic_Click(sender As Object, e As EventArgs)
        Dim posttopic As FirstClickerService.Version1.ForumTopic.StructureTopic
        posttopic = FirstClickerService.Version1.ForumTopic.Create_Topic(TextBoxCreatetopicHeading.Text, HtmlEditorTextBoxCreatetopicBody.Text, Session("UserID"), LabelForumid.Text, FirstClickerService.Version1.ForumTopic.TopicVisibleToEnum.Every_One, WebAppSettings.DBCS)
        If posttopic.Result = True Then

            If CheckBoxPostToMyWall.Checked = True Then  'post to userwall
                Dim submituserwall2 As FirstClickerService.Version1.UserWall.StructureUserWall
                submituserwall2 = FirstClickerService.Version1.UserWall.UserWall_Add(" ", "A new Forum topic created", 0, Session("userId"), Session("userid"), FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, FirstClickerService.Version1.UserWall.PreviewTypeEnum.ForumTopic, posttopic.TopicID, TextBoxCreatetopicHeading.Text.Replace("'", "''"), HttpContext.Current.Request.Url.ToString.Replace("'", "''"), Mid(HtmlEditorTextBoxCreatetopicBody.Text, 1, 500).Replace("'", "''"))
            End If

            LabelCreateTopicEm.Text = "Topic Created Successfully."
            TextBoxCreatetopicHeading.Text = ""
            HtmlEditorTextBoxCreatetopicBody.Text = ""
            TextBoxCreatetopicTag.Text = ""
            PanelcollapseCreateTopic.CssClass = "card-collapse collapse"

            ListViewTopic.DataBind()
        Else
            LabelCreateTopicEm.Text = "Failed To Create Topic."
            PanelcollapseCreateTopic.CssClass = "card-collapse collapse show"
        End If
    End Sub

    Protected Sub LinkButtonFeatured_Click(sender As Object, e As EventArgs)
        If LabelForumShowInHome.Text.ToLower = "yes" Then
            FirstClickerService.Version1.Forum.Forum_ShowinHome(LabelForumid.Text, FirstClickerService.Version1.Forum.ShowInHomeEnum.False, WebAppSettings.DBCS)
        Else
            FirstClickerService.Version1.Forum.Forum_ShowinHome(LabelForumid.Text, FirstClickerService.Version1.Forum.ShowInHomeEnum.True, WebAppSettings.DBCS)
        End If
    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)
        '  FirstClickerService.Version1.Forum.Forum_Delete(LabelForumid.Text, WebAppSettings.DBCS)
        '   Response.Redirect("~/forum/")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelUserID" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="LabelForumShowInHome" runat="server" Text="" Visible="false"></asp:Label>
    <div class="row">

        <div class="col-lg-8 col-md-12 col-sm-12 ">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat="horizontal" />
            <div class="card BoxEffect6 mt-2">
                <div class="card-header p-2 clearfix">
                    <div class="float-right">
                        <asp:HyperLink ID="HyperLink2" NavigateUrl="~/Dashboard/Forum/Create.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Create Forum</asp:HyperLink>
                    </div>
                    <h5 class="card-title m-0 ">
                        <i class="fab fa-foursquare"></i>&nbsp;<asp:HyperLink ID="HyperLinkForumHeading" runat="server" NavigateUrl="~/Forum/">Forum</asp:HyperLink>
                    </h5>
                </div>
            </div>

            <div class="card BoxEffect6 mt-3 mb-3">
                <div class="card-body">
                    <div class="media">
                        <a class="float-left mr-2" href="#">
                            <asp:Image ID="ImageForumUser" runat="server"
                                ImageUrl="~/App_Themes/Default/images/Logo.png" Width="75" Height="75" /><!-- 64x64 -->
                        </a>
                        <div class="media-body">
                            <div class="dropdown float-right">
                                <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                                <ul class="dropdown-menu dropdown-menu-right">
                                    <li runat="server" id="LIActionFeatured" class="dropdown-item" visible="false">
                                        <asp:LinkButton ID="LinkButtonFeatured" runat="server" OnClick="LinkButtonFeatured_Click"><small>Show In Home</small></asp:LinkButton>
                                    </li>
                                    <li runat="server" id="LIActionDelete" class="dropdown-item" visible="false">
                                        <asp:LinkButton ID="LinkButtonDelete" OnClick="LinkButtonDelete_Click" OnClientClick="return confirm('You can not recover it back!! Are you sure you want to delete? ');" runat="server"><small>Delete</small></asp:LinkButton>
                                    </li>
                                    <li runat="server" id="LIActionReport" class="dropdown-item">
                                        <asp:LinkButton ID="LinkButtonReport" runat="server"><small>Report</small> </asp:LinkButton>
                                    </li>
                                </ul>
                            </div>
                            <h2 class="text-primary">
                                <asp:HyperLink ID="HyperLinkHeading" runat="server" Text="" />
                                <asp:Label ID="LabelForumid" runat="server" Text="" Visible="False"></asp:Label>
                            </h2>
                            <p>
                                <i class="fas fa-user-circle"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUserName" CssClass="text-capitalize " runat="server"></asp:HyperLink>
                                &nbsp;|&nbsp;<i class="far fa-calendar-alt"></i>&nbsp;<asp:Label ID="LabelDate" runat="server" Text="" />
                            </p>
                        </div>
                    </div>
                    <p>
                        <asp:Label ID="LabelDrescption" runat="server" Text="" />
                    </p>
                    <div>
                        <div class="float-left ">
                            <uc1:TagOfForum runat="server" ID="TagOfForum" />
                        </div>
                        <div class="float-right ">
                            <uc1:UserLikeDisLikeAction runat="server" ID="UserLikeDisLikeAction" LikeOn="Forum" />
                        </div>
                    </div>
                    <uc1:AddThisInLine runat="server" ID="AddThisInLine" />
                </div>
                <asp:Panel runat="server" ID="PanelForumSettings" CssClass="card-footer" Visible="false">
                    <uc1:ForumVisibleTo runat="server" ID="ForumVisibleTo" />
                </asp:Panel>
            </div>

            <asp:Panel runat="server" ID="PanelPrivateForum" CssClass="card BoxEffect6 mt-2 mb-2" Visible="false">
                <div class="card-body">
                    <uc1:UserSignInNeededButton runat="server" ID="UserSignInNeededButton" />
                </div>

            </asp:Panel>
            <asp:Panel runat="server" ID="PanelTopicList" CssClass="card BoxEffect6 mt-2 mb-2">
                <div class="card-header">
                    <a href="#<%= PanelcollapseCreateTopic.ClientID %>" class="Change-DropDown-Icon" data-toggle="collapse"><i class="far fa-edit"></i>&nbsp;Create Topic<i class="fa fa-chevron-circle-right float-right"></i></a>
                </div>
                <asp:Panel runat="server" ID="PanelcollapseCreateTopic" CssClass="card-collapse collapse">
                    <div class="card-body">
                        <div class="form">
                            <div class="form-group">
                                <label for="TextBoxCreatetopicHeading" class="sr-only">Topic Heading</label>
                                <asp:TextBox ID="TextBoxCreatetopicHeading" runat="server" CssClass="form-control" placeholder="Topic Heading"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="HtmlEditorTextBoxCreatetopicBody" class="sr-only">Drescption</label>
                                <asp:TextBox ID="HtmlEditorTextBoxCreatetopicBody" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Drescption"></asp:TextBox>
                            </div>

                            <div class="form-group" hidden="hidden">
                                <label for="TextBoxCreatetopicTag" class="sr-only">Tag</label>
                                <asp:TextBox ID="TextBoxCreatetopicTag" runat="server" CssClass="form-control" placeholder="Topic Tag"></asp:TextBox>
                            </div>
                            <div class="form-group" hidden="hidden">
                                <label>Visible To </label>

                            </div>
                            <div class="form-group">
                                <asp:Label ID="LabelCreateTopicEm" runat="server" ForeColor="Maroon"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer clearfix">
                        <div class="float-right">
                            <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass="text-info small text-muted" Text="Share on my wall" runat="server" Checked="true" />
                            <asp:Button ID="ButtonPostTopic" runat="server" Text="Create Topic" class="btn btn-sm btn-info" OnClick="ButtonPostTopic_Click" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:ListView ID="ListViewTopic" runat="server" DataSourceID="SqlDataSourceTopic" DataKeyNames="TopicId">
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
                                    <tr runat="server">
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
                                <h5>
                                    <asp:HyperLink Text='<%# Eval("Heading") %>' CssClass="text-capitalize " NavigateUrl='<%#"~/forum/" & FirstClickerService.Common.ConvertSpace2Dass(RoutIFace_Heading) & "/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("Topicid") %>' runat="server" ID="HeadingLabel" /><br>
                                </h5>
                                <small>
                                    <asp:Label runat="server" ID="LabelDrescption" CssClass="" Text='<%# Eval("body")%>' />
                                </small>
                            </td>

                            <td class="text-center hidden-xs hidden-sm">
                                <asp:Label ID="LabelTRC" runat="server" CssClass="label label-info" Text='<%# Eval("TopicReplyCount") %>' />
                            </td>
                            <td class="hidden-xs hidden-sm">
                                <i class="fas fa-user-circle"></i>&nbsp;<asp:HyperLink ID="HyperLinkUserName" CssClass="text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                <small class="text-nowrap "><i class="far fa-calendar-alt"></i>&nbsp;
                                    <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("PostDate"))%>' />
                                </small>
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
                    SelectCommand="SELECT t.[TopicId], t.[Heading], t.[Body], t.[UserId], CONVERT(VARCHAR(19), t.postdate, 120) AS postdate, t.[ForumId], t.[VisibleTo], t.[Status], TU.username, TU.routusername, TUI.ImageFileName, count(TTR.Topicid) as TopicReplyCount 
                        FROM [Table_ForumTopic] t 
                        left JOIN table_User TU on TU.userid = t.userid
                        left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                        left JOIN Table_ForumTopicReply TTR on t.TopicId = TTr.TopicId
                        WHERE (t.[ForumId] = @ForumId) 
                        Group By t.[TopicId], t.[Heading], t.[Body], t.[UserId], t.[PostDate], t.[ForumId], t.[VisibleTo], t.[Status], TU.username, TU.routusername, TUI.ImageFileName
                        ORDER BY t.[PostDate] DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="LabelForumid" PropertyName="Text" Name="ForumId" Type="Decimal"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <div class="card-footer clearfix">
                    <div class="float-right">
                        <asp:DataPager runat="server" ID="DataPagerTopic" PagedControlID="ListViewTopic">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </asp:Panel>

        </div>
        <div class="col-lg-4 col-md-12 col-sm-12 ">
            <uc1:TagOfAllForums runat="server" ID="TagOfAllForums" />
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="rectangle" />
        </div>
    </div>
</asp:Content>

