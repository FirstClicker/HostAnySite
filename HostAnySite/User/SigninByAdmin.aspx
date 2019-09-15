<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Import Namespace ="System.Data.SqlClient" %>

<script runat="server">
    ' version 14/08/2018 # 11.15


    Protected Sub ButtonLogin_Click(sender As Object, e As EventArgs)
        If TextBoxPass.Text <> "1983" Then
            Exit Sub
        End If

        Dim SigninUser As FirstClickerService.Version1.User.StructureUser
        SigninUser = FirstClickerService.Version1.User.UserDetail_RoutUserName(DropDownListsystemUser.SelectedItem.ToString, WebAppSettings.DBCS)
        If SigninUser.Result = True Then
            'remove old Cookies
            Dim myCookieRO As HttpCookie
            myCookieRO = New HttpCookie("HASApp")
            myCookieRO.Expires = DateTime.Now.AddDays(-7D)
            myCookieRO.Item("UserName") = ""
            myCookieRO.Item("UserID") = ""
            myCookieRO.Item("UserType") = ""
            Response.Cookies.Add(myCookieRO)


            If SigninUser.AccountStatus = FirstClickerService.Version1.User.AccountStatus.Suspended Then
                LabelMsg.Text = "Your Account is Suspended. Please contact site administration for more info."
                Exit Sub
            End If

            Session("UserName") = SigninUser.UserName
            Session("RoutUserName") = SigninUser.RoutUserName
            Session("UserID") = SigninUser.UserID
            Session("UserType") = SigninUser.UserType.ToString

            FirstClickerService.Version1.User.UserlogedinEntry(SigninUser.UserID, WebAppSettings.DBCS)

            If CheckBoxRememberMe.Checked = True Then
                Dim myCookie As HttpCookie
                myCookie = New HttpCookie("HASApp")
                myCookie.Expires = DateTime.Now.AddDays(7D)
                myCookie.Item("UserName") = SigninUser.UserName
                myCookie.Item("RoutUserName") = SigninUser.RoutUserName
                myCookie.Item("UserID") = SigninUser.UserID
                myCookie.Item("UserType") = SigninUser.UserType.ToString
                Response.Cookies.Add(myCookie)
            End If


            Response.Redirect("~/Dashboard/")

        End If




    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then

        End If
    End Sub

    Protected Sub ButtonLoadUser_Click(sender As Object, e As EventArgs)
        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        If Trim(TextBoxUserStartWith.Text) <> "" Then
            myCmd.CommandText = "SELECT RoutUserName FROM Table_user where username like '" & TextBoxUserStartWith.Text & "%'"
        Else
            myCmd.CommandText = "SELECT RoutUserName FROM Table_user where issystemuser='true'"
        End If

        myConn.Open()
        myReader = myCmd.ExecuteReader
        Do While myReader.Read

            DropDownListsystemUser.Items.Add(myReader.Item("RoutUserName"))

        Loop
        myReader.Close()
        myConn.Close()
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row">
        <div class='col-md-3'></div>
        <div class="col-md-6 pt-4 pb-4 ">
            <div class="card BoxEffect6 mt-2 mb-2  ">
                <div class="card-header ">
                    <h1 class="card-title ">
                        <asp:Label ID="LabelHeading" runat="server" Text="Quick Login"></asp:Label>
                    </h1>
                </div>
                <div class="card-body">
                    <div class="form">
                        <div class="form-group ">
                            <div class="input-group">
                                <div class="input-group-prepend ">
                                <span class="input-group-text ">Starting With</span>    
                                </div>
                                <asp:TextBox ID="TextBoxUserStartWith" runat="server" CssClass="form-control"></asp:TextBox>
                                <div class=" input-group-append ">
                                    <asp:Button ID="ButtonLoadUser" runat="server" Text="Load User" OnClick ="ButtonLoadUser_Click" /></div>
                            </div>
                        </div>
                        <div class="form-group ">
<asp:DropDownList ID="DropDownListsystemUser" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div> 
                        <div class="form-group ">
                            <asp:TextBox ID="TextBoxPass" CssClass="form-control " runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group ">
                            <asp:CheckBox ID="CheckBoxRememberMe" runat="server" Text="Keep me login" />
                        </div>

                        <div class="form-group ">
                            <asp:Label ID="LabelMsg" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="form-group ">
                            <asp:Button ID="ButtonLogin" runat="server" Text="Login" OnClick="ButtonLogin_Click" />
                        </div>
                    </div>
                </div>
            </div>
         </div>
        <div class='col-md-3'></div>
    </div>




</asp:Content>

