<%@ Control Language="VB" ClassName="FaceBookPluginsComments" %>

<script runat="server">
    ' version 24/10/2018 




    Public m_LikeURL As String
    Public Property LikeURL() As String
        Get
            Return m_LikeURL
        End Get
        Set(ByVal Value As String)
            m_LikeURL = Value
        End Set
    End Property

    Public m_Gwidth As String
    Public Property Gwidth() As String
        Get
            Return m_Gwidth
        End Get
        Set(ByVal Value As String)
            m_Gwidth = Value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As System.EventArgs)
        If Trim(LikeURL) = "" Then
            LikeURL = Request.Url.GetLeftPart(UriPartial.Path)
        End If
    End Sub
</script>

<div class="card mt-2 mb-2 border-0">
    <div class="card-header">
        <h3 class="card-title">Facebook Commnet
        </h3>
    </div>

    <div class="fb-comments" data-href="<%=LikeURL %>" data-width="100%" data-numposts="5" data-colorscheme="light"></div>

</div>
