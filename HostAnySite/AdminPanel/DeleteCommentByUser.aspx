<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>
<%@ Import Namespace ="System.Data.SqlClient" %>


<script runat="server">
    ' version 24/06/2019 # 4.27 AM

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs)

        Dim userdetails As New FirstClickerService.Version1.User.StructureUser

        userdetails = FirstClickerService.Version1.User.UserDetail_RoutUserName(TextBoxusername.Text, WebAppSettings.DBCS)
        If userdetails.Result = False Then
            LabelEM.Text = "user not found"
            Exit Sub
        End If

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "delete FROM Table_UserWall where userid='" & Trim(userdetails.UserID) & "'"

        myConn.Open()
        myReader = myCmd.ExecuteReader

        LabelEM.Text = "deleted Wall : " & myReader.RecordsAffected & " </br>"

        myReader.Close()

        myCmd.CommandText = "delete FROM Table_UserWallComment where userid='" & Trim(userdetails.UserID) & "'"
        myReader = myCmd.ExecuteReader

        LabelEM.Text = LabelEM.Text & "deleted Wall comment: " & myReader.RecordsAffected & " </br>"


        myReader.Close()
        myConn.Close()
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-md-3">
        </div>
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header">
                   Delete Comments
                </div>
                <div class="card-body">
                    <asp:TextBox ID="TextBoxusername" runat="server"></asp:TextBox>
                    <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
                    <asp:Label ID="LabelEM" runat="server" Text="msg"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

