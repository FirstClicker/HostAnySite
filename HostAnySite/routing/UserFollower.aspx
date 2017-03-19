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
                                    Follower
                              <asp:Label ID="LabelUserName" runat="server" Visible="False" Text=""></asp:Label>
                                    <asp:Label ID="LabelProfileUserId" runat="server" Text="" Visible="False"></asp:Label>
                                    <asp:Label ID="LabelProfileRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
                                </div>
                                <div class="panel-body">
                                    <asp:ListView ID="ListViewFollower" runat="server" DataSourceID="SqlDataSourceFollower" DataKeyNames="userid">


                                        <EmptyDataTemplate>
                                            <span>No one following yet.</span>
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
                                    <asp:SqlDataSource runat="server" ID="SqlDataSourceFollower" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                        SelectCommand="SELECT t.userName,  t.userid, t.imageid, t.RoutUserName, t3.ImageFileName as userimagefilename 
                                 FROM [table_User] t
                                  left JOIN Table_UserRelation t1 on t.userid = t1.Second_UserId
                                  left JOIN Table_UserRelation t2 on t.userid = t2.First_UserId
                                  left JOIN table_image t3 ON t.ImageID=t3.ImageID 
                                  WHERE ((t1.[First_UserId] = @First_UserId) AND ((t1.[FollowStatus]='connected') or (t1.[FollowStatus]='Follower'))) or ((t2.[Second_UserId] = @Second_UserId) AND ((t2.[FollowStatus]='connected') or (t2.[FollowStatus]='following')))
                                  group by t.userName,  t.userid, t.imageid, t.RoutUserName, t3.ImageFileName
                                 ">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="LabelProfileUserId" PropertyName="Text" Name="First_UserId" Type="Decimal"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="LabelProfileUserId" PropertyName="Text" Name="Second_UserId" Type="Decimal"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                                <div class="panel-footer clearfix ">
                                    <div class="pull-Left"></div>
                                    <div class="pull-right">
                                        <asp:DataPager runat="server" ID="DataPagerFollower" PagedControlID="ListViewFollower">
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

