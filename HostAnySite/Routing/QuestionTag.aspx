<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/App_Controls/TagOfAllQuestions.ascx" TagPrefix="uc1" TagName="TagOfAllQuestions" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>



<script runat="server">
    ' version 13/10/2018 # 1.27 AM

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
            HyperLinkKeyword.NavigateUrl = "~/Question/" & FirstClickerService.Common.ConvertSpace2Dass(tagdetails.TagName)

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
        <div class="col-12 col-sm-12 col-md-8 col-lg-8 col-xl-8">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="horizontal" />
              <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix ">
                    <div class="float-right ">
                        <asp:HyperLink ID="HyperLink2" NavigateUrl="~/Dashboard/Question/Ask.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Ask</asp:HyperLink>
                    </div>

                    <ul class="list-inline m-0 ">
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 "><i class="fas fa-question"></i>&nbsp;<asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Question/">Question</asp:HyperLink></h5>
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
                                    <asp:HyperLink Text='<%# Eval("Question") %>' CssClass=" text-capitalize " NavigateUrl='<%#"~/Question/" & FirstClickerService.Common.ConvertSpace2Dass(Eval("Question")) & "/" & Eval("QuestionId")  %>' runat="server" ID="HeadingLabel" /><br>
                                </h4>
                                <span class="text-dark ">
                                    <asp:Label Text='<%# Mid(Eval("Drescption"), 1, 500) %>' CssClass=" text-capitalize " runat="server" ID="DrescptionLabel" />
                                </span>
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
                         left join Table_tagOfquestion TTOQ on TTOQ.QuestionID=Tq.QuestionID 
                       WHERE TTOq.tagId=@tagID
                          Group By TQ.QuestionId, TQ.Question, TQ.Drescption, TQ.UserId, TQ.postDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY TQ.[postdate] DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="LabelTagID" PropertyName="Text" Name="TagID" Type="Decimal"></asp:ControlParameter>
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
         <div class="col-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
            <uc1:TagOfAllQuestions runat="server" ID="TagOfAllQuestions" />
             <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat="rectangle" />
        </div>
    </div>
</asp:Content>

