<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:validateuseraccess runat="server" id="ValidateUserAccess" />
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:navigationsidedashboard runat="server" id="NavigationSideDashboard" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card  mt-2 BoxEffect6 ">
                <div class="card-header clearfix">
                    <div class="float-right"></div>
                      <h5 class="card-title m-0 ">
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Dashboard/Question/MyQuestions.aspx">My Questions</asp:HyperLink>
                    </h5>
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
                         <asp:SessionParameter SessionField="UserId" Name="UserId" Type="Decimal"></asp:SessionParameter>
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
    </div>
</asp:Content>

