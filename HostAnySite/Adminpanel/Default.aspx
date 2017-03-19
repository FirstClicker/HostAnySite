<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/app_controls/web/NavigationSideAdmin.ascx" TagPrefix="uc1" TagName="NavigationSideAdmin" %>
<%@ Register Src="~/app_controls/web/ValidateAdminUserAccess.ascx" TagPrefix="uc1" TagName="ValidateAdminUserAccess" %>



<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Try
                ClassHostAnySite.ReportDomain.Reportdoamin(Request.Url.Host, ClassAppDetails.DatabaseVersion)
            Catch ex As Exception

            End Try
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:ValidateAdminUserAccess runat="server" id="ValidateAdminUserAccess" />
     <div class="row">
        <div class="col-md-3 col-sm-3">
            <uc1:NavigationSideAdmin runat="server" ID="NavigationSideAdmin" />
        </div>
        <div class="col-md-8 col-sm-8">
           <div class="panel panel-default">
                <div class="panel-heading">Activity</div>
                <div class="panel-body">
                    <asp:ListView ID="ListViewActivity" runat="server" DataSourceID="SqlDataSourceActivity">
                    
                        <EditItemTemplate>
                            <span style="">Activity:
                                <asp:TextBox Text='<%# Bind("Activity") %>' runat="server" ID="ActivityTextBox" /><br />
                                UserId:
                                <asp:TextBox Text='<%# Bind("UserId") %>' runat="server" ID="UserIdTextBox" /><br />
                                ActivityDate:
                                <asp:TextBox Text='<%# Bind("ActivityDate") %>' runat="server" ID="ActivityDateTextBox" /><br />
                                <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" /><asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" /><br />
                                <br />
                            </span>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <span>No activity.</span>
                        </EmptyDataTemplate>
                        <InsertItemTemplate>
                            <span style="">Activity:
                                <asp:TextBox Text='<%# Bind("Activity") %>' runat="server" ID="ActivityTextBox" /><br />
                                UserId:
                                <asp:TextBox Text='<%# Bind("UserId") %>' runat="server" ID="UserIdTextBox" /><br />
                                ActivityDate:
                                <asp:TextBox Text='<%# Bind("ActivityDate") %>' runat="server" ID="ActivityDateTextBox" /><br />
                                <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /><asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" /><br />
                                <br />
                            </span>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <div class="list-group-item">Activity:
                                <asp:Label Text='<%# Eval("Activity") %>' runat="server" ID="ActivityLabel" /><br />
                               
                                <asp:Label Text='<%# Eval("UserId") %>' runat="server" ID="UserIdLabel" /> - 
                              
                                <asp:Label Text='<%# Eval("ActivityDate") %>' runat="server" ID="ActivityDateLabel" /><br />
                             </div>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" class="list-group">
                                <div runat="server" id="itemPlaceholder" />

                            </div>
                            <div style="">
                                <asp:DataPager runat="server" ID="DataPager1">
                                    <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                                    </Fields>
                                </asp:DataPager>

                            </div>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <span style="">Activity:
                                <asp:Label Text='<%# Eval("Activity") %>' runat="server" ID="ActivityLabel" /><br />
                                UserId:
                                <asp:Label Text='<%# Eval("UserId") %>' runat="server" ID="UserIdLabel" /><br />
                                ActivityDate:
                                <asp:Label Text='<%# Eval("ActivityDate") %>' runat="server" ID="ActivityDateLabel" /><br />
                                <br />
                            </span>
                        </SelectedItemTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceActivity" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' SelectCommand="SELECT [Activity], [UserId], [ActivityDate] FROM [Table_Activity] ORDER BY [ActivityDate] DESC"></asp:SqlDataSource>
                </div> </div> 
        </div>
       
    </div>
</asp:Content>


