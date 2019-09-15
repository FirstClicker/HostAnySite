<%@ Control Language="VB" ClassName="TagHolderMax5" %>

<script runat="server">


    Public Property TagIds As String
        Get
            Dim Ids As String = ""
            If ListBoxTagCointainer.Items.Count > 0 Then
                For ii As Integer = 0 To ListBoxTagCointainer.Items.Count - 1
                    If Ids = "" Then
                        Ids = ListBoxTagCointainer.Items.Item(ii).Value
                    Else
                        Ids = Ids & ", " & ListBoxTagCointainer.Items.Item(ii).Value
                    End If
                Next
            Else
                Ids = 0
            End If
            Return Ids
        End Get

        Set(ByVal value As String)
            Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag
            Dim ids As String() = value.Split(",")

            For ii As Integer = 0 To ids.Length - 1
                tagdetails = FirstClickerService.Version1.Tag.CheckandAddTag(ids(ii), WebAppSettings.DBCS)
                If tagdetails.Result = True Then
                    Dim listitemtosave As New ListItem
                    listitemtosave.Text = tagdetails.TagName
                    listitemtosave.Value = tagdetails.TagId

                    ListBoxTagCointainer.Items.Add(listitemtosave)
                End If
            Next

        End Set
    End Property



    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If Val(Trim(Session("UserId"))) > 1111 Then
            DivAddTag.Visible = True
        End If

        If IsPostBack = False Then
            For ii As Integer = 0 To ListBoxTagCointainer.Items.Count - 1
                LabelTags.Text = LabelTags.Text & " <span class=""badge badge-info"">" & ListBoxTagCointainer.Items.Item(ii).Text & "</span>"
            Next
        End If
    End Sub



    Protected Sub Buttonaddtag_Click(sender As Object, e As EventArgs)
        Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.CheckandAddTag(TextBoxTag.Text, WebAppSettings.dbcs)
        If tagdetails.Result = True Then
            Dim listitemtosave As New ListItem
            listitemtosave.Text = tagdetails.TagName
            listitemtosave.Value = tagdetails.TagId

            ListBoxTagCointainer.Items.Add(listitemtosave)

            LabelTags.Text = LabelTags.Text & " <span class=""badge badge-info"">" & tagdetails.TagName & "</span>"
        End If
    End Sub

</script>


<asp:ListBox ID="ListBoxTagCointainer" runat="server" Visible="false"></asp:ListBox>
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
