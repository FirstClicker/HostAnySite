<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Implements Interface="ClassHostAnySite.RoutUserInterface" %>
<%@ Register Src="~/app_controls/web/UserInfoBox.ascx" TagPrefix="uc1" TagName="UserInfoBox" %>
<%@ Register Src="~/app_controls/web/MenuUserProfile.ascx" TagPrefix="uc1" TagName="MenuUserProfile" %>



<script runat="server">
    Private m_RoutFace_RoutUserName As String
    Public Property RoutFace_RoutUserName() As String Implements ClassHostAnySite.RoutUserInterface.RoutIFace_RoutUserName
        Get
            Return m_RoutFace_RoutUserName
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutUserName = value
        End Set
    End Property



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim userinfo As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.UserDetail_RoutUserName(RoutFace_RoutUserName, ClassAppDetails.DBCS)
        If userinfo.Result = False Then
            Response.Redirect("~/")
            Exit Sub
        End If

        MenuUserProfile.UserName = Trim(userinfo.UserName)
        MenuUserProfile.ImageFileName = userinfo.UserImage.ImageFileName
        MenuUserProfile.RoutUserName = userinfo.RoutUserName

        LabelProfileUserId.Text = Val(userinfo.UserID)

        LabelPageheading.Text = userinfo.UserName & "' Blog"

        If Session("userid") <> userinfo.UserID And Trim(Session("userid")) <> "" Then
            'PanelUserHeader.Visible = True
        End If



    End Sub



    Protected Sub ListViewBlog_ItemDataBound(sender As Object, e As ListViewItemEventArgs)
        If Val(Session("userid")) = Val(LabelProfileUserId.Text) Then
            ' is admin user

            Dim DeletetargetButton As Button = e.Item.FindControl("DeleteButton")
            DeletetargetButton.Visible = True

            DeletetargetButton.Enabled = False
        Else
            ' Is Not admin user
            Dim DeletetargetButton As Button = e.Item.FindControl("DeleteButton")
            DeletetargetButton.Visible = False


        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row">
            <div class="col-lg-9">
                <div class="row">
                    <div class="col-lg-3 col-md-3 col-sm-3">
                        <uc1:MenuUserProfile runat="server" ID="MenuUserProfile" />
                    </div>
                    <div class="col-lg-9 col-md-9 col-sm-9">
                        <asp:UpdatePanel ID="UpdatePanelMessage" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <asp:Label ID="LabelPageheading" runat="server" Text=""></asp:Label>
                                        <asp:Label ID="LabelProfileUserId" runat="server" Text="0" Visible="False"></asp:Label>
                                    </div>
                                    <div class="panel-body ">
                                        <asp:ListView ID="ListViewBlog" runat="server" DataSourceID="SqlDataSourceMessage" DataKeyNames="Blogid" OnItemDataBound="ListViewBlog_ItemDataBound">


                                            <EmptyDataTemplate>
                                                <span>No blog posted.</span>
                                            </EmptyDataTemplate>

                                            <ItemTemplate>


                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 thumb">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body" style="height: 360px; overflow: hidden;">
                                                            <div class="pull-right ">
                                                                <asp:Button runat="server" CommandName="Cancel" Text="X" ID="DeleteButton" />
                                                            </div>
                                                            <h4>
                                                                <asp:HyperLink ID="HyperLinkStoryNameBn" runat="server" NavigateUrl='<%#"~/blog/" + Eval("Blogid").ToString.Trim + "/" + Eval("Heading2") + "/"%>'><%# Eval("Heading")%></asp:HyperLink>
                                                            </h4>
                                                            <asp:Panel ID="postimage" runat="server" CssClass="thumbnail" Style="border-style: none; margin: 2px;" Visible='<%# CBool(Eval("imageid"))%>'>

                                                                <asp:Image ID="ImageTRW2" runat="server" ImageUrl='<%#"~/storage/image/" + Eval("PostImageFilename")%>' Style="max-height: 160px;" />

                                                            </asp:Panel>
                                                            <asp:Label Text='<%# Eval("Highlight") %>' runat="server" ID="HighlightLabel" />
                                                        </div>
                                                        <div class="panel-footer clearfix ">
                                                            <div class="pull-left">
                                                                <small>
                                                                    <asp:HyperLink ID="Hyperuser" runat="server" Text='<%# Eval("Username")%>' NavigateUrl='<%#"~/User/" + Eval("Routusername").Trim + "/"%>'></asp:HyperLink>
                                                                    <br />
                                                                    <span class="glyphicon glyphicon-time"></span>
                                                                    <asp:Label ID="LabelDatetime" runat="server" Text='<%# Eval("PostDate") %>'></asp:Label>
                                                                </small>
                                                            </div>
                                                            <div class="pull-right ">
                                                                <asp:LinkButton ID="LinkButtonmore" runat="server" CssClass="btn btn-primary btn-block" PostBackUrl='<%#"~/blog/" + Eval("blogid").ToString + "/" + Eval("heading2")%>' Text="read more"></asp:LinkButton>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>

                                            <LayoutTemplate>
                                                <div id="itemPlaceholderContainer" runat="server" class="row">
                                                    <div runat="server" id="itemPlaceholder" />
                                                </div>
                                            </LayoutTemplate>

                                        </asp:ListView>
                                        <asp:SqlDataSource runat="server" ID="SqlDataSourceMessage" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                            SelectCommand="SELECT t.Blogid, t.Heading, replace(t.[Heading],' ','-') as [Heading2], t.Highlight, t.Containt, t.PostDate, t2.username, t2.routusername, t1.ImageFileName as PostImageFilename, t.imageid  
                                    FROM [Table_Blog] t
                                    left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                                    left JOIN table_User t2 on t.userid = t2.userid
                                    WHERE (t.[UserID] = @UserID) 
                                    ORDER BY [PostDate] DESC"
                                            DeleteCommand="DELETE FROM [Table_Blog] WHERE [Blogid] = @Blogid" InsertCommand="INSERT INTO [Table_Blog] ([Blogid], [Heading], [Highlight], [Containt], [ImageId], [UserID], [PostDate], [Status]) VALUES (@Blogid, @Heading, @Highlight, @Containt, @ImageId, @UserID, @PostDate, @Status)" UpdateCommand="UPDATE [Table_Blog] SET [Heading] = @Heading, [Highlight] = @Highlight, [Containt] = @Containt, [ImageId] = @ImageId, [UserID] = @UserID, [PostDate] = @PostDate, [Status] = @Status WHERE [Blogid] = @Blogid">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Blogid" Type="Decimal"></asp:Parameter>
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="LabelProfileUserId" PropertyName="Text" Name="UserID" Type="Decimal"></asp:ControlParameter>
                                            </SelectParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="Heading" Type="String"></asp:Parameter>
                                                <asp:Parameter Name="Highlight" Type="String"></asp:Parameter>
                                                <asp:Parameter Name="Containt" Type="String"></asp:Parameter>
                                                <asp:Parameter Name="ImageId" Type="Decimal"></asp:Parameter>
                                                <asp:Parameter Name="UserID" Type="Decimal"></asp:Parameter>
                                                <asp:Parameter Name="PostDate" Type="DateTime"></asp:Parameter>
                                                <asp:Parameter Name="Status" Type="String"></asp:Parameter>
                                                <asp:Parameter Name="Blogid" Type="Decimal"></asp:Parameter>
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                    <div class="panel-footer  clearfix ">
                                        <div class="pull-right ">
                                            <asp:DataPager runat="server" ID="DataPagerMessage" PagedControlID="ListViewBlog">
                                                <Fields>
                                                    <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                                                </Fields>
                                            </asp:DataPager>

                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
            </div>
        </div>
    </div>
</asp:Content>

