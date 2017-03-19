<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/app_controls/web/NavigationSideAdmin.ascx" TagPrefix="uc1" TagName="NavigationSideAdmin" %>
<%@ Register Src="~/app_controls/web/ValidateAdminUserAccess.ascx" TagPrefix="uc1" TagName="ValidateAdminUserAccess" %>



<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Me.IsPostBack = False Then
            Dim emaildetails As ClassHostAnySite.Email.StructureEmail = ClassHostAnySite.Email.ServiceEmail_Get(ClassAppDetails.DBCS)
            TextBoxHost.Text = emaildetails.Host
            TextBoxPort.Text = emaildetails.Port
            TextBoxUserName.Text = emaildetails.UserName
            TextBoxPassword.Text = emaildetails.Password
            TextBoxEmail.Text = emaildetails.Email
            
            CheckBoxEnabled.Checked = emaildetails.Result
        End If
    End Sub

    Protected Sub ButtonTest_Click(sender As Object, e As EventArgs)
        Dim emaildetails As ClassHostAnySite.Email.StructureEmail = ClassHostAnySite.Email.ServiceEmail_Get(ClassAppDetails.DBCS)
         
        Try
            ' mail sendinggggggggggg
            Dim client As New System.Net.Mail.SmtpClient(emaildetails.Host, emaildetails.Port)
            Dim msg As System.Net.Mail.MailMessage

            client.UseDefaultCredentials = False
            client.Credentials = New System.Net.NetworkCredential(emaildetails.UserName, emaildetails.Password)
            client.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network

            msg = New System.Net.Mail.MailMessage(emaildetails.Email, TextBoxCheckEmail.Text)

            msg.Subject = "This is a verificatin Email"
            msg.IsBodyHtml = True
            msg.Body = "Hi, <br/><br/> This is a verificatin Email <br/><br/>"
            msg.Body = msg.Body & "This is a verificatin Email <br/>"
            msg.Body = msg.Body & "Regards, <Br/> "

            client.Send(msg)
        Catch ex As Exception
            LabelMsg.Text = ex.Message
            Exit Sub
        End Try
        'mail sendinggggggggggg
     
        Dim updatesetting As ClassHostAnySite.WebSetting.StructureWebSetting
        updatesetting = ClassHostAnySite.WebSetting.WebSetting_Update("ServiceEmail_Enabled", "True", ClassAppDetails.DBCS)
        
        
    End Sub

    Protected Sub ButtonSave_Click(sender As Object, e As EventArgs)
        Dim updatesetting As ClassHostAnySite.WebSetting.StructureWebSetting

        updatesetting = ClassHostAnySite.WebSetting.WebSetting_Update("ServiceEmail_Host", TextBoxHost.Text, ClassAppDetails.DBCS)
        updatesetting = ClassHostAnySite.WebSetting.WebSetting_Update("ServiceEmail_Port", TextBoxPort.Text, ClassAppDetails.DBCS)
        updatesetting = ClassHostAnySite.WebSetting.WebSetting_Update("ServiceEmail_userName", TextBoxUserName.Text, ClassAppDetails.DBCS)
        updatesetting = ClassHostAnySite.WebSetting.WebSetting_Update("ServiceEmail_Password", TextBoxPassword.Text, ClassAppDetails.DBCS)
        updatesetting = ClassHostAnySite.WebSetting.WebSetting_Update("ServiceEmail_Email", TextBoxEmail.Text, ClassAppDetails.DBCS)

    End Sub

    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateAdminUserAccess runat="server" ID="ValidateAdminUserAccess" />
    <div class="row">
       <div class="col-md-3 col-sm-3">
            <uc1:NavigationSideAdmin runat="server" ID="NavigationSideAdmin" />
        </div>
        <div class="col-md-8 col-sm-8">
            <div class="panel panel-default">
                <div class="panel-heading">Email Settings</div>
                <div class="panel-body">
                    <div class="form-signin">
                        <div class="form-group">
                   
                              
                                <asp:TextBox ID="TextBoxHost" runat="server" class="form-control" placeholder="Host"></asp:TextBox>
                        
                        </div>
                        <div class="form">
                         
                                <asp:TextBox ID="TextBoxPort" runat="server" class="form-control" placeholder="Port"></asp:TextBox>
                       
                        </div>
                         <div class="form-group">
                          
                                <asp:TextBox ID="TextBoxUserName" runat="server" class="form-control" placeholder="User Name"></asp:TextBox>
                       
                        </div>
                         <div class="form-group">
                         
                                <asp:TextBox ID="TextBoxPassword" runat="server" class="form-control" placeholder="Password"></asp:TextBox>
                    
                        </div>
                         <div class="form-group">
                          
                                <asp:TextBox ID="TextBoxEmail" runat="server" class="form-control" placeholder="Email"></asp:TextBox>
                        
                        </div>
                        <div class="form-group clearfix ">
                            <div class="pull-left ">
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="CheckBoxEnabled" runat="server" />
                                        Enable</label>
                                </div>
                            </div>
                            <div class="pull-right">
                                <asp:Button ID="ButtonSave" runat="server" class="btn btn-primary" Text="Save" OnClick="ButtonSave_Click"   />
                            </div>
                        </div>
               
                        <div class="form-group">
                            <asp:Label ID="LabelMsg" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>

                        <div class="form-group clearfix ">
                            <div class="pull-left ">
                                 <asp:TextBox ID="TextBoxCheckEmail" runat="server" class="form-control" placeholder="Email"></asp:TextBox>
                            </div>
                            <div class="pull-right">
                                <asp:Button ID="ButtonTest" runat="server" class="btn btn-primary" Text="Test Email" OnClick="ButtonTest_Click"  />
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>

