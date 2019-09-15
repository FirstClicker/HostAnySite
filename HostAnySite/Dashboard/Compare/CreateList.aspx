<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>

<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Trim(Session("routusername")) <> "" Then

        End If

        Title = "Create Comparison List."
        MetaDescription = "Create your own list with your own criteria to compare. Share your list in favebook or twitter for your friends review."
        MetaKeywords = "ReviewClicker, Compare, Comparison, Criteria, List, Comparison List"

    End Sub



    Protected Sub ButtonAddMoreEntry2_Click(sender As Object, e As EventArgs)
        ButtonAddMoreEntry2.Visible = False
        PanelEntry3.Visible = True
        ButtonAddMoreEntry3.Visible = True
    End Sub

    Protected Sub ButtonAddMoreEntry3_Click(sender As Object, e As EventArgs)
        ButtonAddMoreEntry3.Visible = False
        PanelEntry4.Visible = True
        ButtonAddMoreEntry4.Visible = True
    End Sub

    Protected Sub ButtonAddMoreEntry4_Click(sender As Object, e As EventArgs)
        ButtonAddMoreEntry4.Visible = False
        PanelEntry5.Visible = True
        ButtonAddMoreEntry5.Visible = True
    End Sub

    Protected Sub ButtonAddMoreEntry5_Click(sender As Object, e As EventArgs)
        ButtonAddMoreEntry5.Visible = False
        PanelEntry6.Visible = True
    End Sub



    Protected Sub ButtonAddMoreCriteria1_Click(sender As Object, e As EventArgs)
        ButtonAddMoreCriteria1.Visible = False
        panelCriteria2.Visible = True
        ButtonAddMoreCriteria2.Visible = True
    End Sub

    Protected Sub ButtonAddMoreCriteria2_Click(sender As Object, e As EventArgs)
        ButtonAddMoreCriteria2.Visible = False
        panelCriteria3.Visible = True
        ButtonAddMoreCriteria3.Visible = True
    End Sub

    Protected Sub ButtonAddMoreCriteria3_Click(sender As Object, e As EventArgs)
        ButtonAddMoreCriteria3.Visible = False
        panelCriteria4.Visible = True
        ButtonAddMoreCriteria4.Visible = True
    End Sub

    Protected Sub ButtonAddMoreCriteria4_Click(sender As Object, e As EventArgs)
        ButtonAddMoreCriteria4.Visible = False
        panelCriteria5.Visible = True
        ButtonAddMoreCriteria5.Visible = True
    End Sub

    Protected Sub ButtonAddMoreCriteria5_Click(sender As Object, e As EventArgs)
        ButtonAddMoreCriteria5.Visible = False
        panelCriteria6.Visible = True
    End Sub



    Protected Sub ButtonAddMoreTag1_Click(sender As Object, e As EventArgs)
        ButtonAddMoreTag1.Visible = False
        panelTag2.Visible = True
        ButtonAddMoreTag2.Visible = True
    End Sub

    Protected Sub ButtonAddMoreTag2_Click(sender As Object, e As EventArgs)
        ButtonAddMoreTag2.Visible = False
        panelTag3.Visible = True
    End Sub



    Protected Sub Buttonpublish_Click(sender As Object, e As EventArgs)
        If Trim(TextBoxListHeading.Text) = "" Then
            LabelEm.Text = "Heading is compulsory"
            Exit Sub
        End If

        Dim listOfEntry As New ArrayList
        For r As Integer = 1 To 6
            Select Case r
                Case 1
                    If Trim(TextBoxEntry1.Text) <> "" Then
                        If Trim(TextBoxEntry1.Text).Length >= 2 And Trim(TextBoxEntry1.Text).Length < 50 Then
                            listOfEntry.Add(TextBoxEntry1.Text)
                        Else
                            LabelEm.Text = "List entry 1 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 2
                    If Trim(TextBoxEntry2.Text) <> "" Then
                        If Trim(TextBoxEntry2.Text).Length >= 2 And Trim(TextBoxEntry2.Text).Length < 50 Then
                            listOfEntry.Add(TextBoxEntry2.Text)
                        Else
                            LabelEm.Text = "List entry 2 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 3
                    If Trim(TextBoxEntry3.Text) <> "" Then
                        If Trim(TextBoxEntry3.Text).Length >= 2 And Trim(TextBoxEntry3.Text).Length < 50 Then
                            listOfEntry.Add(TextBoxEntry3.Text)
                        Else
                            LabelEm.Text = "List entry 3 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 4
                    If Trim(TextBoxEntry4.Text) <> "" Then
                        If Trim(TextBoxEntry4.Text).Length >= 2 And Trim(TextBoxEntry4.Text).Length < 50 Then
                            listOfEntry.Add(TextBoxEntry4.Text)
                        Else
                            LabelEm.Text = "List entry 4 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 5
                    If Trim(TextBoxEntry5.Text) <> "" Then
                        If Trim(TextBoxEntry5.Text).Length >= 2 And Trim(TextBoxEntry5.Text).Length < 50 Then
                            listOfEntry.Add(TextBoxEntry5.Text)
                        Else
                            LabelEm.Text = "List entry 5 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 6
                    If Trim(TextBoxEntry6.Text) <> "" Then
                        If Trim(TextBoxEntry6.Text).Length >= 2 And Trim(TextBoxEntry6.Text).Length < 50 Then
                            listOfEntry.Add(TextBoxEntry6.Text)
                        Else
                            LabelEm.Text = "List entry 6 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
            End Select
        Next

        If listOfEntry.Count < 2 Then
            LabelEm.Text = "Atleast 2 Entry is neeed to create comparison list."
            Exit Sub
        End If


        Dim listOfCriteria As New ArrayList
        For r As Integer = 1 To 6
            Select Case r
                Case 1
                    If Trim(TextBoxCriteria1.Text) <> "" Then
                        If Trim(TextBoxCriteria1.Text).Length >= 2 And Trim(TextBoxCriteria1.Text).Length < 50 Then
                            listOfCriteria.Add(TextBoxCriteria1.Text)
                        Else
                            LabelEm.Text = "List Criteria 1 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 2
                    If Trim(TextBoxCriteria2.Text) <> "" Then
                        If Trim(TextBoxCriteria2.Text).Length >= 2 And Trim(TextBoxCriteria2.Text).Length < 50 Then
                            listOfCriteria.Add(TextBoxCriteria2.Text)
                        Else
                            LabelEm.Text = "List Criteria 2 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 3
                    If Trim(TextBoxCriteria3.Text) <> "" Then
                        If Trim(TextBoxCriteria3.Text).Length >= 2 And Trim(TextBoxCriteria3.Text).Length < 50 Then
                            listOfCriteria.Add(TextBoxCriteria3.Text)
                        Else
                            LabelEm.Text = "List Criteria 3 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 4
                    If Trim(TextBoxCriteria4.Text) <> "" Then
                        If Trim(TextBoxCriteria4.Text).Length >= 2 And Trim(TextBoxCriteria4.Text).Length < 50 Then
                            listOfCriteria.Add(TextBoxCriteria4.Text)
                        Else
                            LabelEm.Text = "List Criteria 4 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 5
                    If Trim(TextBoxCriteria5.Text) <> "" Then
                        If Trim(TextBoxCriteria5.Text).Length >= 2 And Trim(TextBoxCriteria5.Text).Length < 50 Then
                            listOfCriteria.Add(TextBoxCriteria5.Text)
                        Else
                            LabelEm.Text = "List Criteria 5 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 6
                    If Trim(TextBoxCriteria6.Text) <> "" Then
                        If Trim(TextBoxCriteria6.Text).Length >= 2 And Trim(TextBoxCriteria6.Text).Length < 50 Then
                            listOfCriteria.Add(TextBoxCriteria6.Text)
                        Else
                            LabelEm.Text = "List Criteria 6 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
            End Select
        Next

        If listOfCriteria.Count < 1 Then
            LabelEm.Text = "Atleast 1 Criteria is neeed to create comparison list."
            Exit Sub
        End If



        Dim listOfTags As New ArrayList
        For r As Integer = 1 To 3
            Select Case r
                Case 1
                    If Trim(TextBoxTag1.Text) <> "" Then
                        If Trim(TextBoxTag1.Text).Length >= 2 And Trim(TextBoxTag1.Text).Length < 50 Then
                            listOfTags.Add(TextBoxTag1.Text)
                        Else
                            LabelEm.Text = "List Tag 1 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 2
                    If Trim(TextBoxTag2.Text) <> "" Then
                        If Trim(TextBoxTag2.Text).Length >= 2 And Trim(TextBoxTag2.Text).Length < 50 Then
                            listOfTags.Add(TextBoxTag2.Text)
                        Else
                            LabelEm.Text = "List Tag 2 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
                Case 3
                    If Trim(TextBoxTag3.Text) <> "" Then
                        If Trim(TextBoxTag3.Text).Length >= 2 And Trim(TextBoxTag3.Text).Length < 50 Then
                            listOfTags.Add(TextBoxTag3.Text)
                        Else
                            LabelEm.Text = "List Tag 3 lenth must be 2 to 50 character."
                            Exit Sub
                        End If
                    End If
            End Select
        Next

        If listOfTags.Count < 1 Then
            LabelEm.Text = "Atleast 1 tag is neeed to create comparison list."
            Exit Sub
        End If

        Dim SubmitList As FirstClickerService.Version1.ComparisonList.StructureComparisonList = FirstClickerService.Version1.ComparisonList.SubmitList(TextBoxListHeading.Text, " ", Val(Session("UserId")), FirstClickerService.Version1.ComparisonList.ComparisonListStatus.Unpublished, Now, Now.AddYears(10D), WebAppSettings.DBCS)
        If SubmitList.Result = True Then

            'xxxxxxxxxxxxxxx submit List Tag xxxxxxxxxxxxxxxxxxxx 
            Dim i As Integer = 0
            For i = 0 To listOfTags.Count - 1
                If Trim(listOfTags(i)) <> "" Then
                    Dim TagSubmit As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.CheckandAddTag(Trim(listOfTags(i)), WebAppSettings.DBCS)
                    If TagSubmit.Result = True Then
                        Dim ListTagsubmit As FirstClickerService.Version1.TagOfComparisonList.StructureTagOfList = FirstClickerService.Version1.TagOfComparisonList.AddTagOfList(TagSubmit.TagId, SubmitList.ListID, Val(Session("UserId")), WebAppSettings.DBCS)
                    End If
                End If
            Next

            'xxxxxxxxxxxxxxx submit List Entry xxxxxxxxxxxxxxxxxxxx 
            i = 0
            For i = 0 To listOfEntry.Count - 1
                If Trim(listOfEntry(i)) <> "" Then
                    Dim EntrySubmit As FirstClickerService.Version1.ComparisonEntry.StructureComparisonEntry = FirstClickerService.Version1.ComparisonEntry.CheckandAddEntry(Trim(listOfEntry(i)), " ", WebAppSettings.DefaultImgID_ComparisonEntry, Val(Session("UserId")), WebAppSettings.DBCS)
                    If EntrySubmit.Result = True Then
                        Dim ListEntryubmit As FirstClickerService.Version1.ComparisonEntryOfList.StructureEntryOfComparison = FirstClickerService.Version1.ComparisonEntryOfList.AddEntryOfComparisonList(EntrySubmit.EntryID, SubmitList.ListID, Val(Session("UserId")), EntrySubmit.ImageID, EntrySubmit.Description, WebAppSettings.DBCS)
                        If ListEntryubmit.Result = True Then

                            'xxxxxxxxxxxxxxx submit ListEntry Tag xxxxxxxxxxxxxxxxxxxx 
                            Dim i2 As Integer = 0
                            For i2 = 0 To listOfTags.Count - 1
                                If Trim(listOfTags(i2)) <> "" Then
                                    Dim TagSubmit As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.CheckandAddTag(Trim(listOfTags(i2)), WebAppSettings.DBCS)
                                    If TagSubmit.Result = True Then
                                        Dim ListEntryTagsubmit As FirstClickerService.Version1.TagOfComparisonListEntry.StructureTagOfListEntry = FirstClickerService.Version1.TagOfComparisonListEntry.AddTagOfListEntry(TagSubmit.TagId, ListEntryubmit.EntryID, Val(Session("UserId")), WebAppSettings.DBCS)
                                    End If
                                End If
                            Next

                        End If
                    End If
                End If
            Next


            'xxxxxxxxxxxxxxx submit List Criteria xxxxxxxxxxxxxxxxxxxx 
            i = 0
            For i = 0 To listOfCriteria.Count - 1
                If Trim(listOfCriteria(i)) <> "" Then
                    Dim CriteriaSubmit As FirstClickerService.Version1.ComparisonCriteria.StructureComparisonCriteria = FirstClickerService.Version1.ComparisonCriteria.CheckandAddCriteria(Trim(listOfCriteria(i)), WebAppSettings.DBCS)
                    If CriteriaSubmit.Result = True Then
                        Dim ListCriteriaSubmit As FirstClickerService.Version1.ComparisonCriteriaOfList.StructureCriteriaOfComparison = FirstClickerService.Version1.ComparisonCriteriaOfList.AddCriteriaOfComparisonList(CriteriaSubmit.CriteriaID, SubmitList.ListID, Val(Session("UserId")), " ", WebAppSettings.DBCS)
                    End If
                End If
            Next

            LabelEm.Text = "Submitted.."
            Response.Redirect("~/ComparisonList/" & FirstClickerService.Common.ConvertSpace2Dass(SubmitList.Heading) & "/" & SubmitList.ListID & "/")

        Else
            LabelEm.Text = SubmitList.My_Error_message
        End If


    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:validateuseraccess runat="server" id="ValidateUserAccess" />
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:navigationsidedashboard runat="server" id="NavigationSideDashboard" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card  mt-2 BoxEffect6 ">
                <div class="card-header clearfix">
                    <div class="float-right"></div>
                   <h5 class="card-title m-0 ">
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Dashboard/Compare/CreateList.aspx">Create Compare List</asp:HyperLink>
                    </h5>
                </div>
                   <div class="card-body">
                                       <div>
                        <div class="form-group">
                            <label for="TextBoxHeading">List Heding:</label>
                            <asp:TextBox ID="TextBoxListHeading" CssClass="form-control input-lg" runat="server"></asp:TextBox>
                        </div>

                        <asp:UpdatePanel ID="UpdatePanelListEntry" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <br />
                                <asp:Panel runat="server" ID="PanelEntry1" CssClass="form-group" Visible="true">
                                    <label for="TextBoxHeading">List Entry:</label>
                                    <asp:TextBox ID="TextBoxEntry1" runat="server" CssClass="form-control input-sm text-primary" placeholder="Write Your List Entry"></asp:TextBox>
                                </asp:Panel>
                                <asp:Panel runat="server" ID="PanelEntry2" CssClass="form-group" Visible="true">
                                    <asp:TextBox ID="TextBoxEntry2" runat="server" CssClass="form-control input-sm text-primary" placeholder="Write Your List Entry"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreEntry2" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="True" OnClick="ButtonAddMoreEntry2_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="PanelEntry3" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxEntry3" runat="server" CssClass="form-control input-sm text-primary" placeholder="Write Your List Entry"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreEntry3" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="false" OnClick="ButtonAddMoreEntry3_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="PanelEntry4" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxEntry4" runat="server" CssClass="form-control input-sm text-primary" placeholder="Write Your List Entry"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreEntry4" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="false" OnClick="ButtonAddMoreEntry4_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="PanelEntry5" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxEntry5" runat="server" CssClass="form-control input-sm text-primary" placeholder="Write Your List Entry"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreEntry5" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="false" OnClick="ButtonAddMoreEntry5_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="PanelEntry6" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxEntry6" runat="server" CssClass="form-control input-sm text-primary" placeholder="Write Your List Entry"></asp:TextBox>
                                </asp:Panel>
                                <br />


                                <asp:Panel runat="server" ID="panelCriteria1" CssClass="form-group" Visible="true">
                                    <label for="TextBoxHeading">Comparison Criteria:</label>
                                    <asp:TextBox ID="TextBoxCriteria1" runat="server" CssClass="form-control input-sm text-primary" placeholder="Criteria for Comparison"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreCriteria1" runat="server" CssClass="btn btn-sm btn-info float-right " Text="Add More" Visible="true" OnClick="ButtonAddMoreCriteria1_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="panelCriteria2" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxCriteria2" runat="server" CssClass="form-control input-sm text-primary" placeholder="Criteria for Comparison"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreCriteria2" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="false" OnClick="ButtonAddMoreCriteria2_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="panelCriteria3" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxCriteria3" runat="server" CssClass="form-control input-sm text-primary" placeholder="Criteria for Comparison"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreCriteria3" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="false" OnClick="ButtonAddMoreCriteria3_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="panelCriteria4" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxCriteria4" runat="server" CssClass="form-control input-sm text-primary" placeholder="Criteria for Comparison"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreCriteria4" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="false" OnClick="ButtonAddMoreCriteria4_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="panelCriteria5" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxCriteria5" runat="server" CssClass="form-control input-sm text-primary" placeholder="Criteria for Comparison"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreCriteria5" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="false" OnClick="ButtonAddMoreCriteria5_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="panelCriteria6" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxCriteria6" runat="server" CssClass="form-control input-sm text-primary" placeholder="Criteria for Comparison"></asp:TextBox>
                                </asp:Panel>
                                <br />


                                <asp:Panel runat="server" ID="panelTag1" CssClass="form-group" Visible="true">
                                    <label for="TextBoxTag1">Comparison Tag:</label>
                                    <asp:TextBox ID="TextBoxTag1" runat="server" CssClass="form-control input-sm text-primary" placeholder="Tag for Comparison"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreTag1" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="true" OnClick="ButtonAddMoreTag1_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="panelTag2" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxTag2" runat="server" CssClass="form-control input-sm text-primary" placeholder="Tag for Comparison"></asp:TextBox>
                                    <asp:Button ID="ButtonAddMoreTag2" runat="server" Text="Add More" CssClass="btn btn-sm btn-info float-right " Visible="false" OnClick="ButtonAddMoreTag2_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="panelTag3" CssClass="form-group" Visible="false">
                                    <asp:TextBox ID="TextBoxTag3" runat="server" CssClass="form-control input-sm text-primary" placeholder="Tag for Comparison"></asp:TextBox>
                                </asp:Panel>
                                <br />
                                <br />
                                <br />
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <div class="form-group">
                            <div class="float-left ">
                                <asp:Label ID="LabelEm" runat="server" Text="" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                            </div>
                            <div class="float-right ">
                                <asp:Button ID="Buttonpublish" runat="server" CssClass="btn btn-primary " Text="Publish List" OnClick="Buttonpublish_Click" />
                            </div>
                        </div>
                        <br />
                    </div>
                   </div> 
            </div>
        </div>
    </div>
</asp:Content>

