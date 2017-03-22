<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Src="~/app_controls/web/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/app_controls/web/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>


<script runat="server">



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim userdet As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.UserDetail_UserID(Session("userid"), ClassAppDetails.DBCS)

        TextBoxUserName.Text = userdet.UserName

        Image1.ImageUrl = "~/storage/image/" & userdet.UserImage.ImageFileName
        ImageBanner.ImageUrl = "~/storage/image/" & userdet.BannerImage.ImageFileName
    End Sub


    Protected Sub ButtonSubmit_Click(sender As Object, e As EventArgs)
        Dim SubmitWall As ClassHostAnySite.Image.StructureImage
        Dim Wallid As String = ClassHostAnySite.Image.NewimageId(ClassAppDetails.DBCS)

        'upload image
        Dim filename As String = ClassHostAnySite.HostAnySite.ConvertSpace2Dass(Session("UserName").ToString.Trim) & "-" & Wallid & ".jpg"
        LabelEm.Text = ""

        ''''''''''''''''''
        If FileUpload1.HasFile = True Then
            Dim fileExt As String
            fileExt = System.IO.Path.GetExtension(FileUpload1.FileName)

            If Not (fileExt.ToLower = ".jpg") Then
                LabelEm.Text = "Only .Jpg files allowed!"
                Exit Sub
            End If
        Else
            LabelEm.Text = "You have not specified a Jpg file to upload."
            Exit Sub
        End If
        ''''''''''''''''''''''
        FileUpload1.PostedFile.SaveAs(Server.MapPath("~/storage/Image/" & filename))
        ClassHostAnySite.Image.ImageResize(Server.MapPath("~/storage/Image/" & filename), Server.MapPath("~/storage/Image/" & filename), 300, 400)

        SubmitWall = ClassHostAnySite.Image.SubmitImageByWeb(Wallid, filename, Session("UserName").ToString, Session("UserName").ToString, Session("userid").ToString, Session("UserName").ToString, ClassAppDetails.DBCS)
        If SubmitWall.Result = False Then
            LabelEm.Text = SubmitWall.My_Error_message
            LabelEm.Text = LabelEm.Text & vbNewLine & SubmitWall.Sys_Error_message
        Else
            ClassHostAnySite.User.User_AddImageId(Session("userid"), Wallid, ClassAppDetails.DBCS)
            LabelEm.Text = "Profile Picture Changed Successfully."

            Response.Redirect(Request.RawUrl)
        End If
    End Sub

    Protected Sub ButtonUploadBanner_Click(sender As Object, e As EventArgs)
        Dim SubmitWall As ClassHostAnySite.Image.StructureImage
        Dim Wallid As String = ClassHostAnySite.Image.NewimageId(ClassAppDetails.DBCS)

        'upload image
        Dim filename As String = ClassHostAnySite.HostAnySite.ConvertSpace2Dass(Session("UserName").ToString.Trim) & "-" & Wallid & ".jpg"
        LabelEm.Text = ""

        ''''''''''''''''''
        If FileUpload2.HasFile = True Then
            Dim fileExt As String
            fileExt = System.IO.Path.GetExtension(FileUpload2.FileName)

            If Not (fileExt.ToLower = ".jpg") Then
                LabelEm.Text = "Only .Jpg files allowed!"
                Exit Sub
            End If
        Else
            LabelEm.Text = "You have not specified a Jpg file to upload."
            Exit Sub
        End If
        ''''''''''''''''''''''
        FileUpload2.PostedFile.SaveAs(Server.MapPath("~/storage/Image/" & filename))

        SubmitWall = ClassHostAnySite.Image.SubmitImageByWeb(Wallid, filename, Session("UserName").ToString, Session("UserName").ToString, Session("userid").ToString, Session("UserName").ToString, ClassAppDetails.DBCS)
        If SubmitWall.Result = False Then
            LabelEm.Text = SubmitWall.My_Error_message
            LabelEm.Text = LabelEm.Text & vbNewLine & SubmitWall.Sys_Error_message
        Else
            ClassHostAnySite.User.User_AddBannerImageId(Session("userid"), Wallid, ClassAppDetails.DBCS)
            LabelEm.Text = "Profile banner changed successfully."

            Response.Redirect(Request.RawUrl)
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="row">
        <div class="col-md-3 col-sm-3">
        <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
    </div>
     <div class="col-md-9 col-sm-9">
            <div class="row ">
                <div class="panel panel-default">
                    <div class="panel-heading">Change your profile Details</div>
                    <div class="list-group ">
                        <div class="list-group-item disabled ">User Name :</div>
                        <div class="list-group-item">
                            <div class="form-inline">
                                <div class="form-group">
                                    <asp:TextBox ID="TextBoxUserName" CssClass="form-control " runat="server"></asp:TextBox>
                                </div>

                                <div class="checkbox">
                                    <asp:Label ID="LabelUsernameEM" runat="server" Text=""></asp:Label>
                                </div>
                                <button type="submit" class="btn btn-default">Submit</button>
                            </div>
                        </div>
                        <div class="list-group-item disabled ">Profile Picture :</div>
                        <div class="list-group-item">

                            <div class="media">
                                <asp:Image ID="Image1" runat="server" Width="95px" CssClass="pull-left" />
                                <div class="media-body">
                                    <div class="form-group ">
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                    </div>
                                    <div class="form-group ">
                                        <asp:Button ID="ButtonSubmit" runat="server" Text="Change Image"
                                            Width="175px" Height="27px" OnClick="ButtonSubmit_Click" />
                                    </div>
                                    <div class="form-group ">
                                        <asp:Label ID="LabelEm" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="list-group-item disabled ">Profile Banner :</div>
                        <div class="list-group-item">
                            <div class="form">
                                <div class="form-group ">
                                    <asp:Image ID="ImageBanner" runat="server" CssClass="img-responsive " />
                                </div>
                                <div class="form-group clearfix">
                                    <div class="pull-left ">
                                        <asp:FileUpload ID="FileUpload2" runat="server" />
                                    </div>
                                    <div class="pull-right ">
                                        <asp:Button ID="ButtonUploadBanner" runat="server" Text="Change Image"
                                            CssClass="btn btn-info " OnClick="ButtonUploadBanner_Click" />
                                    </div>
                                </div>

                                <div class="form-group ">
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>

