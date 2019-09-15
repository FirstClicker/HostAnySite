<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card ">
                <div class="card-header ">Inbox</div>
                <asp:ListView ID="ListViewInbox" runat="server" DataSourceID="SqlDataSourceInbox" DataKeyNames="UserId">
                    <EmptyDataTemplate>
                        <div class="list-group">
                            <div class="list-group-item">No message history.. </div>
                        </div>
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
                                    group by t.[UserId], t.[UserName], t.[RoutUserName], t.imageid,  ti.ImageFileName
                                   ">
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
</asp:Content>

