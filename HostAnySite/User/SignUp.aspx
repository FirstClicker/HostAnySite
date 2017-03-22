<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Register Src="~/app_controls/web/ImageCarousel.ascx" TagPrefix="uc1" TagName="ImageCarousel" %>



<script runat="server">
    Protected Sub ButtonSignUp_Click(sender As Object, e As EventArgs)
        Dim returnurl As String = Trim(Request.QueryString("returnURL"))

        Dim createuser As ClassHostAnySite.User.StructureUser

        Dim ServiceEmailDetails As ClassHostAnySite.Email.StructureEmail = ClassHostAnySite.Email.ServiceEmail_Get(ClassAppDetails.DBCS)
        Dim SendEmailVerifyMail As ClassHostAnySite.HostAnySite.StructureResult


        createuser = ClassHostAnySite.User.Create_User(TextBoxUsername.Text, inputPassword.Text, ClassHostAnySite.User.UserType.Member, inputEmail.Text, ClassAppDetails.DBCS)
        If createuser.Result = True Then

            'remove old Cookies
            Dim myCookieRO As HttpCookie
            myCookieRO = New HttpCookie("HASApp")
            myCookieRO.Expires = DateTime.Now.AddDays(-7D)
            myCookieRO.Item("UserName") = ""
            myCookieRO.Item("UserID") = ""
            myCookieRO.Item("UserType") = ""
            Response.Cookies.Add(myCookieRO)


            If ServiceEmailDetails.Result = True Then
                SendEmailVerifyMail = ClassHostAnySite.User.SendEmailVerificationMail(createuser.Email, ServiceEmailDetails, ClassAppDetails.DBCS)
                If SendEmailVerifyMail.Result = False Then
                    'report Error

                End If
            End If

            Session("UserName") = createuser.UserName
            Session("RoutUserName") = createuser.RoutUserName
            Session("UserID") = createuser.UserID
            Session("UserType") = createuser.UserType.ToString

            If CheckBoxRememberMe.Checked = True Then
                Dim myCookie As HttpCookie
                myCookie = New HttpCookie("HASApp")
                myCookie.Expires = DateTime.Now.AddDays(7D)
                myCookie.Item("UserName") = createuser.UserName
                myCookie.Item("RoutUserName") = createuser.RoutUserName
                myCookie.Item("UserID") = createuser.UserID
                myCookie.Item("UserType") = createuser.UserType.ToString
                Response.Cookies.Add(myCookie)
            End If


            Dim posttowall As ClassHostAnySite.UserWall.StructureUserWall
            posttowall = ClassHostAnySite.UserWall.UserWall_Add("", "Hi, I jost Joined...", "0", createuser.UserID, createuser.UserID, 0, "0", "visible", ClassAppDetails.DBCS)

            If returnurl = "" Then
                Response.Redirect("~/Dashboard/")
            Else
                Response.Redirect(returnurl)
            End If
        Else
            LabelMsg.Text = createuser.My_Error_message
        End If

    End Sub

    Protected Sub ButtonSignIn_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/user/signin.aspx")
    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        ImageCarousel.Carousel_WebSetting = "SignUpCarouselImage"

        Dim websetting As ClassHostAnySite.WebSetting.StructureWebSetting
        websetting = ClassHostAnySite.WebSetting.WebSetting_Get("SignUpNote", ClassAppDetails.DBCS)
        LabelSignupNote.Text = websetting.SettingValue
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-8 col-md-8  hidden-sm hidden-xs ">
            <uc1:ImageCarousel runat="server" ID="ImageCarousel" />
            <div class="panel">
                <div class="panel-body">
                    <asp:Label ID="LabelSignupNote" runat="server" Text="Create your Account."></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 pull-right">
            <div class="panel panel-default ">
                <div class="panel-heading ">Create Account</div>
                <div class="panel-body ">
                    <div class="form-signin">
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="glyphicon glyphicon-user "></i>
                                </span>
                                <asp:TextBox ID="TextBoxUsername" runat="server" class="form-control" placeholder="Your Name"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="glyphicon glyphicon-envelope "></i>
                                </span>
                                <asp:TextBox ID="inputEmail" runat="server" class="form-control" placeholder="Email address"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="glyphicon glyphicon-lock"></i>
                                </span>
                                <asp:TextBox ID="inputPassword" class="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                            </div>
                        </div>
                          <div class="form-group">
                            <asp:Label ID="LabelMsg" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>
                        <div class="form-group clearfix ">
                            <div class="pull-left ">
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="CheckBoxRememberMe" runat="server" />
                                        Remember Me</label>
                                </div>
                            </div>
                            <div class="pull-right">
                                 <asp:Button ID="ButtonSignUp" runat="server" class="btn btn-primary" Text="Sign Up" OnClick="ButtonSignUp_Click" />
                            </div>
                        </div>
                      
                        <hr />
                        <asp:Button ID="ButtonSignIn" runat="server" class="btn btn-primary btn-block" Text="Sign in" OnClick="ButtonSignIn_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


