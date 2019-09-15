<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Import Namespace="HtmlAgilityPack" %>

<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>
<%@ Register Src="~/App_Controls/ImageUploader.ascx" TagPrefix="uc1" TagName="ImageUploader" %>
<%@ Register Src="~/App_Controls/TagHolderMax5.ascx" TagPrefix="uc1" TagName="TagHolderMax5" %>


<script runat="server">
    ' version 26/08/2018 # 4.27 AM


    Protected Sub ButtonSubmit_Click(sender As Object, e As EventArgs)
        If TagHolderMax5.TagIds = "0" Then
            LabelEm.Text = "Atleast 1 tag is neeed to create comparison list."
            Exit Sub
        End If

        If Trim(TextBoxHeading.Text) = "" Then
            LabelEm.Text = "Please provide a heading to your blog."
            Exit Sub
        End If

        Dim htmldoc As New HtmlDocument
        htmldoc.LoadHtml(HtmlEditor1.Text)

        If Trim(htmldoc.DocumentNode.InnerText) = "" Then
            LabelEm.Text = "Blog body can't be empty."
            Exit Sub
        End If


        ' Publish image
        If ImageUploader.ImageID <> 0 Then
            FirstClickerService.Version1.Image.Image_UpdateStatus(ImageUploader.ImageID, FirstClickerService.Version1.Image.StatusEnum.Visible, WebAppSettings.DBCS)
        End If
        'Publish image


        Dim heighlight As String = Mid(htmldoc.DocumentNode.InnerText, 1, 600)

        Dim submitblog As FirstClickerService.Version1.Blog.StructureBlog = FirstClickerService.Version1.Blog.Blog_Add(TextBoxHeading.Text, heighlight, HtmlEditor1.Text, FirstClickerService.Version1.Blog.StatusEnum.Visible, ImageUploader.ImageID, Session("UserId"), WebAppSettings.DBCS)
        If submitblog.Result = False Then
            LabelEm.Text = "Failed to submit blog"

            'report error
            If submitblog.EX_ReportNeed = True Then
                FirstClickerService.Version1.ReportError.ReportError(submitblog.Ex, WebAppSettings.DBCS)
            End If
        Else

            'xxxxxxxxxxxxxxx submit List Tag xxxxxxxxxxxxxxxxxxxx 

            If TagHolderMax5.TagIds = "0" Then
                ' no tag
            Else
                Dim tagids As String() = TagHolderMax5.TagIds.Split(",")

                Dim i As Integer = 0
                For i = 0 To tagids.Length - 1
                    Dim ListTagsubmit As FirstClickerService.Version1.TagOfBlog.StructureTagOfBlog = FirstClickerService.Version1.TagOfBlog.AddTagOfBlog(tagids(i), submitblog.BlogId, Val(Session("UserId")), WebAppSettings.DBCS)
                Next
            End If


            If CheckBoxPostToMyWall.Checked = True Then  'post to user wall
                Dim submituserwall2 As FirstClickerService.Version1.UserWall.StructureUserWall
                submituserwall2 = FirstClickerService.Version1.UserWall.UserWall_Add("Posted New Blog", " ", 0, Session("userId"), Session("userid"), FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, FirstClickerService.Version1.UserWall.PreviewTypeEnum.Blog, submitblog.BlogId)
            End If


            TextBoxHeading.Text = ""
            HtmlEditor1.Text = ""
            LabelEm.Text = "Blog submitted"

            Response.Redirect("~/blog/" & FirstClickerService.Common.ConvertSpace2Dass(submitblog.Heading) & "/" & submitblog.BlogId)
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
            <div class="card  mt-2 BoxEffect6 ">
                <div class="card-header clearfix">
                   <div class="float-right ">
                        <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Dashboard/Blog/MyBlogs.aspx"  role="button" runat="server">My Blogs</asp:HyperLink>
                    </div>
                    <h5 class="card-title m-0 ">
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Dashboard/Blog/write.aspx">Write new Blog</asp:HyperLink>
                    </h5>
                </div>
                <div class="card-body">

                    <div class="form-group">
                        <label>Blog Heading</label>
                        <asp:TextBox ID="TextBoxHeading" runat="server" CssClass="form-control" placeholder="Blog Heading" TextMode="MultiLine" Rows="2"></asp:TextBox>

                    </div>

                    <div class="form-group clearfix ">
                        <label>Blog Image</label>
                        <uc1:ImageUploader runat="server" ID="ImageUploader" />
                    </div>

                    <div class="form-group">
                        <label>Blog Content</label>
                        <asp:TextBox ID="HtmlEditor1" runat="server" CssClass="form-control" Height="238px" TextMode="MultiLine"></asp:TextBox>
                        <div style="visibility: hidden">
                            <ajaxToolkit:HtmlEditorExtender runat="server" BehaviorID="HtmlEditor1_HtmlEditorExtender" TargetControlID="HtmlEditor1" ID="HtmlEditor1_HtmlEditorExtender">
                                <Toolbar>
                                    <ajaxToolkit:Undo />
                                    <ajaxToolkit:Redo />

                                    <ajaxToolkit:Bold />
                                    <ajaxToolkit:Italic />
                                    <ajaxToolkit:Underline />
                                    <ajaxToolkit:StrikeThrough />
                                    <ajaxToolkit:Subscript />
                                    <ajaxToolkit:Superscript />

                                    <ajaxToolkit:FontNameSelector />
                                    <ajaxToolkit:FontSizeSelector />
                                    <ajaxToolkit:ForeColorSelector />
                                    <ajaxToolkit:BackgroundColorSelector />

                                    <ajaxToolkit:JustifyLeft />
                                    <ajaxToolkit:JustifyCenter />
                                    <ajaxToolkit:JustifyRight />
                                    <ajaxToolkit:JustifyFull />

                                    <ajaxToolkit:CreateLink />
                                    <ajaxToolkit:UnLink />

                                    <ajaxToolkit:RemoveFormat />

                                </Toolbar>
                            </ajaxToolkit:HtmlEditorExtender>
                        </div>
                    </div>
                    <div class="form-group ">
                        <asp:Label ID="LabelEm" runat="server" Text="" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                    </div>

                    <uc1:TagHolderMax5 runat="server" ID="TagHolderMax5" />

                </div>

                <div class="card-footer clearfix ">
                    <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass="text-info text-primary" Text=" Share on my wall" runat="server" Checked="True" />
                    <div class="float-right ">
                        <asp:Button ID="ButtonSubmit" runat="server" CssClass="btn btn-info" OnClick="ButtonSubmit_Click" Text="Submit Blog" />
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

