<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/app_controls/web/NavigationSideAdmin.ascx" TagPrefix="uc1" TagName="NavigationSideAdmin" %>
<%@ Register Src="~/app_controls/web/ValidateAdminUserAccess.ascx" TagPrefix="uc1" TagName="ValidateAdminUserAccess" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim myConn As SqlConnection
            Dim myCmd As SqlCommand
            Dim myReader As SqlDataReader

            Dim CategoriesAxis As String = "0"
            Dim LineChartSeries As String = "0"

            myConn = New SqlConnection(ClassAppDetails.DBCS)
            myCmd = myConn.CreateCommand
            myConn.Open()

            myCmd.CommandText = "select CAST(ErrorTime AS DATE) as DateField, count(*) RecordsPerGroup from Table_ErrorPublic where (ErrorTime > '" & Now.AddDays(-15D).ToString("yyyy-MM-ddTHH:mm:ss") & "') GROUP BY CAST(ErrorTime AS DATE) order by DateField asc"
            myReader = myCmd.ExecuteReader
            Do While myReader.Read
                CategoriesAxis = CategoriesAxis & ", " & myReader.Item("DateField")
                LineChartSeries = LineChartSeries & ", " & myReader.Item("RecordsPerGroup")
            Loop

            myReader.Close()
            myConn.Close()


            Dim LineChartSerieslist As String() = LineChartSeries.Split(",")
            Dim LineChartSeriesdata(LineChartSerieslist.Length) As Decimal

            For j As Integer = 0 To LineChartSerieslist.Length - 1
                LineChartSeriesdata(j) = LineChartSerieslist(j)
            Next

            LineChartError.CategoriesAxis = CategoriesAxis
            LineChartError.Series.Add(New AjaxControlToolkit.LineChartSeries() With {.Data = LineChartSeriesdata, .Name = "All"})
        End If
    End Sub

    Protected Sub ButtonClearError_Click(sender As Object, e As EventArgs)
        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(ClassAppDetails.DBCS)
        myCmd = myConn.CreateCommand
        myConn.Open()

        myCmd.CommandText = "delete from Table_ErrorPublic"
        myReader = myCmd.ExecuteReader

        myReader.Close()
        myConn.Close()

        Response.Redirect(Request.Url.ToString)

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
            <div class="panel panel-default ">

                <div class="table-responsive">
                    <table class="table">
                        <tr>
                            <td>
                                <ajaxToolkit:LineChart ID="LineChartError" runat="server"
                                    ChartWidth="1000" ChartHeight="300" ChartType="Basic"
                                    ChartTitle=""
                                    CategoriesAxis=""
                                    ChartTitleColor="#0E426C" CategoryAxisLineColor="#D08AD9"
                                    ValueAxisLineColor="#D08AD9" BaseLineColor="#A156AB" BorderStyle="None">
                                    <Series>
                                    </Series>
                                </ajaxToolkit:LineChart>
                            </td>
                        </tr>
                    </table>
                </div>


            </div>


        <div class="panel panel-default ">
            <div class="panel-heading clearfix">
                <div class="pull-right ">
                    <asp:Button ID="ButtonClearError" runat="server" Text="Clear Errors" CssClass ="btn btn-sm btn-danger" OnClick ="ButtonClearError_Click" />
                </div>
                <h1 class="panel-title ">Run Time Errors -  <%=Now.ToString  %></h1>

            </div>

            <div class="panel-body ">
                <asp:ListView ID="ListViewErrorPublic" runat="server" DataSourceID="SqlDataSourceErrorPublic">
                    <EmptyDataTemplate>
                        <span>No data was returned.</span>
                    </EmptyDataTemplate>

                    <ItemTemplate>
                        <span style="">ErrorTime:
                        <asp:Label Text='<%# Eval("ErrorTime") %>' runat="server" ID="ErrorTimeLabel" /><br />
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
                        <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                        <div style="">
                            <asp:DataPager runat="server" ID="DataPager1">
                                <Fields>
 <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />                                </Fields>
                            </asp:DataPager>

                        </div>
                    </LayoutTemplate>

                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceErrorPublic" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                    SelectCommand="SELECT * FROM [Table_ErrorPublic] ORDER BY [ErrorTime] DESC"></asp:SqlDataSource>
            </div>
        </div>


    </div>
    </div>
</asp:Content>
