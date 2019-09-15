<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface="RoutSiteHomeInterface" %>

<%@ Register Src="~/App_Controls/TagOfAllQuestions.ascx" TagPrefix="uc1" TagName="TagOfAllQuestions" %>
<%@ Register Src="~/App_Controls/PagingControl.ascx" TagPrefix="uc1" TagName="PagingControl" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>
<%@ Register Src="~/App_Controls/QuestionInListView.ascx" TagPrefix="uc1" TagName="QuestionInListView" %>



<script runat="server">
    ' version 23/07/2019 # 4.27 AM

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            PagingControl.CurrentPage = 1
            PagingControl.BaseURL = "~/Question/"
        End If

        Dim pageinfo As FirstClickerService.Version1.StaticPage.StructureStaticPage
        pageinfo = FirstClickerService.Version1.StaticPage.StaticPage_Get(FirstClickerService.Version1.StaticPage.PageNameList.Site_Question_Default, WebAppSettings.DBCS)

        PanelPagebody.Controls.Add(New LiteralControl(pageinfo.PageBody))
        ' as dinamic LiteralControl used in above, need to load on every post back 

        HyperLinkHeading.Text = pageinfo.Title

        Dim mytitle As String
        Dim myDescription As String

        mytitle = pageinfo.Title
        myDescription = Page.MetaDescription


        Title = mytitle
        MetaDescription = myDescription


    End Sub

    Protected Sub SqlDataSourcePubicForum_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        PagingControl.LastPage = CInt(e.AffectedRows / DataPagerQuestion.PageSize)
        If e.AffectedRows > Val(PagingControl.LastPage) * DataPagerQuestion.PageSize Then
            PagingControl.LastPage = Val(PagingControl.LastPage) + 1
        End If

        If e.AffectedRows <= DataPagerQuestion.PageSize Then
            panelfooter.Visible = False
        End If

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-8 col-lg-8 col-xl-8">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat ="horizontal"  />
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix">
                    <div class="float-right">
                        <asp:HyperLink ID="HyperLink2" NavigateUrl="~/Dashboard/question/ask.aspx" CssClass="btn btn-sm btn-info" role="button" runat="server">Ask Question</asp:HyperLink>
                    </div>
                    <h5 class="card-title m-0 ">
                        <i class="fas fa-question"></i>&nbsp;<asp:HyperLink ID="HyperLinkHeading" runat="server" NavigateUrl="~/question/">Question</asp:HyperLink>
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
                        <div>
                           
                                <uc1:QuestionInListView runat="server" ID="QuestionInListView" Heading='<%# Eval("Question") %>' QuestionId='<%# Eval("QuestionId") %>' UserId='<%# Eval("UserId") %>' RoutUserName='<%# Eval("RoutUserName") %>' UserName='<%# Eval("UserName") %>' PostDate='<%# Eval("PostDate") %>' AnswerCount='<%# Eval("AnswerCount") %>' />
                         
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div class="card ">
                            <div class="card-header">
                                Recently Asked
                            </div>
                            <div class="card-body ">
                                <div runat="server" id="itemPlaceholder">
                                </div>
                            </div>
                        </div>

                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourcePubicForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' OnSelected="SqlDataSourcePubicForum_Selected"
                    SelectCommand="SELECT TQ.QuestionId, TQ.Question, TQ.Drescption, TQ.UserId, CONVERT(VARCHAR(19), tq.postdate, 120) AS postdate, TU.username, TU.routusername, TUI.ImageFileName, count(DISTINCT TQA.AnswerID) as AnswerCount
                          FROM [Table_Question] TQ
                          left JOIN table_User TU on TU.userid = TQ.userid
                          left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                          left JOIN Table_QuestionAnswer TQA on TQ.QuestionID = TQA.QuestionID
                          Group By TQ.QuestionId, TQ.Question, TQ.Drescption, TQ.UserId, TQ.postDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY TQ.[postdate] DESC"></asp:SqlDataSource>
                <asp:panel runat ="server" ID="panelfooter" cssclass="card-footer clearfix">
                    <div class="float-right">
                        <uc1:PagingControl runat="server" ID="PagingControl" />
                        <asp:DataPager runat="server" ID="DataPagerQuestion" PagedControlID="ListviewPublicForom" Visible="false">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <div class="float-Left"></div>
                </asp:panel>
            </div>

        </div>
        <div class="col-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
            <div class="card">
                <asp:Panel ID="PanelPagebody" CssClass="card-body " runat="server"></asp:Panel>
            </div>
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="rectangle" />
            <uc1:TagOfAllQuestions runat="server" ID="TagOfAllQuestions" />
        </div>
    </div>
</asp:Content>

