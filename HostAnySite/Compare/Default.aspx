<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface ="RoutSiteHomeInterface"  %>

<%@ Register Src="~/App_Controls/ComparisonListPreviewInList.ascx" TagPrefix="uc1" TagName="ComparisonListPreviewInList" %>


<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row">
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                  <div class="card-header clearfix">
                    <div class="float-right"></div>
                      <h5 class="card-title m-0 ">
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Compare/Default.aspx" >Compare List</asp:HyperLink>
                    </h5>
                </div>
                      <div class="card-body" style="padding: 0px;">
                    <asp:ListView ID="ListViewComparisonList" runat="server" DataSourceID="SqlDataSourceComparisonList" DataKeyNames="ListID">
                        <EmptyDataTemplate>
                            <span>No List Found.</span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <uc1:ComparisonListPreviewInList runat="server" ID="ComparisonListPreviewInList" ListID='<%# Eval("ListID") %>' ListHeading='<%# Eval("Heading") %>' UserID='<%# Eval("UserID") %>' UserName='<%# Eval("UserName") %>' RoutUserName='<%# Eval("RoutUserName") %>' CreateDate='<%# Eval("CreateDate") %>' />
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style="">
                                <div runat="server" id="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceComparisonList" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT TCL.*, CONVERT(VARCHAR(19), TCL.CreateDate, 120) AS CreateDateF, Tu.userId, Tu.UserName, Tu.routUserName 
                        FROM [Table_ComparisonList] TCL 
                        Left join Table_user TU on Tu.userid=Tcl.userID 
                        ORDER BY TCL.[CreateDate] DESC"></asp:SqlDataSource>
                </div>
                <div class="card-footer clearfix ">
                    <div class="float-right ">
                        <asp:DataPager runat="server" ID="DataPagerComparisonList" PagedControlID="ListViewComparisonList">
                            <Fields>
                                <asp:NumericPagerField></asp:NumericPagerField>
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
         <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
             <div class="card">
                 
             </div>
        </div>
    </div> 
</asp:Content>

