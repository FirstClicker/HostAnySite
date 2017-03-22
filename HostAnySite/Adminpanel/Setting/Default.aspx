<%@ Page Language="VB" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Implements Interface="ClassHostAnySite.RoutSiteHomeInterface" %>
<!DOCTYPE html>

<script runat="server">


    Protected Sub Page_Load(sender As Object, e As EventArgs)

        If IsPostBack = False Then
            If IO.File.Exists(Server.MapPath("~/install/install.txt")) = True Then
                PanelPreInstall.Visible = True
            Else
                PanelPreInstall.Visible = False
                PanelServerInfo.Visible = True
            End If
        End If

        ' content page load event fire before master page load event
        Page.Title = "Install HostAnySite Application"

    End Sub

    Protected Sub ButtonRestartInstallation_Click(sender As Object, e As EventArgs)
        If IO.File.Exists(Server.MapPath("~/install/install.txt")) = False Then
            System.Web.HttpRuntime.UnloadAppDomain()
            Response.Redirect(Page.Request.Url.ToString)
        Else
            Response.Redirect(Page.Request.Url.ToString)
        End If
    End Sub

    Protected Sub ButtonNextServerInfo_Click(sender As Object, e As EventArgs)
        Dim CSservercheck As String = "Server=" & TextBoxServerPath.Text & ";Uid=" & TextBoxAdminUser.Text & ";Password=" & TextBoxAdminPass.Text

        LabelServerInfoEm.Text = ""

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand

        myConn = New SqlConnection(CSservercheck)
        myCmd = myConn.CreateCommand

        Try
            myConn.Open()
        Catch ex As Exception
            LabelServerInfoEm.Text = ex.Message
            Exit Sub
        End Try

        If myConn.State = Data.ConnectionState.Open Then
            LabelServerInfoEm.Text = "Server connected."
        Else
            LabelServerInfoEm.Text = "Failed to make server connection."
            Exit Sub
        End If

        myConn.Close()

        PanelServerInfo.Enabled = False
        PanelServerInfo.Visible = False

        PanelDBinfo.Enabled = True
        PanelDBinfo.Visible = True
    End Sub



    Protected Sub DropDownListDBinstallType_SelectedIndexChanged(sender As Object, e As EventArgs)

        LabelDBInfoEm.Text = ""

        If DropDownListDBinstallType.SelectedIndex = 0 Then  ' create
            DropDownListDBList.Visible = False
            TextBoxDBname.Visible = True
        Else ' edit
            TextBoxDBname.Visible = False
            DropDownListDBList.Visible = True
            DropDownListDBList.Items.Clear()


            Dim CSservercheck As String = "Server=" & TextBoxServerPath.Text & ";Uid=" & TextBoxAdminUser.Text & ";Password=" & TextBoxAdminPass.Text

            Dim myConn As SqlConnection
            Dim myCmd As SqlCommand
            Dim myReader As SqlDataReader

            myConn = New SqlConnection(CSservercheck)
            myCmd = myConn.CreateCommand

            myCmd.CommandText = "select * from sys.databases"
            Try
                myConn.Open()
                myReader = myCmd.ExecuteReader
            Catch ex As Exception
                LabelDBInfoEm.Text = "Restart the installation by refreshing the page because of following error - " & ex.Message
                Exit Sub
            End Try

            If myReader.HasRows = True Then
                Do While myReader.Read
                    DropDownListDBList.Items.Add(myReader.Item("Name"))
                Loop
            End If

            myReader.Close()
            myConn.Close()
        End If
    End Sub

    Protected Sub DropDownListDBList_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim CSservercheck As String = "Server=" & TextBoxServerPath.Text & ";Database=" & DropDownListDBList.SelectedItem.Text & ";Uid=" & TextBoxAdminUser.Text & ";Password=" & TextBoxAdminPass.Text

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(CSservercheck)
        myCmd = myConn.CreateCommand

        myCmd.CommandText = "select * from table_websettings where setting='db_version'"

        Try
            myConn.Open()
            myReader = myCmd.ExecuteReader
        Catch ex As Exception
            LabelServerInfoEm.Text = ex.Message
            Exit Sub
        End Try

        If myReader.HasRows = False Then
            LabelServerInfoEm.Text = "Are you sure this is old HostAnySite installed database? Installation failed to get database version. It may be because some table od data structure is changed since last installation. Installation may be failed. We advice not to upgrade the database."

            myReader.Close()
            myConn.Close()

            Exit Sub
        Else
            myReader.Read()
            LabelDBinfoDBversion.Text = myReader.Item("value")
        End If

        myReader.Close()
        myConn.Close()

        LabelDBInfoEm.Text = "'" & DropDownListDBList.SelectedItem.Text & "' Will be modified and you can't go back to previous step. Please backup the database before modifing it."
    End Sub

    Protected Sub ButtonNextDBinfo_Click(sender As Object, e As EventArgs)
        Dim CSservercheck As String = "Server=" & TextBoxServerPath.Text & ";Uid=" & TextBoxAdminUser.Text & ";Password=" & TextBoxAdminPass.Text

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(CSservercheck)
        myCmd = myConn.CreateCommand

        If DropDownListDBinstallType.SelectedIndex = 0 Then  ' create

            If Trim(TextBoxDBname.Text) = "" Then
                LabelDBInfoEm.Text = "Provide a Database name."
                Exit Sub
            End If

            myCmd.CommandText = "select * from sys.databases where name='" & TextBoxDBname.Text & " '"

            Try
                myConn.Open()
                myReader = myCmd.ExecuteReader
            Catch ex As Exception
                LabelDBInfoEm.Text = ex.Message
                Exit Sub
            End Try

            If myReader.HasRows = True Then
                LabelDBInfoEm.Text = "Database with same name exist. Please select another name."

                myReader.Close()
                myConn.Close()

                Exit Sub
            End If

            myReader.Close()
            myConn.Close()

        Else ' edit
            ' nothing to do
        End If

        PanelDBinfo.Enabled = False
        PanelDBinfo.Visible = False

        PanelDBuserInfo.Enabled = True
        PanelDBuserInfo.Visible = True

    End Sub

    Protected Sub ButtonPreviousDBinfo_Click(sender As Object, e As EventArgs)
        PanelDBinfo.Enabled = False
        PanelDBinfo.Visible = False

        PanelServerInfo.Enabled = True
        PanelServerInfo.Visible = True
    End Sub


    Protected Sub DropDownListDBUser_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub

    Protected Sub ButtonNextDBUserInfo_Click(sender As Object, e As EventArgs)
        If DropDownListDBUser.SelectedIndex = 0 Then ' create
            If Trim(TextBoxDBUserName.Text) = "" Or Trim(TextBoxDbUserPassword.Text) = "" Then
                LabelDBUserInfoEm.Text = "Provide a username and passord."
                Exit Sub
            End If


            Dim CSservercheck As String = "Server=" & TextBoxServerPath.Text & ";Uid=" & TextBoxAdminUser.Text & ";Password=" & TextBoxAdminPass.Text

            Dim myConn As SqlConnection
            Dim myCmd As SqlCommand
            Dim myReader As SqlDataReader

            myConn = New SqlConnection(CSservercheck)
            myCmd = myConn.CreateCommand

            myCmd.CommandText = "Select name FROM master.sys.server_principals WHERE name = '" & TextBoxDBUserName.Text.Trim & "'"
            Try
                myConn.Open()
                myReader = myCmd.ExecuteReader
            Catch ex As Exception
                LabelDBUserInfoEm.Text = "Restart the installation by refreshing the page because of following error - " & ex.Message
                Exit Sub
            End Try

            If myReader.HasRows = True Then
                LabelDBUserInfoEm.Text = "Username Already exist "

                myReader.Close()
                myConn.Close()
                Exit Sub
            End If

            myReader.Close()
            myConn.Close()


            PanelDBuserInfo.Enabled = False
            PanelDBuserInfo.Visible = False

            PanelCreateWebAdminUser.Enabled = True
            PanelCreateWebAdminUser.Visible = True

        Else ' use old


        End If

    End Sub

    Protected Sub ButtonPreviousDBUserInfo_Click(sender As Object, e As EventArgs)
        PanelDBuserInfo.Enabled = False
        PanelDBuserInfo.Visible = False

        PanelDBinfo.Enabled = True
        PanelDBinfo.Visible = True
    End Sub



    Protected Sub ButtonPreviousWebUserInfo_Click(sender As Object, e As EventArgs)
        PanelDBuserInfo.Enabled = True
        PanelDBuserInfo.Visible = True

        PanelCreateWebAdminUser.Enabled = False
        PanelCreateWebAdminUser.Visible = False
    End Sub

    Protected Sub ButtonNextWebUserInfo_Click(sender As Object, e As EventArgs)
        If Trim(TextBoxWEBUser.Text) = "" Or Len(Trim(TextBoxWEBUser.Text)) > 20 Then
            LabelWebUserEM.Text = "Please provide a not more than 20 lenth username."
            Exit Sub
        End If
        If Len(Trim(TextBoxWEBUser.Text)) < 8 Then
            LabelWebUserEM.Text = "Please provide a not more than 8 lenth username."
            Exit Sub
        End If

        If Trim(TextBoxWEBuserPass.Text) = "" Or Len(Trim(TextBoxWEBuserPass.Text)) > 20 Then
            LabelWebUserEM.Text = "Please provide a not more than 20 lenth Password."
            Exit Sub
        End If
        If Trim(TextBoxWEBuserEmail.Text) = "" Then
            LabelWebUserEM.Text = "Please provide a valid email."
            Exit Sub
        End If


        PanelCreateWebAdminUser.Enabled = False
        PanelCreateWebAdminUser.Visible = False

        PanelExecuteSql.Enabled = True
        PanelExecuteSql.Visible = True
    End Sub



    Protected Sub ButtonExecute_Click(sender As Object, e As EventArgs)
        Dim CSservercheck As String = "Server=" & TextBoxServerPath.Text & ";Uid=" & TextBoxAdminUser.Text & ";Password=" & TextBoxAdminPass.Text

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand

        myConn = New SqlConnection(CSservercheck)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "CREATE Database " & TextBoxDBname.Text

        Try
            myConn.Open()
            myCmd.ExecuteNonQuery()
        Catch ex As Exception
            ListBoxExecuteResult.Items.Add(ex.Message)
            LabelExecuteSql.Text = "An error occurred while creating database. So installation stopped. Please check if database created, then delete it and try again. If the error continue, please contact developer for more help."
            Exit Sub
        End Try
        myConn.Close()

        ListBoxExecuteResult.Items.Add("Database created successfully")


        ' creating username
        Dim tempstring As String = My.Computer.FileSystem.ReadAllText(Server.MapPath("~/install/dbscript/CreateDBUser.sql"))
        tempstring = tempstring.Replace("DatabaseUserName", TextBoxDBUserName.Text) ' replace dosenot ignore case.. need to be carefull
        tempstring = tempstring.Replace("DatabaseUserpassword", TextBoxDbUserPassword.Text) ' replace dosenot ignore case.. need to be carefull
        tempstring = tempstring.Replace("DatabaseName", TextBoxDBname.Text) ' replace dosenot ignore case.. need to be carefull


        Dim mySqlConnection0 As New SqlConnection(CSservercheck)
        mySqlConnection0.Open()

        Using mySqlConnection0
            ' Assume that you are tring execute a file "SqlScript.sql"
            Dim dbScript0 As String = tempstring
            ' Split at the GO; statements in our current script.
            Dim sqlCommands0 As String() = dbScript0.Split(New String() {"GO"}, StringSplitOptions.None)

            For Each sqlCommand As String In sqlCommands0
                Dim dbCommand As New SqlCommand(sqlCommand, mySqlConnection0)

                Try
                    dbCommand.ExecuteNonQuery()
                Catch ex As Exception
                    ListBoxExecuteResult.Items.Add(ex.Message & " - " & sqlCommand)
                End Try
            Next
            ListBoxExecuteResult.Items.Add("Database User created.")
        End Using




        ' creating table
        tempstring = ""
        tempstring = My.Computer.FileSystem.ReadAllText(Server.MapPath("~/install/dbscript/createdatabase.sql"))
        tempstring = tempstring.Replace("DatabaseName", TextBoxDBname.Text) ' replace dosenot ignore case.. need to be carefull


        Dim mySqlConnection As New SqlConnection(CSservercheck)
        mySqlConnection.Open()


        Using mySqlConnection
            ' Assume that you are tring execute a file "SqlScript.sql"
            Dim dbScript As String = tempstring
            ' Split at the GO; statements in our current script.
            Dim sqlCommands As String() = dbScript.Split(New String() {"GO"}, StringSplitOptions.None)

            For Each sqlCommand As String In sqlCommands
                Dim dbCommand As New SqlCommand(sqlCommand, mySqlConnection)

                Try
                    dbCommand.ExecuteNonQuery()
                Catch ex As Exception
                    ListBoxExecuteResult.Items.Add(ex.Message & " - " & sqlCommand)
                End Try
            Next
        End Using


        ListBoxExecuteResult.Items.Add("Tabele and table data creation completed.")



        Dim CSDBcheck As String = "Server=" & TextBoxServerPath.Text & ";Database=" & TextBoxDBname.Text & ";Uid=" & TextBoxDBUserName.Text & ";Password=" & TextBoxDbUserPassword.Text
        My.Computer.FileSystem.WriteAllText(Server.MapPath("~/install/install.txt"), CSDBcheck, False)

        ListBoxExecuteResult.Items.Add("Connecting string saved in settings.")

        Try
            'Dim myConfiguration As Configuration = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~")
            'myConfiguration.ConnectionStrings.ConnectionStrings("HasForumConnectionString").ConnectionString = CSDBcheck
            'myConfiguration.Save()

            tempstring = ""
            tempstring = My.Computer.FileSystem.ReadAllText(Server.MapPath("~/web.config"))
            tempstring = tempstring.Replace("AppConnectionStringValue", CSDBcheck) ' replace dosenot ignore case.. need to be carefull
            My.Computer.FileSystem.WriteAllText(Server.MapPath("~/web.config"), tempstring, False)

        Catch ex As Exception
            ListBoxExecuteResult.Items.Add("Failed to save connecting string in 'Web.Config' : " & ex.Message)
        End Try


        Dim createuser As ClassHostAnySite.User.StructureUser
        createuser = ClassHostAnySite.User.Create_User(TextBoxWEBUser.Text, TextBoxWEBuserPass.Text, ClassHostAnySite.User.UserType.Administrator, TextBoxWEBuserEmail.Text, CSDBcheck)

        If createuser.Result = True Then
            Session("UserName") = createuser.UserName
            Session("RoutUserName") = createuser.RoutUserName
            Session("UserID") = createuser.UserID
            Session("UserType") = createuser.UserType.ToString

            ListBoxExecuteResult.Items.Add("Application Admin user created.")
        Else
            ListBoxExecuteResult.Items.Add("failed to create web admin user. " & createuser.My_Error_message)
        End If

        ButtonExecute.Enabled = False
        ButtonExecute.Visible = False

        ListBoxExecuteResult.Visible = True

        ButtonStartApplication.Visible = True

    End Sub

    Protected Sub ListBoxExecuteResult_SelectedIndexChanged(sender As Object, e As EventArgs)
        LabelExecuteSql.Text = ListBoxExecuteResult.SelectedItem.Text
    End Sub

    Protected Sub ButtonStartApplication_Click(sender As Object, e As EventArgs)
        System.Web.HttpRuntime.UnloadAppDomain()
        Response.Redirect("~/install/Quicksetup.aspx")
    End Sub



</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-theme.min.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="../Content/custom.css" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src='<%= ResolveUrl("~/Scripts/jquery-3.1.1.min")%>'></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src='<%= ResolveUrl("~/Scripts/bootstrap.min.js")%>'></script>
    <script src='<%= ResolveUrl("~/Scripts/custom.js")%>'></script>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <nav class="navbar navbar-default navbar-static-top">
            <div class="container">
                <div class="navbar-header">
                    <div class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </div>
                    <asp:HyperLink ID="HyperLinkHome" runat="server" CssClass="navbar-brand" NavigateUrl="~/">HostAnySite Installation</asp:HyperLink>
                </div>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <asp:Panel runat="server" ID="PanelPreInstall" Visible="False" CssClass="panel panel-default ">
                    <div class="panel-heading clearfix  ">
                        <div class="pull-left ">HostAnySite - Installation</div>
                        <div class="pull-right ">
                            <asp:Button ID="ButtonRestartInstallation" runat="server" OnClick="ButtonRestartInstallation_Click" Text="Restart Installation" />
                        </div>
                    </div>
                  

                    <div class="panel-body ">
                        <table style="width: 100%;" class="TableBox ">
                            <tr>
                                <td style="padding: 10px; vertical-align: top; height: 300px;">

                                    <h3>If you are here to install/reinstall HostAnySite application do the following.</h3>
                                    <ul>
                                        <li>Delete the file &quot;~/install/install.txt&quot; </li>
                                        <li>Click the &quot;Restart Installation&quot; button on upper-right corner.
                                        </li>
                                    </ul>
                                    <h3>If you are seeing this page unexpectedly do the following.</h3>
                                    <ul>
                                        <li>Check If database connection is okey.</li>
                                        <li>Restart the website manually.</li>
                                        <li>If still the problem exist, take help of developer. </li>
                                    </ul>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="panel-footer "></div>
                </asp:Panel>

                <asp:Panel runat="server" ID="PanelServerInfo" Visible="False" CssClass="row ">

                    <div class="col-lg-8 ">
                        <div class="panel panel-default ">
                            <div class="panel-heading ">HostAnySite Installation - Step I - Ms-SQL Server Info</div>
                            <div class="panel-body ">
                              
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label for="TextBoxServerPath" class="control-label col-xs-3">Server Path</label>
                                            <div class="col-xs-9">
                                                <asp:TextBox ID="TextBoxServerPath" runat="server" CssClass="form-control "></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="TextBoxAdminUser" class="control-label col-xs-3">Admin User</label>
                                            <div class="col-xs-9">
                                                <asp:TextBox ID="TextBoxAdminUser" runat="server" CssClass="form-control ">SA</asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="TextBoxAdminPass" class="control-label col-xs-3">SAdmin Password</label>
                                            <div class="col-xs-9">
                                                <asp:TextBox ID="TextBoxAdminPass" runat="server" CssClass="form-control " Text="" />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-offset-3 col-xs-9">
                                                <asp:Label ID="LabelServerInfoEm" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                               
                            </div>
                            <div class="panel-footer clearfix">
                                <div class="pull-right">
                                    <asp:Button ID="ButtonNextServerInfo" runat="server" Text="Next" Width="100px" OnClick="ButtonNextServerInfo_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                        <div class="col-lg-4 ">
                              <div class="panel panel-default ">
                                <div class="panel-heading">Installation Help</div>
                                <div class="panel-body">
                                    Note 1: Your Sql Server admin user and password required to create datebase.<br />
                                    Note 2: Installation process will need write/execute permission on web server...
                                </div>
                            </div>
                        </div>
                </asp:Panel>

                <asp:Panel ID="PanelDBinfo" runat="server" Enabled="False" Visible="False" CssClass="row">
                    <div class="col-lg-8 ">
                        <div class="panel panel-default ">
                            <div class="panel-heading ">HostAnySite Installation - Step II - Sql Database Info</div>
                            <div class="panel-body ">

                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <label for="DropDownListDBinstallType" class="control-label col-xs-3">Installation Type</label>
                                        <div class="col-xs-9">
                                            <asp:DropDownList ID="DropDownListDBinstallType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownListDBinstallType_SelectedIndexChanged" CssClass="form-control " Enabled="False">
                                                <asp:ListItem Value="Create">Create DataBase</asp:ListItem>
                                                <asp:ListItem Value="Update">Update Database</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="TextBoxDBname" class="control-label col-xs-3">DataBase Name</label>
                                        <div class="col-xs-9">
                                            <asp:TextBox ID="TextBoxDBname" runat="server" CssClass="form-control "></asp:TextBox>
                                            <asp:DropDownList ID="DropDownListDBList" runat="server" AutoPostBack="True" Visible="False" CssClass="form-control " OnSelectedIndexChanged="DropDownListDBList_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:Label ID="LabelDBinfoDBversion" runat="server" CssClass="form-control " Text="0" Visible="False"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-offset-3 col-xs-9">
                                            <asp:Label ID="LabelDBInfoEm" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer clearfix">
                                <div class="pull-right ">
                                    <asp:Button ID="ButtonPreviousDBinfo" runat="server" OnClick="ButtonPreviousDBinfo_Click" Text="Previous" Width="100px" />
                                    <asp:Button ID="ButtonNextDBinfo" runat="server" OnClick="ButtonNextDBinfo_Click" Text="Next" Width="100px" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 ">
                        <div class="panel panel-default ">
                            <div class="panel-heading">Installation Help</div>
                            <div class="panel-body">
                                Provide the MS SQL database name.
                            </div>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="PanelDBuserInfo" runat="server" Visible="False" CssClass="row">
                    <div class="col-lg-8 ">
                        <div class="panel panel-default ">
                            <div class="panel-heading ">HostAnySite Installation - Step III - Sql Database User Info</div>
                            <div class="panel-body ">

                                <div class="form-horizontal">
                                    <div class="form-group">
                                        <label for="DropDownListDBUser" class="control-label col-xs-3">New/Old User</label>
                                        <div class="col-xs-9">
                                            <asp:DropDownList ID="DropDownListDBUser" runat="server" CssClass="form-control " AutoPostBack="True" OnSelectedIndexChanged="DropDownListDBUser_SelectedIndexChanged" Enabled="False">
                                                <asp:ListItem Value="Create DataBase User">Create DataBase User</asp:ListItem>
                                                <asp:ListItem Value="Use Existing Database User">Use Existing Database User</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="TextBoxDBUserName" class="control-label col-xs-3">Database UserName</label>
                                        <div class="col-xs-9">
                                            <asp:TextBox ID="TextBoxDBUserName" runat="server" CssClass="form-control "></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="TextBoxDbUserPassword" class="control-label col-xs-3">Database Password</label>
                                        <div class="col-xs-9">
                                            <asp:TextBox ID="TextBoxDbUserPassword" runat="server" CssClass="form-control "></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-offset-3 col-xs-9">
                                            <asp:Label ID="LabelDBUserInfoEm" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="panel-footer clearfix">
                                <div class="pull-right ">
                                    <asp:Button ID="ButtonPreviousDBUserInfo" runat="server" OnClick="ButtonPreviousDBUserInfo_Click" Text="Previous" Width="100px" />
                                    <asp:Button ID="ButtonNextDBUserInfo" runat="server" OnClick="ButtonNextDBUserInfo_Click" Text="Next" Width="100px" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-default ">
                            <div class="panel-heading">Installation Help</div>
                            <div class="panel-body">
                                Note: This &#39;username&#39; and &#39;password&#39; will be maped with database and will be used to login and connecting string in web.config.
                            </div>
                        </div>
                    </div>
                </asp:Panel>



                <asp:Panel ID="PanelCreateWebAdminUser" runat="server" Visible="False" CssClass="row">
                    <div class="col-lg-8 ">
                        <div class="panel panel-default ">
                            <div class="panel-heading ">HostAnySite Installation - Step IV - Create website Admin User</div>
                            <div class="panel-body ">
                                <div class="col-lg-8">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label for="TextBoxWEBUser" class="control-label col-xs-3">User Name</label>
                                            <div class="col-xs-9">
                                                <asp:TextBox ID="TextBoxWEBUser" runat="server" CssClass="form-control "></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="TextBoxWEBuserPass" class="control-label col-xs-3">Password</label>
                                            <div class="col-xs-9">
                                                <asp:TextBox ID="TextBoxWEBuserPass" runat="server" CssClass="form-control "></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="TextBoxWEBuserEmail" class="control-label col-xs-3">Email</label>
                                            <div class="col-xs-9">
                                                <asp:TextBox ID="TextBoxWEBuserEmail" runat="server" CssClass="form-control "></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-xs-offset-3 col-xs-9">
                                                <asp:Label ID="LabelWebUserEM" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer clearfix">
                                <div class="pull-right ">
                                    <asp:Button ID="ButtonPreviousWebUserInfo" runat="server" Text="Previous" Width="100px" OnClick="ButtonPreviousWebUserInfo_Click" />
                                    <asp:Button ID="ButtonNextWebUserInfo" runat="server" Text="Next" Width="100px" OnClick="ButtonNextWebUserInfo_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-default ">
                            <div class="panel-heading">Installation Help</div>
                            <div class="panel-body">
                                Note 1: Donot use special character in username.<br />
                                Note 2: Use a good working email addresh.<br />
                                Note 3: Donot use following names (Riya Sen, Bidyut Das, Raju Das, My Admin) as they will created by default.
                            </div>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="PanelExecuteSql" runat="server" Visible="False" CssClass="row">
                    <div class="col-lg-8 ">
                        <div class="panel panel-default ">
                            <div class="panel-heading ">HostAnySite Installation - Step V - Execute Installation</div>
                            <div class="panel-body ">
                                <div class="form-horizontal">
                                    <div class="form-group text-center">
                                        <asp:Button ID="ButtonExecute" runat="server" CssClass ="btn btn-info " OnClick="ButtonExecute_Click" Text="Execute To Finish Installation" />
                                    </div>
                                    <div class="form-group text-center">
                                        <asp:Label ID="LabelExecuteSql" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="form-group text-center">
                                        <asp:ListBox ID="ListBoxExecuteResult" runat="server" CssClass="form-control " OnSelectedIndexChanged="ListBoxExecuteResult_SelectedIndexChanged" AutoPostBack="True" Visible ="false" ></asp:ListBox>

                                    </div>
                                    <div class="form-group text-center">
                                        <asp:Button ID="ButtonStartApplication" CssClass ="btn btn-primary " runat="server" OnClick="ButtonStartApplication_Click" Text="Start Application" Visible="False" />
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-default ">
                            <div class="panel-heading">Installation Help</div>
                            <div class="panel-body">
                                This is final Step of installation where database and setting will be created.<br />
                                <strong>This step may take few minute to complete.</strong>
                            </div>
                        </div>
                    </div>


                </asp:Panel>
            </div>
        </div>
        <footer class="footer">
            <div class="container">
                <p class="text-muted">
                    <asp:Label ID="LabelCopyRight" runat="server" Text="Copyright @ HostAnySite.Com"></asp:Label>
                </p>
            </div>
        </footer>
    </form>

</body>
</html>
