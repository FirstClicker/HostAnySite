<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>


<script runat="server">
    Protected Sub ButtonSendVcode_Click(sender As Object, e As EventArgs)
        Dim ServiceEmailDetails As ClassHostAnySite.Email.StructureEmail = ClassHostAnySite.Email.ServiceEmail_Get(ClassAppDetails.DBCS)

        If ServiceEmailDetails.Result = True Then
            Dim SigninUser As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.SignIn_User(inputEmail.Text, inputPassword.Text, ClassAppDetails.DBCS)
            If SigninUser.Result = True Then
                Dim sendvcode As ClassHostAnySite.HostAnySite.StructureResult = ClassHostAnySite.User.SendEmailVerificationMail(SigninUser.Email, ServiceEmailDetails, ClassAppDetails.DBCS)
                If sendvcode.Result = True Then
                    LabelMsg.Text = sendvcode.My_Error_message
                Else
                    LabelMsg.Text = sendvcode.My_Error_message
                End If
            Else
                LabelMsg.Text = "Failed to validate your email and password. Try again."
            End If
        Else
            
        End If
      
    End Sub
    
    Protected Sub ButtonSignIn_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/signin.aspx")
    End Sub

    Protected Sub ButtonCreateAccount_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/signup.aspx")
    End Sub

 

    Protected Sub ButtonRecoverPassword_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/recoverpassword.aspx")
    End Sub

    Protected Sub ButtonVerifyEmail_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/VerifyEmail.aspx")
    End Sub

   
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim websetting As ClassHostAnySite.WebSetting.StructureWebSetting
        websetting = ClassHostAnySite.WebSetting.WebSetting_Get("EmailVerificationCodeNote", ClassAppDetails.DBCS)
        LabelEmailVerificationCodeNote.Text = websetting.SettingValue
        
        
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-lg-8">
            <div class="panel">
                <div class="panel-body">
                    <asp:Label ID="LabelEmailVerificationCodeNote" runat="server" Text="Verify Email."></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-4">
          <div class="panel panel-default ">
                <div class="panel-heading ">Sign in to get code</div>
                <div class="panel-body ">
    <div class="form-signin">
      
        <label for="inputEmail" class="sr-only">Email</label>
        <asp:TextBox ID="inputEmail" runat="server" class="form-control" placeholder="Email"></asp:TextBox>

        <label for="inputPassword" class="sr-only">Password</label>
        <asp:TextBox ID="inputPassword" class="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>

        <div class="form-group">
            <asp:Label ID="LabelMsg" runat="server" ForeColor="Maroon"></asp:Label>
        </div>

        <asp:Button ID="ButtonSendVcode" runat="server" class="btn btn-primary btn-block" Text="Email My Verification Code" OnClick="ButtonSendVcode_Click"  />
       <asp:Button ID="ButtonVerifyEmail" runat="server" class="btn btn-primary btn-block" Text="Verify Email" OnClick="ButtonVerifyEmail_Click"  />
         <hr />
            <asp:Button ID="ButtonCreateAccount" runat="server" class="btn btn-primary btn-block" Text="Create Account" OnClick="ButtonCreateAccount_Click" />
          <asp:Button ID="ButtonSignIn" runat="server" class="btn btn-primary btn-block" Text="Sign in" OnClick="ButtonSignIn_Click" />

       
        
    </div>
</div></div> 
        </div>
    </div>
</asp:Content>


