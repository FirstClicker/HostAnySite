<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/UserSignInFacebookButton.ascx" TagPrefix="uc1" TagName="UserSignInFacebookButton" %>
<%@ Register Src="~/App_Controls/UserSignInTwitterButton.ascx" TagPrefix="uc1" TagName="UserSignInTwitterButton" %>
<%@ Register Src="~/App_Controls/UserSignInGoogleButton.ascx" TagPrefix="uc1" TagName="UserSignInGoogleButton" %>



<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            If Trim(Request.QueryString("ReturnURL")) = "" Then
                UserSignInFacebookButton.returnurl = "~/Dashboard/"
                UserSignInGoogleButton.returnurl = "~/Dashboard/"
                UserSignInTwitterButton.returnurl = "~/Dashboard/"
            End If
        End If
    End Sub

    Protected Sub ButtonSignIn_Click(sender As Object, e As EventArgs)
        Dim returnurl As String = Trim(Request.QueryString("returnURL"))

        Dim SigninUser As FirstClickerService.Version1.User.StructureUser
        SigninUser = FirstClickerService.Version1.User.SignIn_User(TextBoxEmail.Text, TextBoxPassword.Text, WebAppSettings.DBCS)

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
                LabelEm.Text = "Your Account is Suspended. Please contact site administration for more info."
                PanelEM.Visible = True
                Exit Sub
            End If

            If WebAppSettings.UserEmailVerificationRequired = True Then
                If SigninUser.EmailVerified = FirstClickerService.Version1.User.EmailVerified.No Then
                    ' push to email verification page
                    Response.Redirect("~/user/verifyEmail.aspx?email=" & SigninUser.Email)
                End If

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

            If returnurl = "" Then
                Response.Redirect("~/Dashboard/")
            Else
                Response.Redirect(returnurl)
            End If
        Else
            LabelEm.Text = SigninUser.My_Error_message
            PanelEM.Visible = True
        End If
    End Sub


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6 pt-4 pb-4 ">
            <div class="card BoxEffect6">
                <div class="card-header">
                    <h4 class="card-title text-center text-muted ">Welcome, Sign in back..</h4>
                </div>
                <div class="card-body">
                    <div class="form-group text-right">
                        <asp:HyperLink ID="HyperLinkTroubleSigning" runat="server" NavigateUrl="~/User/RecoverPassword.aspx"><i class="fas fa-question-circle" aria-hidden="true"></i> Trouble signing in?</asp:HyperLink></div>
                    <div class="form-group">
                        <label for="username-email">E-mail</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text ">
                                    <i class="fas fa-envelope"></i></span>
                            </div>
                            <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="form-control" placeholder="eg. SomeOne@Domain.Com"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text ">
                                    <i class="fas fa-lock"></i></span>
                            </div>
                            <asp:TextBox ID="TextBoxPassword" CssClass="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group clearfix ">
                        <div class="float-left ">
                            <div class="checkbox">
                                <label>
                                    <asp:CheckBox ID="CheckBoxRememberMe" runat="server" />
                                    Remember Me</label>
                            </div>
                        </div>
                        <div class="float-right ">
                            <asp:Button ID="ButtonSignIn" runat="server" CssClass="btn btn-sm btn-primary" Text="Sign in" OnClick="ButtonSignIn_Click" />
                        </div>
                    </div>
                    <asp:panel runat ="server" ID="PanelEM" cssclass="form-group alert alert-danger " Visible="false">
                        <i class="fas fa-info-circle mr-1"></i><asp:Label ID="LabelEm" runat="server" ></asp:Label>
                    </asp:panel>
                    <hr />
                    <div class="form-group text-center">
                        <uc1:UserSignInFacebookButton runat="server" ID="UserSignInFacebookButton" />
                        <uc1:UserSignInTwitterButton runat="server" id="UserSignInTwitterButton" />
                        <uc1:UserSignInGoogleButton runat="server" ID="UserSignInGoogleButton" />
                    </div>
                    <hr />
                    <div class="form-group text-center font-weight-bold">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/User/signup.aspx"><i class="fas fa-user-plus" aria-hidden="true"></i> Create an account</asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
</asp:Content>

