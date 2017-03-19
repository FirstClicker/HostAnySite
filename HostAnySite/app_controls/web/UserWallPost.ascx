<%@ Control Language="VB" ClassName="UserWallPost" %>
<%@ Register Src="~/app_controls/web/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Import Namespace ="System.ComponentModel" %>
<script runat="server">

    Public Property Wall_UserId() As String
        Get
            Return LabelWall_UserId.Text
        End Get
        Set(ByVal value As String)
            LabelWall_UserId.Text = value
        End Set
    End Property

    Public Property Wall_BlogId() As String
        Get
            Return LabelWall_BlogId.Text
        End Get
        Set(ByVal value As String)
            LabelWall_BlogId.Text = value
        End Set
    End Property

    Public Property Wall_ImageId() As String
        Get
            Return LabelWall_ImageId.Text
        End Get
        Set(ByVal value As String)
            LabelWall_ImageId.Text = value
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


    <DefaultValue(ClassHostAnySite.UserWall.PreviewTypeEnum.None)>
    Public Property PreviewType() As ClassHostAnySite.UserWall.PreviewTypeEnum
        Get
            If Trim(LabelPreviewType.Text) <> "" Then
                Return [Enum].Parse(GetType(ClassHostAnySite.UserWall.PreviewTypeEnum), LabelPreviewType.Text, True)
            Else
                Return ClassHostAnySite.UserWall.PreviewTypeEnum.None
            End If

        End Get
        Set(ByVal value As ClassHostAnySite.UserWall.PreviewTypeEnum)
            LabelPreviewType.Text = value.ToString
        End Set
    End Property

    Public Property Preview_Heading() As String
        Get
            Return LabelPreview_Heading.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_Heading.Text = value
        End Set
    End Property

    Public Property Preview_TargetURL() As String
        Get
            Return LabelPreview_TargetURL.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_TargetURL.Text = value
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
            LabelStatusEm.Text = "Please login to post."
            Exit Sub
        End If

        Dim MyWall_UserId As String
        Dim MyWall_BlogId As String
        Dim MyWall_ImageId As String

        If Wall_UserId = "22" Then
            MyWall_UserId = 0
        Else
            MyWall_UserId = Wall_UserId
        End If

        If Wall_BlogId = "22" Then
            MyWall_BlogId = 0
        Else
            MyWall_BlogId = Wall_BlogId
        End If

        If Wall_ImageId = "22" Then
            MyWall_ImageId = 0
        Else
            MyWall_ImageId = Wall_BlogId
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
            ClassHostAnySite.Image.ImageResize(Server.MapPath("~/storage/Image/" & filename), Server.MapPath("~/storage/Image/" & filename), 300, 400)
            SubmitWall = ClassHostAnySite.Image.SubmitImageByWeb(WallImageid, filename, Session("username") & " wall post", Session("username") & " wall post", Session("UserID"), Session("username"), ClassAppDetails.DBCS)

            If SubmitWall.Result = False Then
                LabelStatusEm.Text = SubmitWall.My_Error_message
                Exit Sub
            Else
                ' success
                '   Labelimageid.Text = Wallid
                heading = "<a href='http://" & Request.Url.Host & "/user/" & Session("routusername") & "'>" & Session("username") & "</a> posted image"

            End If
        Else
            WallImageid = 0
            heading = "<a href='http://" & Request.Url.Host & "/user/" & Session("routusername") & "'>" & Session("username") & "</a> posted"
        End If
        ''''''''''''''''''''''
        'up load image

        If Trim(HeadingEndPart) <> "" Then
            heading = heading + " " + HeadingEndPart
        End If

        Dim submituserwall As ClassHostAnySite.UserWall.StructureUserWall
        submituserwall = ClassHostAnySite.UserWall.UserWall_Add(heading, TextBoxStatus.Text, WallImageid, Session("userId"), MyWall_UserId, MyWall_BlogId, MyWall_ImageId, "active", ClassAppDetails.DBCS)
        If submituserwall.Result = False Then
            LabelStatusEm.Text = "Failed to submit post."
            ' LabelStatusEm.Text =  submituserwall.My_Error_message  & " " & submituserwall.Sys_Error_message 
        Else
            If CheckBoxPostToMyWall.Checked <> True Then
                Dim submituserwall2 As ClassHostAnySite.UserWall.StructureUserWall
                submituserwall2 = ClassHostAnySite.UserWall.UserWall_Add(heading, TextBoxStatus.Text, WallImageid, Session("userId"), Session("userid"), MyWall_BlogId, MyWall_ImageId, "active", ClassAppDetails.DBCS, PreviewType, Preview_Heading.Replace("'", "''"), Preview_TargetURL.Replace("'", "''"), Preview_BodyText.Replace("'", "''"))
            End If

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

</script>
<div class="panel panel-default">
     <div class="panel-heading ">
        Comment
    </div>
    <div class="panel-body">
        <div class="form-group">
            <asp:Label ID="LabelWall_UserId" runat="server" Text="22" Visible="False"></asp:Label>
            <asp:Label ID="LabelWall_BlogId" runat="server" Text="22" Visible="False"></asp:Label>
            <asp:Label ID="LabelWall_ImageId" runat="server" Text="22" Visible="False"></asp:Label>
            
            <asp:Label ID="LabelHeadingEndPart" runat="server" Text="" Visible="False"></asp:Label>

              <asp:Label ID="LabelPreviewType" runat="server" Text="" Visible="False"></asp:Label>
             <asp:Label ID="LabelPreview_Heading" runat="server" Text="" Visible="False"></asp:Label>
             <asp:Label ID="LabelPreview_TargetURL" runat="server" Text="" Visible="False"></asp:Label>
             <asp:Label ID="LabelPreview_BodyText" runat="server" Text="" Visible="False"></asp:Label>

            
            <label for="TextBoxStatus" class="sr-only">Status</label>
            <asp:TextBox ID="TextBoxStatus" runat="server" CssClass="form-control" placeholder="Whats you want to share?" TextMode="MultiLine"></asp:TextBox>
        </div>
        <div class="form-group">
            <div >
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </div>
            <div class="pull-right">
                <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass ="text-info text-muted" Text="Share on my wall" runat="server" />
                <asp:Button runat="server" ID="SubmitStatus" type="button" class="btn btn-info" Text="Post" OnClick="SubmitStatus_Click" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="LabelStatusEm" runat="server" ForeColor="Maroon"></asp:Label>
        </div>
        
    </div>
      <hr style ="margin :0px;" />
    <div class="panel-body UserWall-Body">
        <asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="Wallid" DataSourceID="SqlDataSourceCommnet">
            <EmptyDataTemplate>
                <span>No one commented yet.</span>
            </EmptyDataTemplate>

            <ItemTemplate>

                <uc1:UserWallEntry runat="server" ID="UserWallEntry" WallUserURL='<%# "~/user/" + Eval("RoutUserName")%>' WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' WallHeading='<%# Eval("Heading") %>' WallDatetime='<%# Eval("postdate") %>' WallMessage='<%# Eval("Message") %>' WallPostImage='<%# "~/storage/image/" + Eval("PostImageFilename")%>'   WallID='<%# Eval("Wallid")%>' numberofcomment='<%# Eval("numberofcomment")%>' />

            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server">
                    <div runat="server" id="itemPlaceholder" />
                </div>
            </LayoutTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSourceCommnet" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT t.Wallid, t.heading, t.message, t.postdate, t.userid, t.imageid, t2.RoutUserName, t1.ImageFileName as PostImageFilename, t3.ImageFileName as userimagefilename, count(TUWC.wallId) as numberofcomment  
                        FROM [Table_UserWall] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left join table_userwallComment TUWC on t.Wallid=TUWC.wallId
                        WHERE (t.Wall_UserId = @Wall_UserId) or (t.Wall_BlogId = @Wall_BlogId) 
                        group by t.Wallid, t.heading, t.message, t.postdate, t.userid, t.imageid, t2.RoutUserName, t1.ImageFileName , t3.ImageFileName  
                        ORDER BY t.[postdate] DESC" OnSelected ="SqlDataSourceCommnet_Selected">
            <SelectParameters>
                <asp:ControlParameter ControlID="LabelWall_UserId" PropertyName="text" Name="Wall_UserId" Type="String"></asp:ControlParameter>
                <asp:ControlParameter ControlID="LabelWall_BlogId" PropertyName="text" Name="Wall_BlogId" Type="String"></asp:ControlParameter>
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <asp:panel runat ="server" ID="PanelCommentFooter" cssclass="panel-footer clearfix">
        <div class="pull-right">
            <asp:DataPager runat="server" ID="DataPagerNotification" PagedControlID="ListViewNotification" PageSize="5">
                <Fields>
                    <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                </Fields>
            </asp:DataPager>
        </div>
        <div class="pull-Left"></div>
    </asp:panel>
</div>
