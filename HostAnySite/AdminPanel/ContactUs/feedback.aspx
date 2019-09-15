<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>



<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        SqlDataSourceContactus.ConnectionString = WebAppSettings.DBCS
        labelDomain.Text = WebAppSettings.WebSiteName
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="labelDomain" runat="server" Text="" Visible="False"></asp:Label>
    <div class="row">
       <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class=" card-header clearfix">
                    Contact Us Messages
                </div>

                <asp:ListView ID="ListViewContactUs" runat="server" DataSourceID="SqlDataSourceContactus" DataKeyNames="ID">

                    <EmptyDataTemplate>
                        <div class="list-group-item ">No data was returned.</div>
                    </EmptyDataTemplate>

                    <ItemTemplate>
                        <div class="list-group-item ">
                            ID:
                                <asp:Label Text='<%# Eval("ID") %>' runat="server" ID="IDLabel" /><br />
                            Email:
                                <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" /><br />
                            Name:
                                <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /><br />
                            Phone:
                                <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /><br />
                            Address:
                                <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" /><br />
                            FeedbackType:
                                <asp:Label Text='<%# Eval("FeedbackType") %>' runat="server" ID="FeedbackTypeLabel" /><br />
                            Domain:
                                <asp:Label Text='<%# Eval("Domain") %>' runat="server" ID="DomainLabel" /><br />
                            Heading:
                                <asp:Label Text='<%# Eval("Heading") %>' runat="server" ID="HeadingLabel" /><br />
                            Message:
                                <asp:Label Text='<%# Eval("Message") %>' runat="server" ID="MessageLabel" /><br />
                            FeedbackDate:
                                <asp:Label Text='<%# Eval("FeedbackDate") %>' runat="server" ID="FeedbackDateLabel" /><br />
                            ThreadID:
                                <asp:Label Text='<%# Eval("ThreadID") %>' runat="server" ID="ThreadIDLabel" /><br />
                            Status:
                                <asp:Label Text='<%# Eval("Status") %>' runat="server" ID="StatusLabel" /><br />
                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                            <br />
                            <br />
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholderContainer" class="list-group ">
                            <div runat="server" id="itemPlaceholder" />
                        </div>

                    </LayoutTemplate>
                </asp:ListView>

                <asp:SqlDataSource runat="server" ID="SqlDataSourceContactus"
                    SelectCommand="SELECT * FROM [Table_Feedback] where domain like  '%' + @domain + '%' ORDER BY [FeedbackDate] DESC"
                    DeleteCommand="DELETE FROM [Table_Feedback] WHERE [ID] = @ID">
                    <DeleteParameters>
                        <asp:Parameter Name="ID" Type="Decimal"></asp:Parameter>
                    </DeleteParameters>
                    <SelectParameters >
                          <asp:ControlParameter ControlID="labelDomain" PropertyName="text" Name="domain" Type="String"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <div class="card-footer clearfix">
                    <div class="pull-right ">
                        <asp:DataPager runat="server" ID="DataPagerContactUs" PagedControlID="ListViewContactUs">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                <asp:NumericPagerField></asp:NumericPagerField>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
    </div> 
</asp:Content>

