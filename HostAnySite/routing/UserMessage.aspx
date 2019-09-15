<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Implements Interface="RoutUserInterface" %>


<%@ Register Src="~/app_controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>
<%@ Register Src="~/app_controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>


<script runat="server">
    Private m_RoutFace_RoutUserName As String
    Public Property RoutFace_RoutUserName() As String Implements RoutUserInterface.RoutIFace_RoutUserName
        Get
            Return m_RoutFace_RoutUserName
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutUserName = value
        End Set
    End Property



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim userinfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_RoutUserName(RoutFace_RoutUserName, WebAppSettings.DBCS)
            If userinfo.Result = False Then
                Response.Redirect("~/dashboard/inbox.aspx")
                Exit Sub
            Else
                If Trim(Session("RoutUserName")).ToLower = RoutFace_RoutUserName.ToLower Then
                    Response.Redirect("~/dashboard/message/")
                Else


                    Dim chatdetaiuls As FirstClickerService.Version1.UserChat.StructureUserChat = FirstClickerService.Version1.UserChat.UserChat_Get(Val(Session("userid")), userinfo.UserID, WebAppSettings.DBCS)
                    LabelChatId.Text = chatdetaiuls.ChatId
                End If
            End If

            LabelProfileRoutUserName.Text = userinfo.RoutUserName
            LabelProfileUserId.Text = Val(userinfo.UserID)
            LabelUserName.Text = userinfo.UserName

        End If
    End Sub


    Protected Sub SubmitStatus_Click(sender As Object, e As EventArgs)
        Dim postmessage As FirstClickerService.Version1.UserChat.StructureUserChatMessage
        postmessage = FirstClickerService.Version1.UserChat.ChatMessage_Add(Val(Session("userid")), TextBoxStatus.Text, LabelChatId.Text, WebAppSettings.DBCS)
        If postmessage.Result = True Then
            Response.Redirect(Request.Url.ToString)
        Else
            LabelStatusEm.Text = "failed..."
        End If
        UpdatePanelMessage.Update()
    End Sub

    Protected Sub ListViewMessage_ItemDataBound(sender As Object, e As ListViewItemEventArgs)
        If e.Item.ItemType = ListViewItemType.DataItem Then
            Dim dataItem As ListViewDataItem = DirectCast(e.Item, ListViewDataItem)

            Dim lvrow As Data.DataRowView = DirectCast(dataItem.DataItem, Data.DataRowView)

            If lvrow("messageid") IsNot System.DBNull.Value Then

                Dim myConn As SqlConnection
                Dim myCmd As SqlCommand
                Dim myReader As SqlDataReader

                myConn = New SqlConnection(WebAppSettings.dbcs)
                myCmd = myConn.CreateCommand
                myConn.Open()

                myCmd.CommandText = "update Table_UserChatMessage set IsRead='true' where (messageid='" & lvrow("messageid") & "') and (UserID<>'" & Session("UserId") & "')"
                myReader = myCmd.ExecuteReader

                myReader.Close()
                myConn.Close()

            End If



        End If

    End Sub



</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="container">
        <div class="row">
            <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
                <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
            </div>
            <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
                <div class="row">
                    <div class="col-9 ">
                        <asp:UpdatePanel ID="UpdatePanelMessage" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <div class="card  BoxEffect6 mt-2 mb-2 ">
                                    <div class="card-header">
                                        <asp:Label ID="LabelChatId" runat="server" Text="0" Visible="False"></asp:Label>
                                        <asp:Label ID="LabelUserName" runat="server" Text=""></asp:Label>
                                        <asp:Label ID="LabelProfileUserId" runat="server" Text="" Visible="False"></asp:Label>
                                        <asp:Label ID="LabelProfileRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
                                    </div>

                                    <div class="card-body">
                                        <div class="form-group">
                                            <label for="TextBoxStatus" class="sr-only">Status</label>
                                            <asp:TextBox ID="TextBoxStatus" runat="server" CssClass="form-control" placeholder="Whats you want to share?" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <div class="float-left ">
                                                <asp:Label ID="LabelStatusEm" runat="server" ForeColor="Maroon"></asp:Label>
                                            </div>
                                            <div class="float-right">
                                                <asp:Button runat="server" ID="SubmitStatus" type="button" class="btn btn-info" Text="Post" OnClick="SubmitStatus_Click" />
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="card-body">
                                    <asp:ListView ID="ListViewMessage" runat="server" DataSourceID="SqlDataSourceMessage" OnItemDataBound="ListViewMessage_ItemDataBound">

                                        <EmptyDataTemplate>
                                            <div class="list-group">
                                                <div class="list-group-item">No message history.. </div>
                                            </div>
                                        </EmptyDataTemplate>

                                        <ItemTemplate>
                                            <div class="list-group-item">
                                                <div class="media">
                                                    <asp:HyperLink ID="userimage" runat="server" class="float-left" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'>
                                                        <asp:Image runat="server" ID="userimg" class=" " ImageUrl='<%# "~/storage/image/" + Eval("imagefilename")%>' Width="33" Height="44" />
                                                    </asp:HyperLink>
                                                    <div class="media-body">
                                                        <h5 class="">
                                                            <asp:Label ID="Labelmid" runat="server" Text='<%# Eval("messageid")%>' Visible="False"></asp:Label>
                                                            <asp:HyperLink Text='<%# Eval("username") %>' runat="server" ID="Labeluser" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>' />
                                                            <small>
                                                                <asp:Label Text='<%# Eval("PostDate") %>' runat="server" ID="PostDateLabel" />
                                                            </small></h5>
                                                    </div>
                                                    <asp:Label Text='<%# Eval("Message") %>' runat="server" ID="MessageLabel" />
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <LayoutTemplate>
                                            <div runat="server" id="itemPlaceholderContainer" class="list-group ">
                                                <div runat="server" id="itemPlaceholder" />
                                            </div>
                                        </LayoutTemplate>

                                    </asp:ListView>

                                    <asp:SqlDataSource runat="server" ID="SqlDataSourceMessage" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                        SelectCommand="select TUCM.message, TUCM.messageid, TUCM.postdate, tu.username, tu.routusername, TI.imagefilename
                                                    FROM [Table_UserChatMessage] TUCM
                                                    left JOIN table_User TU ON TU.UserId=TUCM.UserId
                                                    left JOIN table_image TI ON TU.ImageID=TI.ImageID 
                                                    left JOIN Table_UserChat Tuc ON Tuc.chatid=TUCM.chatid
                                                    where Tuc.chatid=@chatid
                                                    order by TUCM.postdate desc">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="LabelChatId" PropertyName="Text" Name="chatid" Type="Decimal"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                </div>
                                <div class="card-footer  clearfix ">
                                    <div class="float-right ">
                                        <asp:DataPager runat="server" ID="DataPagerMessage" PagedControlID="ListViewMessage">
                                            <Fields>
                                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                                            </Fields>
                                        </asp:DataPager>

                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-3 ">
                        <div class="card ">
                            <div class="card-header ">Inbox</div>
                            <asp:ListView ID="ListViewInbox" runat="server" DataSourceID="SqlDataSourceInbox" DataKeyNames="UserId">

                                <EmptyDataTemplate>
                                    <span>No message history.</span>
                                </EmptyDataTemplate>

                                <ItemTemplate>
                                    <div class="list-group-item ">
                                        <asp:HyperLink Text='<%# Eval("UserName") %>' runat="server" ID="UserNameLabel" NavigateUrl='<%# "~/message/" + Eval("RoutUserName") + "/"%>' />
                                    </div>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div runat="server" id="itemPlaceholderContainer" class="list-group">
                                        <div runat="server" id="itemPlaceholder" />
                                    </div>

                                </LayoutTemplate>

                            </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceInbox" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                SelectCommand="SELECT t.[UserId], t.[UserName], t.[RoutUserName], t.imageid, ti.ImageFileName as userImageFilename 
                                    FROM [Table_User] t
                                    left JOIN table_image TI ON t.ImageID=TI.ImageID 
                                    left JOIN Table_UserChat TUC1 on t.userid = TUC1.First_userid
                                    left JOIN Table_UserChat TUC2 on t.userid = TUC2.second_userid
                                    where ((TUC1.second_userid = @UserID) 
                                    or (TUC2.First_userid = @UserID))
                                    group by t.[UserId], t.[UserName], t.[RoutUserName], t.imageid,  ti.ImageFileName">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="userid" Name="userid" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <div class="card-footer clearfix">
                                <div class="float-right">
                                    <asp:DataPager runat="server" ID="DataPagerInbox" PagedControlID="ListViewInbox">
                                        <Fields>
                                            <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</asp:Content>

