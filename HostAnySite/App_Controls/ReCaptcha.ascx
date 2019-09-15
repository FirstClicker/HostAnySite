<%@ Control Language="VB" ClassName="ReCaptcha" %>

<script runat="server">

    Public ReadOnly Property validCaptcha() As Boolean
        Get
            If WebAppSettings.ReCaptcha_IsEnabled = True Then
                Return hbehr.recaptcha.ReCaptcha.ValidateCaptcha(Request.Params("g-recaptcha-response"))
            Else
                Return True
            End If
        End Get
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        panelCaptchaholder.Visible = WebAppSettings.ReCaptcha_IsEnabled
    End Sub
</script>

<asp:Label ID="LabelvalidCaptcha" runat="server" Text="" Visible="False"></asp:Label>

<asp:Panel runat ="server" ID="panelCaptchaholder">
<%=hbehr.recaptcha.ReCaptcha.GetCaptcha() %>
</asp:Panel> 
  