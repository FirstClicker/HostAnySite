<%@ Control Language="VB" ClassName="UserWallEntry" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Import Namespace="System.ComponentModel" %>

<script runat="server">

    Public Property UserID() As String
        Get
            Return LabeluserID.Text
        End Get
        Set(ByVal value As String)
            LabeluserID.Text = value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return HyperLinkUserName.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUserName.Text = value
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUserName.Text = value
        End Set
    End Property

    Public Property WallUserImage() As String
        Get
            Return userimg.ImageUrl
        End Get
        Set(ByVal value As String)
            userimg.ImageUrl = value
        End Set
    End Property

    Public Property WallID() As String
        Get
            Return LabelWallID.Text
        End Get
        Set(ByVal value As String)
            LabelWallID.Text = value
        End Set
    End Property

    Public Property WallHeading() As String
        Get
            Return LabelHeading.Text
        End Get
        Set(ByVal value As String)
            LabelHeading.Text = value
        End Set
    End Property

    Public Property WallMessage() As String
        Get
            Return MessageLabel.Text
        End Get
        Set(ByVal value As String)
            MessageLabel.Text = value.Replace(Environment.NewLine, "<br />")
        End Set
    End Property

    Public Property WallDatetime() As String
        Get
            Return postdateLabel.Text
        End Get
        Set(ByVal value As String)
            postdateLabel.Text = ClassHostAnySite.HostAnySite.ConvertDateTime4Use(value)
        End Set
    End Property

    Public Property WallPostImageURL() As String
        Get
            Return WallPostImage.ImageUrl
        End Get
        Set(ByVal value As String)
            WallPostImage.ImageUrl = value
        End Set
    End Property

    Public Property WallPostImageID() As String
        Get
            Return LabelWallPostImageID.Text
        End Get
        Set(ByVal value As String)
            LabelWallPostImageID.Text = value
            WallPostImage.Visible = CBool(value)
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

    Public Property Wall_UserName() As String
        Get
            Return LabelWall_UserName.Text
        End Get
        Set(ByVal value As String)
            LabelWall_UserName.Text = value
        End Set
    End Property


    Public Property Wall_RoutUserName() As String
        Get
            Return LabelWall_RoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelWall_RoutUserName.Text = value
        End Set
    End Property




    Public Property numberofcomment() As String
        Get
            Return Labelnumberofcomment.Text
        End Get
        Set(ByVal value As String)
            Labelnumberofcomment.Text = value
        End Set
    End Property

    Public Property numberofLike() As String
        Get
            Return LabelLikeCount.Text
        End Get
        Set(ByVal value As String)
            LabelLikeCount.Text = value
        End Set
    End Property

    Public Property numberofDisLike() As String
        Get
            Return LabelDisLikeCount.Text
        End Get
        Set(ByVal value As String)
            LabelDisLikeCount.Text = value
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

    Public Property Preview_ImageURL() As String
        Get
            Return LabelPreview_ImageURL.Text
        End Get
        Set(ByVal value As String)
            LabelPreview_ImageURL.Text = value
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




    Protected Sub BtnLike_Click(source As Object, e As EventArgs)

        Dim submitlike As ClassHostAnySite.UserLike.StructureUserLike
        submitlike = ClassHostAnySite.UserLike.UserLike_Add(Session("userId"), ClassHostAnySite.UserLike.IsLikeEnum.IsLike, 1, WallID, 0, ClassAppDetails.DBCS)
        If submitlike.Result = True Then
            LabelLikeCount.Text = Val(LabelLikeCount.Text) + 1
        Else
            LabelPop.Text = "Please signin to use this function."
            ModalPopupExtender1.Show()
        End If

    End Sub

    Protected Sub BtnDisLike_Click(sender As Object, e As EventArgs)

        Dim submitlike As ClassHostAnySite.UserLike.StructureUserLike
        submitlike = ClassHostAnySite.UserLike.UserLike_Add(Session("userId"), ClassHostAnySite.UserLike.IsLikeEnum.IsDisLike, 1, WallID, 0, ClassAppDetails.DBCS)
        If submitlike.Result = True Then
            LabelDisLikeCount.Text = Val(LabelDisLikeCount.Text) + 1
        Else
            LabelPop.Text = "Please signin to use this function."
            ModalPopupExtender1.Show()
        End If
    End Sub


    Protected Sub ButtonPostComment_Click(sender As Object, e As EventArgs)
        If Trim(TextBoxComment.Text) = "" Or Trim(Session("userid")) = "" Then
            LabelPop.Text = "Please signin to use this function."
            ModalPopupExtender1.Show()
            Exit Sub
        End If

        Dim postcommnet As ClassHostAnySite.UserWallComment.StructureUserWallComment = ClassHostAnySite.UserWallComment.UserWallCommentPost_Add(TextBoxComment.Text, Session("Userid"), LabelWallID.Text, ClassAppDetails.DBCS)
        If postcommnet.Result = True Then
            TextBoxComment.Text = ""
            ListViewWallComment.DataBind()
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkUserName.NavigateUrl = "~/user/" & RoutUserName
        If IsPostBack = False Then

            If Val(Wall_UserId) <> 0 And Val(Wall_UserId) <> Val(UserID) Then
                HyperLinkPostedOnusername.Text = Wall_UserName
                HyperLinkPostedOnusername.NavigateUrl = "~/user/" & Wall_RoutUserName
            End If


            'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            Dim Cusertype As New ClassHostAnySite.User.UserType
            Try
                Cusertype = [Enum].Parse(GetType(ClassHostAnySite.User.UserType), Trim(Session("UserType")), True)
                If Cusertype = ClassHostAnySite.User.UserType.Administrator Or Cusertype = ClassHostAnySite.User.UserType.Moderator Then
                    LIActionDelete.Visible = True
                End If
            Catch ex As Exception
            End Try

            If Val(UserID) > 10 And Val(UserID) = Val(Session("UserID")) Then
                LIActionDelete.Visible = True
            End If
            'Action Button Coding XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


            Dim myConn As SqlConnection
            Dim myCmd As SqlCommand
            Dim myReader As SqlDataReader

            myConn = New SqlConnection(ClassAppDetails.DBCS)
            myCmd = myConn.CreateCommand
            myConn.Open()

            myCmd.CommandText = "SELECT count(*) as lc FROM Table_Userlike where (wallid='" & Trim(WallID) & "') and IsLike='IsLike'"
            myReader = myCmd.ExecuteReader
            myReader.Read()
            numberofLike = myReader.Item("lc")

            myReader.Close()
            myCmd.CommandText = "SELECT count(*) as lc FROM Table_Userlike where (wallid='" & Trim(WallID) & "') and IsLike='isDislike'"
            myReader = myCmd.ExecuteReader
            myReader.Read()
            numberofDisLike = myReader.Item("lc")

            myReader.Close()
            myConn.Close()

            If PreviewType = ClassHostAnySite.UserWall.PreviewTypeEnum.MediaView Then
                PanelPreviewTypeMediaView.Visible = True

                If Trim(Preview_ImageURL) <> "" Then
                    PreviewTypeMediaViewImage.ImageUrl = Preview_ImageURL
                End If

                PreviewTypeMediaViewheading.Text = Preview_Heading
                PreviewTypeMediaViewheading.NavigateUrl = Preview_TargetURL
                PreviewTypeMediaViewBody.Text = Preview_BodyText

                PanelPreviewMediaViewImageCointainer.Visible = CBool(Len(Trim(Preview_ImageURL)))
            End If

            If PreviewType = ClassHostAnySite.UserWall.PreviewTypeEnum.ImageView Then
                PanelPreviewTypeImageView.Visible = True
                PreviewTypeImageViewImage.ImageUrl = Preview_ImageURL
            End If

        End If
    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)
        ClassHostAnySite.UserWall.UserWall_Delete(WallID, ClassAppDetails.DBCS)
        panelContainer.Visible = False
        Me.Visible = False
    End Sub
</script>


<asp:Label ID="LabeluserID" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelWallID" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelWall_UserId" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelWall_UserName" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelWall_RoutUserName" runat="server" Text="" Visible="False"></asp:Label>

          
<asp:Label ID="LabelPreviewType" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_Heading" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_TargetURL" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_ImageURL" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelPreview_BodyText" runat="server" Text="" Visible="False"></asp:Label>

<asp:Panel ID="panelContainer" runat="server" CssClass="panel panel-default">
    <div class="panel-body">
        <div class="media" style="overflow: visible">
            <asp:HyperLink ID="HyperLinkUserURL" runat="server" CssClass="pull-left">
                <asp:Image runat="server" ID="userimg" class="media-object" Width="27" Height="36" />
            </asp:HyperLink>
            <div class="media-body" style="overflow: visible">
                <div class="dropdown pull-right">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                    <ul class="dropdown-menu">
                        <li runat="server" id="LIActionFeatured" visible="false">
                            <asp:LinkButton ID="LinkButtonFeatured" runat="server"><small>Hide</small></asp:LinkButton>
                        </li>
                        <li runat="server" id="LIActionDelete" visible="false">
                            <asp:LinkButton ID="LinkButtonDelete" OnClick="LinkButtonDelete_Click" runat="server"><small>Delete</small></asp:LinkButton>
                        </li>
                        <li runat="server" id="LIActionReport">
                            <asp:LinkButton ID="LinkButtonReport" runat="server"><small>Report</small> </asp:LinkButton>
                        </li>
                    </ul>
                </div>
                <h5 class="media-heading">
                    <asp:HyperLink ID="HyperLinkUserName" CssClass="text-capitalize" runat="server"></asp:HyperLink>
                    <asp:Label ID="LabelHeading" CssClass="text-capitalize" runat="server" Text="" />
                   on&nbsp;<asp:HyperLink ID="HyperLinkPostedOnusername" runat="server"></asp:HyperLink>
                </h5>
                <small>
                    <asp:Label ID="postdateLabel" runat="server" Text="" />
                </small>
            </div>
        </div>
        <hr style="margin: 4px;" />
    </div>
    <div class="panel-body" style ="word-wrap: break-word;">
        <asp:Label ID="MessageLabel" runat="server" Text="" /><br />
          <asp:Label ID="LabelWallPostImageID" runat="server" Text="0" Visible="false"></asp:Label>
          <asp:Image runat="server" ID="WallPostImage" CssClass="img-responsive" style="margin-top :10px;" />
    </div>

    <asp:Panel runat="server" ID="PanelPreviewTypeMediaView" CssClass="panel-body" Visible="false">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="media">
                    
                    <div class="media-body">
                        <h4 class="media-heading">
                            <asp:HyperLink ID="PreviewTypeMediaViewheading" runat="server"></asp:HyperLink>
                        </h4>
                        <div>
                            <asp:Panel runat="server" ID="PanelPreviewMediaViewImageCointainer" style="float:right;width:40%;">
                                <asp:Image runat="server" ID="PreviewTypeMediaViewImage" CssClass="img-responsive" />
                            </asp:Panel>
                            <p>
                                <asp:Label ID="PreviewTypeMediaViewBody" runat="server" Text=""></asp:Label>
                            </p>
                        </div>
                     
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel runat="server" ID="PanelPreviewTypeImageView" CssClass="panel-body" Visible="false">
        <div class="panel panel-default">
            <div class="panel-body">
               <asp:Image runat="server" ID="PreviewTypeImageViewImage"  CssClass ="img-responsive" />
            </div>
        </div>
    </asp:Panel>


    <div class="panel-footer clearfix">
        <div class="pull-left ">
            <i class="fa fa-comments-o" aria-hidden="true"></i>&nbsp;<a data-toggle="collapse" href="#<%=collapseComment.ClientID%>">Comment
            </a>(<asp:Label ID="Labelnumberofcomment" runat="server" Text="0"></asp:Label>)
        </div>
        <div class="pull-right ">
            <button runat="server" id="BtnLike" class="btn btn-xs btn-primary" type="button" onserverclick=" BtnLike_Click">
                <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>&nbsp;<asp:Label ID="LabelLikeCount" runat="server" Text="0"></asp:Label>
            </button>

            <button runat="server" id="BtnDisLike" class="btn btn-xs btn-danger" type="button" onserverclick=" BtnDisLike_Click">
                <i class="fa fa-thumbs-o-down" aria-hidden="true"></i>&nbsp;<asp:Label ID="LabelDisLikeCount" runat="server" Text="0"></asp:Label>
            </button>
        </div>
    </div>
    <asp:Panel runat="server" ID="collapseComment" class="panel-collapse collapse">
        <div class="panel-body">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="form">
                        <div class="form-group">
                            <div class="input-group">
                                <asp:TextBox ID="TextBoxComment" runat="server" CssClass="form-control"></asp:TextBox>
                                <span class="input-group-btn">
                                    <asp:Button ID="ButtonPostComment" CssClass="btn btn-default" runat="server" Text="Post" OnClick="ButtonPostComment_Click" UseSubmitBehavior="False" />
                                </span>
                            </div>
                        </div>
                    </div>
                    <asp:ListView ID="ListViewWallComment" runat="server" DataKeyNames="WallCommentId" DataSourceID="SqlDataSourceWallcomment">
                        <EmptyDataTemplate>
                            <span></span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <div class="list-group-item">
                                <div class="media">
                                    <asp:HyperLink ID="HyperLinkUserURL" runat="server" class="media-left">
                                        <asp:Image runat="server" ID="userimg" class="media-object" ImageUrl='<%# "~/storage/image/" + Eval("userimagefilename")%>' Width="33" Height="44" />
                                    </asp:HyperLink>
                                    <div class="media-body">
                                        <h5 class="media-heading">
                                            <asp:Label ID="UserIdLabel" runat="server" CssClass="text-capitalize" Text='<%# Eval("Username")%>' />
                                            <small>
                                                <asp:Label ID="PostDateLabel" runat="server" Text='<%# ClassHostAnySite.HostAnySite.ConvertDateTime4Use(Eval("PostDate")) %>' />
                                            </small>
                                        </h5>
                                        <p>
                                            <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div id="itemPlaceholderContainer" runat="server" class="list-group">
                                <div runat="server" id="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSourceWallcomment" runat="server"
                        ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                        SelectCommand="SELECT TUWC.WallCommentId, TUWC.WallId, TUWC.Comment, TUWC.UserId, CONVERT(VARCHAR(19), TUWC.PostDate, 120) AS postdate , tU.Username, ti.ImageFileName as userimagefilename  
                                FROM [Table_UserWallComment] TUWC
                                left JOIN table_User tU on tU.userid = TUWC.userid
                                left JOIN table_image TI on tI.Imageid = tU.Imageid
                                WHERE ([WallId] = @WallId) ORDER BY [PostDate] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="LabelWallID" Name="WallId" PropertyName="Text" Type="Decimal" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </asp:Panel>
</asp:Panel>

<asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
<cc1:ModalPopupExtender ID="ModalPopupExtender1" BehaviorID="mpe" runat="server"
    PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground" CancelControlID="btnHide">
</cc1:ModalPopupExtender>
<asp:Panel ID="pnlPopup" runat="server" CssClass="panel panel-primary" Style="display: none">
    <div class="panel-heading ">
        Message:
    </div>
    <div class="panel-body ">
        <asp:Label ID="LabelPop" runat="server" Text="Please signin to use this function."></asp:Label>
    </div>
    <div class="panel-footer clearfix ">
        <div class="btn-group pull-left">
            <asp:HyperLink ID="HyperLinkSignIn" runat="server" CssClass="btn btn-success" NavigateUrl="~/user/Signin.aspx">Sign In</asp:HyperLink><asp:HyperLink ID="HyperLinkSignUp" runat="server" CssClass="btn btn-info" NavigateUrl="~/user/SignUp.aspx">Sign Up</asp:HyperLink>
        </div>
        <div class="pull-right ">
            <asp:Button ID="btnHide" runat="server" CssClass="btn btn-danger" Text="Not Now" />
        </div>
    </div>
</asp:Panel>

