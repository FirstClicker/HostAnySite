<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>




<script runat="server">

    Protected Sub ButtonCreateAccount_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/signup.aspx")
    End Sub

   
    Protected Sub ButtonRecoverPassword_Click(sender As Object, e As EventArgs)
        Dim ServiceEmailDetails As ClassHostAnySite.Email.StructureEmail = ClassHostAnySite.Email.ServiceEmail_Get(ClassAppDetails.DBCS)

        If ServiceEmailDetails.Result = True Then
            Dim recoverpass As ClassHostAnySite.HostAnySite.StructureResult = ClassHostAnySite.User.SendPasswordRecoveryMail(inputEmail.Text, ServiceEmailDetails, ClassAppDetails.DBCS)
            LabelEm.Text = recoverpass.My_Error_message
        Else
            
        End If
    End Sub


    Protected Sub ButtonSignIn_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/signin.aspx")
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim websetting As ClassHostAnySite.WebSetting.StructureWebSetting
        websetting = ClassHostAnySite.WebSetting.WebSetting_Get("RecoverPasswordNote", ClassAppDetails.DBCS)
        LabelRecoverPasswordNote.Text = websetting.SettingValue
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-8">
             <div class="panel">
                <div class="panel-body">
                    <asp:Label ID="LabelRecoverPasswordNote" runat="server" Text="Recover Password."></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-md-4">

            <div class="panel panel-default ">
                <div class="panel-heading ">Recover Password By Email</div>
                <div class="panel-body ">
                    <div class="form-signin">
                      
                        <label for="inputUserId" class="sr-only">Email</label>
                        <asp:TextBox ID="inputEmail" runat="server" class="form-control" placeholder="Email"></asp:TextBox>



                        <div class="form-group">
                            <asp:Label ID="LabelEm" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>

                        <asp:Button ID="ButtonRecoverPassword" runat="server" class="btn  btn-primary btn-block" Text="Recover Password" OnClick="ButtonRecoverPassword_Click" />
                        <hr />

                        <asp:Button ID="ButtonCreateAccount" runat="server" class="btn  btn-primary btn-block" Text="Create Account" OnClick="ButtonCreateAccount_Click" />
                        <asp:Button ID="ButtonSignIn" runat="server" class="btn  btn-primary btn-block" Text="Sign in" OnClick="ButtonSignIn_Click" />

                    </div>
                </div>
            </div> 
        </div>
    </div>
</asp:Content>

