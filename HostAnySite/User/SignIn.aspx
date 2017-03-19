<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Register Src="~/app_controls/web/ImageCarousel.ascx" TagPrefix="uc1" TagName="ImageCarousel" %>


<script runat="server">
    Protected Sub ButtonSignIn_Click(sender As Object, e As EventArgs)
        Dim returnurl As String = Trim(Request.QueryString("returnURL"))
 
        Dim SigninUser As ClassHostAnySite.User.StructureUser
        SigninUser = ClassHostAnySite.User.SignIn_User(inputEmail.Text, inputPassword.Text, ClassAppDetails.DBCS)

        If SigninUser.Result = True Then
            'remove old Cookies
            Dim myCookieRO As HttpCookie
            myCookieRO = New HttpCookie("HASApp")
            myCookieRO.Expires = DateTime.Now.AddDays(-7D)
            myCookieRO.Item("UserName") = ""
            myCookieRO.Item("UserID") = ""
            myCookieRO.Item("UserType") = ""
            Response.Cookies.Add(myCookieRO)
            
            
            If SigninUser.AccountStatus = ClassHostAnySite.User.AccountStatus.Suspended Then
                LabelMsg.Text = "Your Account is Suspended. Please contact site administration for more info."
                Exit Sub
            End If
            
            Session("UserName") = SigninUser.UserName
            Session("RoutUserName") = SigninUser.RoutUserName
            Session("UserID") = SigninUser.UserID
            Session("UserType") = SigninUser.UserType.ToString

         

            ClassHostAnySite.User.UserlogedinEntry(SigninUser.UserID, ClassAppDetails.DBCS)
            
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
            LabelMsg.Text = SigninUser.My_Error_message
        End If
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
        ImageCarousel.Carousel_WebSetting = "SignInCarouselImage"
        
        Dim websetting As ClassHostAnySite.WebSetting.StructureWebSetting
        websetting = ClassHostAnySite.WebSetting.WebSetting_Get("SignInNote", ClassAppDetails.DBCS)
        LabelSignInNote.Text = websetting.SettingValue
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
                    <asp:Label ID="LabelSignInNote" runat="server" Text="Sign in Back."></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 pull-right">
            <div class="panel panel-default ">
                <div class="panel-heading ">Please sign in</div>
                <div class="panel-body ">
                    <div class="form-signin">
                        <div class="form-group">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="glyphicon glyphicon-envelope "></i>
                                </span>
                                 <asp:TextBox ID="inputEmail" runat="server" class="form-control" placeholder="E-Mail"></asp:TextBox>
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
                            <div class="pull-right ">
                                <asp:Button ID="ButtonSignIn" runat="server" class="btn btn-primary" Text="Sign in" OnClick="ButtonSignIn_Click" />
                            </div> 
                        </div> 
                       
                      
                      
                        <hr />

                        <asp:Button ID="ButtonCreateAccount" runat="server" class="btn btn-primary btn-block" Text="Create Account" OnClick="ButtonCreateAccount_Click" />
                        <asp:Button ID="ButtonRecoverPassword" runat="server" class="btn btn-primary btn-block" Text="Recover Password" OnClick="ButtonRecoverPassword_Click" />
                        <asp:Button ID="ButtonVerifyEmail" runat="server" class="btn btn-primary btn-block" Text="Verify Email" OnClick="ButtonVerifyEmail_Click" />
                    </div>
                </div>

            </div>

        </div>

      

    </div>
</asp:Content>


