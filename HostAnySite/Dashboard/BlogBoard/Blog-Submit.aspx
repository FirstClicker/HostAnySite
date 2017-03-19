<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Import Namespace="HtmlAgilityPack" %>
<%@ Register Src="~/app_controls/web/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/app_controls/web/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>


<script runat="server">

    Protected Sub ButtonSubmit_Click(sender As Object, e As EventArgs)
        If Trim(TextBoxHeading.Text) = "" Then
            LabelEm.Text = "Please provide a heading to your blog."
            Exit Sub
        End If

        Dim htmldoc As New HtmlDocument
        htmldoc.LoadHtml(HtmlEditor1.Text)

        If Trim(htmldoc.DocumentNode.InnerText) = "" Then
            LabelEm.Text = "Please edit the blog. Blog body can't be empty."
            Exit Sub
        End If


        ' upload image
        Dim Submitpic As ClassHostAnySite.Image.StructureImage
        Dim Wallid As String = ClassHostAnySite.Image.NewimageId(ClassAppDetails.DBCS)
        Dim filename As String = ClassHostAnySite.HostAnySite.ConvertSpace2Dass(Trim(TextBoxHeading.Text)) & "-" & Wallid & ".jpg"
        LabelEm.Text = ""

        If FileUpload1.HasFile = True Then
            Dim fileExt As String
            fileExt = System.IO.Path.GetExtension(FileUpload1.FileName)

            If Not (fileExt.ToLower = ".jpg") Then
                LabelEm.Text = "Only .Jpg files allowed!"
                Exit Sub
            End If

            FileUpload1.PostedFile.SaveAs(Server.MapPath("~/storage/Image/" & filename))
            Dim imgsiz As Drawing.Size = ClassHostAnySite.Image.ImageResolution(Server.MapPath("~/storage/Image/" & filename))
            ' If imgsiz.Height * 2 > imgsiz.Width Then
            ' System.IO.File.Delete(Server.MapPath("~/storage/Image/" & filename))
            ' LabelEm.Text = "JPG image with 2:1 width height ratio allowed."
            ' Exit Sub
            ' End If
            Submitpic = ClassHostAnySite.Image.SubmitImageByWeb(Wallid, filename, TextBoxHeading.Text, TextBoxHeading.Text, Session("UserID"), TextBoxHeading.Text, ClassAppDetails.DBCS)

            If Submitpic.Result = False Then
                LabelEm.Text = Submitpic.My_Error_message
                Exit Sub
            Else
                ' success 
                Labelimageid.Text = Wallid
            End If
        Else
            Labelimageid.Text = 0
        End If
        ''''''''''''''''''''''
        'up load image



        Dim heighlight As String = Mid(htmldoc.DocumentNode.InnerText, 1, 1000)

        Dim submitblog As ClassHostAnySite.Blog.StructureBlog = ClassHostAnySite.Blog.Blog_Add(TextBoxHeading.Text, heighlight, HtmlEditor1.Text, 0, Labelimageid.Text, Session("UserId"), ClassAppDetails.DBCS)
        If submitblog.Result = False Then
            LabelEm.Text = "Failed to submit"
        Else
            Dim NewBlogURL As String = "http://" & Request.Url.Host & "/blog/" & submitblog.BlogId & "/" & ClassHostAnySite.HostAnySite.ConvertSpace2Dass(submitblog.Heading)

            'post to user wall
            Dim submituserwall2 As ClassHostAnySite.UserWall.StructureUserWall
            submituserwall2 = ClassHostAnySite.UserWall.UserWall_Add(" ", "A new blog posted", Labelimageid.Text, Session("userId"), Session("userid"), 0, 0, "active", ClassAppDetails.DBCS, ClassHostAnySite.UserWall.PreviewTypeEnum.MediaView, TextBoxHeading.Text.Replace("'", "''"), NewBlogURL.Replace("'", "''"), Mid(submitblog.Highlight, 1, 500).Replace("'", "''"))


            TextBoxHeading.Text = ""
            HtmlEditor1.Text = ""
            LabelEm.Text = "Submitted"
        End If

    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then

        End If
    End Sub



</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="row">
        <div class="col-md-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-lg-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Write New Blog&nbsp;
                </div>
                <div class="panel-body">

                    <div class="form-group">
                        <div class="Google-transliterate-Way2blogging">
                            <asp:TextBox ID="TextBoxHeading" runat="server" CssClass="form-control" placeholder="Blog Heading"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group clearfix ">
                        <div class="pull-left">
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                            <asp:Label ID="Labelimageid" runat="server" Visible="False">0</asp:Label>
                        </div>
                        <div class="pull-right ">[Only JPG image.]</div>
                    </div>

                    <div class="form-group">

                        <asp:TextBox ID="HtmlEditor1" runat="server" CssClass="form-control" Height="238px" TextMode="MultiLine"></asp:TextBox>

                        <div style="visibility: hidden">
                            <cc1:HtmlEditorExtender ID="TextBoxPoem_HtmlEditorExtender" runat="server" BehaviorID="TextBoxPoem_HtmlEditorExtender" EnableSanitization="False" TargetControlID="HtmlEditor1">
                                <Toolbar>
                                    <cc1:Undo />
                                    <cc1:Redo />
                                    <cc1:Bold />
                                    <cc1:Italic />
                                    <cc1:Underline />
                                    <cc1:StrikeThrough />
                                    <cc1:Subscript />
                                    <cc1:Superscript />
                                    <cc1:JustifyLeft />
                                    <cc1:JustifyCenter />
                                    <cc1:JustifyRight />
                                    <cc1:JustifyFull />
                                    <cc1:RemoveFormat />
                                </Toolbar>
                            </cc1:HtmlEditorExtender>
                        </div>
                    </div>
                    <div class="form-group ">
                        <asp:Label ID="LabelEm" runat="server" Text="" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                    </div>
                    <div class="form-group">
                        <div class="pull-left ">
                            <asp:CheckBox ID="CheckBoxAuthorConfirm" runat="server" Text="This blog is writen by me." />
                        </div>
                        <div class="pull-right ">
                            <asp:Button ID="ButtonSubmit" runat="server" CssClass="btn btn-info " OnClick="ButtonSubmit_Click" Text="Submit" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>

