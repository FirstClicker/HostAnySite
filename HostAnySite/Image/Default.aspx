<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Implements Interface="RoutSiteHomeInterface" %>


<%@ Register Src="~/app_controls/TagOfAllImages.ascx" TagPrefix="uc1" TagName="TagOfAllImages" %>
<%@ Register Src="~/App_Controls/ImageThumb.ascx" TagPrefix="uc1" TagName="ImageThumb" %>
<%@ Register Src="~/App_Controls/PagingControl.ascx" TagPrefix="uc1" TagName="PagingControl" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>


<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            PagingControl.CurrentPage = 1
            PagingControl.BaseURL = "~/Image/"
        End If

        Dim pageinfo As FirstClickerService.Version1.StaticPage.StructureStaticPage
        pageinfo = FirstClickerService.Version1.StaticPage.StaticPage_Get(FirstClickerService.Version1.StaticPage.PageNameList.Site_Image_Default, WebAppSettings.DBCS)

        PanelPagebody.Controls.Add(New LiteralControl(pageinfo.PageBody))
        ' as dinamic LiteralControl used in above, need to load on every post back 

        HyperLinkHeading.Text = pageinfo.Title

        Dim mytitle As String
        Dim myDescription As String

        mytitle = pageinfo.Title
        myDescription = Page.MetaDescription


        Page.Title = mytitle
        MetaKeywords = pageinfo.Keyword
        MetaDescription = myDescription
    End Sub

    Protected Sub SqlDataSourceImage_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        If e.AffectedRows <= DataPagerImage.PageSize Then
            PanelFooterNavBar.Visible = False
            Exit Sub
        End If

        PagingControl.LastPage = CInt(e.AffectedRows / DataPagerImage.PageSize)
        If e.AffectedRows > Val(PagingControl.LastPage) * DataPagerImage.PageSize Then
            PagingControl.LastPage = Val(PagingControl.LastPage) + 1
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="horizontal" />
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header">
                    <h5 class="card-title m-0 ">
                        <i class="far fa-images"></i>&nbsp;<asp:HyperLink ID="HyperLinkHeading" runat="server" NavigateUrl="~/Image/">Images</asp:HyperLink>
                    </h5>
                </div>
            </div>
            <div class="card-body">
                <asp:ListView ID="ListViewImage" runat="server" DataSourceID="SqlDataSourceImage" DataKeyNames="ImageId">
                    <EmptyDataTemplate>
                        <span>No data was returned.</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <uc1:ImageThumb runat="server" ID="ImageThumb" ImageId='<%# Eval("ImageId") %>' ImageName='<%# Eval("ImageName") %>' ImageFileName='<%# Eval("ImageFileName") %>' PostDate='<%# Eval("PostDatef") %>' UserId='<%# Eval("UserId") %>' UserName='<%# Eval("UserName") %>' RoutUserName='<%# Eval("RoutUserName") %>' />
                        </div>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholderContainer" class="row">
                            <div runat="server" id="itemPlaceholder" />
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceImage" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' OnSelected="SqlDataSourceImage_Selected"
                    SelectCommand="SELECT TI.ImageId, ti.imagename, ti.imagefilename, ti.postdate, CONVERT(VARCHAR(19), TI.postdate, 120) AS PostDatef, tu.userid, tu.username, tu.routusername, sum(CASE WHEN TUL.islike ='True' THEN ABS(TUL.vote) ELSE 0 - ABS(TUL.vote) END) as votecount
                    FROM [Table_Image] TI 
                    left join table_user TU on Tu.userid=Ti.userId
                    Left Join Table_UserLike TUL on TUL.ImageID=TI.imageid 
                    WHERE ([STATUS] = 'Visible') 
                    Group By TI.ImageId, ti.imagename, ti.imagefilename, ti.postdate, tu.userid, tu.username, tu.routusername
                    ORDER BY votecount DESC"></asp:SqlDataSource>
            </div>
            <asp:Panel runat="server" ID="PanelFooterNavBar" CssClass="card-footer clearfix">
                <div class="float-right">
                    <uc1:PagingControl runat="server" ID="PagingControl" />
                    <asp:DataPager runat="server" ID="DataPagerImage" PagedControlID="ListViewImage" PageSize="12" Visible="false">
                        <Fields>
                            <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </asp:Panel>
            <uc1:AdsenseAds runat="server" ID="AdsenseAds2" Adsformat="rectangle" />

        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-4 col-xl-4">
            <div class="card">
                <asp:Panel ID="PanelPagebody" CssClass="card-body " runat="server"></asp:Panel>
            </div>
            <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat="rectangle" />
            <uc1:TagOfAllImages runat="server" ID="TagOfAllImages" />
        </div>
    </div>
</asp:Content>

