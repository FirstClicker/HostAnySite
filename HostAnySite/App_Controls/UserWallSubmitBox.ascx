<%@ Control Language="VB" ClassName="UserWallSubmitBox" %>
<%@ Register Src="~/app_controls/UserSignInNeededButton.ascx" TagPrefix="uc1" TagName="UserSignInNeededButton" %>
<%@ Register Src="~/app_controls/ImageUploader.ascx" TagPrefix="uc1" TagName="ImageUploader" %>
<%@ Register Src="~/app_controls/ImagesSelector.ascx" TagPrefix="uc1" TagName="ImagesSelector" %>


<script runat="server">
    Public Event WallPost_Success As EventHandler
    Public Event WallPost_Failed As EventHandler
    Public Event PostBackNotifier As EventHandler

    Public Property Collapse_Status() As String
        Get
            Return PanelCollapseStatusBox.CssClass
        End Get
        Set(ByVal value As String)
            PanelCollapseStatusBox.CssClass = value
        End Set
    End Property

    Public Property Wall_UserId() As String
        Get
            Return LabelWall_UserId.Text
        End Get
        Set(ByVal value As String)
            LabelWall_UserId.Text = value
        End Set
    End Property



    Protected Sub SubmitStatus_Click(sender As Object, e As EventArgs)
        If Trim(Session("userid")) = "" Then
            LabelStatusEm.Text = "You must be logged in to comment..."
            PanelPostlinkDetails.CssClass = "card-collapse collapse show"
            Exit Sub
        End If



        If ImageUploader.ImageID = 0 And Trim(TextBoxStatus.Text) = "" And TextBoxLink.Enabled = True Then
            LabelStatusEm.Text = "Nothing to post or upload."
            PanelPostlinkDetails.CssClass = "card-collapse collapse show"
            Exit Sub
        End If

        If Wall_UserId = 0 Then
            Wall_UserId = Val(Trim(Session("userid")))
        End If


        Dim heading As String
        Dim wallpostid As String = FirstClickerService.Version1.UserWall.NewUserWallId(WebAppSettings.DBCS)
        Dim submituserwall As FirstClickerService.Version1.UserWall.StructureUserWall

        If ImageUploader.ImageID <> 0 Then
            FirstClickerService.Version1.Image.Image_UpdateStatus(ImageUploader.ImageID, FirstClickerService.Version1.Image.StatusEnum.Visible, WebAppSettings.DBCS)
            heading = "uploaded an image"
        Else
            heading = "posted"
        End If

        If TextBoxLink.Enabled = False Then
            submituserwall = FirstClickerService.Version1.UserWall.UserWall_Add(heading, TextBoxStatus.Text, ImageUploader.ImageID, Session("userId"), Wall_UserId, FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, FirstClickerService.Version1.UserWall.PreviewTypeEnum.ExternalLink, "0", LabelLinkheading.Text, TextBoxLink.Text, LabelLinkDesc.Text, ImagesSelector.SelectedImageURL)
        Else
            submituserwall = FirstClickerService.Version1.UserWall.UserWall_Add(heading, TextBoxStatus.Text, ImageUploader.ImageID, Session("userId"), Wall_UserId, FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS)
        End If

        If submituserwall.Result = False Then
            LabelStatusEm.Text = "Failed to submit post."
            PanelPostlinkDetails.CssClass = "card-collapse collapse show"
        Else
            TextBoxStatus.Text = ""
            LabelStatusEm.Text = ""
            Response.Redirect(Request.Url.ToString)
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Session("username") = "" Then
            UserSignInNeededButton.Visible = True
            UserSignInNeededButton.UserNotificationMsg = "You must be logged in to comment..."
            PanelSubmitPost.Visible = False
            PanelPostBody.Visible = False
        Else
            UserSignInNeededButton.Visible = False
            PanelSubmitPost.Visible = True
            PanelPostBody.Visible = True
        End If
    End Sub

    Protected Sub ButtonlinkValidataion_Click(sender As Object, e As EventArgs)
        Dim linkdetails As ClassURLlinkValidator.StructureURL = ClassURLlinkValidator.LinkDetails(TextBoxLink.Text)
        If linkdetails.Result = True Then
            LabelLinkDesc.Text = linkdetails.Description
            LabelLinkheading.Text = linkdetails.Title
            ImagesSelector.ImageURL = linkdetails.ImageURL
            TextBoxLink.Enabled = False
        Else
            LabelLinkDesc.Text = "failed"
        End If
        PanelPostlinkDetails.CssClass = "card-collapse collapse show"

    End Sub

    Protected Sub ImageUploader_PostBackNotifier(sender As Object, e As EventArgs)
        PanelCollapseStatusBox.CssClass = "card-collapse collapse show"
        PanelPostPicture.CssClass = "card-collapse collapse show"
    End Sub

</script>

<asp:Label ID="LabelWall_UserId" runat="server" Text="0" Visible="False"></asp:Label>
<div class="card border-info BoxEffect6 mt-2 mb-2">
    <div class="card-header bg-info">
        <i class="fas fa-share-alt-square"></i>&nbsp;<a href="#<%=PanelCollapseStatusBox.ClientID  %>" class="text-white Change-DropDown-Icon" data-toggle="collapse">Share Status<i class="fa fa-chevron-circle-down float-right"></i></a>
    </div>
    <asp:Panel runat="server" ID="PanelCollapseStatusBox" CssClass="card-collapse collapse">
        <asp:panel runat ="server" ID="PanelPostBody"  cssclass="card-body">
            <div class="form-group">
                <label for="TextBoxStatus" class="sr-only">Status</label>
                <asp:TextBox ID="TextBoxStatus" runat="server" CssClass="form-control" placeholder="Whats you want to share?" TextMode="MultiLine"></asp:TextBox>
            </div>
            <asp:Panel runat="server" CssClass="card-collapse collapse" ID="PanelPostPicture">
                <uc1:ImageUploader runat="server" ID="ImageUploader" OnPostBackNotifier="ImageUploader_PostBackNotifier" />
            </asp:Panel>
            <asp:Panel runat="server" CssClass="card-collapse collapse" ID="PanelPostlink">
                <div class="card">
                    <div class="card-body">
                        <asp:UpdatePanel ID="UpdatePanelLink" runat="server" UpdateMode="Always">
                            <ContentTemplate>
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">Valid URL
                                            </span>
                                        </div>
                                        <asp:TextBox ID="TextBoxLink" CssClass="form-control" placeholder="Vlid URL" runat="server"></asp:TextBox>
                                        <span class="input-group-append">
                                            <asp:Button ID="ButtonlinkValidataion" CssClass="form-control" runat="server" Text="Validate" OnClick="ButtonlinkValidataion_Click" />
                                        </span>
                                    </div>
                                    <asp:Panel runat="server" CssClass="card-collapse collapse" ID="PanelPostlinkDetails">
                                        <div class="panel">
                                            <div class="card-body">
                                                <div class="media">
                                                    <div class="media-left mr-2" style="width: 110px;">
                                                        <uc1:ImagesSelector runat="server" ID="ImagesSelector" />
                                                    </div>
                                                    <div class="media-body">
                                                        <h4>
                                                            <asp:Label ID="LabelLinkheading" runat="server" Text=""></asp:Label>
                                                        </h4>
                                                        <asp:Label ID="LabelLinkDesc" runat="server" Text=""></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanelLink">
                            <ProgressTemplate>
                                <div>
                                    <div class="text-center">
                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/Image/spinner.gif" Width="25" />
                                    </div>
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </div>
            </asp:Panel>
            <div class="form-group">
                <asp:Label ID="LabelStatusEm" runat="server" ForeColor="Maroon"></asp:Label>
            </div>
        </asp:panel>
        <asp:Panel runat="server" ID="PanelSubmitPost" CssClass="card-footer clearfix">
            <div class="float-right">
                <asp:Panel runat="server" ID="PanelCointainer" CssClass="btn-group btn-group-sm float-right">
                    <asp:Button runat="server" ID="SubmitStatus" type="button" class="btn btn-info btn-sm" Text="Share Status" OnClick="SubmitStatus_Click" />

                    <div class="btn-group dropdown">
                        <button runat="server" id="buttonDropdown" type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">
                        </button>
                        <div class="dropdown-menu dropdown-menu-right">
                            <div class="dropdown-item">
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Dashboard/question/ask.aspx"><i class="fas fa-question"></i>&nbsp;Ask Question</asp:HyperLink>
                            </div>
                            <div class="dropdown-item">
                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Dashboard/Blog/write.aspx"><i class="fab fa-blogger"></i>&nbsp;Share Blog</asp:HyperLink>
                            </div>
                              <div class="dropdown-item">
                                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Dashboard/Forum/Create.aspx"><i class="fab fa-foursquare"></i>&nbsp;Create Forum</asp:HyperLink>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>
            <div class="btn-group float-left">
                <button data-toggle="collapse" type="button" class="btn btn-sm btn-outline-dark" data-target="#<%=PanelPostPicture.ClientID%>"><i class="far fa-image"></i></button>
                <button data-toggle="collapse" type="button" class="btn btn-sm btn-outline-dark" data-target="#<%=PanelPostlink.ClientID%>"><i class="fas fa-link"></i></button>
            </div>
        </asp:Panel>
        <uc1:UserSignInNeededButton runat="server" ID="UserSignInNeededButton" />
    </asp:Panel>
</div>
