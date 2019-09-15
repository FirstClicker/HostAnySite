<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Register Src="~/app_controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        Dim CurrentThemesetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        CurrentThemesetting = FirstClickerService.Version1.WebSetting.WebSetting_Get(FirstClickerService.Version1.WebSetting.RequiredSettingName.WebSiteCurrentTheme.ToString, WebAppSettings.DBCS)
        If CurrentThemesetting.Result = True Then

            Dim myConn As SqlConnection
            Dim myCmd As SqlCommand
            Dim myReader As SqlDataReader

            myConn = New SqlConnection(WebAppSettings.DBCS)
            myCmd = myConn.CreateCommand
            myCmd.CommandText = "select * from Table_Websetting where Settingtype='" & FirstClickerService.Version1.WebSetting.SettingType.WebTheme.ToString & "' and settingvalue= '" & CurrentThemesetting.SettingValue & "'"
            myConn.Open()
            myReader = myCmd.ExecuteReader
            If myReader.HasRows = True Then
                myReader.Read()
                LabelCurrentTheme.Text = myReader.Item("SettingName")
            End If
            myReader.Close()
            myConn.Close()


        End If

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

        myConn = New SqlConnection(WebAppSettings.dbcs)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "select * from Table_Websetting where SettingType='" & FirstClickerService.Version1.WebSetting.SettingType.WebTheme.ToString & "' and settingName<>'" & FirstClickerService.Version1.WebSetting.RequiredSettingName.WebSiteCurrentTheme.ToString & "'"
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
        If DropDownListTheme.SelectedIndex = 0 Then
            Exit Sub
        End If

        Dim updatesetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        updatesetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(FirstClickerService.Version1.WebSetting.RequiredSettingName.WebSiteCurrentTheme.ToString, DropDownListTheme.SelectedValue, WebAppSettings.DBCS)
        If updatesetting.Result = True Then
            WebAppSettings.WebSiteCurrentTheme = updatesetting.SettingValue
        End If

        Response.Redirect(Request.Url.ToString)
    End Sub

    Protected Sub DropDownListTheme_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim MySetting As FirstClickerService.Version1.WebSetting.StructureWebSetting

        If DropDownListTheme.SelectedIndex = 0 Then
            Exit Sub
        End If

        MySetting = FirstClickerService.Version1.WebSetting.WebSetting_Get(DropDownListTheme.SelectedItem.ToString, WebAppSettings.DBCS)
        LabelThemePreview.Text = MySetting.SettingName

        If IO.File.Exists(Server.MapPath("~/content/image/theme/" & MySetting.SettingName.Trim & ".png")) = True Then
            ImagethemePreview.ImageUrl = "~/content/image/theme/" & MySetting.SettingName.Trim & ".png"
            ImagethemePreview.Visible = True
        End If

        Exit Sub
    End Sub

    Protected Sub ButtonBootsWatchReAdder_Click(sender As Object, e As EventArgs)

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "delete from Table_Websetting where SettingGroup='bootswatch' "
        myConn.Open()

        myReader = myCmd.ExecuteReader
        myReader.Close()
        myConn.Close()


        Dim listofTheme As New List(Of String)
        listofTheme = GetFilesFromDirectory(Server.MapPath("~/content/bootswatch/"))

        For i = 0 To listofTheme.Count - 1
            Dim MySetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
            MySetting = FirstClickerService.Version1.WebSetting.WebSetting_Add("bootswatchTheme_" & listofTheme.Item(i), "Content/bootswatch/" & listofTheme.Item(i) & "/bootstrap.min.css", " ", FirstClickerService.Version1.WebSetting.SettingType.WebTheme, "bootswatch", " ", WebAppSettings.DBCS)
        Next

        loadThemeInfo()
    End Sub

    Private Shared Function GetFilesFromDirectory(ByVal DirPath As String) As List(Of String )
        Dim result As New List(Of String)

        Dim Dir As IO.DirectoryInfo = New IO.DirectoryInfo(DirPath)
        Dim Directorylist As IO.DirectoryInfo() = Dir.GetDirectories()
        For Each FI As IO.DirectoryInfo In Directorylist
            result.Add(FI.Name)
        Next
        Return result
    End Function
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header">Theme Management - <asp:Label ID="LabelCurrentTheme" CssClass ="font-weight-bold " runat="server" Text=""></asp:Label>
                    <div class="float-right ">
                        <asp:Button ID="ButtonBootsWatchReAdder" CssClass ="btn btn-dark btn-sm " OnClick ="ButtonBootsWatchReAdder_Click" runat="server" Text="Add BootsWatch Theme" />
                    </div>
               </div>
                <div class="card-body">
                    <div class="form">
                         <div class="form-group">

                         </div> 

                        <div class="form-group">
                            <div class="input-group ">
                                <div class=" input-group-append "><span class="input-group-text ">Select Theme:</span></div>
                                <asp:DropDownList ID="DropDownListTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownListTheme_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                                <div class="input-group-prepend ">
                                    <asp:Button ID="ButtonSave" CssClass="btn btn-Info float-right " runat="server" Text="Save" OnClick="ButtonSave_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel card-success">
                        <div class="card-header">
                            Theme Preview :
                            <asp:Label ID="LabelThemePreview" runat="server" Text="Select a Theme"></asp:Label>
                        </div>
                        <div class="card-body ">
                            <asp:Image ID="ImagethemePreview" CssClass="img-fluid" runat="server" Visible="false" AlternateText ="Preview Not Available" />
                        </div>
                    </div>
                </div>
            </div>
           
        </div>
    </div>
</asp:Content>

