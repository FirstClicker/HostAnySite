<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>

<script runat="server">
    ' version 18/08/2018 # 21.42 AM

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
            <uc1:navigationsideadminpanel runat="server" id="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix">
                    <div class="float-right ">
                    </div>
                    <h4 class="card-title ">Run Time Errors (Location) </h4>
                </div>


                <div class="card-body">
                    <asp:ListView ID="ListViewErrorPublic" runat="server" DataSourceID="SqlDataSourceErrorPublic">
                        <EmptyDataTemplate>
                            <span>No data was returned.</span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                              ErrorCount:
                        <asp:Label Text='<%# Eval("recordCount") %>' runat="server" ID="LabelrecordCount" /><br />
                                ErrorCode:
                        <asp:Label Text='<%# Eval("ErrorCode") %>' runat="server" ID="ErrorCodeLabel" /><br />
                                ErrorLocation:
                        <asp:Label Text='<%# Eval("ErrorLocation") %>' runat="server" ID="ErrorLocationLabel" /><br />
                                Message:
                        <asp:Label Text='<%# Eval("Message") %>' runat="server" ID="MessageLabel" /><br />
                                <br />
                            </span>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style="">
                                <span runat="server" id="itemPlaceholder" />
                            </div>
                            <div style="">
                                <asp:DataPager runat="server" ID="DataPager1">
                                    <Fields>
                                        <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                                    </Fields>
                                </asp:DataPager>
                            </div>
                        </LayoutTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceErrorPublic" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT count(0) as recordCount, ErrorLocation, ErrorCode, Message  FROM [Table_ErrorPublic] group by ErrorLocation, ErrorCode, Message ORDER BY recordCount DESC"></asp:SqlDataSource>
                </div>

            </div>

        </div>
    </div>

</asp:Content>

