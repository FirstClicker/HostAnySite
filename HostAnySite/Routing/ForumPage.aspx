<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/App_Controls/TagOfAllForums.ascx" TagPrefix="uc1" TagName="TagOfAllForums" %>
<%@ Register Src="~/App_Controls/PagingControl.ascx" TagPrefix="uc1" TagName="PagingControl" %>



<script runat="server">
    ' version 12/09/2018 # 20.27 

    Private m_RoutIFace_String1 As String
    Public Property RoutIFace_String1 As String Implements RoutBoardUniInterface.RoutIFace_String1
        Get
            Return m_RoutIFace_String1
        End Get
        Set(value As String)
            m_RoutIFace_String1 = value
        End Set
    End Property

    Private m_RoutIFace_Pagenum As String
    Public Property RoutIFace_Pagenum() As String Implements RoutBoardUniInterface.RoutIFace_String2
        Get
            Return m_RoutIFace_Pagenum
        End Get
        Set(ByVal value As String)
            m_RoutIFace_Pagenum = Val(value)
        End Set
    End Property

    Private m_RoutIFace_String3 As String
    Public Property RoutIFace_String3 As String Implements RoutBoardUniInterface.RoutIFace_String3
        Get
            Return m_RoutIFace_String3
        End Get
        Set(value As String)
            m_RoutIFace_String3 = value
        End Set
    End Property

    Private m_RoutIFace_String4 As String
    Public Property RoutIFace_String4 As String Implements RoutBoardUniInterface.RoutIFace_String4
        Get
            Return m_RoutIFace_String4
        End Get
        Set(value As String)
            m_RoutIFace_String4 = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)

        If IsPostBack = False Then
            If Val(RoutIFace_Pagenum) <= 0 Then
                RoutIFace_Pagenum = 1
            End If
            DataPagerForum.SetPageProperties((RoutIFace_Pagenum * DataPagerForum.PageSize) - DataPagerForum.PageSize, DataPagerForum.PageSize, True)

            PagingControl.CurrentPage = RoutIFace_Pagenum
            PagingControl.BaseURL = "~/Forum/"
        End If


        Title = WebAppSettings.WebSiteName & ": Start your own free forum, social network and social community- Page " & RoutIFace_Pagenum
        MetaDescription = WebAppSettings.WebSiteName & " is best online discussion forums. Create a free forum in seconds. Unlimited threads, unlimited size and reach unlimited members. Create the community of your dreams with our free forums platform."

    End Sub

    Protected Sub SqlDataSourcePubicForum_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        PagingControl.LastPage = CInt(e.AffectedRows / DataPagerForum.PageSize)
        If e.AffectedRows > Val(PagingControl.LastPage) * DataPagerForum.PageSize Then
            PagingControl.LastPage = Val(PagingControl.LastPage) + 1
        End If
    End Sub
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
                        <i class="fab fa-foursquare"></i>&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Forum/Default.aspx">Forum</asp:HyperLink>
                    </h5>
                </div>
            </div>
            <div class="card-body">
                <asp:ListView ID="ListViewPublicForom" runat="server" DataSourceID="SqlDataSourcePubicForum" DataKeyNames="ForumId">
                    <EmptyDataTemplate>
                        <div class="table-responsive ">
                            <table runat="server" class="table">
                                <thead>
                                    <tr runat="server">
                                        <th runat="server" class="text-left ">Forum Heading</th>
                                        <th runat="server" class="text-center">Topics</th>
                                        <th runat="server" class="text-center">Posts</th>
                                        <th runat="server" class="d-none d-md-block">Create On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server">
                                        <td>No forum found.</td>
                                        <td></td>
                                        <td></td>
                                        <td class="d-none d-md-block"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="text-left ">
                                <h4>
                                    <asp:HyperLink Text='<%# Eval("Heading") %>' CssClass=" text-capitalize " NavigateUrl='<%#"~/forum/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Heading")) & "/" & Eval("ForumId") %>' runat="server" ID="HeadingLabel" /><br>
                                    <small>
                                        <asp:Label Text='<%# Eval("Drescption") %>' CssClass=" text-capitalize " runat="server" ID="DrescptionLabel" />
                                    </small>
                                </h4>
                                <div class="d-md-none">
                                    <asp:HyperLink ID="HyperLink1" CssClass=" text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                    <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                        <asp:Label ID="Label1" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("CreateDate")) %>' /></small>
                                </div>
                            </td>
                            <td class="text-center">
                                <asp:Label ID="LabelTC" runat="server" CssClass="label label-success" Text='<%# Eval("TopicCount") %>' />
                            </td>
                            <td class="text-center">
                                <asp:Label ID="LabelTRC" runat="server" CssClass="label label-info" Text='<%# Eval("TopicReplyCount") %>' />
                            </td>
                            <td class="d-none d-md-block">
                                <asp:HyperLink ID="HyperLinkUserName" CssClass=" text-capitalize " runat="server" NavigateUrl='<%# "~/user/" + Eval("RoutUserName")%>'><%# Eval("Username")%></asp:HyperLink><br>
                                <small class="text-nowrap "><i class="fa fa-clock-o"></i>
                                    <asp:Label ID="NotificationDateLabel" runat="server" Text='<%# FirstClickerService.Common.ConvertDateTime4Use(Eval("CreateDate")) %>' /></small>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div class="table-responsive ">
                            <table runat="server" class="table">
                                <thead>
                                    <tr runat="server">
                                        <th runat="server" class="text-left ">Forum Heading</th>
                                        <th runat="server" class="text-center">Topics</th>
                                        <th runat="server" class="text-center">Posts</th>
                                        <th runat="server" class="d-none d-md-block">Create On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </tbody>
                            </table>
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourcePubicForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' OnSelected ="SqlDataSourcePubicForum_Selected"
                    SelectCommand="SELECT t.ForumId, t.Heading, t.Drescption, t.UserId, CONVERT(VARCHAR(19), t.CreateDate, 120) AS CreateDate, TU.username, TU.routusername, TUI.ImageFileName, count(DISTINCT TFT.topicid) as TopicCount, COUNT(DISTINCT TFTR.Id) as TopicReplyCount
                          FROM [Table_Forum] t
                          left JOIN table_User TU on TU.userid = t.userid
                          left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                          left JOIN Table_ForumTopic TFT on t.forumid = TFT.forumid
                          left JOIN Table_ForumTopicReply TFTR on TFT.TopicId = TFTR.TopicId
                          Group By  t.ForumId, t.Heading, t.Drescption, t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY t.[CreateDate] DESC"></asp:SqlDataSource>
                <div class="card-footer clearfix">
                    <div class="float-right">
                        <uc1:PagingControl runat="server" ID="PagingControl" />
                        <asp:DataPager runat="server" ID="DataPagerForum" QueryStringField="Page" PagedControlID="ListviewPublicForom" Visible ="false" >
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <div class="float-Left"></div>
                </div>
            </div>
            
        </div>
         <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">

             <uc1:TagOfAllForums runat="server" ID="TagOfAllForums" />
        </div>
    </div> 
</asp:Content>

