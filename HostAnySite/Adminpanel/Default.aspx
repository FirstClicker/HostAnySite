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

        If IsPostBack = False Then
            Dim myConn As SqlConnection
            Dim myCmd As SqlCommand
            Dim myReader As SqlDataReader

            myConn = New SqlConnection(WebAppSettings.DBCS)
            myCmd = myConn.CreateCommand
            myConn.Open()

            myCmd.CommandText = "select count(0) as TotalError from Table_ErrorPublic"
            myReader = myCmd.ExecuteReader
            If myReader.HasRows = True Then
                myReader.Read()
                LabelErrorCount.Text = myReader.Item("TotalError")
            End If

            myReader.Close()
            myConn.Close()
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
          <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="card  m-3 BoxEffect4">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-3">
                                        <i class="fa fa-comments fa-5x"></i>
                                    </div>
                                    <div class="col-9 text-right">
                                        <div class="huge">26</div>
                                        <div>New Comments!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="card-footer">
                                    <span class="float-left">View Details</span>
                                    <span class="float-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="card  m-3 BoxEffect4">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-3">
                                        <i class="fa fa-tasks fa-5x"></i>
                                    </div>
                                    <div class="col-9 text-right">
                                        <div class="huge">12</div>
                                        <div>New Tasks!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="card-footer">
                                    <span class="float-left">View Details</span>
                                    <span class="float-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="card m-3 BoxEffect4 ">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-3">
                                        <i class="fa fa-exclamation-triangle fa-5x"></i>
                                    </div>
                                    <div class="col-9 text-right">
                                        <div class="badge badge-dark">
                                            <asp:Label ID="LabelErrorCount" runat="server" Text="0"></asp:Label></div>
                                        <div>Errors!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="card-footer">
                                    <span class="float-left">
                                        <asp:HyperLink ID="HyperLinkErrors" runat="server" NavigateUrl="~/AdminPanel/Errors/Default.aspx">View Details</asp:HyperLink></span>
                                    <span class="float-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="card  m-3 BoxEffect4">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-3">
                                        <i class="fas fa-phone-square fa-5x"></i>
                                    </div>
                                    <div class="col-9 text-right">
                                        <div class="huge">13</div>
                                        <div>Support Tickets!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="card-footer">
                                    <span class="float-left">View Details</span>
                                    <span class="float-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header ">WebApp Starting Value</div>
                <div class="card-body ">
                    <table>
                        <tr>
                            <td>WebSiteName</td>
                            <td><%=WebAppSettings.WebSiteName %></td>
                        </tr>
                        <tr>
                            <td>CopyRightText</td>
                            <td><%=WebAppSettings.CopyRightText %></td>
                        </tr>
                        <tr>
                            <td>WebSiteCurrentTheme</td>
                            <td><%=WebAppSettings.WebSiteCurrentTheme %></td>
                        </tr>
                        <tr>
                            <td>UserEmailVerificationRequired</td>
                            <td><%=WebAppSettings.UserEmailVerificationRequired %></td>
                        </tr>
                        <tr>
                            <td>ReCaptcha_IsEnabled</td>
                            <td><%=WebAppSettings.ReCaptcha_IsEnabled %></td>
                        </tr>
                        <tr>
                            <td>DefaultImgID_UserAvtar</td>
                            <td><%=WebAppSettings.DefaultImgID_UserAvtar %></td>
                        </tr>
                        <tr>
                            <td>DefaultImgID_ProfileBanner</td>
                            <td><%=WebAppSettings.DefaultImgID_ProfileBanner %></td>
                        </tr>
                        <tr>
                            <td>DefaultImgID_ComparisonEntry</td>
                            <td><%=WebAppSettings.DefaultImgID_ComparisonEntry %></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>










</asp:Content>

