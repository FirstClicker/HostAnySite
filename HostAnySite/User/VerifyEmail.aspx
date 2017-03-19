<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>


<script runat="server">
    Protected Sub ButtonVerifyEmail_Click(sender As Object, e As EventArgs)
        Dim verifyemail As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.User_EmailVerifY(inputEmail.Text, inputPassword.Text, ClassAppDetails.DBCS)
        If verifyemail.Result = True Then
                    
            LabelEm.Text = "Your email is verified. Please sign in to continue."
        Else
            LabelEm.Text = "Failed to verify your Email verification code. Try again."
        End If
    End Sub

    Protected Sub ButtonCreateAccount_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/signup.aspx")
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim websetting As ClassHostAnySite.WebSetting.StructureWebSetting
        websetting = ClassHostAnySite.WebSetting.WebSetting_Get("VerifyEmailNote", ClassAppDetails.DBCS)
        LabelVerifyEmailNote.Text = websetting.SettingValue
        
        
        
        
        If IsPostBack = False Then
            Dim email As String = Trim(Request.QueryString("email"))
            Dim Vcode As String = Trim(Request.QueryString("vcode"))
        
            If email <> "" Then
                inputEmail.Text = email
            
                If Val(Vcode) > 0 Then
                    inputPassword.Text = Vcode
                    ButtonVerifyEmail_Click(sender, e)
                End If
            End If
        End If
    End Sub

  

    Protected Sub ButtonSignIn_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/signin.aspx")
    End Sub

    Protected Sub ButtonSendVcode_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/SendEmailVerificationCode.aspx")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-8">
            <div class="panel">
                <div class="panel-body">
                    <asp:Label ID="LabelVerifyEmailNote" runat="server" Text="Verify Email."></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-4">

            <div class="panel panel-default ">
                <div class="panel-heading ">Please Verify Email</div>
                <div class="panel-body ">
                    <div class="form-signin">
             
                        <label for="inputUserId" class="sr-only">Email</label>
                        <asp:TextBox ID="inputEmail" runat="server" class="form-control" placeholder="Email"></asp:TextBox>

                        <label for="inputPassword" class="sr-only">Verification Code</label>
                        <asp:TextBox ID="inputPassword" class="form-control" placeholder="Verification Code" runat="server" TextMode="Password"></asp:TextBox>


                        <div class="form-group">
                            <asp:Label ID="LabelEm" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>

                        <asp:Button ID="ButtonVerifyEmail" runat="server" class="btn  btn-primary btn-block" Text="Verify Email" OnClick="ButtonVerifyEmail_Click" />
                        <hr />

                        <asp:Button ID="ButtonSendVcode" runat="server" class="btn  btn-primary btn-block" Text="Email My Verification Code" OnClick="ButtonSendVcode_Click" />


                        <hr />
                        <asp:Button ID="ButtonCreateAccount" runat="server" class="btn btn-primary btn-block" Text="Create Account" OnClick="ButtonCreateAccount_Click" />

                        <asp:Button ID="ButtonSignIn" runat="server" class="btn btn-primary btn-block" Text="Sign in" OnClick="ButtonSignIn_Click" />

                    </div>
                </div>
            </div> 

        </div>
    </div>
</asp:Content>

