<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>
<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/App_Controls/UserLikeDisLikeAction.ascx" TagPrefix="uc1" TagName="UserLikeDisLikeAction" %>


<script runat="server">
    ' version 12/09/2018 # 20.27 

    Private m_RoutIFace_String1 As String
    Public Property RoutIFace_String1 As String Implements RoutBoardUniInterface.RoutIFace_String1
        Get
            Return m_RoutIFace_String1
        End Get
        Set(value As String)
            m_RoutIFace_String1 = value
        End Set
    End Property

    Private m_RoutIFace_ForumHeading As String
    Public Property RoutIFace_ForumHeading() As String Implements RoutBoardUniInterface.RoutIFace_String2
        Get
            Return m_RoutIFace_ForumHeading
        End Get
        Set(ByVal value As String)
            m_RoutIFace_ForumHeading = FirstClickerService.Common.ConvertDass2Space(value)
        End Set
    End Property


    Private m_RoutIFace_Heading As String
    Public Property RoutIFace_Heading() As String Implements RoutBoardUniInterface.RoutIFace_String3
        Get
            Return m_RoutIFace_Heading
        End Get
        Set(ByVal value As String)
            m_RoutIFace_Heading = FirstClickerService.Common.ConvertDass2Space(value)
        End Set
    End Property



    Private m_RoutIFace_ID As String
    Public Property RoutIFace_ID() As String Implements RoutBoardUniInterface.RoutIFace_String4
        Get
            Return m_RoutIFace_ID
        End Get
        Set(ByVal value As String)
            m_RoutIFace_ID = Val(value)
        End Set
    End Property



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim Topicinfo As FirstClickerService.Version1.ForumTopic.StructureTopic = FirstClickerService.Version1.ForumTopic.Get_TopicDetails(RoutIFace_ID, WebAppSettings.DBCS)
            LabelTopicid.Text = Topicinfo.TopicID
            LabelHeading.Text = Topicinfo.Heading
            LabelDate.Text = FirstClickerService.Common.ConvertDateTime4Use(Topicinfo.PostDate.ToString("yyyy-MM-dd HH:mm:ss"))
            LabelDrescption.Text = Topicinfo.Body
            LabelForumID.Text = Topicinfo.ForumID
            LabelTopicUserID.Text = Topicinfo.UserID

            UserLikeDisLikeAction.LikeOnID = Topicinfo.TopicID


            If Topicinfo.Status = FirstClickerService.Version1.ForumTopic.TopicStatusEnum.Closed Or Topicinfo.Status = FirstClickerService.Version1.ForumTopic.TopicStatusEnum.Closed_By_Moderators Or Topicinfo.Status = FirstClickerService.Version1.ForumTopic.TopicStatusEnum.Closed_By_SiteAdmin Then
                PanelPostReply.Enabled = False
            Else

            End If


            Dim Foruminfo As FirstClickerService.Version1.Forum.StructureForum = FirstClickerService.Version1.Forum.Get_Forum_ByID(LabelForumID.Text, WebAppSettings.DBCS)
            HyperLinkForum.Text = Foruminfo.Heading
            HyperLinkForum.NavigateUrl = "~/forum/" & Foruminfo.Heading.Replace(" ", "-") & "/" & Foruminfo.ForumId

            HyperLinkForumHeading.Text = Foruminfo.Heading
            HyperLinkForumHeading.NavigateUrl = "~/forum/" & Foruminfo.Heading.Replace(" ", "-") & "/" & Foruminfo.ForumId
            LabelForumUserID.Text = Foruminfo.UserID


            Dim userInfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_UserID(Topicinfo.UserID, WebAppSettings.DBCS)
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

            Dim Cusertype As New FirstClickerService.Version1.User.UserType
            Try
                Cusertype = [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Trim(Session("UserType")), True)
                If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
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

        Dim topicreply As FirstClickerService.Version1.ForumTopicReply.StructureTopicReply = FirstClickerService.Version1.ForumTopicReply.Create_topicReply(textboxreplyBody.Text, Session("userid"), RoutIFace_ID, "0", WebAppSettings.DBCS)
        If topicreply.Result = False Then
            LabelMsg.Text = "Failed to make reply."
        Else
            If CheckBoxPostToMyWall.Checked = True Then
                ' post to user wall
                Dim submituserwall2 As FirstClickerService.Version1.UserWall.StructureUserWall
                submituserwall2 = FirstClickerService.Version1.UserWall.UserWall_Add("replied in following topic", textboxreplyBody.Text.Replace("'", "''"), 0, Session("userId"), Session("userid"), FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, FirstClickerService.Version1.UserWall.PreviewTypeEnum.ForumTopic, LabelTopicid.Text, LabelHeading.Text, HttpContext.Current.Request.Url.ToString.Replace("'", "''"), Mid(textboxreplyBody.Text, 1, 500).Replace("'", "''"))
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
    <asp:Label ID="LabelForumUserID" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="LabelTopicUserID" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="LabelForumID" runat="server" Text="0" Visible="False"></asp:Label>

    <div class="row">

          <div class="col-lg-9 col-md-12 col-sm-12 ">
            <div class="card BoxEffect6 mt-2">
                <div class="card-header p-2 clearfix">
                    <div class="float-right">
                        <asp:HyperLink ID="HyperLink2" NavigateUrl="~/Dashboard/Forum/Create.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Create Forum</asp:HyperLink>
                    </div>
                    <ul class="list-inline m-0 ">
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 ">
                                <i class="fab fa-foursquare"></i>&nbsp;<asp:HyperLink ID="HyperLinkForumHome" runat="server" NavigateUrl="~/Forum/Default.aspx">Forum</asp:HyperLink>
                            </h5>
                        </li>
                        <li class="list-inline-item">/</li>
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 ">
                                <asp:HyperLink ID="HyperLinkForumHeading" runat="server"></asp:HyperLink></h5>
                        </li>

                    </ul>
                </div>
            </div>



            <div class="card mt-2 mb-2">

                <div class="list-group-item">
                    <div class="media">
                        <a class="float-left" href="#">
                            <asp:Image ID="ImageForumTopicUser" runat="server" CssClass=" "
                                ImageUrl="~/App_Themes/Default/images/Logo.png" Width="75" Height="100" /><!-- 64x64 -->
                        </a>
                        <div class="media-body ml-2 ">
                            <div class="dropdown float-right">
                                <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                                <ul class="dropdown-menu">
                                    <li runat="server" id="LIActionStatus" class ="dropdown-item " visible="false">
                                        <asp:LinkButton ID="LinkButtonStatus" OnClick="LinkButtonStatus_Click" runat="server"><small>Change Status</small></asp:LinkButton>
                                    </li>
                                    <li runat="server" id="LIActionDelete" class ="dropdown-item " visible="false">
                                        <asp:LinkButton ID="LinkButtonDelete" OnClick="LinkButtonDelete_Click" OnClientClick="return confirm('You can not recover it back!! Are you sure you want to delete? ');" runat="server"><small>Delete</small></asp:LinkButton>
                                    </li>
                                    <li runat="server" id="LIActionReport" class ="dropdown-item ">
                                        <asp:LinkButton ID="LinkButtonReport" runat="server"><small>Report</small> </asp:LinkButton>
                                    </li>
                                </ul>
                            </div>

                            <h2 class=" text-primary">
                                <asp:Label ID="LabelHeading" runat="server" Text="" />
                                <asp:Label ID="LabelTopicid" runat="server" Text="" Visible="False"></asp:Label>
                            </h2>
                            <h5>
                                <i class="fab fa-foursquare"></i>&nbsp;<asp:HyperLink ID="HyperLinkForum" runat="server"></asp:HyperLink>
                            </h5>
                            <p>
                                <i class="fas fa-user-circle"></i>&nbsp;<asp:HyperLink ID="HyperLinkUserName" CssClass="text-capitalize " runat="server"></asp:HyperLink>
                                <small>
                                    <i class="far fa-calendar-alt"></i>&nbsp;<asp:Label ID="LabelDate" runat="server" Text="" />
                                </small>
                            </p>
                            <p>
                                <asp:Label ID="LabelDrescption" runat="server" Text="" />
                            </p>
                        </div>
                    </div>
                </div>
                  <div class="list-group-item">
                        <div class="float-left ">
                           
                                </div>
                                <div class="float-right ">
                                    <uc1:UserLikeDisLikeAction runat="server" ID="UserLikeDisLikeAction" LikeOn="ForumTopic"  />
                                </div>
                  </div> 
                <div class="card-footer"><a href="#<%= PanelPostReply.ClientID %>" class="Change-DropDown-Icon" data-toggle="collapse"  aria-expanded="false" ><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Write reply<i class="fa fa-chevron-circle-right float-right"></i></a></div>
                <asp:Panel runat="server" ID="PanelPostReply" CssClass="card-collapse collapse">
                    <div class="card-body ">
                        <div class="form">
                            <div class="form-group">
                                <label for="textboxreplyBody" class="sr-only">Make reply</label>
                                <asp:TextBox ID="textboxreplyBody" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Your reply"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="LabelMsg" runat="server" ForeColor="Maroon"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer clearfix">
                        <div class="float-right ">
                            <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass="text-info small text-muted" Text="Share on my wall" runat="server" />
                            <asp:Button ID="ButtonReply" runat="server" CssClass="btn btn-sm btn-info" Text="Reply" OnClick="ButtonReply_Click" />
                        </div>
                    </div>
                </asp:Panel>
            </div>




            <div class="card">
            

            
                    <asp:ListView ID="ListViewTopicReply" runat="server" DataSourceID="SqlDataSourceTopicReply" DataKeyNames="Id">
                        <EmptyDataTemplate>
                            <div class="card-body">No comment yet.</div>
                        </EmptyDataTemplate>

                        <ItemTemplate>
                         
                                <div class="card-body">
                                    <div class="media">
                                        <asp:HyperLink ID="userimage" runat="server" CssClass="float-left" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'>
                                            <asp:Image runat="server" ID="userimg" CssClass=" " ImageUrl='<%# "~/storage/image/" + Eval("imagefilename")%>' Width="60" Height="80" />
                                        </asp:HyperLink>
                                        <div class="media-body ml-2">
                                            <p>
                                                <strong>
                                                    <asp:HyperLink ID="HyperLinkUserName" runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink>
                                                    <small>
                                                        <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# Eval("PostDate")%>' />
                                                    </small></strong>
                                            </p>
                                            <p>
                                                <asp:Label Text='<%# Eval("Reply").ToString.Replace(Environment.NewLine, "<br />")%>' runat="server" ID="DrescptionLabel" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                         

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" class="card">
                                <div runat="server" id="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceTopicReply" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT t.[Id], t.[TopicId], t.[Reply], t.[PostDate], t.[UserId],  t.[Status], TU.username, TU.routusername, TUI.ImageFileName 
                        FROM [Table_ForumTopicReply] t 
                        left JOIN table_User TU on TU.userid = t.userid
                        left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                        WHERE ([TopicId] = @TopicId) 
                        ORDER BY [PostDate] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="LabelTopicid" PropertyName="Text" Name="TopicId" Type="Decimal"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
               
                <div class="card-footer clearfix ">
                    <div class="float-left "></div>
                    <div class=" float-right ">
                        <asp:DataPager runat="server" ID="DataPagerTopicReply" PagedControlID="ListViewTopicReply">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>

            <div class="col-lg-3 col-md-12 col-sm-12 ">

            </div>
    </div>
</asp:Content>

