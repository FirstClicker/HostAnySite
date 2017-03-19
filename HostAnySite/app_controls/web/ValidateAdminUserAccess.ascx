<%@ Control Language="VB" ClassName="ValidateAdminUserAccess" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As New ClassHostAnySite.User.UserType
        Try
            Cusertype = [Enum].Parse(GetType(ClassHostAnySite.User.UserType), Trim(Session("UserType")), True)
        Catch ex As Exception

        End Try

        If Cusertype = ClassHostAnySite.User.UserType.Administrator Or Cusertype = ClassHostAnySite.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

    End Sub
</script>
