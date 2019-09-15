<%@ Control Language="VB" ClassName="UserWallOnPostSubmitBox" %>
<%@ Register Src="~/app_controls/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/app_controls/ImageUploader.ascx" TagPrefix="uc1" TagName="ImageUploader" %>
<%@ Register Src="~/app_controls/UserSignInNeededButton.ascx" TagPrefix="uc1" TagName="UserSignInNeededButton" %>
<%@ Register Src="~/App_Controls/ImagesSelector.ascx" TagPrefix="uc1" TagName="ImagesSelector" %>



<%@ Import Namespace="System.ComponentModel" %>
<script runat="server">
    ' version 01/10/2018 #1.27

    Public Event PostedSuccessfully_Notifier As EventHandler

    Public Property Wall_UserId() As String
        Get
            Return LabelWall_UserId.Text
        End Get
        Set(ByVal value As String)
            LabelWall_UserId.Text = value
        End Set
    End Property

    Public Property HeadingEndPart() As String
        Get
            Return LabelHeadingEndPart.Text
        End Get
        Set(ByVal value As String)
            LabelHeadingEndPart.Text = value
        End Set
    End Property


    <DefaultValue(FirstClickerService.Version1.UserWall.PreviewTypeEnum.None)>
    Public Property PreviewType() As FirstClickerService.Version1.UserWall.PreviewTypeEnum
        Get
            If Trim(LabelPreviewType.Text) <> "" Then
                Return [Enum].Parse(GetType(FirstClickerService.Version1.UserWall.PreviewTypeEnum), LabelPreviewType.Text, True)
            Else
                Return FirstClickerService.Version1.UserWall.PreviewTypeEnum.None
            End If

        End Get
        Set(ByVal value As FirstClickerService.Version1.UserWall.PreviewTypeEnum)
            LabelPreviewType.Text = value.ToString
        End Set
    End Property



    Public Property Preview_ID() As String
        Get
            Return LabelPreview_ID.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_ID.Text = value
        End Set
    End Property





    Public Property Preview_BodyText() As String
        Get
            Return LabelPreview_BodyText.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_BodyText.Text = value
        End Set
    End Property


    Protected Sub SubmitStatus_Click(sender As Object, e As EventArgs)
        If Trim(Session("userid")) = "" Then
            LabelStatusEm.Text = "Please login To post."
            Exit Sub
        End If

        If ImageUploader.ImageID = 0 And Trim(TextBoxStatus.Text) = "" And TextBoxLink.Enabled = True Then
            LabelStatusEm.Text = "Nothing to post or upload."
            PanelPostlinkDetails.CssClass = "card-collapse collapse"
            Exit Sub
        End If


        Dim MyWall_UserId As String
        Dim MyPreview_Id As String

        If Wall_UserId = "22" Then
            MyWall_UserId = 0
        Else
            MyWall_UserId = Wall_UserId
        End If

        If Preview_ID = "22" Then
            MyPreview_Id = 0
        Else
            MyPreview_Id = Preview_ID
        End If


        Dim heading As String
        Dim wallpostid As String = FirstClickerService.Version1.UserWall.NewUserWallId(WebAppSettings.DBCS)
        Dim submituserwall As FirstClickerService.Version1.UserWall.StructureUserWall

        If ImageUploader.ImageID <> 0 Then
            FirstClickerService.Version1.Image.Image_UpdateStatus(ImageUploader.ImageID, FirstClickerService.Version1.Image.StatusEnum.Visible, WebAppSettings.DBCS)

            heading = "posted image"
            If Trim(HeadingEndPart) <> "" Then
                heading = heading + " " + HeadingEndPart
            End If


            submituserwall = FirstClickerService.Version1.UserWall.UserWall_Add(heading, TextBoxStatus.Text, ImageUploader.ImageID, Session("userId"), MyWall_UserId, FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, PreviewType, Preview_ID)
        Else
            heading = "commented"
            If Trim(HeadingEndPart) <> "" Then
                heading = heading + " " + HeadingEndPart
            End If

            submituserwall = FirstClickerService.Version1.UserWall.UserWall_Add(heading, TextBoxStatus.Text, ImageUploader.ImageID, Session("userId"), MyWall_UserId, FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, PreviewType, Preview_ID)
        End If

        If submituserwall.Result = False Then
            LabelStatusEm.Text = "Failed To submit post."
        Else
            If CheckBoxPostToMyWall.Checked = True Then
                Dim submituserwall2 As FirstClickerService.Version1.UserWall.StructureUserWall
                submituserwall2 = FirstClickerService.Version1.UserWall.UserWall_Add(heading, TextBoxStatus.Text, ImageUploader.ImageID, Session("userId"), Session("userid"), FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, PreviewType, Preview_ID)
            End If

            RaiseEvent PostedSuccessfully_Notifier(Me, EventArgs.Empty)

            TextBoxStatus.Text = ""
            LabelStatusEm.Text = ""

            ListViewNotification.DataBind()
        End If
    End Sub

    Protected Sub SqlDataSourceCommnet_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        If e.AffectedRows = 0 Then
            PanelCommentFooter.Visible = False
        End If
    End Sub

    Protected Sub ButtonlinkValidataion_Click(sender As Object, e As EventArgs)

    End Sub
</script>

<asp:Label ID="LabelWall_UserId" runat="server" Text="22" Visible="False"></asp:Label>
<asp:Label ID="LabelHeadingEndPart" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelPreviewType" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_ID" runat="server" Text="22" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_BodyText" runat="server" Text="" Visible="False"></asp:Label>

<div class="card BoxEffect6 mt-2 mb-2">
    <div class="card-header bg-info">
        <i class="fas fa-share-alt-square"></i>&nbsp;Comment
    </div>
    <div class="card-body">
        <div class="form-group">

            <label for="TextBoxStatus" class="sr-only">Status</label>
            <asp:TextBox ID="TextBoxStatus" runat="server" CssClass="form-control" placeholder="Whats you want to share?" TextMode="MultiLine"></asp:TextBox>
        </div>
        <asp:Panel runat="server" CssClass="card-collapse collapse" ID="PanelPostPicture">
            <uc1:ImageUploader runat="server" ID="ImageUploader" />
        </asp:Panel>
        <asp:Panel runat="server" CssClass="card-collapse collapse" ID="PanelPostlink">
            <div class="card">
                <div class="card-body">
                    <asp:UpdatePanel ID="UpdatePanelLink" runat="server" UpdateMode="Conditional">
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
                </div>
            </div>
        </asp:Panel>
        <div class="form-group">
            <asp:Label ID="LabelStatusEm" runat="server" ForeColor="Maroon"></asp:Label>
        </div>
    </div>
    <div class="card-footer clearfix">
        <div class="float-right">
            <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass="text-info text-muted" Text="Share on my wall" runat="server" Checked="true" />
            <asp:Button runat="server" ID="SubmitStatus" type="button" class="btn btn-sm btn-info" Text="Comment" OnClick="SubmitStatus_Click" />
        </div>
        <div class="btn-group float-left">
            <button data-toggle="collapse" type="button" class="btn btn-sm btn-outline-dark" data-target="#<%=PanelPostPicture.ClientID%>"><i class="far fa-image"></i></button>
            <button data-toggle="collapse" type="button" class="btn btn-sm btn-outline-dark" data-target="#<%=PanelPostlink.ClientID%>"><i class="fas fa-link"></i></button>
        </div>
    </div>
    <uc1:UserSignInNeededButton runat="server" ID="UserSignInNeededButton" />

<asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="Wallid" DataSourceID="SqlDataSourceCommnet">
    <EmptyDataTemplate>
        <div class="card">
            <div class="card-body">No one commented yet.</div>
        </div>
    </EmptyDataTemplate>

    <ItemTemplate>
        <uc1:UserWallEntry runat="server" ID="UserWallEntry" UserID='<%# Eval("UserID")%>' RoutUserName='<%# Eval("RoutUserName")%>' UserName='<%# Eval("UserName")%>' WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' WallHeading="Posted" WallDatetime='<%# Eval("postdate") %>' WallMessage='<%# Eval("Message") %>' WallPostImageURL='<%# "~/storage/image/" + Eval("PostImageFilename")%>' WallPostImageID='<%# Eval("ImageID")%>' WallID='<%# Eval("Wallid")%>' numberofcomment='<%# Eval("numberofcomment")%>' />
    </ItemTemplate>
    <LayoutTemplate>
        <hr class="m-2" />
        <div id="itemPlaceholderContainer" runat="server">
            <div runat="server" id="itemPlaceholder" />
        </div>
    </LayoutTemplate>
</asp:ListView>
<asp:SqlDataSource ID="SqlDataSourceCommnet" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
    SelectCommand="SELECT t.Wallid, t.heading, t.message, t.postdate, t.userid, t.imageid, t2.RoutUserName, t2.UserName, t1.ImageFileName as PostImageFilename, t3.ImageFileName as userimagefilename, count(TUWC.wallId) as numberofcomment  
                        FROM [Table_UserWall] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left join table_userwallComment TUWC on t.Wallid=TUWC.wallId
                        WHERE ((t.Wall_UserId ='0') and (t.preview_id = @Preview_ID))  
                        group by t.Wallid, t.heading, t.message, t.postdate, t.userid, t.imageid, t2.RoutUserName, t2.UserName, t1.ImageFileName , t3.ImageFileName  
                        ORDER BY t.[postdate] DESC"
    OnSelected="SqlDataSourceCommnet_Selected">
    <SelectParameters>
        <asp:ControlParameter ControlID="LabelPreview_ID" PropertyName="text" Name="Preview_ID" Type="String"></asp:ControlParameter>
    </SelectParameters>
</asp:SqlDataSource>


<asp:Panel runat="server" ID="PanelCommentFooter" CssClass="card-footer clearfix">
    <div class="float-right">
        <asp:DataPager runat="server" ID="DataPagerNotification" PagedControlID="ListViewNotification" PageSize="5">
            <Fields>
                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
            </Fields>
        </asp:DataPager>
    </div>
    <div class="float-Left"></div>
</asp:Panel>
</div>




