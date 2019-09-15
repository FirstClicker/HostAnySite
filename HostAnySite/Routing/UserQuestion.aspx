<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Implements Interface="RoutUserInterface" %>

<%@ Register Src="~/App_Controls/NavigationSideUserProfile.ascx" TagPrefix="uc1" TagName="NavigationSideUserProfile" %>
<%@ Register Src="~/App_Controls/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/App_Controls/BlogPreviewInList.ascx" TagPrefix="uc1" TagName="BlogPreviewInList" %>




<script runat="server">
    Private m_RoutFace_RoutUserName As String
    Public Property RoutFace_RoutUserName() As String Implements RoutUserInterface.RoutIFace_RoutUserName
        Get
            Return m_RoutFace_RoutUserName
        End Get
        Set(ByVal value As String)
            m_RoutFace_RoutUserName = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim userinfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_RoutUserName(RoutFace_RoutUserName, WebAppSettings.DBCS)
            If userinfo.Result = False Then
                Response.Redirect("~/")
                Exit Sub
            End If

            NavigationSideUserProfile.UserName = Trim(userinfo.UserName)
            NavigationSideUserProfile.ImageFileName = userinfo.UserImage.ImageFileName
            NavigationSideUserProfile.RoutUserName = userinfo.RoutUserName
            NavigationSideUserProfile.UserID = userinfo.UserID

            ImageUserBanner.ImageUrl = "~/storage/image/" & userinfo.BannerImage.ImageFileName

            HyperLinkPageHeading.Text = userinfo.UserName & "'s Questions"
            HyperLinkPageHeading.NavigateUrl = "~/user/" & userinfo.RoutUserName & "/Question"
        End If

        Me.Title = NavigationSideUserProfile.UserName & "'s Questions"
        Me.MetaDescription = NavigationSideUserProfile.UserName & "'s Questions"
        Me.MetaKeywords = ""
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <div class="card  m-1 BoxEffect8">
                <asp:Image ID="ImageUserBanner" ImageUrl="~/Content/image/ProfileBanner.png" CssClass="img-fluid" runat="server" />
            </div>
        </div>
    </div>

  
            <div class="row">
                <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
                    <uc1:NavigationSideUserProfile runat="server" ID="NavigationSideUserProfile" />
                </div>
                <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">

                    <div class="card mt-2 BoxEffect6 ">
                        <div class="card-header clearfix ">
                            <div class="float-right ">
                            </div>
                            <h5 class="card-title m-0 ">
                                <asp:HyperLink ID="HyperLinkPageHeading" runat="server" NavigateUrl="~/question/Default.aspx" Text="Question"></asp:HyperLink>
                            </h5>
                        </div>
                    </div>
                        <div class="card-body">
                            <asp:ListView ID="ListViewPublicForom" runat="server" DataSourceID="SqlDataSourcePubicForum" DataKeyNames="QuestionId">
                                <EmptyDataTemplate>
                                    <div class="table-responsive ">
                                        <table runat="server" class="table">
                                            <thead>
                                                <tr runat="server">
                                                    <th runat="server" class="text-left ">Recently Asked</th>
                                                    <th runat="server" class="text-center">Answers</th>
                                                    <th runat="server" class="d-none d-md-block">Created On</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr runat="server">
                                                    <td>No Question found.</td>
                                                    <td></td>
                                                    <td class="d-none d-md-block"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td class="text-left">
                                            <h4>
                                                <asp:HyperLink Text='<%# Eval("Question") %>' CssClass=" text-capitalize " NavigateUrl='<%#"~/Question/Asked/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Question")) & "/" & Eval("QuestionId")  %>' runat="server" ID="HeadingLabel" /><br>
                                                <small>
                                                    <asp:Label Text='<%# Eval("Drescption") %>' CssClass=" text-capitalize " runat="server" ID="DrescptionLabel" />
                                                </small>
                                            </h4>
                                            <div class="d-md-none">
                                                <asp:HyperLink ID="HyperLink1" CssClass=" text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                                <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("postDate"))%>' /></small>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                            <asp:Label ID="LabelTC" runat="server" CssClass="label label-success" Text='<%# Eval("AnswerCount") %>' />
                                        </td>

                                        <td class="d-none d-md-block">
                                            <asp:HyperLink ID="HyperLinkUserName" CssClass=" text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                            <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                                <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("postDate"))%>' /></small>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div class="table-responsive ">
                                        <table runat="server" class="table">
                                            <thead>
                                                <tr runat="server">
                                                    <th runat="server" class="text-left ">Recently Asked</th>
                                                    <th runat="server" class="text-center">Answer</th>
                                                    <th runat="server" class="d-none d-md-block">Posted On</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr runat="server" id="itemPlaceholder"></tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </LayoutTemplate>
                            </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="SqlDataSourcePubicForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                SelectCommand="SELECT TQ.QuestionId, TQ.Question, TQ.Drescption, TQ.UserId, TQ.postDate, TU.username, TU.routusername, TUI.ImageFileName, count(DISTINCT TQA.AnswerID) as AnswerCount
                          FROM [Table_Question] TQ
                          left JOIN table_User TU on TU.userid = TQ.userid
                          left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                          left JOIN Table_QuestionAnswer TQA on TQ.QuestionID = TQA.QuestionID
                        WHERE (TQ.userid = @UserID) 
                          Group By TQ.QuestionId, TQ.Question, TQ.Drescption, TQ.UserId, TQ.postDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY TQ.[postdate] DESC">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="NavigationSideUserProfile" PropertyName="userid" Name="UserID" Type="String"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <div class="card-footer clearfix">
                                <div class="float-right">
                                    <asp:DataPager runat="server" ID="DataPagerPublicForom" PagedControlID="ListviewPublicForom">
                                        <Fields>
                                            <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                                <div class="float-Left"></div>
                            </div>
                        </div>
                  
                </div>
            </div>
     

</asp:Content>

