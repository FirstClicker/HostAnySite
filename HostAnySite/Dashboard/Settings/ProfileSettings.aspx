<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>
<%@ Import Namespace="FirstClickerService" %>


<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim userdet As Version1.User.StructureUser = Version1.User.UserDetail_UserID(Session("userid"), WebAppSettings.DBCS)
        TextBoxUserName.Text = userdet.UserName
        TextBoxRoutUsername.Text = userdet.RoutUserName
        TextBoxEmail.Text = userdet.Email

        ImageUserimage.ImageUrl = "~/storage/image/" & userdet.UserImage.ImageFileName
        ImageProfileBanner.ImageUrl = "~/storage/image/" & userdet.BannerImage.ImageFileName
    End Sub
    Protected Sub ButtonUpdateUserName_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub ButtonUpdateRoutUserName_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub ButtonUpdatePhone_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub ButtonUpdateEmail_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub ButtonUploadProfilePicture_Click(sender As Object, e As EventArgs)
        Dim SubmitImage As Version1.Image.StructureImage
        Dim Imageid As String = Version1.Image.NewImageId(WebAppSettings.DBCS)

        'upload image
        Dim filename As String = Common.ConvertSpace2Dass(Session("UserName").ToString.Trim) & "-" & Imageid & ".jpg"
        LabelProfilePictureEM.Text = ""

        ''''''''''''''''''
        If FileUploadProfilePicture.HasFile = True Then
            Dim fileExt As String
            fileExt = System.IO.Path.GetExtension(FileUploadProfilePicture.FileName)

            If (fileExt.ToLower = ".jpg") Or (fileExt.ToLower = ".png") Then
            Else
                LabelProfilePictureEM.Text = "Only Jpg and Png files allowed!"
                Exit Sub
            End If
        Else
            LabelProfilePictureEM.Text = "You have not specified a Jpg file to upload."
            Exit Sub
        End If
        ''''''''''''''''''''''
        FileUploadProfilePicture.PostedFile.SaveAs(Server.MapPath("~/storage/Image/" & filename))
        Version1.Image.ImageResize_withCompression(Server.MapPath("~/storage/Image/" & filename), Server.MapPath("~/storage/Image/" & filename), 400, 400, 95)

        SubmitImage = Version1.Image.SubmitImageByWeb(Imageid, filename, Session("UserName").ToString, Session("UserName").ToString, Session("userid").ToString, Version1.Image.StatusEnum.Visible, WebAppSettings.DBCS)
        If SubmitImage.Result = False Then
            LabelProfilePictureEM.Text = SubmitImage.My_Error_message
            ' report error
        Else
            Version1.User.User_AddImageId(Session("userid"), Imageid, WebAppSettings.DBCS)
            LabelProfilePictureEM.Text = "Profile Picture Changed Successfully."

            Response.Redirect(Request.RawUrl)
        End If
    End Sub

    Protected Sub ButtonUploadBanner_Click(sender As Object, e As EventArgs)
        Dim SubmitImage As Version1.Image.StructureImage
        Dim ImageId As String = Version1.Image.NewImageId(WebAppSettings.DBCS)

        'upload image
        Dim filename As String = Common.ConvertSpace2Dass(Session("UserName").ToString.Trim) & "-" & ImageId & ".jpg"
        LabelProfileBannerEM.Text = ""

        ''''''''''''''''''
        If FileUploadPrfileBanner.HasFile = True Then
            Dim fileExt As String
            fileExt = System.IO.Path.GetExtension(FileUploadPrfileBanner.FileName)
            If (fileExt.ToLower = ".jpg") Or (fileExt.ToLower = ".png") Then
            Else
                LabelProfileBannerEM.Text = "Only Jpg and Png files allowed!"
                Exit Sub
            End If
        Else
            LabelProfileBannerEM.Text = "You have not specified a Jpg file to upload."
            Exit Sub
        End If
        ''''''''''''''''''''''
        FileUploadPrfileBanner.PostedFile.SaveAs(Server.MapPath("~/storage/Image/" & filename))
        Version1.Image.ImageResize_withCompression(Server.MapPath("~/storage/Image/" & filename), Server.MapPath("~/storage/Image/" & filename), 1000, 250, 95)

        SubmitImage = Version1.Image.SubmitImageByWeb(ImageId, filename, Session("UserName").ToString, Session("UserName").ToString, Session("userid").ToString, Version1.Image.StatusEnum.Visible, WebAppSettings.DBCS)
        If SubmitImage.Result = False Then
            LabelProfileBannerEM.Text = SubmitImage.My_Error_message
            ' report error
        Else
            Version1.User.User_AddBannerImageId(Session("userid"), ImageId, WebAppSettings.DBCS)
            LabelProfileBannerEM.Text = "Profile banner changed successfully."

            Response.Redirect(Request.RawUrl)
        End If
    End Sub


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card  mt-2  BoxEffect6 ">
                <div class=" card-header">
                    Profile Settings
                </div>
                <div class="card-body">

                    <!-- Text input-->
                    <div class="form-group">
                        <label>Your Name</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text ">
                                    <i class="fas fa-user-circle"></i>
                                </span>
                            </div>
                            <asp:TextBox ID="TextBoxUserName" CssClass="form-control" runat="server"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button ID="ButtonUpdateUserName" OnClick="ButtonUpdateUserName_Click" CssClass="btn btn-info" runat="server" Text="Update" />
                            </div>
                        </div>
                    </div>

                    <!-- Text input-->
                    <div class="form-group">
                        <label>User Name</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text ">
                                    <i class="fas fa-user-circle"></i>
                                </span>
                            </div>
                            <asp:TextBox ID="TextBoxRoutUsername" CssClass="form-control" runat="server"></asp:TextBox>
                            <div class="input-group-append">
                                <asp:Button ID="ButtonUpdateRoutUserName" OnClick="ButtonUpdateRoutUserName_Click" CssClass="btn btn-info " runat="server" Text="Update" />
                            </div>
                        </div>
                    </div>


                    <!-- Multiple Radios (inline) -->
                    <div class="form-group">
                        <label>Gender</label>
                        <div class="col-md-4">
                            <label class="radio-inline" for="Gender-0">
                                <input type="radio" name="Gender" id="Gender-0" value="1" checked="checked">
                                Male
   
                            </label>
                            <label class="radio-inline" for="Gender-1">
                                <input type="radio" name="Gender" id="Gender-1" value="2">
                                Female
   
                            </label>
                            <label class="radio-inline" for="Gender-2">
                                <input type="radio" name="Gender" id="Gender-2" value="3">
                                Other
   
                            </label>
                        </div>
                    </div>



                    <div class="form-row">

                        <div class="col-12 mb-3">
                            <label>Email</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text ">
                                        <i class="far fa-envelope"></i>
                                    </span>
                                </div>
                                <asp:TextBox ID="TextBoxEmail" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="ButtonUpdateEmail" OnClick="ButtonUpdateEmail_Click" CssClass="btn btn-info " runat="server" Text="Update" />
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="form-group">
                      
                        <div class="card">
                            <div class="card-body ">
                                 <h4 class="card-title">Profile Picture</h4>
                                <div class="form-group text-center  ">
                                    <asp:Image ID="ImageUserimage" runat="server" ImageUrl="~/Content/image/UserAvtar.png" Width="100" />
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="custom-file">
                                            <asp:FileUpload ID="FileUploadProfilePicture" runat="server" CssClass="custom-file-input" />
                                            <label class="custom-file-label" for="<%=FileUploadProfilePicture.ClientID %>">Choose file</label>
                                        </div>
                                        <div class="input-group-append">
                                            <asp:Button ID="ButtonUploadProfilePicture" runat="server" CssClass="btn " Text="Change"
                                                OnClick="ButtonUploadProfilePicture_Click" />
                                        </div>
                                    </div>
                                </div>
                                <asp:Panel runat="server" ID="PanelEM" CssClass="form-group alert alert-info ">
                                    <i class="fas fa-info-circle mr-1"></i>
                                    <asp:Label ID="LabelProfilePictureEM" runat="server" Text="Image will be resize to 400x400 px"></asp:Label>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                       
                        <div class="card">
                            <div class="card-body ">
                                 <h4 class="card-title">Profile Banner</h4>
                                <div class="form-group text-center  ">
                                    <asp:Image ID="ImageProfileBanner" runat="server" ImageUrl="~/Content/image/ProfileBanner.png" Height="100" />
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="custom-file">
                                            <asp:FileUpload ID="FileUploadPrfileBanner" runat="server" CssClass="custom-file-input" />

                                            <label class=" custom-file-label" for="inputGroupFile04">Choose file</label>
                                        </div>
                                        <div class="input-group-append">
                                            <asp:Button ID="ButtonUploadBanner" runat="server" Text="Change"
                                                CssClass="btn" OnClick="ButtonUploadBanner_Click" />
                                        </div>
                                    </div>
                                </div>
                                <asp:Panel runat="server" ID="Panel1" CssClass="form-group alert alert-info ">
                                    <i class="fas fa-info-circle mr-1"></i>
                                    <asp:Label ID="LabelProfileBannerEM" runat="server" Text="Image will be resize to 1000x250 px"></asp:Label>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

