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

        LabelProfileRoutUserName.Text = userinfo.RoutUserName


        LabelProfileUserId.Text = Val(userinfo.UserID)


        LabelUserName.Text = userinfo.UserName


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
                        <div class="row">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    Friend Request Sent
                              <asp:Label ID="LabelUserName" runat="server" Visible="False" Text=""></asp:Label>
                                    <asp:Label ID="LabelProfileUserId" runat="server" Text="" Visible="False"></asp:Label>
                                    <asp:Label ID="LabelProfileRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
                                </div>
                                <div class="panel-body">
                                    <asp:ListView ID="ListViewFollowing" runat="server" DataSourceID="SqlDataSourceFollowing" DataKeyNames="userid">


                                        <EmptyDataTemplate>
                                            <span>No friend request pending.</span>
                                        </EmptyDataTemplate>

                                        <ItemTemplate>
                                            <span style="">
                                                <uc1:UserInfoBox runat="server" ID="UserInfoBox" RoutUserName='<%# Eval("RoutUserName") %>' UserId='<%# Eval("userid") %>' UserName='<%# Eval("userName") %>' ImageFileName='<%# Bind("userimagefilename") %>' />
                                            </span>
                                        </ItemTemplate>
                                        <LayoutTemplate>
                                            <div runat="server" id="itemPlaceholderContainer" class="row">
                                                <span runat="server" id="itemPlaceholder" />
                                            </div>

                                        </LayoutTemplate>

                                    </asp:ListView>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSourceFollowing" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                        SelectCommand="SELECT TU.userName,  TU.userid, TU.imageid, TU.RoutUserName, TI.ImageFileName as userimagefilename, TIB.ImageFileName as BannerImageFileName 
                                 FROM [table_User] TU
                                 left JOIN table_image TI ON TU.ImageID=TI.ImageID 
                                 left JOIN table_image TIB ON TU.BannerImageID=TIB.ImageID 
                                 left JOIN Table_UserRelation TUR1 on TU.userid = TUR1.Second_UserId
                                 left JOIN Table_UserRelation TUR2 on TU.userid = TUR2.First_UserId 
                                 Where ((TUR1.[First_UserId] = @UserId) and (TUR1.FriendStatus='RequestSent')) or ((TUR2.[Second_UserId] = @UserId) and (TUR2.FriendStatus='RequestReceived'))
                                 group by TU.userName, TU.userid, TU.imageid, TU.RoutUserName, TI.ImageFileName, TIB.ImageFileName">
                                        <SelectParameters>
                                          <asp:ControlParameter ControlID="LabelProfileUserId" PropertyName="Text" Name="UserId" Type="Decimal"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="panel-footer clearfix ">
                                    <div class="pull-Left"></div>
                                    <div class="pull-right">
                                        <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ListViewFollowing">
                                            <Fields>
                                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                                            </Fields>
                                        </asp:DataPager>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="col-lg-3">
            </div>
        </div>
    </div>
</asp:Content>

