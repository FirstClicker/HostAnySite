<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<script runat="server">
    ' version 14/08/2018 # 5.42 PM

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then


            FirstClickerService.Version1.ReportError.ReportErrorRaw("404", System.Web.HttpContext.Current.Request.Url.ToString, "Broken link", WebAppSettings.DBCS)
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta http-equiv="refresh" content="10; url=/"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-8 col-xl-8">
            <div class="card">
                <asp:Image ID="ImagePagenotFound" CssClass="img-fluid" ImageUrl="~/Content/image/Page-Not-Found.png" AlternateText="Page not found." runat="server" />
                <div class="card-body ">
                    <div class="media ">
                        <asp:Image CssClass="mr-3" ID="ImageProgress" ImageUrl="~/Content/image/spinner.gif" runat="server" Width="30" />
                        <div class="media-body">
                            <h2 class="mt-0">Returning to website home in 10 seconds.</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-4 col-xl-4">
           
        </div>
    </div> 
</asp:Content>

