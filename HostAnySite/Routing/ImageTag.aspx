<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Implements Interface="RoutBoardUniInterface" %>

<%@ Register Src="~/app_controls/Imagethumb.ascx" TagPrefix="uc1" TagName="ImageSmallThumb" %>
<%@ Register Src="~/app_controls/TagOfAllImages.ascx" TagPrefix="uc1" TagName="TagOfAllImages" %>
<%@ Register Src="~/App_Controls/AdsenseAds.ascx" TagPrefix="uc1" TagName="AdsenseAds" %>
<%@ Register Src="~/App_Controls/TagOfTagForImages.ascx" TagPrefix="uc1" TagName="TagOfTagForImages" %>
<%@ Register Src="~/App_Controls/AdminAutoImageTag.ascx" TagPrefix="uc1" TagName="AdminAutoImageTag" %>
<%@ Register Src="~/App_Controls/AdminTagDrescptionFinder.ascx" TagPrefix="uc1" TagName="AdminTagDrescptionFinder" %>
<%@ Register Src="~/App_Controls/PagingControl.ascx" TagPrefix="uc1" TagName="PagingControl" %>





<script runat="server">
    ' version 12/09/2018 # 1.27 AM


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



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            If Val(RoutIFace_Pagenum) <= 0 Then
                RoutIFace_Pagenum = 1
            End If
            DataPagerImage.SetPageProperties((RoutIFace_Pagenum * DataPagerImage.PageSize) - DataPagerImage.PageSize, DataPagerImage.PageSize, True)

            PagingControl.CurrentPage = RoutIFace_Pagenum
            PagingControl.BaseURL = "~/Image/" & FirstClickerService.Common.ConvertSpace2Dass(RoutIFace_TagName) & "/"
        End If

        Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.GetDetails_BYTagName(RoutIFace_TagName, WebAppSettings.DBCS)
        If tagdetails.Result = False Then
            'redirect to search or image home
            Response.Redirect("~/image/")
            Exit Sub
        Else
            LabelTagID.Text = tagdetails.TagId

            HyperLinkKeyword.Text = tagdetails.TagName
            HyperLinkKeyword.NavigateUrl = "~/image/" & FirstClickerService.Common.ConvertSpace2Dass(tagdetails.TagName)

            HyperLinkPageNum.Text = "Page " & RoutIFace_Pagenum
            HyperLinkPageNum.NavigateUrl = "~/image/" & FirstClickerService.Common.ConvertSpace2Dass(tagdetails.TagName) & "/" & RoutIFace_Pagenum & "/"

            TagOfTagForImages.ParentTagId = tagdetails.TagId
            AdminAutoImageTag.TagName = tagdetails.TagName
        End If

        Dim TagSEO As FirstClickerService.Version1.TagSEO.TagSEOStructure = FirstClickerService.Version1.TagSEO.GetSeo_BYTagID(tagdetails.TagId, FirstClickerService.Version1.TagSEO.TagSEOForEnum.Image, WebAppSettings.DBCS)
        ' will not create blank tagseo for image here.. 
        ' that need to create in adminpanel manually
        If Trim(TagSEO.Title) <> "" Then
            Title = TagSEO.Title & " - Page " & RoutIFace_Pagenum
        Else
            Title = "Best " & tagdetails.TagName & " hd Pictures - Page " & RoutIFace_Pagenum & " - BestHDPics.Com"
        End If

        If Trim(TagSEO.Keyword) <> "" Then
            MetaKeywords = TagSEO.Keyword
        Else

        End If

        If Trim(TagSEO.Description) <> "" Then
            MetaDescription = TagSEO.Description
            LabelContent.Text = TagSEO.Description
        Else
            MetaDescription = "Download " & tagdetails.TagName & " Images"
            LabelContent.Text = "Download " & tagdetails.TagName & " Images"

            AdminTagDrescptionFinder.TagName = tagdetails.TagName
        End If

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


    Protected Sub LinkButtonFeatured_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/adminpanel/Tags/EditTag.aspx?TagId=" & LabelTagID.Text)
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelTagID" runat="server" Text="0" Visible="False"></asp:Label>

    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
            <uc1:AdsenseAds runat="server" ID="AdsenseAds" Adsformat="horizontal" />
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header">
                    <ul class="list-inline m-0  float-left">
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 "><i class="far fa-images"></i>&nbsp;<asp:HyperLink ID="HyperLinkHeading" runat="server" NavigateUrl="~/Image/">Image</asp:HyperLink></h5>
                        </li>
                        <li class="list-inline-item">/</li>
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 ">
                                <asp:HyperLink ID="HyperLinkKeyword" CssClass="text-capitalize" runat="server"></asp:HyperLink></h5>
                        </li>
                        <li class="list-inline-item">/</li>
                        <li class="list-inline-item">
                            <asp:HyperLink ID="HyperLinkPageNum" CssClass="card-title m-0" runat="server"></asp:HyperLink></li>
                    </ul>
                    <div class="dropdown float-right">
                        <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                        <ul class="dropdown-menu dropdown-menu-right">
                            <li runat="server" id="LIActionEditTag" class="dropdown-item">
                                <asp:LinkButton ID="LinkButtonFeatured" runat="server" OnClick="LinkButtonFeatured_Click"><small>Edit Keyword</small></asp:LinkButton>
                            </li>
                            <li runat="server" id="LIActionFollowTag" class="dropdown-item" visible="false">
                                <asp:LinkButton ID="LinkButtonDelete" runat="server"><small>Follow</small></asp:LinkButton>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <asp:ListView ID="ListViewImage" runat="server" DataSourceID="SqlDataSourceImage" DataKeyNames="ImageId">
                    <EmptyDataTemplate>
                        <span>No data was returned.</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <uc1:ImageSmallThumb runat="server" ID="ImageSmallThumb" ImageId='<%# Eval("ImageId") %>' ImageName='<%# Eval("ImageName") %>' ImageFileName='<%# Eval("ImageFileName") %>' PostDate='<%# Eval("PostDatef") %>' UserId='<%# Eval("UserId") %>' UserName='<%# Eval("UserName") %>' RoutUserName='<%# Eval("RoutUserName") %>' />
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
                        left join Table_tagOfImage TTOI on TToi.ImageId=Ti.ImageID 
                        Left Join Table_UserLike TUL on TUL.ImageID=TI.imageid 
                        WHERE (TI.Status = @Status) and (TTOi.tagId=@tagID) and (TTOI.status='Active')
                        Group By TI.ImageId, ti.imagename, ti.imagefilename, ti.postdate, tu.userid, tu.username, tu.routusername 
                        ORDER BY votecount DESC">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Visible" Name="Status" Type="String"></asp:Parameter>
                        <asp:ControlParameter ControlID="LabelTagID" PropertyName="Text" Name="TagID" Type="Decimal"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <asp:Panel runat="server" ID="PanelFooterNavBar" CssClass="card-footer clearfix">
                <div class="float-right">
                    <uc1:PagingControl runat="server" ID="PagingControl" />
                    <asp:DataPager runat="server" ID="DataPagerImage" PagedControlID="ListViewImage" PageSize="12" visible="false" >
                        <Fields>
                            <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-default" CurrentPageLabelCssClass="btn btn-sm btn-default" NextPreviousButtonCssClass="btn btn-sm btn-default" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </asp:Panel>
            <uc1:AdminAutoImageTag runat="server" ID="AdminAutoImageTag" />
            <uc1:AdminTagDrescptionFinder runat="server" ID="AdminTagDrescptionFinder" IncludeKeyword = "image, picture, pics, photo" TagType = "Images" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-4 col-xl-4">
            <div class="card">
                <div class="card-body ">
                    <asp:Label ID="LabelContent" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <uc1:TagOfTagForImages runat="server" ID="TagOfTagForImages" />
            <uc1:AdsenseAds runat="server" ID="AdsenseAds1" Adsformat="rectangle" />
            <uc1:TagOfAllImages runat="server" ID="TagOfAllImages" />
        </div>
    </div>
</asp:Content>

