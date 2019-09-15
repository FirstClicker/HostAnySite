<%@ Control Language="VB" ClassName="ForumTopicVisibleTo" %>
<%@ Import Namespace="firstclickerservice.version1" %>
<style type="text/css">

</style>

<script runat="server">



    Public m_visibleTo As ForumTopic.TopicVisibleToEnum
    Public Property VisibleTo() As ForumTopic.TopicVisibleToEnum
        Get
            Return [Enum].Parse(GetType(ForumTopic.TopicVisibleToEnum), DropDownListTopicVisibleTo.SelectedIndex.ToString, True)
        End Get
        Set(ByVal Value As ForumTopic.TopicVisibleToEnum)
            m_visibleTo = Value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            DropDownListTopicVisibleTo.DataSource = System.Enum.GetValues(GetType(ForumTopic.TopicVisibleToEnum))
            DropDownListTopicVisibleTo.DataBind()
            DropDownListTopicVisibleTo.SelectedIndex = CInt([Enum].Parse(GetType(ForumTopic.TopicVisibleToEnum), [Enum].GetName(GetType(ForumTopic.TopicVisibleToEnum), VisibleTo)))
        End If
    End Sub


</script>

<div class="form-group">
    <label>Visible To</label>
    <asp:DropDownList ID="DropDownListTopicVisibleTo" runat="server" AutoPostBack="True" CssClass="form-control" >
    </asp:DropDownList>
</div>



