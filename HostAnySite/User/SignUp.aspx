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

    Protected Sub ButtonSignUp_Click(sender As Object, e As EventArgs)
        If CheckBoxTerms.Checked = False Then
            LabelEm.Text = "You must agree to the terms and conditions to create an account"
            PanelEM.Visible = True
            Exit Sub
        End If

        Dim returnurl As String = Trim(Request.QueryString("ReturnURL"))

        Dim CreateUser As FirstClickerService.Version1.User.StructureUser
        CreateUser = FirstClickerService.Version1.User.Create_User(TextBoxUserName.Text, TextBoxPassword.Text, FirstClickerService.Version1.User.UserType.Member, TextBoxEmail.Text, WebAppSettings.DBCS)
        If CreateUser.Result = True Then
            'remove old Cookies
            Dim myCookieRO As HttpCookie
            myCookieRO = New HttpCookie("HASApp")
            myCookieRO.Expires = DateTime.Now.AddDays(-7D)
            myCookieRO.Item("UserName") = ""
            myCookieRO.Item("UserID") = ""
            myCookieRO.Item("UserType") = ""
            Response.Cookies.Add(myCookieRO)

            If WebAppSettings.UserEmailVerificationRequired = True Then
                Dim SupportEmailDetails As FirstClickerService.Version1.SysEmailDetails.StructureEmailDetails = FirstClickerService.Version1.SysEmailDetails.Email_Get(FirstClickerService.Version1.SysEmailDetails.EmailNameEnum.Support, WebAppSettings.DBCS)
                If SupportEmailDetails.Result = True AndAlso SupportEmailDetails.IsVerified = True Then
                    Dim SendEmailVerifyMail As FirstClickerService.Common.StructureResult

                    SendEmailVerifyMail = FirstClickerService.Version1.User.SendEmailVerificationMail(CreateUser.Email, SupportEmailDetails, WebAppSettings.DBCS)
                    If SendEmailVerifyMail.Result = False Then
                        '   report Error
                    End If
                    Response.Redirect("~/user/verifyemail.aspx?email=" & CreateUser.Email)
                End If
            End If

            Session("UserName") = CreateUser.UserName
            Session("RoutUserName") = CreateUser.RoutUserName
            Session("UserID") = CreateUser.UserID
            Session("UserType") = CreateUser.UserType.ToString


            If returnurl = "" Then
                Response.Redirect("~/Dashboard/")
            Else
                Response.Redirect(returnurl)
            End If
        Else
            LabelEm.Text = CreateUser.My_Error_message
            PanelEM.Visible = True
        End If

    End Sub


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6 pt-4 pb-4 ">
            <div class="card BoxEffect6">
                <div class="card-header">
                    <h4 class="card-title text-center text-muted ">Create New Account..</h4>
                </div>
                <div class="card-body">
                   <div class="form-group">
                        <label for="username">Your Name</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text ">
                                    <i class="fas fa-user"></i></span>
                            </div>
                            <asp:TextBox ID="TextBoxUserName" runat="server" CssClass="form-control" placeholder="eg. Good Name"></asp:TextBox>
                        </div>
                    </div>

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
                                    <asp:CheckBox ID="CheckBoxTerms" runat="server" />
                                    I agree to the <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Support/Terms.aspx">Terms & Conditions</asp:HyperLink></label>
                            </div>
                        </div>
                        <div class="float-right ">
                            <asp:Button ID="ButtonSignUp" runat="server" CssClass="btn btn-sm btn-primary" Text="Register Account" OnClick="ButtonSignUp_Click" />
                        </div>
                    </div>
                    <asp:panel runat ="server" ID="PanelEM" cssclass="form-group alert alert-danger " Visible="false">
                        <i class="fas fa-info-circle mr-1"></i><asp:Label ID="LabelEm" runat="server" ></asp:Label>
                    </asp:panel>
                    <hr />
                    <div class="form-group text-center">
                        <uc1:UserSignInFacebookButton runat="server" ID="UserSignInFacebookButton"  />
                        <uc1:UserSignInTwitterButton runat="server" id="UserSignInTwitterButton" />
                        <uc1:UserSignInGoogleButton runat="server" ID="UserSignInGoogleButton" />
                    </div>
                    <hr />
                    <div class="form-group text-center">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/User/signin.aspx">Already have an account? <span class="font-weight-bold "><i class="fas fa-sign-in-alt" aria-hidden="true"></i> SignIn</span></asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
</asp:Content>

