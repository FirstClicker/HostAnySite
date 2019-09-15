<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/App_Controls/TagOfAllForums.ascx" TagPrefix="uc1" TagName="TagOfAllForums" %>



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


    Private m_RoutIFace_TagName As String
    Public Property RoutIFace_TagName() As String Implements RoutBoardUniInterface.RoutIFace_String2
        Get
            Return m_RoutIFace_TagName
        End Get
        Set(ByVal value As String)
            m_RoutIFace_TagName = FirstClickerService.Common.ConvertDass2Space(value)
        End Set
    End Property


    Private m_RoutIFace_Pagenum As String
    Public Property RoutIFace_Pagenum() As String Implements RoutBoardUniInterface.RoutIFace_String3
        Get
            Return m_RoutIFace_Pagenum
        End Get
        Set(ByVal value As String)
            m_RoutIFace_Pagenum = Val(value)
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



    Protected Sub ListViewTagList_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.CheckandAddTag(RoutIFace_TagName, WebAppSettings.dbcs)
        If tagdetails.Result = True Then
            LabelTagID.Text = tagdetails.TagId

            HyperLinkKeyword.Text = tagdetails.TagName
            HyperLinkKeyword.NavigateUrl = "~/forum/" & FirstClickerService.Common.ConvertSpace2Dass(tagdetails.TagName)

        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelTagID" runat="server" Text="0" Visible="False"></asp:Label>
    <div class="row">
        <div class="col-12">
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card BoxEffect6 mt-2">
                <div class="card-header p-2 clearfix">
                    <div class="float-right">
                        <asp:HyperLink ID="HyperLink2" NavigateUrl="~/Dashboard/Forum/Create.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Create Forum</asp:HyperLink>
                    </div>
                    <ul class="list-inline m-0 ">
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 ">
                                <i class="fab fa-foursquare"></i>&nbsp;<asp:HyperLink ID="HyperLinkForumHeading" runat="server" NavigateUrl="~/Forum/Default.aspx">Forum</asp:HyperLink>
                            </h5>
                        </li>
                        <li class="list-inline-item">/</li>
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 ">
                                <asp:HyperLink ID="HyperLinkKeyword" runat="server"></asp:HyperLink></h5>
                        </li>

                    </ul>
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
                <asp:SqlDataSource runat="server" ID="SqlDataSourcePubicForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                    SelectCommand="SELECT t.ForumId, t.Heading, t.Drescption, t.UserId, CONVERT(VARCHAR(19), t.CreateDate, 120) AS CreateDate, TU.username, TU.routusername, TUI.ImageFileName, count(DISTINCT TFT.topicid) as TopicCount, COUNT(DISTINCT TFTR.Id) as TopicReplyCount
                          FROM [Table_Forum] t
                          left JOIN table_User TU on TU.userid = t.userid
                          left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                          left JOIN Table_ForumTopic TFT on t.forumid = TFT.forumid
                          left JOIN Table_ForumTopicReply TFTR on TFT.TopicId = TFTR.TopicId
                          left join Table_tagOfForum TTOF on TTOF.ForumId=T.ForumId 
                          WHERE TTOF.tagId=@tagID
                          Group By  t.ForumId, t.Heading, t.Drescption, t.UserId, t.CreateDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY t.[CreateDate] DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="LabelTagID" PropertyName="Text" Name="TagID" Type="Decimal"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <div class="card-footer clearfix">
                    <div class="float-right">
                        <asp:DataPager runat="server" ID="DataPagerPublicForom" QueryStringField="Page" PagedControlID="ListviewPublicForom">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <div class="float-Left"></div>
                </div>
            </div>


        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:TagOfAllForums runat="server" ID="TagOfAllForums" />
        </div>
    </div>
</asp:Content>

