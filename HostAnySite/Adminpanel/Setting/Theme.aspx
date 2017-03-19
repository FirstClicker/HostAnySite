<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Import Namespace ="System.Data.SqlClient" %>
<%@ Register Src="~/app_controls/web/NavigationSideAdmin.ascx" TagPrefix="uc1" TagName="NavigationSideAdmin" %>
<%@ Register Src="~/app_controls/web/ValidateAdminUserAccess.ascx" TagPrefix="uc1" TagName="ValidateAdminUserAccess" %>



<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

        If Me.IsPostBack = False Then
            loadThemeInfo()
        End If

    End Sub

    Private Function loadThemeInfo() As Boolean
        loadThemeInfo = False

        DropDownListTheme.Items.Clear()

        Dim listitm As New ListItem
        listitm.Text = "Select Theme"
        listitm.Value = 0

        DropDownListTheme.Items.Add(listitm)

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(ClassAppDetails.DBCS)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "select * from Table_Websetting where Type='Theme' and settingName<>'CurrentTheme'"
        myConn.Open()

        myReader = myCmd.ExecuteReader
        If myReader.HasRows = True Then
            Do While myReader.Read
                Dim listitm2 As New ListItem
                listitm2.Text = myReader.Item("SettingName")
                listitm2.Value = myReader.Item("SettingValue")

                DropDownListTheme.Items.Add(listitm2)
            Loop
        End If
        myReader.Close()
        myConn.Close()
    End Function


    Protected Sub ButtonSave_Click(sender As Object, e As EventArgs)
        If DropDownListTheme.SelectedIndex = 0 Then Exit Sub
        ClassHostAnySite.WebSetting.WebSetting_Update("CurrentTheme", DropDownListTheme.SelectedValue, ClassAppDetails.DBCS)

        ClassAppDetails.loadAppValiable()

        Response.Redirect(Request.Url.ToString)
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateAdminUserAccess runat="server" ID="ValidateAdminUserAccess" />
    <div class="row">
       <div class="col-md-3 col-sm-3">
            <uc1:NavigationSideAdmin runat="server" ID="NavigationSideAdmin" />
        </div>
        <div class="col-md-8 col-sm-8">
            <div class="panel panel-default">
                <div class="panel-heading">Change Theme</div>
                <div class="panel-body">
                    <div>
                        <div class="form-group">
                            <label for="email">Select Theme:</label>
                            <asp:DropDownList ID="DropDownListTheme" runat="server" CssClass ="form-control"></asp:DropDownList>
                        </div>
                        <asp:Button ID="ButtonSave" cssclass="btn btn-Info" runat="server" Text="Save" OnClick ="ButtonSave_Click" />

                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>

