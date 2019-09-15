<%@ Control Language="VB" ClassName="ForumVisibleTo" %>
<%@ Import Namespace="firstclickerservice.version1" %>

<style type="text/css">

</style>

<script runat="server">
    ' version 21/10/2018 # 20.27 

    Public Property ForumID() As Long
        Get
            Return LabelForumID.Text
        End Get
        Set(ByVal value As Long)
            LabelForumID.Text = value
        End Set
    End Property

    Public Property VisibleTo() As Forum.ForumVisibleToEnum
        Get
            If Trim(LabelVisibleto.Text) <> "" Then
                Return [Enum].Parse(GetType(Forum.ForumVisibleToEnum), LabelVisibleto.Text, True)

            Else
                Return Forum.ForumVisibleToEnum.Every_One
            End If
        End Get
        Set(ByVal Value As Forum.ForumVisibleToEnum)
            LabelVisibleto.Text = Value.ToString
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            DropDownListTopicVisibleTo.DataSource = System.Enum.GetValues(GetType(Forum.ForumVisibleToEnum))
            DropDownListTopicVisibleTo.DataBind()
            DropDownListTopicVisibleTo.Items.FindByValue(VisibleTo.ToString).Selected = True
        End If
    End Sub

    Protected Sub DropDownListTopicVisibleTo_SelectedIndexChanged(sender As Object, e As EventArgs)
        If ForumID = 0 Then
        Else
            FirstClickerService.Version1.Forum.Set_ForumVisibleTo(ForumID, Session("UserId"), [Enum].Parse(GetType(FirstClickerService.Version1.Forum.ForumVisibleToEnum), DropDownListTopicVisibleTo.SelectedItem.ToString, True), WebAppSettings.DBCS)
        End If
    End Sub
</script>
<asp:Label ID="LabelForumID" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelVisibleto" runat="server" Text="" Visible="false"></asp:Label>
<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" >Visible To</span>
  </div>
    <asp:DropDownList ID="DropDownListTopicVisibleTo" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="DropDownListTopicVisibleTo_SelectedIndexChanged" >
    </asp:DropDownList>
</div>



