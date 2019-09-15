<%@ Control Language="VB" ClassName="QuestionInListView" %>
<%@ Register Src="~/App_Controls/TagOfQuestion.ascx" TagPrefix="uc1" TagName="TagOfQuestion" %>


<script runat="server">
    ' version 23/07/2019 # 4.27 AM

    Public Property UserId() As String
        Get
            Return LabelUserId.Text
        End Get
        Set(ByVal value As String)
            LabelUserId.Text = value
            TagOfQuestion.QuestionUserId = Val(value)
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return HyperLinkUsername.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUsername.Text = value
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

    Public Property QuestionId() As Long
        Get
            Return LabelQuestionId.Text
        End Get
        Set(ByVal value As Long)
            LabelQuestionId.Text = value
            TagOfQuestion.QuestionId = Val(value)
        End Set
    End Property

    Public Property Heading() As String
        Get
            Return HyperLinkHeading.Text
        End Get
        Set(ByVal value As String)
            HyperLinkHeading.Text = value
        End Set
    End Property

    Public Property AnswerCount() As String
        Get
            Return LabelAnswerCount.Text
        End Get
        Set(ByVal value As String)
            LabelAnswerCount.Text = value
        End Set
    End Property




    Public Property PostDate() As String
        Get
            Return LabelPostDate.Text
        End Get
        Set(ByVal value As String)
            LabelPostDate.Text = FirstClickerService.Common.ConvertDateTime4Use(value)
        End Set
    End Property



    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkUsername.NavigateUrl = "~/user/" & RoutUserName
        HyperLinkHeading.NavigateUrl = "~/question/" & FirstClickerService.Common.ConvertSpace2Dass(Heading) & "/" & QuestionId



        'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        Dim Cusertype As New FirstClickerService.Version1.User.UserType
        Try
            Cusertype = [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Trim(Session("UserType")), True)
            If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
                LIActionDelete.Visible = True
            End If
        Catch ex As Exception
        End Try

        If Val(UserId) > 10 And Val(UserId) = Val(Session("UserID")) Then
            LIActionDelete.Visible = True
        End If
        'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)
        Dim deleteQuestion As FirstClickerService.Version1.Question.StructureQuestion = FirstClickerService.Version1.Question.Question_DeleteByQuestionID(QuestionId, WebAppSettings.DBCS)
        If deleteQuestion.Result = True Then
            Me.Visible = False
        Else
            parentpanel.CssClass = parentpanel.CssClass & " border border-danger"
        End If


    End Sub

</script>

<asp:Label ID="LabelUserId" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="false"></asp:Label>

<asp:Label ID="LabelQuestionId" runat="server" Text="0" Visible="false"></asp:Label>


<asp:panel runat ="server" id="parentpanel"  cssclass="card mb-2 mt-1">
    <div class="card-body">
        <div class="row">
            <div class="col-12">
            
                <div class="dropdown float-right">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                    <ul class="dropdown-menu dropdown-menu-right">
                        <li runat="server" id="LIActionFeatured" class="dropdown-item" visible="false">
                            <asp:LinkButton ID="LinkButtonFeatured" runat="server"><small>Featured</small></asp:LinkButton>
                        </li>
                        <li runat="server" id="LIActionDelete" class="dropdown-item" visible="false">
                            <asp:LinkButton ID="LinkButtonDelete" OnClick="LinkButtonDelete_Click" runat="server"><small>Delete</small></asp:LinkButton>
                        </li>
                        <li runat="server" id="LIActionReport" class="dropdown-item">
                            <asp:LinkButton ID="LinkButtonReport" runat="server"><small>Report</small> </asp:LinkButton>
                        </li>
                    </ul>
                </div>
                    <h4>
                    <asp:HyperLink ID="HyperLinkHeading" runat="server"></asp:HyperLink>
                </h4>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 border-top border-bottom">
                <i class="fas fa-user-circle"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUsername" runat="server" CssClass="text-capitalize"></asp:HyperLink>
                &nbsp;|&nbsp;<i class="far fa-calendar-alt"></i>&nbsp;<asp:Label ID="LabelPostDate" runat="server" Text=""></asp:Label>
                &nbsp;|&nbsp;<i class="far fa-comments"></i><a href="#">&nbsp;<asp:Label ID="LabelAnswerCount" runat="server" Text="0"></asp:Label> Answers</a>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <uc1:TagOfQuestion runat="server" ID="TagOfQuestion" />
            </div>
        </div>
    </div>

</asp:panel>
