<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/App_Controls/TagOfAllQuestions.ascx" TagPrefix="uc1" TagName="TagOfAllQuestions" %>
<%@ Register Src="~/App_Controls/PagingControl.ascx" TagPrefix="uc1" TagName="PagingControl" %>
<%@ Register Src="~/App_Controls/QuestionInListView.ascx" TagPrefix="uc1" TagName="QuestionInListView" %>



<script runat="server">
    ' version 23/07/2019 # 4.27 AM

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
            DataPagerQuestion.SetPageProperties((RoutIFace_Pagenum * DataPagerQuestion.PageSize) - DataPagerQuestion.PageSize, DataPagerQuestion.PageSize, True)

            PagingControl.CurrentPage = RoutIFace_Pagenum
            PagingControl.BaseURL = "~/Question/"
        End If


        Title = WebAppSettings.WebSiteName & " Question, Get answer for your every question - Page " & RoutIFace_Pagenum
        MetaDescription = "The Question and Answer sections of our website is a great platform to ask questions, find answers, and discuss various subjects. Whatever your question is, ask it here and, our users will attempt to answer it. You can also find answers from existing questions."
    End Sub

    Protected Sub SqlDataSourcePubicForum_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        PagingControl.LastPage = CInt(e.AffectedRows / DataPagerQuestion.PageSize)
        If e.AffectedRows > Val(PagingControl.LastPage) * DataPagerQuestion.PageSize Then
            PagingControl.LastPage = Val(PagingControl.LastPage) + 1
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix">
                    <div class="float-right"></div>
                    <h5 class="card-title m-0 ">
                        <i class="fas fa-question"></i>&nbsp;<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Forum/Default.aspx">Question</asp:HyperLink>
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
                                <uc1:QuestionInListView runat="server" ID="QuestionInListView" Heading='<%# Eval("Question") %>' QuestionId='<%# Eval("QuestionId") %>' UserId='<%# Eval("UserId") %>' RoutUserName='<%# Eval("RoutUserName") %>' UserName='<%# Eval("UserName") %>' PostDate='<%# Eval("PostDate") %>' AnswerCount='<%# Eval("AnswerCount") %>' />
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
                <asp:SqlDataSource runat="server" ID="SqlDataSourcePubicForum" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' OnSelected ="SqlDataSourcePubicForum_Selected"
                    SelectCommand="SELECT TQ.QuestionId, TQ.Question, TQ.Drescption, TQ.UserId, TQ.postDate, TU.username, TU.routusername, TUI.ImageFileName, count(DISTINCT TQA.AnswerID) as AnswerCount
                          FROM [Table_Question] TQ
                          left JOIN table_User TU on TU.userid = TQ.userid
                          left JOIN table_image TUI on TUI.Imageid = TU.Imageid
                          left JOIN Table_QuestionAnswer TQA on TQ.QuestionID = TQA.QuestionID
                          Group By TQ.QuestionId, TQ.Question, TQ.Drescption, TQ.UserId, TQ.postDate, TU.username, TU.routusername, TUI.ImageFileName
                          ORDER BY TQ.[postdate] DESC"></asp:SqlDataSource>
                <div class="card-footer clearfix">
                    <div class="float-right">
                        <uc1:PagingControl runat="server" ID="PagingControl" />
                        <asp:DataPager runat="server" ID="DataPagerQuestion" PagedControlID="ListviewPublicForom" Visible ="false" >
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
            <uc1:TagOfAllQuestions runat="server" ID="TagOfAllQuestions" />
        </div>
    </div>
</asp:Content>

