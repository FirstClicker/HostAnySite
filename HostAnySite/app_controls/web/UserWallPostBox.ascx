<%@ Control Language="VB" ClassName="UserWallPostBox" %>

<script runat="server">
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
            LabelStatusEm.Text = "Please login to post."
            Exit Sub
        End If

        Dim MyWall_UserId As String
        If Wall_UserId = "22" Then
            MyWall_UserId = 0
        Else
            MyWall_UserId = Wall_UserId
        End If


        Dim WallImageid As String
        Dim heading As String
        Dim wallpostid As String = ClassHostAnySite.UserWall.NewUserWallId(ClassAppDetails.DBCS)

        ' upload image
        If FileUpload1.HasFile = True Then
            Dim SubmitWall As ClassHostAnySite.Image.StructureImage
            WallImageid = ClassHostAnySite.Image.NewimageId(ClassAppDetails.DBCS)
            Dim filename As String = WallImageid & ".jpg"
            LabelStatusEm.Text = ""

            Dim fileExt As String = System.IO.Path.GetExtension(FileUpload1.FileName)
            If Not (fileExt.ToLower = ".jpg") Then
                LabelStatusEm.Text = "Only .Jpg files allowed!"
                Exit Sub
            End If

            FileUpload1.PostedFile.SaveAs(Server.MapPath("~/storage/Image/" & filename))
            SubmitWall = ClassHostAnySite.Image.SubmitImageByWeb(WallImageid, filename, Session("username") & " wall post", Session("username") & " wall post", Session("UserID"), Session("username"), ClassAppDetails.DBCS)

            If SubmitWall.Result = False Then
                LabelStatusEm.Text = SubmitWall.My_Error_message
                Exit Sub
            Else
                ' success
                heading = "posted image"
            End If
        Else
            WallImageid = 0
            heading = "posted"
        End If
        ''''''''''''''''''''''
        'up load image

        Dim submituserwall As ClassHostAnySite.UserWall.StructureUserWall

        If WallImageid = 0 Then
            submituserwall = ClassHostAnySite.UserWall.UserWall_Add(heading, TextBoxStatus.Text, WallImageid, Session("userId"), MyWall_UserId, "0", "0", "active", ClassAppDetails.DBCS)
        Else
            submituserwall = ClassHostAnySite.UserWall.UserWall_Add(heading, TextBoxStatus.Text, WallImageid, Session("userId"), MyWall_UserId, "0", WallImageid, "active", ClassAppDetails.DBCS)
        End If

        If submituserwall.Result = False Then
            LabelStatusEm.Text = "Failed to submit post."
        Else
            TextBoxStatus.Text = ""
            LabelStatusEm.Text = ""

            Response.Redirect(Request.Url.ToString)
        End If
    End Sub
</script>
<div class="panel panel-default">
    <div class="panel-heading ">
        Update Status
          <asp:Label ID="LabelWall_UserId" runat="server" Text="22" Visible="False"></asp:Label>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="TextBoxStatus" class="sr-only">Status</label>
            <asp:TextBox ID="TextBoxStatus" runat="server" CssClass="form-control" placeholder="Whats you want to share?" TextMode="MultiLine"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Label ID="LabelStatusEm" runat="server" ForeColor="Maroon"></asp:Label>
        </div>
    </div>
    <div class="panel-footer clearfix">
        <div class="pull-right">
            <asp:Button runat="server" ID="SubmitStatus" type="button" class="btn btn-info" Text="Post" OnClick="SubmitStatus_Click" />
        </div>
        <div class="pull-Left">
            <asp:FileUpload ID="FileUpload1" runat="server" />
        </div>
    </div>
</div>
