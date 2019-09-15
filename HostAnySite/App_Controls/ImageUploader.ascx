<%@ Control Language="VB" ClassName="ImageUploader" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Drawing.Imaging" %>
<%@ Import Namespace="System.Drawing.Drawing2D" %>
<%@ Register Src="~/App_Controls/TagOfImage.ascx" TagPrefix="uc1" TagName="TagOfImage" %>


<script runat="server">

    Public Event UploadCompleted As EventHandler
    Public Event UploadFailed As EventHandler
    Public Event PostBackNotifier As EventHandler

    <DefaultValue(0)>
    Public Property ImageID() As Long
        Get
            Return Val(LabelImageID.Text)
        End Get
        Set(ByVal value As Long)
            LabelImageID.Text = value
        End Set
    End Property

    Public Property ShowPublishButton() As Boolean
        Get
            Return PanelPublishFooter.Visible
        End Get
        Set(ByVal value As Boolean)
            PanelPublishFooter.Visible = value
            PanelHeader.Visible = value
        End Set
    End Property

    Public Property ImageName() As String
        Get
            Return TextBoximageheading.Text
        End Get
        Set(ByVal value As String)
            TextBoximageheading.Text = value
        End Set
    End Property

    Public Property ImageFileName() As String
        Get
            Return LabelImageFileName.Text
        End Get
        Set(ByVal value As String)
            LabelImageFileName.Text = value
        End Set
    End Property

    Public Property Imagewidth() As Integer
        Get
            Return Val(TW.Text)
        End Get
        Set(ByVal value As Integer)
            TW.Text = value
        End Set
    End Property

    Public Property Imageheight() As Integer
        Get
            Return Val(TH.Text)
        End Get
        Set(ByVal value As Integer)
            TH.Text = value
        End Set
    End Property


    Public Property ErrorMessage() As String
        Get
            Return lblError.Text
        End Get
        Set(ByVal value As String)
            lblError.Text = value
        End Set
    End Property

    <DefaultValue(False)> _
    Public Property UploadSuccess() As Boolean
        Get
            Return lblError.Enabled
        End Get
        Set(ByVal value As Boolean)
            lblError.Enabled = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Upload.Attributes("onchange") = "UploadFileFinal('" + Upload.ClientID + "', '" + btnUpload.ClientID + "');"
        ButtonAddImage.Attributes.Add("onclick", "chooseFile('" + Upload.ClientID + "');")
    End Sub


    Public Sub LoadExistingImage()
        If ImageID <> 0 Then
            Dim imagedetails As FirstClickerService.Version1.Image.StructureImage = FirstClickerService.Version1.Image.ImageDetails_BYID(ImageID, WebAppSettings.DBCS)
            If imagedetails.Result = True Then
                ImageName = imagedetails.ImageName
                ImageFileName = imagedetails.ImageFileName

                TextBoximageheading.Text = ImageName

                Dim imgsiz As Drawing.Size = FirstClickerService.Version1.Image.ImageResolution(Server.MapPath("~/storage/image/" + ImageFileName))
                TW.Text = imgsiz.Width
                TH.Text = imgsiz.Height

                imgCropped.ImageUrl = "~/storage/image/" + ImageFileName

                ButtonAddImage.Disabled = True
                ButtonAddImage.Visible = False

                ButtonRemoveImage.Enabled = True
                ButtonRemoveImage.Visible = True

                panelimagepreview.Visible = True

                TagOfImage.ImageId = imagedetails.ImageId
                TagOfImage.ImageUserId = imagedetails.userId
                UploadSuccess = True


                RaiseEvent UploadCompleted(Me, EventArgs.Empty)
                RaiseEvent PostBackNotifier(Me, EventArgs.Empty)
            Else
                ErrorMessage = "Failed to load extsting image."
                RaiseEvent PostBackNotifier(Me, EventArgs.Empty)
            End If
        End If
    End Sub

    Dim path As [String] = HttpContext.Current.Request.PhysicalApplicationPath + "storage/image/"
    Protected Sub btnUpload_Click(sender As Object, e As EventArgs)
        If Trim(Session("username")) = "" Then
            ErrorMessage = "Please sign in to upload image."
            RaiseEvent PostBackNotifier(Me, EventArgs.Empty)
            Exit Sub
        End If

        Dim FileOK As [Boolean] = False
        Dim FileSaved As [Boolean] = False

        Dim SubmitPic As FirstClickerService.Version1.Image.StructureImage
        Dim NewImageId As String = FirstClickerService.Version1.Image.NewImageId(WebAppSettings.DBCS)

        If Upload.HasFile Then
            Dim FileExtension As [String] = System.IO.Path.GetExtension(Upload.FileName).ToLower()

            ImageName = FirstClickerService.Common.ConvertDass2Space(Mid(Upload.FileName, 1, Len(Upload.FileName) - Len(FileExtension)))
            ImageFileName = FirstClickerService.Common.ConvertSpace2Dass(ImageName) & "-" & NewImageId & FileExtension

            Dim allowedExtensions As [String]() = {".png", ".jpg"}
            For i As Integer = 0 To allowedExtensions.Length - 1
                If FileExtension = allowedExtensions(i) Then
                    FileOK = True
                End If
            Next
        Else
            ErrorMessage = "Select a file to upload."
            RaiseEvent PostBackNotifier(Me, EventArgs.Empty)
            Exit Sub
        End If

        If FileOK Then
            Try
                Upload.PostedFile.SaveAs(path + ImageFileName)
                FileSaved = True
            Catch ex As Exception
                ErrorMessage = "Failed to upload file."
                'ClassReportError.reportError(ex, WebAppSettings.DBCS)
                RaiseEvent PostBackNotifier(Me, EventArgs.Empty)
                Exit Sub
            End Try
        Else
            ErrorMessage = "Cannot accept files of this type."
            RaiseEvent PostBackNotifier(Me, EventArgs.Empty)
            Exit Sub
        End If

        If FileSaved Then
            SubmitPic = FirstClickerService.Version1.Image.SubmitImageByWeb(NewImageId, ImageFileName, ImageName, ImageName, Session("UserID"), FirstClickerService.Version1.Image.StatusEnum.Unpublished, WebAppSettings.DBCS)
            If SubmitPic.Result = False Then
                ErrorMessage = "Failed to upload file due to sql error."

                FirstClickerService.Version1.ReportError.ReportError(SubmitPic.ex, WebAppSettings.DBCS)

                If IO.File.Exists(path + ImageFileName) Then
                    IO.File.Delete(path + ImageFileName)
                End If

                UploadSuccess = False
                'ClassReportError.reportError(SubmitPic.ex, WebAppSettings.DBCS)

                RaiseEvent UploadFailed(Me, EventArgs.Empty)
                RaiseEvent PostBackNotifier(Me, EventArgs.Empty)
                Exit Sub
            Else
                ' success 
                ErrorMessage = "Picture Uploaded.."
                ImageID = NewImageId

                TextBoximageheading.Text = ImageName

                Dim imgsiz As Drawing.Size = FirstClickerService.Version1.Image.ImageResolution(Server.MapPath("~/storage/image/" + ImageFileName))
                TW.Text = imgsiz.Width
                TH.Text = imgsiz.Height

                imgCropped.ImageUrl = "~/storage/image/" + ImageFileName

                ButtonAddImage.Disabled = True
                ButtonAddImage.Visible = False

                ButtonRemoveImage.Enabled = True
                ButtonRemoveImage.Visible = True

                panelimagepreview.Visible = True

                TagOfImage.ImageId = NewImageId
                TagOfImage.ImageUserId = Session("UserID")

                UploadSuccess = True


                RaiseEvent UploadCompleted(Me, EventArgs.Empty)
                RaiseEvent PostBackNotifier(Me, EventArgs.Empty)
            End If
        End If
    End Sub



    Protected Sub ButtonRemoveImage_Click(sender As Object, e As EventArgs)
        ResetControl2Starting()

        RaiseEvent PostBackNotifier(Me, EventArgs.Empty)
    End Sub

    Public Sub ResetControl2Starting()
        imgCropped.ImageUrl = ""

        UploadSuccess = False

        ImageID = 0
        ImageFileName = ""
        ImageName = ""

        ErrorMessage = "Chose a file to upload."

        panelimagepreview.Visible = False

        ButtonAddImage.Disabled = False
        ButtonAddImage.Visible = True

        ButtonRemoveImage.Enabled = False
        ButtonRemoveImage.Visible = False
    End Sub


    Protected Sub ButtonUpdateImageDetails_Click(sender As Object, e As EventArgs)
        Dim updateimgdetails As FirstClickerService.Version1.Image.StructureImage
        updateimgdetails = FirstClickerService.Version1.Image.Image_UpdateNameAndDescription(ImageID, TextBoximageheading.Text, TextBoxImageDerescption.Text, WebAppSettings.DBCS)

        'rename the image
    End Sub


    Protected Sub ButtonPublish_Click(sender As Object, e As EventArgs)
        Dim imgdetails As FirstClickerService.Version1.Image.StructureImage = FirstClickerService.Version1.Image.ImageDetails_BYID(ImageID, WebAppSettings.DBCS)
        If imgdetails.Status = FirstClickerService.Version1.Image.StatusEnum.Unpublished Then
            If FirstClickerService.Version1.Image.Image_UpdateStatus(ImageID, FirstClickerService.Version1.Image.StatusEnum.Visible, WebAppSettings.DBCS).Result = True Then
                ResetControl2Starting()
            End If
        End If
    End Sub
</script>
<script type="text/javascript">
    function chooseFile(id) {
        document.getElementById(id).click();
    };

    function UploadFileFinal(id1, id2) {
        if (document.getElementById(id1).value != '') {
            document.getElementById(id2).click();
        }
    };

</script>

<div style="display: none">
    <asp:FileUpload ID="Upload" runat="server" />
    <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" Text="Upload" />
    <asp:Label ID="LabelImageFileName" runat="server" Text=""></asp:Label>
    <asp:Label ID="LabelImageID" runat="server" Text="0"></asp:Label>
    <asp:Label ID="LabelUpload_validated" runat="server" Text=""></asp:Label>
</div>

<div class="card mb-2">
    <asp:Panel runat="server" ID="PanelHeader" CssClass="card-header" Visible="false">
        Upload Picture
    </asp:Panel>
    <asp:Panel runat="server" ID="panelimagepreview" CssClass="card-body" Visible="False">
        <asp:Panel runat="server" ID="PanelImageDetails" CssClass="row">
            <div class="col-lg-7 col-sm-7 col-12 pb-3">
                <asp:Image ID="imgCropped" runat="server" CssClass="img-fluid" Style="margin: 0 auto;" />
            </div>
            <div class="col-lg-5 col-sm-5 col-12 pb-3 pt-3 border-left">
                <div class="form-group">
                    <label class="col-form-label-sm">Image Name</label>
                    <asp:TextBox ID="TextBoximageheading" CssClass="form-control form-control-sm" placeholder="Image Title" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="col-form-label-sm">Image Description</label>
                    <asp:TextBox ID="TextBoxImageDerescption" CssClass="form-control form-control-sm" runat="server" placeholder="Image Description" TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label class="col-form-label-sm">Size [Width/Height]: </label>
                    [<asp:Label ID="TW" runat="server" Text="0" CssClass="small" />/<asp:Label ID="TH" runat="server" CssClass="small" Text="0" />]
                </div>

                <uc1:TagOfImage runat="server" ID="TagOfImage" />
                <hr class="m-2" />

                <div class="form-group">
                    <asp:Button ID="ButtonUpdateImageDetails" runat="server" Text="Update" CssClass="btn btn-sm btn-info float-right" OnClick="ButtonUpdateImageDetails_Click" />
                </div>
            </div>
        </asp:Panel>

    </asp:Panel>
    <div class="card-footer p-2 clearfix">
        <div class="float-left p-2 mr-2">
            <button runat="server" id="ButtonAddImage" type="button" class="btn btn-sm border">Add Image</button>
            <asp:Button ID="ButtonRemoveImage" runat="server" Text="Remove Image" CssClass="btn btn-sm border" Enabled="False" OnClick="ButtonRemoveImage_Click" Visible="False" />
        </div>
        <div class="p-2">
            <asp:Label ID="lblError" runat="server" Text="Chose jpg or png image to upload." />
        </div>
    </div>
    <asp:Panel runat="server" ID="PanelPublishFooter" CssClass="card-footer clearfix p-1" Visible="false">
        <div class="float-right">
            <asp:Button ID="ButtonPublish" runat="server" CssClass="btn btn-sm btn-info" Text="Publish" OnClick="ButtonPublish_Click" /></div>
        <div class="">
        </div>
    </asp:Panel>
</div>

