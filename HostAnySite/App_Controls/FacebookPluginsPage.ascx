<%@ Control Language="VB" ClassName="FacebookPluginsPage" EnableViewState="false" %>


<script runat="server">
    ' version 24/10/2018 

    Public Property FBPageURL() As String
        Get
            Return LabelFBPageURL.Text
        End Get
        Set(ByVal value As String)
            LabelFBPageURL.Text = value
        End Set
    End Property

    Public Property FBPageName() As String
        Get
            Return LabelFBPageName.Text
        End Get
        Set(ByVal value As String)
            LabelFBPageName.Text = value
        End Set
    End Property
</script>

<asp:Label ID="LabelFBPageURL" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelFBPageName" runat="server" Text="" Visible="false"></asp:Label>


<div class="fb-page" data-href="<%=FBPageURL %>"  data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true"><blockquote cite="<%=FBPageURL %>" class="fb-xfbml-parse-ignore"><a href="<%=FBPageURL %>"><%=FBPageName %></a></blockquote></div>
