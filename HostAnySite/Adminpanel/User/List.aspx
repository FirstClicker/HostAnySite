<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/app_controls/web/NavigationSideAdmin.ascx" TagPrefix="uc1" TagName="NavigationSideAdmin" %>
<%@ Register Src="~/app_controls/web/ValidateAdminUserAccess.ascx" TagPrefix="uc1" TagName="ValidateAdminUserAccess" %>
<%@ Register Src="~/app_controls/web/UserDetailsInListView.ascx" TagPrefix="uc1" TagName="UserDetailsInListView" %>



<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub


    Protected Sub ListViewUserDetails_ItemDataBound(sender As Object, e As ListViewItemEventArgs)


    End Sub

    Protected Sub ListViewUserDetails_ItemUpdating(sender As Object, e As ListViewUpdateEventArgs)
        Dim dd2 As DropDownList = TryCast(ListViewUserDetails.Items(e.ItemIndex).FindControl("DropDownListUserType"), DropDownList)
        If dd2 IsNot Nothing Then
            SqlDataSourceUserlist.UpdateParameters("Usertype").DefaultValue = dd2.SelectedValue
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateAdminUserAccess runat="server" ID="ValidateAdminUserAccess" />
    <div class="row">
       <div class="col-md-3 col-sm-3">
            <uc1:NavigationSideAdmin runat="server" ID="NavigationSideAdmin" />
        </div>
        <div class="col-md-8 col-sm-8">
            <div class="panel panel-default">
                <div class="panel-heading clearfix ">
                    <div class="pull-left ">User list</div>
                    <div class=" pull-right ">
                        <asp:DropDownList ID="DropDownListUserType" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <asp:ListView ID="ListViewUserDetails" runat="server" DataSourceID="SqlDataSourceUserlist" DataKeyNames="UserId" OnItemDataBound="ListViewUserDetails_ItemDataBound" OnItemUpdating="ListViewUserDetails_ItemUpdating">
                    <EmptyDataTemplate>
                        <span>No User found..</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                         <div class="list-group-item">
                        <uc1:UserDetailsInListView runat="server" ID="UserDetailsInListView"  Userid ='<%# Eval("Userid") %>' UserName ='<%# Eval("UserName") %>' UserEmail ='<%# Eval("Email") %>' userType='<%# [Enum].Parse(GetType(ClassHostAnySite.User.UserType), Eval("userType"), True) %>' AccountStatus ='<%# [Enum].Parse(GetType(ClassHostAnySite.User.AccountStatus), Eval("AccountStatus"), True) %>' />
                   </div> 
                              </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholderContainer" class="list-group">
                            <div runat="server" id="itemPlaceholder" />
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceUserlist"
                    ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                    SelectCommand="SELECT [UserId], [UserName], [RoutUserName], [UserType], [EmailVerified], [Email], [AccountStatus], [JoinDate], [LastLogInDate] FROM [Table_User] ORDER BY [LastLogInDate] DESC"
                    DeleteCommand="DELETE FROM [Table_User] WHERE [UserId] = @UserId"
                    InsertCommand="INSERT INTO [Table_User] ([UserId], [UserName], [RoutUserName], [UserType], [EmailVerified], [Email], [AccountStatus], [JoinDate], [LastLogInDate]) VALUES (@UserId, @UserName, @RoutUserName, @UserType, @EmailVerified, @Email, @AccountStatus, @JoinDate, @LastLogInDate)"
                    UpdateCommand="UPDATE [Table_User] SET [UserName] = @UserName, [RoutUserName] = @RoutUserName, [UserType] = @UserType, [EmailVerified] = @EmailVerified, [Email] = @Email, [AccountStatus] = @AccountStatus, [JoinDate] = @JoinDate, [LastLogInDate] = @LastLogInDate WHERE [UserId] = @UserId">
                    <DeleteParameters>
                        <asp:Parameter Name="UserId" Type="Decimal"></asp:Parameter>
                    </DeleteParameters>
                </asp:SqlDataSource>
                <div class="panel-footer clearfix ">
                    <div class="pull-right ">
                        <asp:DataPager runat="server" ID="DataPager2" PagedControlID="ListViewUserDetails">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

