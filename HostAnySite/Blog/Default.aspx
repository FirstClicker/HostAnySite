<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/app_controls/web/UserWallEntry.ascx" TagPrefix="uc1" TagName="UserWallEntry" %>
<%@ Register Src="~/app_controls/web/NavigationSideMain.ascx" TagPrefix="uc1" TagName="NavigationSideMain" %>


<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)



    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-8">






            <div class="panel panel-default ">
                <div class="panel-heading">Blogs</div>
                <div class="panel-body UserWall-Body">
                    <asp:ListView ID="ListViewBlog" runat="server" DataSourceID="SqlDataSourceBlog" DataKeyNames="Blogid">

                        <EmptyDataTemplate>
                            <span>No blog found.</span>
                        </EmptyDataTemplate>

                        <ItemTemplate>
                            <div>
                                <div class="col-lg-6 col-md-6 col-xs-12 thumb">
                                    <div class="panel panel-default">
                                        <div class="panel-body" style="height: 360px; overflow: hidden;">

                                            <h4>
                                                <asp:HyperLink ID="HyperLinkStoryNameBn" runat="server" NavigateUrl='<%#"~/blog/" + Eval("Blogid").ToString.Trim + "/" + Eval("Heading2") + "/"%>'><%# Eval("Heading")%></asp:HyperLink>
                                            </h4>

                                            <asp:Panel ID="postimage" runat="server" class="panel-body" Visible='<%# CBool(Eval("imageid"))%>'>
                                                <div class="thumbnail" style="border-style: none; margin: 2px;">
                                                    <asp:Image ID="ImageTRW2" runat="server" ImageUrl='<%#"~/storage/image/" + Eval("PostImageFilename")%>' Style="max-height: 160px;" />
                                                </div>
                                            </asp:Panel>
                                            <asp:Label Text='<%# Eval("Highlight") %>' runat="server" ID="HighlightLabel" />
                                        </div>
                                        <div class="panel-footer clearfix ">
                                            <div class="pull-left">
                                                <small>
                                                    <asp:HyperLink ID="Hyperuser" runat="server" Text='<%# Eval("Username")%>' NavigateUrl='<%#"~/User/" + Eval("Routusername").Trim + "/"%>'></asp:HyperLink>
                                                    <br />
                                                    <span class="glyphicon glyphicon-time"></span>
                                                    <asp:Label ID="LabelDatetime" runat="server" Text='<%# Eval("PostDate") %>'></asp:Label>
                                                </small>
                                            </div>
                                            <div class="pull-right ">
                                                <asp:LinkButton ID="LinkButtonmore" runat="server" CssClass="btn btn-primary btn-block" PostBackUrl='<%#"~/blog/" + Eval("blogid").ToString + "/" + Eval("heading2")%>' Text="read more"></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" class="row">
                                <div runat="server" id="itemPlaceholder" />

                            </div>

                        </LayoutTemplate>

                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceBlog" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                        SelectCommand="SELECT t.Blogid, t.Heading, replace(t.[Heading],' ','-') as [Heading2], t.Highlight, t.Containt, t.PostDate, t2.username, t2.routusername, t1.ImageFileName as PostImageFilename, t.imageid  
                        FROM [Table_Blog] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        ORDER BY [PostDate] DESC"></asp:SqlDataSource>
                </div>
                <div class="panel-footer clearfix">
                    <div class="pull-right">
                        <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ListViewBlog" PageSize="4">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <uc1:NavigationSideMain runat="server" ID="NavigationSideMain" />
            <div class="panel panel-default">
                <div class="panel-heading">What's Happening?</div>
                <div class="panel-body UserWall-Body">

                    <asp:ListView ID="ListViewNotification" runat="server" DataKeyNames="wallID" DataSourceID="SqlDataSource1">


                        <EmptyDataTemplate>
                            <span>No user activity.</span>
                        </EmptyDataTemplate>

                        <ItemTemplate>
                            <!-- Comment -->

                            <uc1:UserWallEntry runat="server" ID="UserWallEntry" WallUserURL='<%# "~/user/" + Eval("RoutUserName")%>' WallUserImage='<%# "~/storage/image/" + Eval("userimagefilename")%>' WallHeading='<%# Eval("Heading") %>' WallDatetime='<%# Eval("postdate")%>' WallMessage='<%# Eval("Message") %>' WallPostImage='<%# "~/storage/image/" + Eval("PostImageFilename")%>'   WallID='<%# Eval("wallId")%>' numberofcomment='<%# Eval("numberofcomment")%>' />

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div id="itemPlaceholderContainer" runat="server">
                                <div runat="server" id="itemPlaceholder" />
                            </div>

                        </LayoutTemplate>

                    </asp:ListView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                        SelectCommand="SELECT t.wallid, t.heading, t.message, t.postdate, t.userid, t.imageid, t2.RoutUserName, t1.ImageFileName as PostImageFilename, t3.ImageFileName as userimagefilename, count(TUWC.wallId) as numberofcomment 
                        FROM [Table_UserWall] t
                        left JOIN table_image t1 ON t.ImageID=t1.ImageID 
                        left JOIN table_User t2 on t.userid = t2.userid
                        left JOIN table_image t3 on t2.Imageid = t3.Imageid
                        left join table_userwallComment TUWC on t.wallid=TUWC.wallId
                        group by t.wallid, t.heading, t.message, t.postdate, t.userid, t.imageid, t2.RoutUserName, t1.ImageFileName , t3.ImageFileName  
                        ORDER BY t.[postdate] DESC"></asp:SqlDataSource>
                </div>
                <div class="panel-footer clearfix">
                    <div class="pull-right">
                        <asp:DataPager runat="server" ID="DataPagerNotification" PagedControlID="ListViewNotification" PageSize="5">
                            <Fields>
                                <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-xs btn-default" CurrentPageLabelCssClass="btn btn-xs btn-default" NextPreviousButtonCssClass="btn btn-xs btn-default" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                    <div class="pull-Left">
                    </div>
                </div>

            </div>
        </div>
    </div>


</asp:Content>

