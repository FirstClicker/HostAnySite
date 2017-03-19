<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Import Namespace="ClassHostAnySite" %>
<%@ Implements Interface="ClassHostAnySite.RoutForumTopicInterface" %>

<script runat="server">


    Private m_RoutFace_RoutTopic_Id As String
    Public Property RoutFace_RoutTopic_Id() As String Implements ClassHostAnySite.RoutForumTopicInterface.RoutFace_RoutTopic_Id
        Get
            Return m_RoutFace_RoutTopic_Id
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutTopic_Id = value
        End Set
    End Property

    Private m_RoutFace_RoutTopicHeading As String
    Public Property RoutFace_RoutTopicHeading() As String Implements ClassHostAnySite.RoutForumTopicInterface.RoutFace_RoutTopicHeading
        Get
            Return m_RoutFace_RoutTopicHeading
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutTopicHeading = value
        End Set
    End Property



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim Topicinfo As ForumTopic.StructureTopic = ForumTopic.Get_TopicDetails(RoutFace_RoutTopic_Id, ClassAppDetails.DBCS)
            LabelTopicid.Text = Topicinfo.Topic_ID
            LabelHeading.Text = Topicinfo.Heading
            LabelDate.Text = Topicinfo.PostDate
            LabelDrescption.Text = Topicinfo.Body
            LabelForumID.Text = Topicinfo.Forum_ID

            Dim Foruminfo As Forum.StructureForum = Forum.Get_Forum_ByID(LabelForumID.Text, ClassAppDetails.DBCS)
            HyperLinkForum.Text = Foruminfo.Heading
            HyperLinkForum.NavigateUrl = "~/forum/" & Foruminfo.Forum_Id & "/" & Foruminfo.Heading.Replace(" ", "-")

            Dim userInfo As User.StructureUser = ClassHostAnySite.User.UserDetail_UserID(Topicinfo.UserID, ClassAppDetails.DBCS)
            HyperLinkUserName.Text = userInfo.UserName
            HyperLinkUserName.NavigateUrl = "~/user/" & userInfo.RoutUserName
            ImageForumTopicUser.ImageUrl = "~/Storage/Image/" & userInfo.UserImage.ImageFileName
        End If


    End Sub

    Protected Sub ButtonReply_Click(sender As Object, e As EventArgs)
        If textboxreplyBody.Text = "" Then Exit Sub
        If Trim(Session("userid")) = "" Then
            LabelMsg.Text = "Please login to make reply."
            Exit Sub
        End If

        Dim topicreply As ForumTopicReply.StructureTopicReply = ForumTopicReply.Create_topicReply(textboxreplyBody.Text, Session("userid"), RoutFace_RoutTopic_Id, ForumTopicReply.TopicReplyVisibleToEnum.EveryOne, ClassAppDetails.DBCS)
        If topicreply.Result = False Then
            LabelMsg.Text = "Failed to make reply."
        Else
            ' post to user wall

            Dim submituserwall2 As ClassHostAnySite.UserWall.StructureUserWall
            submituserwall2 = ClassHostAnySite.UserWall.UserWall_Add(" ", "posted in following topic", 0, Session("userId"), Session("userid"), 0, 0, "active", ClassAppDetails.DBCS, ClassHostAnySite.UserWall.PreviewTypeEnum.MediaView, " ", HttpContext.Current.Request.Url.ToString.Replace("'", "''"), Mid(textboxreplyBody.Text, 1, 500).Replace("'", "''"))




            textboxreplyBody.Text = ""

            ListViewTopicReply.DataBind()
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    

    <div class="row">
        <div class="col-lg-8">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong><b>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Forum/Default.aspx">Forum</asp:HyperLink>
                        >>
                        <asp:HyperLink ID="HyperLinkForum" runat="server"></asp:HyperLink></b></strong>
                    <asp:Label ID="LabelForumID" runat="server" Text="0" Visible="False"></asp:Label>
                </div>
                <div class="list-group-item">
                    <div class="media">
                        <a class="pull-left" href="#">
                            <asp:Image ID="ImageForumTopicUser" runat="server" cssclass="media-object"
                                ImageUrl="~/App_Themes/Default/images/Logo.png" Width="75" Height="100" /><!-- 64x64 -->
                        </a>
                        <div class="media-body">
                            <h2 class="media-heading text-primary">
                                <asp:Label ID="LabelHeading" runat="server" Text="" />
                                <asp:Label ID="LabelTopicid" runat="server" Text="" Visible="False"></asp:Label>
                            </h2>
                          
                            <p>
                                <asp:HyperLink ID="HyperLinkUserName" runat="server"></asp:HyperLink>
                                <small>
                                    <asp:Label ID="LabelDate" runat="server" Text="" />
                                </small>
                            </p> 
                               <p>
                                <asp:Label ID="LabelDrescption" runat="server" Text="" />
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading ">
                    <div class="form">
                        <div class="form-group">
                            <label for="textboxreplyBody" class="sr-only">Make reply</label>
                            <asp:TextBox ID="textboxreplyBody" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Your reply"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="LabelMsg" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>

                        <asp:Button ID="ButtonReply" runat="server" cssclass="btn btn-info btn-block" Text="Reply" OnClick="ButtonReply_Click" />

                    </div>

                </div>
                <div class="panel-body UserWall-Body">
                    <asp:ListView ID="ListViewTopicReply" runat="server" DataSourceID="SqlDataSourceTopicReply" DataKeyNames="Id">

                     
                        <EmptyDataTemplate>
                            <span>No comment yet.</span>
                        </EmptyDataTemplate>
                   
                        <ItemTemplate>
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="media">
                                        <asp:HyperLink ID="userimage" runat="server" cssclass="pull-left" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'>
                                            <asp:Image runat="server" ID="userimg" cssclass="media-object" ImageUrl='<%# "~/storage/image/" + Eval("imagefilename")%>' Width="60" Height="80" />
                                        </asp:HyperLink>
                                        <div class="media-body">
                                            <p>
                                                <strong>
                                                    <asp:HyperLink ID="HyperLinkUserName" runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink>
                                                    <small>
                                                        <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# Eval("PostDate")%>' />
                                                    </small></strong>
                                            </p>
                                            <p>
                                                <asp:Label Text='<%# Eval("Reply")%>' runat="server" ID="DrescptionLabel" />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer">
                                <div runat="server" id="itemPlaceholder" />
                            </div>

                        </LayoutTemplate>
                       
                    </asp:ListView>

                    <asp:SqlDataSource runat="server" ID="SqlDataSourceTopicReply" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT t.[Id], t.[Topic_Id], t.[Reply], t.[PostDate], t.[UserId], t.[VisibleTo], t.[Status], TU.username, TU.routusername, TUI.ImageFileName 
                        FROM [Table_ForumTopicReply] t 
                        left JOIN table_User TU on TU.userid = t.userid
                        left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                        WHERE ([Topic_Id] = @Topic_Id) 
                        ORDER BY [PostDate] DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="LabelTopicid" PropertyName="Text" Name="Topic_Id" Type="Decimal"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                <div class="panel-footer clearfix ">
                    <div class="pull-left "></div>
                    <div class=" pull-right ">
                        <asp:DataPager runat="server" ID="DataPagerTopicReply" PagedControlID="ListViewTopicReply">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
        </div>
    </div>
</asp:Content>

