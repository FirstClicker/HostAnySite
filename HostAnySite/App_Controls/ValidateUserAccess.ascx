<%@ Control Language="VB" ClassName="ValidateUserAccess" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Trim(Session("UserID")) = "" Then ' user not signed in
            Response.Redirect("~/user/signin.aspx?returnurl=" & "~" & Request.RawUrl)
        End If
    End Sub
</script>
