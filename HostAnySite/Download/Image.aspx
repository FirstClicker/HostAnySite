<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim RequestImagefilename As String = Request.QueryString("Imagefilename")
        Dim RequestImageresolution As String = Request.QueryString("resolution")

        If RequestImagefilename <> "" Then '-- if something was passed to the file querystring 

            Dim path As String = Server.MapPath("~/Storage/Image/" & RequestImagefilename) 'get file object as FileInfo  
            Dim file As System.IO.FileInfo = New System.IO.FileInfo(path) '-- if the file exists on the server  
            If file.Exists Then
                Dim ImageID As String = Mid(RequestImagefilename, Len(RequestImagefilename) - 11, 8)

                Dim actualfilename As String = file.Name
                Dim actualfilePath As String = file.FullName
                Dim actualfileLenth As String = file.Length.ToString()
                Dim ActualResolution As String = ""

                If RequestImageresolution <> "" Then
                    ActualResolution = "-" & Trim(RequestImageresolution)

                    Dim size As String() = RequestImageresolution.ToLower.Split("x")

                    Dim TempImageDetails As FirstClickerService.Version1.ImageTemp.StructureTempImageDetails = FirstClickerService.Version1.ImageTemp.Get_TempImageDetails(ImageID, size(1), size(0), WebAppSettings.DBCS)
                    If TempImageDetails.Result = False Then
                        'create and save tempwall
                        Dim NewTempImageId As String = FirstClickerService.Version1.ImageTemp.NewTempId(WebAppSettings.DBCS)
                        Dim submittempImage As FirstClickerService.Version1.ImageTemp.StructureTempImageDetails = FirstClickerService.Version1.ImageTemp.Submit_TempImageDetails(NewTempImageId, ImageID, size(1), size(0), WebAppSettings.DBCS)

                        Dim newsize As New Drawing.Size(Val(size(0)), Val(size(1)))
                        Dim Oldimage As Drawing.Image = Drawing.Image.FromFile(Server.MapPath("~/storage/image/") & RequestImagefilename)

                        Dim Resizeimage As FirstClickerService.Version1.Image.StructureImageFunction = FirstClickerService.Version1.Image.ResizeImage_WithTransparent(Oldimage, newsize, False)
                        If Resizeimage.result = True Then
                            Resizeimage.Image.Save(Server.MapPath("~/Storage/temp/" & NewTempImageId & file.Extension))
                        End If
                        Dim Finelfile As System.IO.FileInfo = New System.IO.FileInfo(Server.MapPath("~/Storage/temp/" & NewTempImageId & file.Extension)) '-- if the file exists on the server  
                        If Finelfile.Exists Then
                            actualfilePath = Finelfile.FullName
                            actualfileLenth = Finelfile.Length.ToString()
                        End If
                    Else
                        Dim Finelfile As System.IO.FileInfo = New System.IO.FileInfo(Server.MapPath("~/Storage/temp/" & TempImageDetails.TempID & file.Extension)) '-- if the file exists on the server  
                        If Finelfile.Exists Then
                            actualfilePath = Finelfile.FullName
                            actualfileLenth = Finelfile.Length.ToString()
                        End If
                    End If

                End If

                'set appropriate headers  
                Response.Clear()
                Response.AddHeader("Content-Disposition", "attachment; filename=" & actualfilename.Insert(Len(RequestImagefilename) - 4, ActualResolution))
                Response.AddHeader("Content-Length", actualfileLenth)
                Response.ContentType = "image/jpeg"
                Response.WriteFile(actualfilePath)
                Response.End()
            Else 'if file does not exist  

                LabelMessage.Text = "This file does not exist."
            End If 'nothing in the URL as HTTP GET  
        Else
            LabelMessage.Text = "Please provide a file to download."
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-12 ">
  <asp:Label ID="LabelMessage" runat="server" Text=""></asp:Label>
        </div>
    </div>
  
</asp:Content>

