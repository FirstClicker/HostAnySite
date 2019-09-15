<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>

<script runat="server">
    ' version 19/08/2018 # 2.42 AM


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If



        If IsPostBack = False Then
            Dim myConn As SqlConnection
            Dim myCmd As SqlCommand
            Dim myReader As SqlDataReader

            myConn = New SqlConnection(WebAppSettings.DBCS)
            myCmd = myConn.CreateCommand
            myConn.Open()

            myCmd.CommandText = "Select count(*) as NumberOfDeletableTempImage From Table_ImageTemp Where (DateUpdated < '" & Now.AddDays(-10D).ToString("yyyy-MM-ddTHH:mm:ss") & "')"
            myReader = myCmd.ExecuteReader()
            myReader.Read()
            LabelDeletableTempImage.Text = myReader.Item("NumberOfDeletableTempImage")
            myReader.Close()


            myCmd.CommandText = "Select count(*) as NumberOfTotalTempImage From Table_ImageTemp"
            myReader = myCmd.ExecuteReader()
            myReader.Read()
            LabelTotalTempImage.Text = myReader.Item("NumberOfTotalTempImage")
            myReader.Close()

            myConn.Close()

            ButtonCreateChart_Click(sender, e)
        End If
    End Sub

    Protected Sub ButtonCreateChart_Click(sender As Object, e As EventArgs)
        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        Dim CategoriesAxis As String = "0"
        Dim LineChartSeries As String = "0"
        Dim LineChartSeriesUpdateCount As String = "0"

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myConn.Open()

        myCmd.CommandText = "select CAST(DateUpdated AS DATE) as DateField, count(*) as RecordsPerGroup from Table_ImageTemp GROUP BY CAST(DateUpdated AS DATE) order by DateField asc"
        myReader = myCmd.ExecuteReader
        Do While myReader.Read
            CategoriesAxis = CategoriesAxis & ", " & myReader.Item("DateField")
            LineChartSeries = LineChartSeries & ", " & myReader.Item("RecordsPerGroup")
        Loop
        myReader.Close()


        myCmd.CommandText = "select CAST(DateUpdated AS DATE) as DateField, SUM(CASE WHEN UpdateCount>0 THEN 1 ELSE 0 END) AS RecordsPerGroup from Table_ImageTemp GROUP BY CAST(DateUpdated AS DATE) order by DateField asc"
        myReader = myCmd.ExecuteReader
        Do While myReader.Read
            LineChartSeriesUpdateCount = LineChartSeriesUpdateCount & ", " & myReader.Item("RecordsPerGroup")
        Loop
        myReader.Close()
        myConn.Close()


        Dim LineChartSerieslist As String() = LineChartSeries.Split(",")
        Dim LineChartSeriesdata(LineChartSerieslist.Length) As Decimal

        For j As Integer = 0 To LineChartSerieslist.Length - 1
            LineChartSeriesdata(j) = LineChartSerieslist(j)
        Next


        Dim LineChartSerieslist2 As String() = LineChartSeriesUpdateCount.Split(",")
        Dim LineChartSeriesdata2(LineChartSerieslist2.Length) As Decimal

        For k As Integer = 0 To LineChartSerieslist2.Length - 1
            LineChartSeriesdata2(k) = LineChartSerieslist2(k)
        Next


        LineChartError.CategoriesAxis = CategoriesAxis
        LineChartError.Series.Add(New AjaxControlToolkit.LineChartSeries() With {.Data = LineChartSeriesdata, .Name = "TempImage Created."})
        LineChartError.Series.Add(New AjaxControlToolkit.LineChartSeries() With {.Data = LineChartSeriesdata2, .Name = "TempImage Updated."})
    End Sub


    Protected Sub ButtonDelete_Click(sender As Object, e As EventArgs)
        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        Dim TempImageId As New List(Of String)
        Dim ImageFileName As New List(Of String)
        Dim TempImageDate As New List(Of String)

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myConn.Open()

        myCmd.CommandText = "Select top " & Val(TextBoxCount.Text) & " TIT.TempID, TIT.DateUpdated, TI.ImageFileName From Table_ImageTemp TIT left join table_image TI on TI.ImageId = TIT.ImageId Where (TIT.DateUpdated < '" & Now.AddDays(-10D).ToString("yyyy-MM-ddTHH:mm:ss") & "') order by TIT.DateUpdated asc"
        myReader = myCmd.ExecuteReader()
        Do While myReader.Read
            TempImageId.Add(myReader.Item("TempID"))
            TempImageDate.Add(myReader.Item("DateUpdated"))
            ImageFileName.Add(myReader.Item("ImageFileName"))
        Loop

        myReader.Close()
        For r As Integer = 0 To TempImageId.Count - 1
            myCmd.CommandText = "delete from Table_ImageTemp where TempID='" & TempImageId(r) & "'"
            myReader = myCmd.ExecuteReader()
            If myReader.RecordsAffected = 1 Then
                Dim Finelfile As System.IO.FileInfo = New System.IO.FileInfo(Server.MapPath("~/Storage/temp/" & TempImageId(r) & Mid(ImageFileName(r), Len(ImageFileName(r)) - 3, 4))) '-- if the file exists on the server  
                If Finelfile.Exists Then
                    Try
                        Finelfile.Delete()
                        LabelMessage.Text = LabelMessage.Text & "Deleted DB record set (" & TempImageId(r) & ") and File (" & TempImageId(r) & Mid(ImageFileName(r), Len(ImageFileName(r)) - 3, 4) & ") deleted. (" & TempImageDate(r) & ")"
                    Catch ex As Exception
                        LabelMessage.Text = LabelMessage.Text & "Deleted DB record set (" & TempImageId(r) & ") But failed to delete File." & ex.Message
                    End Try
                Else
                    LabelMessage.Text = LabelMessage.Text & "Deleted DB record set (" & TempImageId(r) & ") But File not found on disk.."
                End If
            Else
                LabelMessage.Text = LabelMessage.Text & "failed to Delete DB record set (" & TempImageId(r) & ")."
            End If
            myReader.Close()

            LabelMessage.Text = LabelMessage.Text & " <br/> "
        Next

        myConn.Close()
    End Sub


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card">
                <div class="card-header clearfix">
                    <div class="float-left ">Delete Old Temp Wall (<asp:Label ID="LabelDeletableTempImage" runat="server" Text="0"></asp:Label>&nbsp;of&nbsp;<asp:Label ID="LabelTotalTempImage" runat="server" Text="0"></asp:Label>)</div>
                    <div class="float-right ">
                        <asp:Button ID="ButtonCreateChart" runat="server" Text="Chart" CssClass="btn btn-info" OnClick="ButtonCreateChart_Click" />
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <td>
                                    <ajaxToolkit:LineChart ID="LineChartError" runat="server"
                                        ChartHeight="300" ChartWidth="2000" ChartType="Basic"
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
                <div class="card-body ">
                    <div class="card">
                        <div class="card-body">
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Delete Temp Wall</span>
                                    </div>
                                    <asp:TextBox CssClass="form-control" ID="TextBoxCount" runat="server" Text="500"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:Button ID="ButtonDelete" CssClass="btn btn-info" runat="server" Text="Delete" OnClick="ButtonDelete_Click" />
                                    </div>
                                </div>
                            </div>

                            <hr />
                            <asp:Label ID="LabelMessage" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
</asp:Content>

