<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Implements Interface="RoutUserInterface" %>
<%@ Register Src="~/App_Controls/NavigationSideUserProfile.ascx" TagPrefix="uc1" TagName="NavigationSideUserProfile" %>
<%@ Register Src="~/App_Controls/UserInfoBox.ascx" TagPrefix="uc1" TagName="UserInfoBox" %>
<%@ Register Src="~/App_Controls/UserSuggestionByLastActive.ascx" TagPrefix="uc1" TagName="UserSuggestionByLastActive" %>





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
                Response.Redirect("~/")
                Exit Sub
            End If

            NavigationSideUserProfile.UserName = Trim(userinfo.UserName)
            NavigationSideUserProfile.ImageFileName = userinfo.UserImage.ImageFileName
            NavigationSideUserProfile.RoutUserName = userinfo.RoutUserName
            NavigationSideUserProfile.UserID = userinfo.UserID

            ImageUserBanner.ImageUrl = "~/storage/image/" & userinfo.BannerImage.ImageFileName


            LabelProfileRoutUserName.Text = userinfo.RoutUserName
            LabelProfileUserId.Text = Val(userinfo.UserID)
            LabelUserName.Text = userinfo.UserName
        End If

        Me.Title = NavigationSideUserProfile.UserName & "' profile"
        Me.MetaDescription = NavigationSideUserProfile.UserName & "' profile"
        Me.MetaKeywords = ""
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <div class="card  m-1 BoxEffect8">
                <asp:Image ID="ImageUserBanner" ImageUrl="~/Content/image/ProfileBanner.png" CssClass="img-fluid" runat="server" />
            </div>
        </div>
    </div>

            <div class="row">
                <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
                    <uc1:NavigationSideUserProfile runat="server" ID="NavigationSideUserProfile" />
                </div>
                <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
                    <div class="card BoxEffect6 mt-2 mb-2">
                        <div class="card-header">
                            <div class="float-right">
                            </div>
                            Friend Request Received
                               
                                    <asp:Label ID="LabelUserName" runat="server" Visible="False" Text=""></asp:Label>
                            <asp:Label ID="LabelProfileUserId" runat="server" Text="" Visible="False"></asp:Label>
                            <asp:Label ID="LabelProfileRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
                        </div>
                        <div class="card-body">
                            <asp:ListView ID="ListViewFollowing" runat="server" DataSourceID="SqlDataSourceFollowing" DataKeyNames="userid">


                                <EmptyDataTemplate>
                                    <span>No friend request pending.</span>
                                </EmptyDataTemplate>

                                <ItemTemplate>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-12">
                                        <uc1:UserInfoBox runat="server" ID="UserInfoBox" RoutUserName='<%# Eval("RoutUserName") %>' UserId='<%# Eval("userid") %>' UserName='<%# Eval("userName") %>' ImageFileName='<%# Bind("userimagefilename") %>' />
                                    </div>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div runat="server" id="itemPlaceholderContainer" class="row">
                                        <div runat="server" id="itemPlaceholder" />
                                    </div>

                                </LayoutTemplate>

                            </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourceFollowing" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                SelectCommand="SELECT TU.userName,  TU.userid, TU.imageid, TU.RoutUserName, TI.ImageFileName as userimagefilename 
                                 FROM [table_User] TU
                                 left JOIN table_image TI ON TU.ImageID=TI.ImageID 
                                 left JOIN Table_UserRelation TUR1 on TU.userid = TUR1.Second_UserId
                                 left JOIN Table_UserRelation TUR2 on TU.userid = TUR2.First_UserId 
                                 Where ((TUR1.[First_UserId] = @UserId) and (TUR1.FriendStatus='RequestReceived')) or ((TUR2.[Second_UserId] = @UserId) and (TUR2.FriendStatus='RequestSent'))
                                 group by TU.userName, TU.userid, TU.imageid, TU.RoutUserName, TI.ImageFileName">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="LabelProfileUserId" PropertyName="Text" Name="UserId" Type="Decimal"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                        <div class="card-footer clearfix ">
                            <div class="float-Left"></div>
                            <div class="float-right">
                                <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ListViewFollowing">
                                    <Fields>
                                        <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                                    </Fields>
                                </asp:DataPager>
                            </div>
                        </div>
                    </div>
                       <div class="card BoxEffect6 mt-2 mb-2">
                        <div class="card-header ">Active Users</div>
                        <uc1:UserSuggestionByLastActive runat="server" ID="UserSuggestionByLastActive" />
                    </div>
                </div>
            </div>

</asp:Content>

