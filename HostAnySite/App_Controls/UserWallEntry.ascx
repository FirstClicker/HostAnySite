<%@ Control Language="VB" ClassName="UserWallEntry" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/App_Controls/UserSignInNeededButton.ascx" TagPrefix="uc1" TagName="UserSignInNeededButton" %>
<%@ Register Src="~/App_Controls/UserLikeDisLikeAction.ascx" TagPrefix="uc1" TagName="UserLikeDisLikeAction" %>



<script runat="server">
    ' version 24/06/2019 # 4.27 AM

    Public Property UserID() As String
        Get
            Return LabeluserID.Text
        End Get
        Set(ByVal value As String)
            LabeluserID.Text = value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return HyperLinkUserName.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUserName.Text = value
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUserName.Text = value
        End Set
    End Property

    Public Property WallUserImage() As String
        Get
            Return userimg.ImageUrl
        End Get
        Set(ByVal value As String)
            userimg.ImageUrl = value
        End Set
    End Property

    Public Property WallID() As String
        Get
            Return LabelWallID.Text
        End Get
        Set(ByVal value As String)
            LabelWallID.Text = value
            UserLikeDisLikeAction.LikeOnID = value
            UserLikeDisLikeAction.LikeOn = FirstClickerService.Version1.UserLike.LikeOnEnum.Wall
        End Set
    End Property

    Public Property WallHeading() As String
        Get
            Return LabelHeading.Text
        End Get
        Set(ByVal value As String)
            LabelHeading.Text = value
        End Set
    End Property

    Public Property WallMessage() As String
        Get
            Return MessageLabel.Text
        End Get
        Set(ByVal value As String)
            MessageLabel.Text = value.Replace(Environment.NewLine, "<br />")

        End Set
    End Property

    Public Property WallDatetime() As String
        Get
            Return postdateLabel.Text
        End Get
        Set(ByVal value As String)
            postdateLabel.Text = FirstClickerService.common.ConvertDateTime4Use(value)
        End Set
    End Property

    Public Property WallPostImageID() As String
        Get
            Return LabelWallPostImageID.Text
        End Get
        Set(ByVal value As String)
            LabelWallPostImageID.Text = value
            WallPostImage.Visible = CBool(value)
        End Set
    End Property

    Public Property WallPostImageName() As String
        Get
            Return LabelWall_ImageName.Text
        End Get
        Set(ByVal value As String)
            LabelWall_ImageName.Text = value

        End Set
    End Property

    Public Property WallPostImageURL() As String
        Get
            Return WallPostImage.ImageUrl
        End Get
        Set(ByVal value As String)
            WallPostImage.ImageUrl = value
        End Set
    End Property


    Public Property Wall_UserId() As String
        Get
            Return LabelWall_UserId.Text
        End Get
        Set(ByVal value As String)
            LabelWall_UserId.Text = value
        End Set
    End Property

    Public Property Wall_UserName() As String
        Get
            Return LabelWall_UserName.Text
        End Get
        Set(ByVal value As String)
            LabelWall_UserName.Text = value
        End Set
    End Property

    Public Property Wall_RoutUserName() As String
        Get
            Return LabelWall_RoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelWall_RoutUserName.Text = value
        End Set
    End Property


    Public Property numberofcomment() As String
        Get
            Return Labelnumberofcomment.Text
        End Get
        Set(ByVal value As String)
            Labelnumberofcomment.Text = value
        End Set
    End Property

    Public Property PreviewType As String
        Get
            If [Enum].IsDefined(GetType(FirstClickerService.Version1.UserWall.PreviewTypeEnum), LabelPreviewType.Text) Then
                Return LabelPreviewType.Text
            Else
                Return FirstClickerService.Version1.UserWall.PreviewTypeEnum.None.ToString()
            End If
        End Get
        Set(ByVal value As String)
            If [Enum].IsDefined(GetType(FirstClickerService.Version1.UserWall.PreviewTypeEnum), value) Then
                LabelPreviewType.Text = value.ToString
            Else
                ' report wrong enum type
                'correct in db
                LabelPreviewType.Text = FirstClickerService.Version1.UserWall.PreviewTypeEnum.None.ToString()
            End If
        End Set
    End Property

    Public Property Preview_ID() As String
        Get
            Return LabelPreview_ID.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_ID.Text = value
        End Set
    End Property

    Public Property Preview_Heading() As String
        Get
            Return LabelPreview_Heading.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_Heading.Text = value
        End Set
    End Property

    Public Property Preview_TargetURL() As String
        Get
            Return LabelPreview_TargetURL.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_TargetURL.Text = value
        End Set
    End Property

    Public Property Preview_ImageURL() As String
        Get
            Return LabelPreview_ImageURL.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_ImageURL.Text = value
        End Set
    End Property

    Public Property Preview_BodyText() As String
        Get
            Return LabelPreview_BodyText.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_BodyText.Text = value
        End Set
    End Property


    Public Property ShowInHome() As FirstClickerService.Version1.UserWall.ShowInHomeEnum
        Get
            Return [Enum].Parse(GetType(FirstClickerService.Version1.UserWall.ShowInHomeEnum), LabelShowInHome.Text, True)
        End Get
        Set(ByVal value As FirstClickerService.Version1.UserWall.ShowInHomeEnum)
            LabelShowInHome.Text = value.ToString
        End Set
    End Property


    Protected Sub ButtonPostComment_Click(sender As Object, e As EventArgs)
        If Trim(TextBoxComment.Text) = "" Or Trim(Session("userid")) = "" Then
            LabelPop.Text = "Please signin to use this function."
            ModalPopupExtender1.Show()
            Exit Sub
        End If

        Dim postcommnet As FirstClickerService.Version1.UserWallComment.StructureUserWallComment = FirstClickerService.Version1.UserWallComment.UserWallCommentPost_Add(TextBoxComment.Text, Session("Userid"), LabelWallID.Text, WebAppSettings.DBCS)
        If postcommnet.Result = True Then
            TextBoxComment.Text = ""
            ListViewWallComment.DataBind()
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkUserName.NavigateUrl = "~/user/" & RoutUserName
        HyperLinkWallPostImage.NavigateUrl = "~/image/" & WallPostImageName.ToString.Replace(" ", "-") & "/" & WallPostImageID

        If IsPostBack = False Then

            If Val(Wall_UserId) <> 0 And Val(Wall_UserId) <> Val(UserID) Then
                HyperLinkPostedOnusername.Text = Wall_UserName
                HyperLinkPostedOnusername.NavigateUrl = "~/user/" & Wall_RoutUserName
            End If

            'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            Dim Cusertype As New FirstClickerService.Version1.User.UserType
            Try
                Cusertype = [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Trim(Session("UserType")), True)
                If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
                    LIActionDelete.Visible = True
                    LIActionFeatured.Visible = True
                End If
            Catch ex As Exception
            End Try

            If Val(UserID) > 10 And Val(UserID) = Val(Session("UserID")) Then
                LIActionDelete.Visible = True
            End If
            'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX



            If PreviewType = FirstClickerService.Version1.UserWall.PreviewTypeEnum.Blog.ToString Then
                PanelPreviewTypeBlog.Visible = True
            End If

            If PreviewType = FirstClickerService.Version1.UserWall.PreviewTypeEnum.Forum.ToString Then
                PanelPreviewTypeForum.Visible = True
            End If

            If PreviewType = FirstClickerService.Version1.UserWall.PreviewTypeEnum.ForumTopic.ToString Then
                PanelPreviewTypeForumTopic.Visible = True
            End If

            If PreviewType = FirstClickerService.Version1.UserWall.PreviewTypeEnum.Image.ToString Then
                PanelPreviewTypeImage.Visible = True
                Dim PreviewimgDetails As FirstClickerService.Version1.Image.StructureImage = FirstClickerService.Version1.Image.ImageDetails_BYID(Preview_ID, WebAppSettings.DBCS)

                If PreviewimgDetails.Result = True Then
                    HyperLinkPreviewTypeImageViewImage.NavigateUrl = "~/image/" & PreviewimgDetails.ImageName.ToString.Replace(" ", "-") & "/" & PreviewimgDetails.ImageId
                    PreviewTypeImageViewImage.ImageUrl = "~/storage/image/" & PreviewimgDetails.ImageFileName
                Else
                    'image not found, report error
                End If

            End If

            If PreviewType = FirstClickerService.Version1.UserWall.PreviewTypeEnum.Question.ToString Then
                PanelPreviewTypeQuestion.Visible = True
            End If

            If PreviewType = FirstClickerService.Version1.UserWall.PreviewTypeEnum.QuestionAnswer.ToString Then
                PanelPreviewTypeQuestionAnswer.Visible = True
            End If


            If PreviewType = FirstClickerService.Version1.UserWall.PreviewTypeEnum.ExternalLink.ToString Then
                PanelPreviewTypeExternalLink.Visible = True
                HyperLinkPreviewTypeExternalLinkHeading.Text = Preview_Heading
                HyperLinkPreviewTypeExternalLinkHeading.NavigateUrl = Preview_TargetURL
                LabelPreviewTypeExternalLinkBody.Text = Preview_BodyText
                If Trim(Preview_ImageURL) <> "" Then
                    ImagePreviewTypeExternalLinkImage.Visible = True
                    ImagePreviewTypeExternalLinkImage.ImageUrl = Preview_ImageURL
                End If


            End If

            If LabelWallPostImageID.Text = 0 And Trim(MessageLabel.Text) = "" Then
                PanelPostMain.Visible = False
            End If

            If Trim(MessageLabel.Text) = "" Then
                PanelPostMainMsgHolder.Visible = False
            End If


        End If
    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)
        FirstClickerService.Version1.UserWall.UserWall_DeleteByWallID(WallID, WebAppSettings.DBCS)
        panelContainer.Visible = False
        Me.Visible = False
    End Sub

    Protected Sub LinkButtonFeatured_Click(sender As Object, e As EventArgs)
        Dim userwallupdate As FirstClickerService.Version1.UserWall.StructureUserWall
        If ShowInHome = FirstClickerService.Version1.UserWall.ShowInHomeEnum.False Or ShowInHome = FirstClickerService.Version1.UserWall.ShowInHomeEnum.Pending Then
            userwallupdate = FirstClickerService.Version1.UserWall.Set_ShowinHome(WallID, FirstClickerService.Version1.UserWall.ShowInHomeEnum.True, WebAppSettings.DBCS)
        Else
            userwallupdate = FirstClickerService.Version1.UserWall.Set_ShowinHome(WallID, FirstClickerService.Version1.UserWall.ShowInHomeEnum.False, WebAppSettings.DBCS)
        End If
    End Sub
</script>


<asp:Label ID="LabeluserID" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelWallID" runat="server" Text="0" Visible="False"></asp:Label>

<asp:Label ID="LabelWall_UserId" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelWall_UserName" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelWall_RoutUserName" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelWallPostImageID" runat="server" Text="0" Visible="false"></asp:Label>
<asp:Label ID="LabelWall_ImageName" runat="server" Text="" Visible="False"></asp:Label>


<asp:Label ID="LabelPreviewType" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_ID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_Heading" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_TargetURL" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_ImageURL" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_BodyText" runat="server" Text="" Visible="False"></asp:Label>



<asp:Panel ID="panelContainer" runat="server" CssClass="card BoxEffect6 mt-3 mb-3">
    <div class="card-header p-1">
        <div class="media" style="overflow: visible">
            <asp:Image runat="server" ID="userimg" class="mr-1 rounded" Width="45" Height="45" />
            <div class="media-body clearfix" style="overflow: visible">
                <div class="dropdown float-right mr-1 mt-1">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li runat="server" id="LIActionFeatured" class="dropdown-item" visible="false">
                            <small><asp:LinkButton ID="LinkButtonFeatured" runat="server" OnClick ="LinkButtonFeatured_Click">ShowInHome- <asp:Label ID="LabelShowInHome" runat="server" Text="Pending" ></asp:Label></asp:LinkButton></small>
                        </li>
                        <li runat="server" id="LIActionDelete" class="dropdown-item" visible="false">
                            <asp:LinkButton ID="LinkButtonDelete" OnClick="LinkButtonDelete_Click" runat="server"><small>Delete</small></asp:LinkButton>
                        </li>
                        <li runat="server" id="LIActionReport" class="dropdown-item">
                            <asp:LinkButton ID="LinkButtonReport" runat="server"><small>Report</small> </asp:LinkButton>
                        </li>
                    </ul>
                </div>
                <div class="float-left">
                    <h5 class="card-title m-0">
                        <asp:HyperLink ID="HyperLinkUserName" CssClass="text-capitalize" runat="server"></asp:HyperLink>
                        <asp:Label ID="LabelHeading" CssClass="text-capitalize text-muted" runat="server" Text="" />
                        &nbsp;<asp:HyperLink ID="HyperLinkPostedOnusername" runat="server"></asp:HyperLink>
                    </h5>
                    <span>
                        <asp:Label ID="postdateLabel" runat="server" Text="" />
                    </span>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <asp:Panel runat="server" ID="PanelPreviewTypeQuestion" CssClass="card-body" Visible="false">
            <asp:ListView ID="ListViewQuestionView" runat="server" DataSourceID="SqlDataSourceQuestionView" DataKeyNames="QuestionID">
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="media">
                        <asp:Image ID="Image1" CssClass="mr-1" runat="server" Width="40" ImageUrl="~/Content/Image/Question.png" />
                        <div class="media-body">
                            <h5 class="mr-0">
                                <asp:HyperLink ID="PreviewTypeMediaViewheading" runat="server" Text='<%# Eval("Question") %>' NavigateUrl='<%# "~/Question/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Question")) & "/" & Eval("QuestionId")  %>'></asp:HyperLink>
                            </h5>
                            <div>
                                <asp:Panel runat="server" ID="PanelPreviewMediaViewImageCointainer" Style="float: right; width: 40%;">
                                    <asp:Image runat="server" ID="PreviewTypeMediaViewImage" CssClass="img-fluid" />
                                </asp:Panel>
                                <p>
                                    <asp:Label ID="PreviewTypeMediaViewBody" runat="server" Text='<%# Eval("Drescption") %>'></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style="">
                        <div runat="server" id="itemPlaceholder" />
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceQuestionView" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' SelectCommand="SELECT * FROM [Table_Question] WHERE ([QuestionID] = @QuestionID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="LabelPreview_ID" PropertyName="Text" Name="QuestionID" Type="Decimal"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>

        <asp:Panel runat="server" ID="PanelPreviewTypeQuestionAnswer" CssClass="card-body" Visible="false">
            <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSourceAnswersquestion" DataKeyNames="QuestionID">
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="media">
                        <asp:Image runat="server" ID="userimg" CssClass="mr-1" ImageUrl='<%# "~/storage/image/" + Eval("UserImageFileName")%>' Width="60" Height="80" />
                        <div class="media-body">
                            <h4 class="m-0">
                                <asp:HyperLink ID="PreviewTypeMediaViewheading" runat="server" Text='<%# Eval("Question") %>' NavigateUrl='<%# "~/Question/" &  FirstClickerService.common.ConvertSpace2Dass(Eval("Question")) & "/" & Eval("QuestionId")  %>'></asp:HyperLink>
                            </h4>
                            <p>
                                <strong>
                                    <asp:HyperLink ID="HyperLinkUserName" runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink>
                                </strong>
                            </p>
                            <div>
                                <p>
                                    <asp:Label ID="PreviewTypeMediaViewBody" runat="server" Text='<%# Eval("Drescption") %>'></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style="">
                        <div runat="server" id="itemPlaceholder" />
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceAnswersquestion" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                SelectCommand="SELECT TQA.AnswerID, TQ.QuestionID, TQ.Question, TQ.Drescption, Tu.username, Tu.RoutUserName, Tui.ImageFileName as UserImageFileName
                        FROM [Table_QuestionAnswer] TQA
                        left join [Table_Question] TQ on TQ.QuestionID = TQA.QuestionID 
                         Left join table_user TU on Tu.userid=TQ.userID
                    Left join Table_image TUI on TUI.imageid=Tu.imageID 
                        WHERE (TQA.[AnswerID] = @AnswerID)
                        group by TQA.AnswerID, TQ.QuestionID, TQ.Question, TQ.Drescption, Tu.username, Tu.RoutUserName, Tui.ImageFileName">
                <SelectParameters>
                    <asp:ControlParameter ControlID="LabelPreview_ID" PropertyName="Text" Name="AnswerID" Type="Decimal"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <hr class="no-margin" />

            <asp:ListView ID="ListViewAnswers" runat="server" DataSourceID="SqlDataSourceAnswers" DataKeyNames="AnswerID">
                <EmptyDataTemplate>
                    <div>
                        <div class="card-body ">
                            No data was returned.
                        </div>
                    </div>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="media">
                        <asp:Image ID="Image1" CssClass="mr-1" runat="server" Width="40" ImageUrl="~/Content/Image/answer.png" />
                        <div class="media-body">

                            <p>
                                <asp:Label Text='<%#  Trim(Eval("Answer")).Replace(Environment.NewLine, "</br>") %>' runat="server" ID="DrescptionLabel" />
                                <br />
                                <small>
                                    <asp:HyperLink NavigateUrl='<%# Eval("Source") %>' Target="_blank" Text='<%# Eval("Source") %>' runat="server" ID="SourceLabel" />
                                </small>
                            </p>
                        </div>
                    </div>
                </ItemTemplate>
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer">
                        <div runat="server" id="itemPlaceholder" />
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceAnswers" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                SelectCommand="SELECT TQA.* 
                    FROM [Table_QuestionAnswer] TQA
                    WHERE (TQA.[AnswerID] = @AnswerID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="LabelPreview_ID" PropertyName="Text" Name="AnswerID" Type="Decimal"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

        </asp:Panel>


        <asp:Panel runat="server" ID="PanelPostMain" CssClass="card-body p-0" Style="word-wrap: break-word;">
            <asp:Panel ID="PanelPostMainMsgHolder" CssClass="m-4" runat="server">
                <asp:Label ID="MessageLabel" runat="server" Text="" />
            </asp:Panel>
            <asp:HyperLink ID="HyperLinkWallPostImage" runat="server" CssClass="m-0" NavigateUrl="~/image/">
                <asp:Image runat="server" ID="WallPostImage" CssClass="img-fluid" />
            </asp:HyperLink>
        </asp:Panel>

        <asp:Panel runat="server" ID="PanelPreviewTypeBlog" CssClass="card-body border" Visible="false">

            <asp:ListView ID="ListViewBlogView" runat="server" DataSourceID="SqlDataSourceBlogView" DataKeyNames="BlogId">
                <EmptyDataTemplate>
                    <span>Failed to load Blog.</span>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="media">
                        <div class="media-body">
                            <h3 class="m-1">
                                <asp:HyperLink ID="PreviewTypeMediaViewheading" runat="server" Text='<%# Eval("Heading") %>' NavigateUrl='<%# "~/blog/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("BlogID")  %>'></asp:HyperLink>
                            </h3>
                            <div class="card-body p-0">
                                <asp:Image runat="server" ID="PreviewTypeMediaViewImage" Style="max-width: 50%; max-height: 200px; float: right; margin-left: 10px; margin-right: 10px; margin-bottom: 10px;" Visible='<%# CBool(Eval("ImageID")) %>' ImageUrl='<%# "~/Storage/Image/" & Eval("ImageFileName") %>' />
                                <p>
                                    <asp:Label ID="PreviewTypeMediaViewBody" CssClass="text-muted" runat="server" Text='<%# Eval("Highlight") %>'></asp:Label>...
                                </p>
                                <div class="card-body p-0 ">
                                    <p>
                                        <small>
                                            <i class="fas fa-user-circle"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUsername" runat="server" CssClass="text-capitalize" Text='<%# Eval("username") %>' NavigateUrl='<%# "~/user/" & Eval("RoutUsername") %>'></asp:HyperLink>
                                            &nbsp;|&nbsp;
                                            <i class="far fa-calendar-alt"></i>&nbsp;<asp:Label ID="LabelPostDate" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("PostdateF")) %>'></asp:Label>
                                        </small>
                                        <asp:LinkButton ID="LinkButtonReadCompleteblog" CssClass="btn btn-sm btn-link bg-primary text-white float-right" runat="server" PostBackUrl='<%# "~/blog/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("BlogID") %>'>Read Full Blog</asp:LinkButton>
                                    </p>
                                </div>
                            </div>
                          
                        </div>
                    </div>
                </ItemTemplate>
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style="">
                        <div runat="server" id="itemPlaceholder" />
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceBlogView" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                SelectCommand="SELECT TB.*, CONVERT(VARCHAR(19), TB.postdate, 120) AS postdateF, TBI.ImageFileName, Tu.UserName, Tu.RoutUserName 
                    FROM [Table_Blog] TB 
                    Left Join Table_Image TBI on TBI.imageId=TB.ImageID 
                    Left join Table_user Tu on TU.UserId=TB.userId
                    WHERE (TB.[BlogId] = @BlogId)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="LabelPreview_ID" PropertyName="Text" Name="BlogId" Type="Decimal"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

        </asp:Panel>

        <asp:Panel runat="server" ID="PanelPreviewTypeImage" CssClass="card-body p-0" Visible="false">
            <asp:HyperLink ID="HyperLinkPreviewTypeImageViewImage" runat="server" CssClass="m-0" NavigateUrl="~/image/">
                <asp:Image runat="server" ID="PreviewTypeImageViewImage" CssClass="img-fluid" />
            </asp:HyperLink>
        </asp:Panel>

        <asp:Panel runat="server" ID="PanelPreviewTypeForum" CssClass="card-body" Visible="false">

            <asp:ListView ID="ListViewForumView" runat="server" DataSourceID="SqlDataSourceForumView" DataKeyNames="ForumId">
                <EmptyDataTemplate>
                    <span>Failed To Load Forum.</span>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="media">
                        <div class="media-body">
                            <h4 class="m-1">
                                <asp:HyperLink ID="PreviewTypeMediaViewheading" runat="server" Text='<%# Eval("Heading") %>' NavigateUrl='<%# "~/forum/" &  FirstClickerService.common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("ForumId")  %>'></asp:HyperLink>
                            </h4>
                            <div>
                                <asp:Panel runat="server" ID="PanelPreviewMediaViewImageCointainer" Style="float: right; width: 40%;">
                                    <asp:Image runat="server" ID="PreviewTypeMediaViewImage" CssClass="img-fluid" />
                                </asp:Panel>
                                <p>
                                    <asp:Label ID="PreviewTypeMediaViewBody" runat="server" Text='<%# Eval("Drescption") %>'></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style="">
                        <div runat="server" id="itemPlaceholder" />
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceForumView" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' SelectCommand="SELECT * FROM [Table_Forum] WHERE ([ForumId] = @ForumId)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="LabelPreview_ID" PropertyName="Text" Name="ForumId" Type="Decimal"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

        </asp:Panel>

        <asp:Panel runat="server" ID="PanelPreviewTypeForumTopic" CssClass="card-body" Visible="false">

            <asp:ListView ID="ListViewForumTopicView" runat="server" DataSourceID="SqlDataSourceForumTopicView" DataKeyNames="TopicId">
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="media">
                        <div class="media-body">
                            <h4 class="m-1">
                                <asp:HyperLink ID="PreviewTypeMediaViewheading" runat="server" Text='<%# Eval("Heading") %>' NavigateUrl='<%# "~/forum/topic/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("TopicId")  %>'></asp:HyperLink>
                            </h4>
                            <div>
                                <asp:Panel runat="server" ID="PanelPreviewMediaViewImageCointainer" Style="float: right; width: 40%;">
                                    <asp:Image runat="server" ID="PreviewTypeMediaViewImage" CssClass="img-fluid" />
                                </asp:Panel>
                                <p>
                                    <asp:Label ID="BodyLabel" runat="server" Text='<%# Eval("body") %>'></asp:Label>
                                </p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <LayoutTemplate>
                    <div runat="server" id="itemPlaceholderContainer" style="">
                        <div runat="server" id="itemPlaceholder" />
                    </div>
                </LayoutTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDataSourceForumTopicView" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' 
                SelectCommand="SELECT * FROM [Table_ForumTopic] WHERE ([TopicId] = @TopicId)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="LabelPreview_ID" PropertyName="Text" Name="TopicId" Type="Decimal"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

        </asp:Panel>


        <asp:Panel runat="server" ID="PanelPreviewTypeExternalLink" CssClass="card-body" Visible="false">
            <div class="media">
                <asp:Image runat="server" ID="ImagePreviewTypeExternalLinkImage" CssClass="m-1 " Width="100" Visible="false" />
                <div class="media-body">
                    <h4 class="m-1">
                        <asp:HyperLink ID="HyperLinkPreviewTypeExternalLinkHeading" Target="_blank" runat="server" Text=""></asp:HyperLink>
                    </h4>
                    <p>
                        <asp:Label ID="LabelPreviewTypeExternalLinkBody" runat="server" Text=""></asp:Label>
                    </p>
                </div>
            </div>
        </asp:Panel>

    </div>
    <div class="card-footer clearfix">
        <div class="float-left ">
            <button class="btn btn-link" style="text-decoration:none" type="button" data-toggle="collapse" data-target="#<%=collapseComment.ClientID%>">
                <i class="far fa-comments"></i>&nbsp;Comment:&nbsp;<asp:Label ID="Labelnumberofcomment" runat="server" CssClass="font-weight-bold" Text="0"></asp:Label>
            </button>

        </div>
        <div class="float-right ">
            <uc1:UserLikeDisLikeAction runat="server" id="UserLikeDisLikeAction" />
        </div>
    </div>
    <asp:Panel runat="server" ID="collapseComment" class="card-collapse collapse">
        <div class="card-body">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="form">
                        <div class="form-group">
                            <div class="input-group">
                                <asp:TextBox ID="TextBoxComment" runat="server" CssClass="form-control"></asp:TextBox>
                                <span class="input-group-prepend">
                                    <asp:Button ID="ButtonPostComment" CssClass="btn btn-default" runat="server" Text="Post" OnClick="ButtonPostComment_Click" UseSubmitBehavior="False" />
                                </span>
                            </div>
                        </div>
                    </div>
                    <asp:ListView ID="ListViewWallComment" runat="server" DataKeyNames="WallCommentId" DataSourceID="SqlDataSourceWallcomment">
                        <EmptyDataTemplate>
                            <span></span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <div class="list-group-item">
                                <div class="media">
                                    <asp:Image runat="server" ID="userimg" class="m-1" ImageUrl='<%# "~/storage/image/" + Eval("userimagefilename")%>' Width="33" Height="44" />
                                    <div class="media-body">
                                        <h5 class="">
                                            <asp:Label ID="UserIdLabel" runat="server" CssClass="text-capitalize" Text='<%# Eval("Username")%>' />
                                            <small>
                                                <asp:Label ID="PostDateLabel" runat="server" Text='<%# FirstClickerService.common.ConvertDateTime4Use(Eval("PostDate")) %>' />
                                            </small>
                                        </h5>
                                        <p>
                                            <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div id="itemPlaceholderContainer" runat="server" class="list-group">
                                <div runat="server" id="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSourceWallcomment" runat="server"
                        ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                        SelectCommand="SELECT TUWC.WallCommentId, TUWC.WallId, TUWC.Comment, TUWC.UserId, CONVERT(VARCHAR(19), TUWC.PostDate, 120) AS postdate , tU.Username, ti.ImageFileName as userimagefilename  
                                FROM [Table_UserWallComment] TUWC
                                left JOIN table_User tU on tU.userid = TUWC.userid
                                left JOIN table_image TI on tI.Imageid = tU.Imageid
                                WHERE ([WallId] = @WallId) ORDER BY [PostDate] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="LabelWallID" Name="WallId" PropertyName="Text" Type="Decimal" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </asp:Panel>
</asp:Panel>

<asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
<cc1:ModalPopupExtender ID="ModalPopupExtender1"  runat="server"
    PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground" CancelControlID="btnHide">
</cc1:ModalPopupExtender>
<asp:Panel ID="pnlPopup" runat="server" CssClass="card card-primary" Style="display: none; min-width :300px;">
    <div class="card-header ">
        Message:
         <div class="float-right clearfix">
            <asp:Button ID="btnHide" runat="server" CssClass="btn btn-sm btn-danger" Text="Cancel" />
        </div>
    </div>
    <div class="card-body ">
        <asp:Label ID="LabelPop" runat="server" Text="Please signin to use this function."></asp:Label>
    </div>
    <uc1:UserSignInNeededButton runat="server" ID="UserSignInNeededButton" Visible ="false"  />
</asp:Panel>

