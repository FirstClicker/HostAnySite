<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideSupport.ascx" TagPrefix="uc1" TagName="NavigationSideSupport" %>


<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim pageinfo As FirstClickerService.Version1.StaticPage.StructureStaticPage
        pageinfo = FirstClickerService.Version1.StaticPage.StaticPage_Get(FirstClickerService.Version1.StaticPage.PageNameList.Site_Support_ReportImage, WebAppSettings.DBCS)

        PanelPagebody.Controls.Add(New LiteralControl(pageinfo.PageBody))
        ' as dinamic LiteralControl used in above, need to load on every post back 

        LabelHeading.Text = pageinfo.Title

        Title = pageinfo.Title
        MetaKeywords = pageinfo.Keyword
        MetaDescription = Page.MetaDescription
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideSupport runat="server" ID="NavigationSideSupport" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header clearfix ">
                    <div class="float-right ">
                    </div>
                    <ul class="list-inline m-0 ">
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 "><i class="fa fa-question-circle" aria-hidden="true"></i>&nbsp;<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Support/">Support</asp:HyperLink></h5>
                        </li>
                        <li class="list-inline-item">/</li>
                        <li class="list-inline-item">
                            <h5 class="card-title m-0 ">
                                <asp:HyperLink ID="HyperLinkKeyword" runat="server" ></asp:HyperLink></h5>
                        </li>
                    </ul>
                </div>
            </div>
            
                 <div class="card-body ">
                   <h2 class="card-title text-info mb-3 ">
                        <asp:Label ID="LabelHeading" runat="server" Text="Label"></asp:Label>
                    </h2>
                    <hr />
                    <asp:Panel ID="PanelPagebody" runat="server"></asp:Panel>
              </div>
         

        </div>
    </div> 
</asp:Content>

