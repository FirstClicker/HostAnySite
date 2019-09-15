<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>
<%@ Register Src="~/App_Controls/WebSettingUpdaterText.ascx" TagPrefix="uc1" TagName="WebSettingUpdaterText" %>
<%@ Register Src="~/App_Controls/UserDetailsInListView.ascx" TagPrefix="uc1" TagName="UserDetailsInListView" %>



<script runat="server">

    Protected Sub ListViewUserDetails_ItemUpdating(sender As Object, e As ListViewUpdateEventArgs)
        Dim dd2 As DropDownList = TryCast(ListViewUserDetails.Items(e.ItemIndex).FindControl("DropDownListUserType"), DropDownList)
        If dd2 IsNot Nothing Then
            SqlDataSourceUserlist.UpdateParameters("Usertype").DefaultValue = dd2.SelectedValue
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header ">
                   List Of Users
                    <div class="float-right ">
                   
                    </div>
                </div>
                    <asp:ListView ID="ListViewUserDetails" runat="server" DataSourceID="SqlDataSourceUserlist" DataKeyNames="UserId"  OnItemUpdating="ListViewUserDetails_ItemUpdating">
                    <EmptyDataTemplate>
                        <span>No User found..</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <div class="list-group-item">
                            <uc1:UserDetailsInListView runat="server" ID="UserDetailsInListView" Userid='<%# Eval("Userid") %>' UserName='<%# Eval("UserName") %>' UserEmail='<%# Eval("Email") %>' UserType='<%# [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Eval("userType"), True) %>' AccountStatus='<%# [Enum].Parse(GetType(FirstClickerService.Version1.User.AccountStatus), Eval("AccountStatus"), True) %>' />
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
                    SelectCommand="SELECT [UserId], [UserName], [RoutUserName], [UserType], [EmailVerified], [Email], [AccountStatus], [JoinDate], [LastLogInDate] FROM [Table_User] ORDER BY [LastLogInDate] DESC">
                </asp:SqlDataSource>
                <div class="card-footer clearfix ">
                    <div class="float-right ">
                        <asp:DataPager runat="server" ID="DataPager2" PagedControlID="ListViewUserDetails">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>


        </div>
    </div>
</asp:Content>

