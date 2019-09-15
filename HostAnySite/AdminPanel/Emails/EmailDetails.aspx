<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>


<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>




<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        If Me.IsPostBack = False Then
            DropDownListSetting.Items.Clear()
            DropDownListSetting.Items.Add("Setect Email")
            For Each i In [Enum].GetValues(GetType(FirstClickerService.Version1.SysEmailDetails.EmailNameEnum))
                DropDownListSetting.Items.Add(i.ToString)
            Next
        End If
    End Sub

    Protected Sub DropDownListSetting_SelectedIndexChanged(sender As Object, e As EventArgs)
        If DropDownListSetting.SelectedIndex = 0 Then
            TextBoxEmail.Text = ""
            TextBoxHost.Text = ""
            TextBoxPort.Text = ""
            TextBoxUserName.Text = ""
            TextBoxPassword.Text = ""
            Exit Sub
        End If


        Dim Emailinfo As FirstClickerService.Version1.SysEmailDetails.StructureEmailDetails
        Emailinfo = FirstClickerService.Version1.SysEmailDetails.Email_Get([Enum].Parse(GetType(FirstClickerService.Version1.SysEmailDetails.EmailNameEnum), DropDownListSetting.SelectedItem.Text, True), WebAppSettings.DBCS)
        If Emailinfo.Result = True Then
            TextBoxEmail.Text = Emailinfo.Email
            TextBoxHost.Text = Emailinfo.Host
            TextBoxPort.Text = Emailinfo.Port
            TextBoxUserName.Text = Emailinfo.UserName
            TextBoxPassword.Text = Emailinfo.Password
        Else
            LabelEm.Text = "Failed to load"
        End If

    End Sub


    Protected Sub ButtonTest_Click(sender As Object, e As EventArgs)
        Dim emaildetails As FirstClickerService.Version1.SysEmailDetails.StructureEmailDetails = FirstClickerService.Version1.SysEmailDetails.Email_Get([Enum].Parse(GetType(FirstClickerService.Version1.SysEmailDetails.EmailNameEnum), DropDownListSetting.SelectedItem.Text, True), WebAppSettings.DBCS)

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
            LabelMsgTest.Text = ex.Message
            Exit Sub
        End Try
        'mail sendinggggggggggg



    End Sub

    Protected Sub ButtonSave_Click(sender As Object, e As EventArgs)

    End Sub



</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
         <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header ">System Email Details</div>

                <div class="card-body">
                    <div class="form">
                        <div class="form-group">
                            <asp:DropDownList ID="DropDownListSetting" CssClass="form-control " runat="server" OnSelectedIndexChanged="DropDownListSetting_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                        </div>
                         <div class="form-group">
                              <label for="inputEmail">Email</label>
                            <asp:TextBox ID="TextBoxEmail" runat="server" class="form-control" placeholder="Email"></asp:TextBox>
                        </div>
                        <div class="form-group">
                              <label for="inputEmail">Host</label>
                            <asp:TextBox ID="TextBoxHost" runat="server" class="form-control" placeholder="Host"></asp:TextBox>
                        </div>
                        <div class="form">
                              <label for="inputEmail">Port</label>
                            <asp:TextBox ID="TextBoxPort" runat="server" class="form-control" placeholder="Port"></asp:TextBox>
                        </div>
                        <div class="form-group">
                              <label for="inputEmail">User Name</label>
                            <asp:TextBox ID="TextBoxUserName" runat="server" class="form-control" placeholder="User Name"></asp:TextBox>
                        </div>
                        <div class="form-group">
                              <label for="inputEmail">Password</label>
                            <asp:TextBox ID="TextBoxPassword" runat="server" class="form-control" placeholder="Password"></asp:TextBox>
                        </div>
                       


                        <div class="form-group ">
                            <div class="checkbox">
                                <label for="inputEmail">
                                    <asp:CheckBox ID="CheckBoxEnabled" runat="server"/> Enable Email Service
                                </label>
                            </div>
                        </div>
                        <div class="form-group clearfix ">
                            <div class="float-right">
                                <asp:Button ID="ButtonSave" runat="server" class="btn btn-primary" Text="Save" OnClick="ButtonSave_Click" />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="Labelem" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>

                    </div>
                    <div class="card ">
                        <div class="card-body ">
                            <div class="form-group">
                                <div class=" input-group">
                                    <asp:TextBox ID="TextBoxCheckEmail" runat="server" class="form-control" placeholder="Email"></asp:TextBox>
                                    <div class="input-group-prepend ">
                                        <asp:Button ID="ButtonTest" runat="server" class="btn btn-primary" Text="Test Email and Enable service" OnClick="ButtonTest_Click" />
                                    </div>
                                </div>
                            </div>
                              <div class="form-group">
                            <asp:Label ID="LabelMsgTest" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>

