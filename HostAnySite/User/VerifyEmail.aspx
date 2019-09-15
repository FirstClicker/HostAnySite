<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/UserSignInFacebookButton.ascx" TagPrefix="uc1" TagName="UserSignInFacebookButton" %>
<%@ Register Src="~/App_Controls/UserSignInTwitterButton.ascx" TagPrefix="uc1" TagName="UserSignInTwitterButton" %>
<%@ Register Src="~/App_Controls/UserSignInGoogleButton.ascx" TagPrefix="uc1" TagName="UserSignInGoogleButton" %>




<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim email As String = Trim(Request.QueryString("email"))
            Dim Vcode As String = Trim(Request.QueryString("vcode"))

            If email <> "" Then
                TextBoxEmail.Text = email

                If Val(Vcode) > 0 Then
                    TextBoxPassword.Text = Vcode
                    ButtonVerifyEmail_Click(sender, e)
                End If
            End If
        End If
    End Sub

    Protected Sub LinkButtonResendCode_Click(sender As Object, e As EventArgs)

        LinkButtonResendCode.Text = "<i class=""fas fa-question-circle"" aria-hidden=""True""></i> Code sent to your email."
        LinkButtonResendCode.Enabled = False
    End Sub

    Protected Sub ButtonVerifyEmail_Click(sender As Object, e As EventArgs)
        Dim verifyemail As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.User_EmailVerifY(TextBoxEmail.Text, TextBoxPassword.Text, WebAppSettings.DBCS)
        If verifyemail.Result = True Then
            LabelEm.Text = "Your email is verified. Please sign in to continue."
        Else
            LabelEm.Text = "Failed to verify your Email verification code. Try again."
        End If
    End Sub


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class='col-md-3'></div>
        <div class="col-md-6 pt-4 pb-4 ">
            <div class="card BoxEffect6">
                <div class="card-header">
                    <h4 class="card-title text-center text-muted ">Verify your e-mail</h4>
                </div>
                <div class="card-body">
                
                    <div class="form-group">
                        <label for="username-email">E-mail</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text ">
                                    <i class="fas fa-envelope"></i></span>
                            </div>
                            <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="form-control" placeholder="eg. SomeOne@Domain.Com"></asp:TextBox>
                        </div>
                        <asp:LinkButton ID="LinkButtonResendCode" CssClass="form-text text-muted float-lg-right" runat="server" OnClick="LinkButtonResendCode_Click"><i class="fas fa-question-circle" aria-hidden="true"></i> Resend verification code</asp:LinkButton>
                    </div>
                    <div class="form-group">
                        <label for="password">Verification Code</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text ">
                                    <i class="fas fa-lock"></i></span>
                            </div>
                            <asp:TextBox ID="TextBoxPassword" CssClass="form-control" placeholder="Verification Code" runat="server" TextMode="Password"></asp:TextBox>
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
                            <asp:Button ID="ButtonVerifyEmail" runat="server" CssClass="btn btn-sm btn-primary" Text="Verify e-mail" OnClick="ButtonVerifyEmail_Click" />
                        </div>
                    </div>
                    <asp:Panel runat="server" ID="PanelEM" CssClass="form-group alert alert-danger " Visible="false">
                        <i class="fas fa-info-circle mr-1"></i>
                        <asp:Label ID="LabelEm" runat="server"></asp:Label>
                    </asp:Panel>
                    <hr />
                       <div class="form-group text-center">
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/User/signin.aspx">Already have an account? <span class="font-weight-bold "><i class="fas fa-sign-in-alt" aria-hidden="true"></i> SignIn</span></asp:HyperLink>
                    </div>
                    <div class="form-group text-center font-weight-bold">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/User/signup.aspx"><i class="fas fa-user-plus" aria-hidden="true"></i> Create an account</asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
        <div class='col-md-3'></div>
    </div>
</asp:Content>

