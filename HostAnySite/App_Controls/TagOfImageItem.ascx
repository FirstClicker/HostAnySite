<%@ Control Language="VB" ClassName="TagOfImageItem" %>

<script runat="server">
    ' version 25/08/2018 # 4.27 AM

    Public Property ImageId() As Long
        Get
            Return LabelIMAGEID.Text
        End Get
        Set(ByVal value As Long)
            LabelIMAGEID.Text = value
        End Set
    End Property


    Public Property ImageUserId() As Long
        Get
            Return LabelImageUserID.Text
        End Get
        Set(ByVal value As Long)
            LabelImageUserID.Text = value
        End Set
    End Property

    Public Property TagId() As Long
        Get
            Return LabelTagId.Text
        End Get
        Set(ByVal value As Long)
            LabelTagId.Text = value
        End Set
    End Property


    Public Property TagName() As String
        Get
            Return HyperLinkTagName.Text
        End Get
        Set(ByVal value As String)
            HyperLinkTagName.Text = value
            HyperLinkTagName.NavigateUrl = "~/image/" & FirstClickerService.Common.ConvertSpace2Dass(TagName) & "/"
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Val(Trim(Session("UserId"))) = ImageUserId And Val(Trim(Session("UserId"))) > 100 Then
            PanleAction.Visible = True
        End If

        Dim Cusertype As New FirstClickerService.Version1.User.UserType
        Try
            Cusertype = [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Trim(Session("UserType")), True)
            If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
                PanleAction.Visible = True
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub LinkButtonRemoveTag_Click(sender As Object, e As EventArgs)
        Dim removeresult As FirstClickerService.Common.StructureResult = FirstClickerService.Version1.TagOfimage.RemoveTagOfimage(TagId, ImageId, WebAppSettings.DBCS)
        If removeresult.Result = True Then
            Me.Visible = False
        Else
            HyperLinkTagName.Text = "failed"
        End If
    End Sub

    Protected Sub LinkButtonSuspendTag_Click(sender As Object, e As EventArgs)
        Dim SuspandeResult As FirstClickerService.Common.StructureResult = FirstClickerService.Version1.TagOfimage.Update_ImagetagStatus(TagId, ImageId, FirstClickerService.Version1.TagOfimage.ImageTagStatus.Suspended, WebAppSettings.DBCS)
        If SuspandeResult.Result = True Then
            Me.Visible = False
        Else
            HyperLinkTagName.Text = "failed"
        End If
    End Sub

    Protected Sub LinkButtonMakePrimary_Click(sender As Object, e As EventArgs)
        Dim MakePrimaryResult As FirstClickerService.Common.StructureResult = FirstClickerService.Version1.TagOfimage.Update_ImageTagPrimary(TagId, ImageId, WebAppSettings.DBCS)
        If MakePrimaryResult.Result = True Then
            HyperLinkTagName.CssClass = "text-white font-weight-bold"
        Else
            HyperLinkTagName.Text = "failed"
        End If
    End Sub
</script>


<asp:Label ID="LabelIMAGEID" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelTagId" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelImageUserID" runat="server" Text="0" Visible="False"></asp:Label>


<div class="btn-group btn-group-sm m-1">
    <button class="btn btn-info btn-sm">
        <asp:HyperLink ID="HyperLinkTagName" CssClass="text-white" runat="server"></asp:HyperLink>
    </button>
    <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    </button>
    <asp:Panel runat="server" ID="PanleAction" CssClass="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton" Visible="false">
        <asp:LinkButton ID="LinkButtonRemoveTag" CssClass="dropdown-item" runat="server" OnClientClick ="return confirm('You can not recover it back!! Are you sure you want to delete? ');" OnClick="LinkButtonRemoveTag_Click">Remove</asp:LinkButton>
         <asp:LinkButton ID="LinkButtonSuspendTag" CssClass="dropdown-item" runat="server"  OnClick="LinkButtonSuspendTag_Click">Suspend</asp:LinkButton>
         <asp:LinkButton ID="LinkButtonMakePrimary" CssClass="dropdown-item" runat="server"  OnClick="LinkButtonMakePrimary_Click">Make Primary</asp:LinkButton>
    </asp:Panel>
</div>