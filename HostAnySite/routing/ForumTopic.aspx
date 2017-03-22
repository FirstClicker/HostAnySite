<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Implements Interface="ClassHostAnySite.RoutForumTopicInterface" %>
<%@ Register Src="~/app_controls/web/WhatsHappening.ascx" TagPrefix="uc1" TagName="WhatsHappening" %>


<script runat="server">


    Private m_RoutFace_RoutTopic_Id As String
    Public Property RoutFace_RoutTopic_Id() As String Implements ClassHostAnySite.RoutForumTopicInterface.RoutFace_RoutTopic_Id
        Get
            Return m_RoutFace_RoutTopic_Id
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutTopic_Id = value
        End Set
    End Property

    Private m_RoutFace_RoutTopicHeading As String
    Public Property RoutFace_RoutTopicHeading() As String Implements ClassHostAnySite.RoutForumTopicInterface.RoutFace_RoutTopicHeading
        Get
            Return m_RoutFace_RoutTopicHeading
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutTopicHeading = value
        End Set
    End Property



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim Topicinfo As ClassHostAnySite.ForumTopic.StructureTopic = ClassHostAnySite.ForumTopic.Get_TopicDetails(RoutFace_RoutTopic_Id, ClassAppDetails.DBCS)
            LabelTopicid.Text = Topicinfo.Topic_ID
            LabelHeading.Text = Topicinfo.Heading
            LabelDate.Text = ClassHostAnySite.HostAnySite.ConvertDateTime4Use(Topicinfo.PostDate.ToString("yyyy-MM-dd HH:mm:ss"))
            LabelDrescption.Text = Topicinfo.Body
            LabelForumID.Text = Topicinfo.Forum_ID
            LabelTopicUserID.Text = Topicinfo.UserID

            If Topicinfo.Status = ClassHostAnySite.ForumTopic.TopicStatusEnum.Closed Or Topicinfo.Status = ClassHostAnySite.ForumTopic.TopicStatusEnum.ClosedByAdmin Or Topicinfo.Status = ClassHostAnySite.ForumTopic.TopicStatusEnum.SuspendedByAdmin Then
                PanelPostReply.Enabled = False
            Else

            End If


            Dim Foruminfo As ClassHostAnySite.Forum.StructureForum = ClassHostAnySite.Forum.Get_Forum_ByID(LabelForumID.Text, ClassAppDetails.DBCS)
            HyperLinkForum.Text = Foruminfo.Heading
            HyperLinkForum.NavigateUrl = "~/forum/" & Foruminfo.Forum_Id & "/" & Foruminfo.Heading.Replace(" ", "-")
            LabelForumUserID.Text = Foruminfo.UserID


            Dim userInfo As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.UserDetail_UserID(Topicinfo.UserID, ClassAppDetails.DBCS)
            HyperLinkUserName.Text = userInfo.UserName
            HyperLinkUserName.NavigateUrl = "~/user/" & userInfo.RoutUserName
            ImageForumTopicUser.ImageUrl = "~/Storage/Image/" & userInfo.UserImage.ImageFileName
        End If

        Me.Title = LabelHeading.Text
        Me.MetaDescription = Mid(LabelDrescption.Text, 1, 250)
        Me.MetaKeywords = ""
    End Sub

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If IsPostBack = False Then

            Dim Cusertype As New ClassHostAnySite.User.UserType
            Try
                Cusertype = [Enum].Parse(GetType(ClassHostAnySite.User.UserType), Trim(Session("UserType")), True)
                If Cusertype = ClassHostAnySite.User.UserType.Administrator Or Cusertype = ClassHostAnySite.User.UserType.Moderator Then
                    LIActionDelete.Visible = True
                    LIActionStatus.Visible = True
                End If
            Catch ex As Exception
            End Try

            If Val(LabelTopicUserID.Text) > 10 And Val(LabelTopicUserID.Text) = Val(Session("UserID")) Then
                LIActionDelete.Visible = True
                LIActionStatus.Visible = True
            End If

            If Val(LabelForumUserID.Text) > 10 And Val(LabelForumUserID.Text) = Val(Session("UserID")) Then
                LIActionDelete.Visible = True
                LIActionStatus.Visible = True
            End If
        End If
    End Sub



    Protected Sub ButtonReply_Click(sender As Object, e As EventArgs)
        If textboxreplyBody.Text = "" Then Exit Sub
        If Trim(Session("userid")) = "" Then
            LabelMsg.Text = "Please login to make reply."
            Exit Sub
        End If

        Dim topicreply As ClassHostAnySite.ForumTopicReply.StructureTopicReply = ClassHostAnySite.ForumTopicReply.Create_topicReply(textboxreplyBody.Text, Session("userid"), RoutFace_RoutTopic_Id, ClassHostAnySite.ForumTopicReply.TopicReplyVisibleToEnum.EveryOne, ClassAppDetails.DBCS)
        If topicreply.Result = False Then
            LabelMsg.Text = "Failed to make reply."
        Else
            If CheckBoxPostToMyWall.Checked = True Then
                ' post to user wall
                Dim submituserwall2 As ClassHostAnySite.UserWall.StructureUserWall
                submituserwall2 = ClassHostAnySite.UserWall.UserWall_Add("replied in following topic", textboxreplyBody.Text.Replace("'", "''"), 0, Session("userId"), Session("userid"), 0, 0, "active", ClassAppDetails.DBCS, ClassHostAnySite.UserWall.PreviewTypeEnum.MediaView, LabelHeading.Text, HttpContext.Current.Request.Url.ToString.Replace("'", "''"), Mid(textboxreplyBody.Text, 1, 500).Replace("'", "''"))
            End If

            textboxreplyBody.Text = ""
            ListViewTopicReply.DataBind()
        End If
    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub LinkButtonStatus_Click(sender As Object, e As EventArgs)

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelForumUserID" runat="server" Text="" Visible ="false" ></asp:Label>
    <asp:Label ID="LabelTopicUserID" runat="server" Text="" Visible ="false" ></asp:Label>
    <div class="row">
        <div class="col-lg-8">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="dropdown pull-right">
                        <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                        <ul class="dropdown-menu">
                            <li runat="server" id="LIActionStatus" visible="false">
                                <asp:LinkButton ID="LinkButtonStatus" OnClick="LinkButtonStatus_Click" runat="server"><small>Change Status</small></asp:LinkButton>
                            </li>
                            <li runat="server" id="LIActionDelete" visible="false">
                                <asp:LinkButton ID="LinkButtonDelete" OnClick="LinkButtonDelete_Click" OnClientClick="return confirm('You can not recover it back!! Are you sure you want to delete? ');" runat="server"><small>Delete</small></asp:LinkButton>
                            </li>
                            <li runat="server" id="LIActionReport">
                                <asp:LinkButton ID="LinkButtonReport" runat="server"><small>Report</small> </asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                    <h1 class=" panel-title">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Forum/Default.aspx">Forum</asp:HyperLink>
                        >
                        <asp:HyperLink ID="HyperLinkForum" runat="server"></asp:HyperLink>
                    </h1>

                    <asp:Label ID="LabelForumID" runat="server" Text="0" Visible="False"></asp:Label>
                </div>
                <div class="list-group-item">
                    <div class="media">
                        <a class="pull-left" href="#">
                            <asp:Image ID="ImageForumTopicUser" runat="server" CssClass="media-object"
                                ImageUrl="~/App_Themes/Default/images/Logo.png" Width="75" Height="100" /><!-- 64x64 -->
                        </a>
                        <div class="media-body">
                            <h2 class="media-heading text-primary">
                                <asp:Label ID="LabelHeading" runat="server" Text="" />
                                <asp:Label ID="LabelTopicid" runat="server" Text="" Visible="False"></asp:Label>
                            </h2>

                            <p>
                                <asp:HyperLink ID="HyperLinkUserName" CssClass ="text-capitalize " runat="server"></asp:HyperLink>
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
                <asp:panel runat ="server" ID="PanelPostReply" cssclass="panel-heading ">
                    <div class="form">
                        <div class="form-group">
                            <label for="textboxreplyBody" class="sr-only">Make reply</label>
                            <asp:TextBox ID="textboxreplyBody" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Your reply"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="LabelMsg" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>

                        <div class="form-group clearfix ">
                            <div class="pull-right ">
                                <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass="text-info text-muted" Text="Share on my wall" runat="server" />
                                <asp:Button ID="ButtonReply" runat="server" CssClass="btn btn-info" Text="Reply" OnClick="ButtonReply_Click" />
                            </div>
                        </div> 
                    </div>

                </asp:panel>
                <div class="panel-body UserWall-Body">
                    <asp:ListView ID="ListViewTopicReply" runat="server" DataSourceID="SqlDataSourceTopicReply" DataKeyNames="Id">
                        <EmptyDataTemplate>
                            <span>No comment yet.</span>
                        </EmptyDataTemplate>

                        <ItemTemplate>
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="media">
                                        <asp:HyperLink ID="userimage" runat="server" CssClass="pull-left" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'>
                                            <asp:Image runat="server" ID="userimg" CssClass="media-object" ImageUrl='<%# "~/storage/image/" + Eval("imagefilename")%>' Width="60" Height="80" />
                                        </asp:HyperLink>
                                        <div class="media-body">
                                            <p>
                                                <strong>
                                                    <asp:HyperLink ID="HyperLinkUserName" runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink>
                                                    <small>
                                                        <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# Eval("PostDate")%>' />
                                                    </small></strong>
                                            </p>
                                            <p>
                                                <asp:Label Text='<%# Eval("Reply")%>' runat="server" ID="DrescptionLabel" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer">
                                <div runat="server" id="itemPlaceholder" />
                            </div>

                        </LayoutTemplate>

                    </asp:ListView>

                    <asp:SqlDataSource runat="server" ID="SqlDataSourceTopicReply" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT t.[Id], t.[Topic_Id], t.[Reply], t.[PostDate], t.[UserId], t.[VisibleTo], t.[Status], TU.username, TU.routusername, TUI.ImageFileName 
                        FROM [Table_ForumTopicReply] t 
                        left JOIN table_User TU on TU.userid = t.userid
                        left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                        WHERE ([Topic_Id] = @Topic_Id) 
                        ORDER BY [PostDate] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="LabelTopicid" PropertyName="Text" Name="Topic_Id" Type="Decimal"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="panel-footer clearfix ">
                    <div class="pull-left "></div>
                    <div class=" pull-right ">
                        <asp:DataPager runat="server" ID="DataPagerTopicReply" PagedControlID="ListViewTopicReply">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <uc1:WhatsHappening runat="server" ID="WhatsHappening" />
        </div>
    </div>
</asp:Content>

