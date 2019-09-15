<%@ Control Language="VB" ClassName="TagOfQuestion" %>

<script runat="server">
    Public Property QuestionId() As Long
        Get
            Return LabelQuestionId.Text
        End Get
        Set(ByVal value As Long)
            LabelQuestionId.Text = value
        End Set
    End Property

    Public Property QuestionUserId() As Long
        Get
            Return LabelQuestionUserID.Text
        End Get
        Set(ByVal value As Long)
            LabelQuestionUserID.Text = value
        End Set
    End Property


    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If Val(Trim(Session("UserId"))) = QuestionUserId And Val(Trim(Session("UserId"))) <> 0 Then
            DivAddTag.Visible = True
        End If

        If IsPostBack = False Then
            Dim listtags As List(Of FirstClickerService.Version1.TagOfQuestion.StructureTagOfQuestion) = FirstClickerService.Version1.TagOfQuestion.GetListOfTag(QuestionId, WebAppSettings.DBCS)
            For ii As Integer = 0 To listtags.Count - 1
                LabelTags.Text = LabelTags.Text & " <a href=""" & ResolveUrl("~/Question/" & FirstClickerService.Common.ConvertSpace2Dass(listtags(ii).TagDetails.TagName)) & "/""><span class=""badge badge-info"">" & listtags(ii).TagDetails.TagName & "</span></a>"
            Next
        End If
    End Sub



    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Buttonaddtag_Click(sender As Object, e As EventArgs)
        Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.CheckandAddTag(TextBoxTag.Text, WebAppSettings.dbcs)
        If tagdetails.Result = True Then
            Dim adtag As FirstClickerService.Version1.TagOfQuestion.StructureTagOfQuestion = FirstClickerService.Version1.TagOfQuestion.AddTagOfQuestion(tagdetails.TagId, QuestionId, Session("UserId"), WebAppSettings.DBCS)
            If adtag.Result = True Then
                LabelTags.Text = LabelTags.Text & " <a href=""" & ResolveUrl("~/Question/" & FirstClickerService.Common.ConvertSpace2Dass(tagdetails.TagName)) & "/""><span class=""badge badge-info"">" & tagdetails.TagName & "</span></a>"
            End If
        End If
    End Sub

</script>
<asp:Label ID="LabelQuestionId" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelQuestionUserID" runat="server" Text="0" Visible="False"></asp:Label>


<div class="card mb-2 mt-1 border-0">
    <div class="card-body p-1 clearfix">
        <i class="fa fa-tags"></i>&nbsp;Tags:&nbsp;&nbsp;<asp:Label ID="LabelTags" runat="server" Text=""></asp:Label>
        <div runat="server" id="DivAddTag" class="d-inline ml-3" visible ="false">
            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-plus-square"></i></a>
            <div class="dropdown-menu dropdown-menu-right">
                <div class="p-3">
                    <div class="form-group m-1">
                        <div class="input-group input-group-sm mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Tag</span>
                            </div>
                            <asp:TextBox ID="TextBoxTag" CssClass="form-control" runat="server"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button ID="Buttonaddtag" CssClass="btn btn-sm float-right" runat="server" Text="ADD" OnClick="Buttonaddtag_Click" />
                            </div>
                        </div>
                    </div>
               </div>
            </div>
        </div>
    </div>
</div>