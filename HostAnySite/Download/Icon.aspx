<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim RequestImagefilename As String = Request.QueryString("Imagefilename")
        Dim RequestImageresolution As String = Trim(Request.QueryString("resolution"))

        If RequestImagefilename <> "" Then '-- if something was passed to the file querystring 

            Dim PNGpath As String = Server.MapPath("~/Storage/image/" & RequestImagefilename) 'get file object as FileInfo  
            Dim PNGfile As System.IO.FileInfo = New System.IO.FileInfo(PNGpath) '-- if the file exists on the server  
            If PNGfile.Exists Then
                Dim ImageID As String = Mid(RequestImagefilename, Len(RequestImagefilename) - 11, 8)

                Dim actualfilename As String = PNGfile.Name
                Dim actualfilePath As String = PNGfile.FullName
                Dim actualfileLenth As String = PNGfile.Length.ToString()
                Dim ActualResolution As String = ""

                If RequestImageresolution = "" Then
                    RequestImageresolution = "64x64"
                End If

                Dim size As String() = RequestImageresolution.ToLower.Split("x")
                Dim TempIconDetails As FirstClickerService.Version1.ImageIcom.StructureTempIconDetails = FirstClickerService.Version1.ImageIcom.Get_TempIconDetails(ImageID, size(1), size(0), WebAppSettings.DBCS)
                If TempIconDetails.Result = False Then
                    Dim NewTempIconId As String = FirstClickerService.Version1.ImageIcom.NewTempId(WebAppSettings.DBCS)
                    TempIconDetails = FirstClickerService.Version1.ImageIcom.Submit_TempIconDetails(NewTempIconId, ImageID, size(1), size(0), WebAppSettings.DBCS)
                End If

                Dim ICOpath As String = Server.MapPath("~/Storage/Icon/" & TempIconDetails.TempID & ".ico") 'get file object as FileInfo  
                Dim ICOfile As System.IO.FileInfo = New System.IO.FileInfo(ICOpath) '-- if the file exists on the server  

                If ICOfile.Exists Then
                    'set appropriate headers  
                    Response.Clear()
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & ICOfile.Name)
                    Response.AddHeader("Content-Length", ICOfile.Length)
                    Response.ContentType = "image/x-icon"
                    Response.WriteFile(ICOfile.FullName)
                    Response.End()
                Else

                    FirstClickerService.png2icon.ConvertToIcon(PNGfile.FullName, Server.MapPath("~/Storage/Icon/" & TempIconDetails.TempID & ".ico"), size(1))
                    Dim ICOfilenew As System.IO.FileInfo = New System.IO.FileInfo(ICOpath) '-- if the file exists on the server  

                    Response.Clear()
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & ICOfilenew.Name)
                    Response.AddHeader("Content-Length", ICOfilenew.Length)
                    Response.ContentType = "image/x-icon"
                    Response.WriteFile(ICOfilenew.FullName)
                    Response.End()

                End If

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
    <asp:Label ID="LabelMessage" runat="server" Text="Label"></asp:Label>
</asp:Content>

