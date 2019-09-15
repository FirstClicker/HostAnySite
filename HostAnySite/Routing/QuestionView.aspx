<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>
<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/App_Controls/TagOfQuestion.ascx" TagPrefix="uc1" TagName="TagOfQuestion" %>
<%@ Register Src="~/App_Controls/TagOfAllQuestions.ascx" TagPrefix="uc1" TagName="TagOfAllQuestions" %>
<%@ Register Src="~/App_Controls/UserLikeDisLikeAction.ascx" TagPrefix="uc1" TagName="UserLikeDisLikeAction" %>
<%@ Register Src="~/App_Controls/UserDetailsInListView.ascx" TagPrefix="uc1" TagName="UserDetailsInListView" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>



<script runat="server">
    ' version 13/10/2018 # 1.27 AM


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
            m_RoutIFace_Heading = value
        End Set
    End Property

    Private m_RoutIFace_ID As String
    Public Property RoutIFace_ID() As String Implements RoutBoardUniInterface.RoutIFace_String3
        Get
            Return m_RoutIFace_ID
        End Get
        Set(ByVal value As String)
            m_RoutIFace_ID = value
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
            Dim questioninfo As FirstClickerService.Version1.Question.StructureQuestion = FirstClickerService.Version1.Question.Question_GetByID(RoutIFace_ID, WebAppSettings.DBCS)
            If questioninfo.Result = False Then
                Response.Redirect("~/question/")
            End If

            LabelQuestionid.Text = questioninfo.QuestionID
            HyperLinkQuestion.Text = questioninfo.Question
            HyperLinkQuestion.NavigateUrl = Request.Url.AbsoluteUri

            LabelUserID.Text = questioninfo.userid

            UserLikeDisLikeAction.LikeOnID = questioninfo.QuestionID
            UserLikeDisLikeAction.LikeOn = FirstClickerService.Version1.UserLike.LikeOnEnum.Question

            TagOfQuestion.QuestionId = questioninfo.QuestionID
            TagOfQuestion.QuestionUserId = questioninfo.userid

            LabelDate.Text = FirstClickerService.Common.ConvertDateTime4Use(questioninfo.PostDate.ToString("yyyy-MM-dd HH:mm:ss"))
            LabelDrescption.Text = questioninfo.Drescption


            Dim userInfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_UserID(questioninfo.userid, WebAppSettings.DBCS)
            HyperLinkUserName.Text = userInfo.UserName
            HyperLinkUserName.NavigateUrl = "~/user/" & userInfo.RoutUserName
            ImageForumUser.ImageUrl = "~/Storage/Image/" & userInfo.UserImage.ImageFileName
        End If

        Me.Title = HyperLinkQuestion.Text
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
                End If
            Catch ex As Exception

            End Try

            If Val(LabelUserID.Text) > 10 And Val(LabelUserID.Text) = Val(Session("UserID")) Then
                LIActionDelete.Visible = True
            End If
        End If
    End Sub

    Protected Sub ButtonAnswerQuestion_Click(sender As Object, e As EventArgs)
        Dim PostAnswer As FirstClickerService.Version1.QuestionAnswer.StructureAnswer
        PostAnswer = FirstClickerService.Version1.QuestionAnswer.Answer_Add(LabelQuestionid.Text, HtmlEditorTextBoxAnswer.Text, TextBoxAnswerSource.Text, 0, Val(Session("userid")), WebAppSettings.DBCS)
        If PostAnswer.Result = True Then
            If CheckBoxPostToMyWall.Checked = True Then  'post to userwall
                Dim submituserwall2 As FirstClickerService.Version1.UserWall.StructureUserWall
                submituserwall2 = FirstClickerService.Version1.UserWall.UserWall_Add("Answerd a question", " ", 0, Session("userId"), Session("userid"), FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, FirstClickerService.Version1.UserWall.PreviewTypeEnum.QuestionAnswer, PostAnswer.AnswerID)
            End If

            LabelCreateTopicEm.Text = "Answer poster successfully."
            HtmlEditorTextBoxAnswer.Text = ""
            TextBoxAnswerSource.Text = ""
            PanelcollapseCreateAnswer.CssClass = "card-collapse collapse"

            ListViewAnswers.DataBind()
        Else
            LabelCreateTopicEm.Text = "Failed save answer."
            PanelcollapseCreateAnswer.CssClass = "card-collapse collapse show"
        End If


    End Sub


    Protected Sub LinkButtonFeatured_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)

    End Sub




</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <meta property="og:url" content="<%=Request.Url.ToString%>" />
    <meta property="og:title" content="<%= HyperLinkQuestion.Text%>" />
    <meta property="og:description" content="<%=LabelDrescption.Text%>" />
    <meta property="og:image" content="<%= FirstClickerService.Common.GetAbsoluteUrl(HttpContext.Current, ImageForumUser.ImageUrl)%>" />

    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:site" content="@SayzzTweet" />
    <meta name="twitter:creator" content="@SayzzTweet" />
    <meta name="twitter:title" content="<%=HyperLinkQuestion.Text%>" />
    <meta name="twitter:description" content="<%=LabelDrescption.Text %>" />
    <meta name="twitter:image" content="<%= FirstClickerService.Common.GetAbsoluteUrl(HttpContext.Current, ImageForumUser.ImageUrl)%>" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelUserID" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="LabelForumShowInHome" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="LabelQuestionid" runat="server" Text="" Visible="False"></asp:Label>

    <div class="row">
        <div class="col-lg-8 col-md-8 col-sm-12">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="horizontal" />
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix">
                    <div class="float-right">
                        <asp:HyperLink ID="HyperLink3" NavigateUrl="~/Dashboard/question/ask.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Ask Question</asp:HyperLink>
                    </div>
                    <h5 class="card-title m-0 ">
                        <i class="fas fa-question"></i>&nbsp;<asp:HyperLink ID="HyperLinkQuestionHeading" runat="server" NavigateUrl="~/question/Default.aspx">Question</asp:HyperLink>
                    </h5>
                </div>
            </div>

            <div class="card">

                <div class="list-group-item">
                    <div class="media">
                        <a class="float-left mr-2" href="#">
                            <asp:Image ID="ImageForumUser" runat="server" class=" "
                                ImageUrl="~/App_Themes/Default/images/Logo.png" Width="75" Height="100" /><!-- 64x64 -->
                        </a>
                        <div class="media-body ">
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
                            <h2 class=" text-primary ">
                                <asp:HyperLink ID="HyperLinkQuestion" runat="server"></asp:HyperLink>

                            </h2>
                            <p>
                                <i class="fas fa-user-circle"></i>&nbsp;By&nbsp;
                                <asp:HyperLink ID="HyperLinkUserName" CssClass="text-capitalize " runat="server"></asp:HyperLink>
                                &nbsp;|&nbsp;<i class="far fa-calendar-alt"></i>&nbsp;<asp:Label ID="LabelDate" runat="server" Text="" />


                            </p>
                            <p>
                                <asp:Label ID="LabelDrescption" runat="server" Text="" />
                            </p>
                            <div>
                                <div class="float-left">
                                    <uc1:TagOfQuestion runat="server" ID="TagOfQuestion" />
                                </div>
                                <div class="float-right">
                                    <uc1:UserLikeDisLikeAction runat="server" ID="UserLikeDisLikeAction" />
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="card-footer">
                    <a href="#<%= PanelcollapseCreateAnswer.ClientID %>" class="Change-DropDown-Icon" data-toggle="collapse"><i class="far fa-edit"></i>&nbsp;Answer the question<i class="fa fa-chevron-circle-right float-right"></i></a>

                </div>
                <asp:Panel runat="server" ID="PanelcollapseCreateAnswer" CssClass="card-collapse collapse">
                    <div class="card-body">
                        <div class="form">
                            <div class="form-group">
                                <label for="HtmlEditorTextBoxAnswer" class="sr-only">Answer</label>
                                <asp:TextBox ID="HtmlEditorTextBoxAnswer" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Write your answer.."></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="TextBoxAnswerSource" class="sr-only">Source</label>
                                <asp:TextBox ID="TextBoxAnswerSource" runat="server" CssClass="form-control" placeholder="Source URL"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="LabelCreateTopicEm" runat="server" ForeColor="Maroon"></asp:Label>
                            </div>

                        </div>
                    </div>
                    <div class=" card-footer clearfix ">
                        <div class="float-right">
                            <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass="text-info small text-muted" Text="Share on my wall" runat="server" Checked="true" />
                            <asp:Button ID="ButtonAnswerQuestion" runat="server" Text="Answer" class="btn btn-sm btn-info" OnClick="ButtonAnswerQuestion_Click" />
                        </div>
                    </div>
                </asp:Panel>
            </div>


            <asp:ListView ID="ListViewAnswers" runat="server" DataSourceID="SqlDataSourceAnswers" DataKeyNames="AnswerID">

                <EmptyDataTemplate>
                    <div class="card  mt-2">
                        <div class="card-body">
                            Be the first one to answer the question...
                        </div>
                    </div>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <div class="card BoxEffect1 mt-2">
                        <div class="card-body p-2">
                            <div class="media">
                                <asp:HyperLink ID="userimage" runat="server" CssClass="float-left m-1" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'>
                                    <asp:Image runat="server" ID="userimg" CssClass=" " ImageUrl='<%# "~/storage/image/" + Eval("UserImageFileName")%>' Width="60" Height="80" />
                                </asp:HyperLink>
                                <div class="media-body">

                                    <h5 class="m-2">
                                        <i class="fas fa-user-circle"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUserName" runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink>
                                        &nbsp;|&nbsp;<i class="far fa-calendar-alt"></i>&nbsp;
                                        <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("postdateF"))%>' />

                                    </h5>

                                    <p class="ml-2 ">
                                        <asp:Label Text='<%#  Trim(Eval("Answer")).Replace(Environment.NewLine, "</br>") %>' runat="server" ID="DrescptionLabel" />
                                        <br />
                                        <small>
                                            <asp:HyperLink NavigateUrl='<%# Eval("Source") %>' Target="_blank" Text='<%# Eval("Source") %>' runat="server" ID="SourceLabel" />
                                        </small>
                                    </p>
                                </div>
                            </div>
                            <div class="clearfix ">
                                <div class="float-left"></div>
                                <div class="float-right">
                                    <uc1:UserLikeDisLikeAction runat="server" ID="UserLikeDisLikeAction" LikeOn="QuestionAnswer" LikeOnID='<%# Eval("AnswerId")%>' />
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
            <asp:SqlDataSource runat="server" ID="SqlDataSourceAnswers" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                SelectCommand="SELECT TQA.*, CONVERT(VARCHAR(19), TQA.postdate, 120) AS postdateF,  Tu.username, Tu.RoutUserName, Tui.ImageFileName as UserImageFileName 
                    FROM [Table_QuestionAnswer] TQA
                    Left join table_user TU on Tu.userid=TQA.userID
                    Left join Table_image TUI on TUI.imageid=Tu.imageID  
                    WHERE (TQA.[QuestionID] = @QuestionID)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="LabelQuestionid" PropertyName="Text" Name="QuestionID" Type="Decimal"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>


            <div class="card-footer mt-2 clearfix">
                <div class="float-right">
                    <asp:DataPager runat="server" ID="DataPagerTopic" PagedControlID="ListViewAnswers">
                        <Fields>
                            <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>

        </div>
        <div class="col-lg-4 col-md-4 col-sm-12">
            <uc1:TagOfAllQuestions runat="server" ID="TagOfAllQuestions" />
            <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat="rectangle" />
        </div>
    </div>

</asp:Content>

