<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/ReCaptcha.ascx" TagPrefix="uc1" TagName="ReCaptcha" %>





<script runat="server">



    Protected Sub ButtonSendPasswordEmail_Click(sender As Object, e As EventArgs)
        If ReCaptcha.validCaptcha = False Then Exit Sub
        Dim ServiceEmailDetails As FirstClickerService.Email.StructureEmail = FirstClickerService.Email.ServiceEmail_Get(WebAppSettings.DBCS)

        If ServiceEmailDetails.Result = True Then
            '  Dim recoverpass As FirstClickerService.Common.StructureResult = FirstClickerService.Version1.User.SendPasswordRecoveryMail(TextBoxEmail.Text, ServiceEmailDetails, WebAppSettings.DBCS)
            '  LabelEm.Text = recoverpass.My_Error_message
        Else

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
                    <h4 class="card-title text-center text-muted ">Recover your password..</h4>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <label for="username-email">E-mail registered with us</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text ">
                                    <i class="fas fa-envelope"></i></span>
                            </div>
                            <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="form-control" placeholder="eg. SomeOne@Domain.Com"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                            <uc1:ReCaptcha runat="server" ID="ReCaptcha" />
                        </div>
                    <div class="form-group clearfix ">
                       
                        <div class="float-right">
                            <asp:Button ID="ButtonSendPasswordEmail" runat="server" CssClass="btn btn-sm btn-primary " Text="Email My Password" OnClick="ButtonSendPasswordEmail_Click" />
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

