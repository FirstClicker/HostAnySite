<%@ Control Language="VB" ClassName="ForumTopicVisibleTo" %>
<%@ Import Namespace="ClassHostAnySite" %>

<style type="text/css">

</style>

<script runat="server">
    Public Property enable() As Boolean
        Get
            Return DropDownListTopicVisibleTo.Enabled
        End Get
        Set(ByVal value As Boolean)
            DropDownListTopicVisibleTo.Enabled = value
        End Set
    End Property
    
     
    Public Property TopicID() As String
        Get
            Return LabelTopicID.Text
        End Get
        Set(ByVal value As String)
            LabelTopicID.Text = value
        End Set
    End Property
    
    Public m_visibleTo As ForumTopic.TopicVisibleToEnum
    Public Property VisibleTo() As ForumTopic.TopicVisibleToEnum
        Get
            Return m_visibleTo
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

    Protected Sub DropDownListTopicVisibleTo_SelectedIndexChanged(sender As Object, e As EventArgs)
        VisibleTo = [Enum].Parse(GetType(ForumTopic.TopicVisibleToEnum), DropDownListTopicVisibleTo.SelectedIndex.ToString, True)
        If Trim(TopicID) <> "" Then
            Dim statuschange As ForumTopic.StructureTopic = ForumTopic.SetVisibleTo_Topic(TopicID, Session("UserId"), VisibleTo, ClassAppDetails.DBCS)
            If statuschange.Result = True Then
         
            Else
         
            End If
        End If
    End Sub
</script>
  <asp:DropDownList ID="DropDownListTopicVisibleTo" runat="server" AutoPostBack="True" Width="100px" OnSelectedIndexChanged="DropDownListTopicVisibleTo_SelectedIndexChanged">
            </asp:DropDownList>
  <asp:Label ID="LabelTopicID" runat="server" Text=" " Visible="False"></asp:Label>
            <asp:Label ID="LabelEM" runat="server" Text=" " Visible="false"></asp:Label>

