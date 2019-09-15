<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>

<script runat="server">
    Protected Sub ButtonAddMoreTag1_Click(sender As Object, e As EventArgs)
        ButtonAddMoreTag1.Visible = False
        panelTag2.Visible = True
        ButtonAddMoreTag2.Visible = True
    End Sub

    Protected Sub ButtonAddMoreTag2_Click(sender As Object, e As EventArgs)
        ButtonAddMoreTag2.Visible = False
        panelTag3.Visible = True
    End Sub

    Protected Sub ButtonAskQuestion_Click(sender As Object, e As EventArgs)
        Dim createQuestion As FirstClickerService.Version1.Question.StructureQuestion
        createQuestion = FirstClickerService.Version1.Question.Question_Add(TextBoxQuestion.Text, TextBoxDrescption.Text, "0", Val(Session("UserID")), WebAppSettings.DBCS)
        If createQuestion.Result = True Then
            Dim newForumURL As String = "~/question/" & FirstClickerService.Common.ConvertSpace2Dass(createQuestion.Question) & "/" & createQuestion.QuestionID

            'xxxxxxxxxxxxxxx submit Tag xxxxxxxxxxxxxxxxxxxx 
            Dim listOfTags As New ArrayList
            For r As Integer = 1 To 3
                Select Case r
                    Case 1
                        If Trim(TextBoxTag1.Text) <> "" Then
                            If Trim(TextBoxTag1.Text).Length >= 2 And Trim(TextBoxTag1.Text).Length < 50 Then
                                listOfTags.Add(TextBoxTag1.Text)
                            Else
                                LabelEM.Text = "Tag#1 lenth must be 2 to 50 character."
                                Exit Sub
                            End If
                        End If
                    Case 2
                        If Trim(TextBoxTag2.Text) <> "" Then
                            If Trim(TextBoxTag2.Text).Length >= 2 And Trim(TextBoxTag2.Text).Length < 50 Then
                                listOfTags.Add(TextBoxTag2.Text)
                            Else
                                LabelEM.Text = "Tag#2 lenth must be 2 to 50 character."
                                Exit Sub
                            End If
                        End If
                    Case 3
                        If Trim(TextBoxTag3.Text) <> "" Then
                            If Trim(TextBoxTag3.Text).Length >= 2 And Trim(TextBoxTag3.Text).Length < 50 Then
                                listOfTags.Add(TextBoxTag3.Text)
                            Else
                                LabelEM.Text = "Tag#3 lenth must be 2 to 50 character."
                                Exit Sub
                            End If
                        End If
                End Select
            Next


            Dim i As Integer = 0
            For i = 0 To listOfTags.Count - 1
                If Trim(listOfTags(i)) <> "" Then
                    Dim TagSubmit As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.CheckandAddTag(Trim(listOfTags(i)), WebAppSettings.DBCS)
                    If TagSubmit.Result = True Then
                        Dim ListTagsubmit As FirstClickerService.Version1.TagOfQuestion.StructureTagOfQuestion = FirstClickerService.Version1.TagOfQuestion.AddTagOfQuestion(TagSubmit.TagId, createQuestion.QuestionID, Val(Session("UserId")), WebAppSettings.DBCS)
                    End If
                End If
            Next
            'xxxxxxxxxxxxxxx submit Tag xxxxxxxxxxxxxxxxxxxx 


            If CheckBoxPostToMyWall.Checked = True Then  'post to userwall
                Dim submituserwall2 As FirstClickerService.Version1.UserWall.StructureUserWall
                submituserwall2 = FirstClickerService.Version1.UserWall.UserWall_Add("asked new question", " ", 0, Session("userId"), Session("userid"), FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, FirstClickerService.Version1.UserWall.PreviewTypeEnum.Question, createQuestion.QuestionID)
            End If

            Response.Redirect(newForumURL)
        Else
            LabelEM.Text = createQuestion.My_Error_message
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub
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
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Dashboard/Question/Ask.aspx">Ask Question</asp:HyperLink>
                    </h5>
                </div>
                <div class="card-body">
                    <div class="form">
                        <div class="form-group">
                            <label>Question</label>
                            <asp:TextBox ID="TextBoxQuestion" runat="server" CssClass="form-control" placeholder="Ask Question"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Describe your question</label>
                            <asp:TextBox ID="TextBoxDrescption" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Question Drescption" ng-model="test" ng-trim="false" MaxLength="1500"></asp:TextBox>
                            
                            <small class="form-text text-muted">
                            </small>
                            </div>
                        <div class="form-group">
                            <asp:Label ID="LabelEM" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>

                        <asp:UpdatePanel ID="UpdatePanelListEntry" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Panel runat="server" ID="panelTag1" CssClass="form-group" Visible="true">
                                    <label for="TextBoxTag1">Question Tags: (One tag each line)</label>
                                    <asp:TextBox ID="TextBoxTag1" runat="server" CssClass="form-control form-control-sm text-primary" placeholder="e.g. Question Category, related keyword etc."></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreTag1" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="true" OnClick="ButtonAddMoreTag1_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="panelTag2" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxTag2" runat="server" CssClass="form-control form-control-sm text-primary" placeholder="e.g. Question Category, related keyword etc."></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreTag2" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="false" OnClick="ButtonAddMoreTag2_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="panelTag3" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxTag3" runat="server" CssClass="form-control form-control-sm text-primary" placeholder="e.g. Question Category, related keyword etc."></asp:TextBox>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="card-footer clearfix">
                    <div class="float-right">
                        <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass="text-info small text-muted" Text="Share on my wall" runat="server" Checked="true" />
                        <asp:Button ID="ButtonAskQuestion" runat="server" Text="Ask Question" class="btn btn-info btn-sm" OnClick="ButtonAskQuestion_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

