<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>
<%@ Register Src="~/App_Controls/TagOfImage.ascx" TagPrefix="uc1" TagName="TagOfImage" %>


<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Imagedetails As FirstClickerService.Version1.Image.StructureImage = FirstClickerService.Version1.Image.ImageDetails_BYID(Val(Trim(Request.QueryString("ImageId"))), WebAppSettings.DBCS)
        If Imagedetails.Result = True Then
            LabelImageID.Text = Imagedetails.ImageId

            TagOfImage.ImageId = Imagedetails.ImageId
            TagOfImage.ImageUserId = Imagedetails.userId

            HyperHeading.Text = Imagedetails.ImageName
            HyperHeading.NavigateUrl = Request.Url.ToString
            Labeldescription.Text = Imagedetails.Drescption
            LabelDatetime.Text = FirstClickerService.Common.ConvertDateTime4Use(Imagedetails.PostDate.ToString("yyyy-MM-dd HH:mm:ss"))



            Dim userinfo As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_UserID(Imagedetails.userId, WebAppSettings.DBCS)
            LabelUserID.Text = userinfo.UserID
            HyperLinkUsername.Text = userinfo.UserName
            HyperLinkUsername.NavigateUrl = "~/user/" & userinfo.RoutUserName



            Blogimage.ImageUrl = "~/storage/image/" & Imagedetails.ImageFileName
        Else
            Response.Redirect("~/image/")
        End If

        If IsPostBack = False Then
            DropDownListStatus.DataSource = System.Enum.GetValues(GetType(FirstClickerService.Version1.Image.StatusEnum))
            DropDownListStatus.DataBind()

            Dim ItemStatus = DropDownListStatus.Items.FindByText(Imagedetails.Status.ToString)
            If ItemStatus IsNot Nothing Then ItemStatus.Selected = True
        End If

    End Sub

    Protected Sub DropDownListStatus_SelectedIndexChanged(sender As Object, e As EventArgs)
        FirstClickerService.Version1.Image.Image_UpdateStatus(LabelImageID.Text, [Enum].Parse(GetType(FirstClickerService.Version1.Image.StatusEnum), DropDownListStatus.SelectedItem.Text, True), WebAppSettings.DBCS)
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <asp:Label ID="LabelUserID" runat="server" Text="0" Visible="false"></asp:Label>
      <asp:Label ID="LabelImageID" runat="server" Text="0" Visible="false"></asp:Label>
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                   <div class="row">
                <div class="col-12">
                    <div class="card mt-2 mb-2">
                        <div class="card-body ">
                            <div class="clearfix ">
                                <div class="float-left">
                                    <h3 class="card-title ">
                                        <asp:HyperLink ID="HyperHeading" CssClass="text-capitalize " runat="server"></asp:HyperLink></h3>
                                </div>
                                <div class="float-right "></div>
                            </div>
                            <div class="clearfix ">
                                <div class="float-left">
                                    <p>
                                        <i class="fas fa-user-circle"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUsername" runat="server" CssClass="text-capitalize"></asp:HyperLink>
                                        &nbsp;|&nbsp;<i class="far fa-calendar-alt"></i>&nbsp;Posted on&nbsp;<asp:Label ID="LabelDatetime" runat="server" Text="Label"></asp:Label>
                                    </p>
                                </div>
                                <div class="float-right ">
                                </div>
                            </div>
                        </div>
                        <div class="text-center ">
                            <asp:Image runat="server" ID="Blogimage" CssClass="img-fluid " />
                        </div>
                        <!-- Post Content -->
                        <div class=" card-body ">
                            <p class="lead">
                                <asp:Label ID="Labeldescription" runat="server" Text="Label"></asp:Label>
                            </p>
                            <uc1:TagOfImage runat="server" ID="TagOfImage" />
                            <div class="form-group ">
                                <asp:DropDownList ID="DropDownListStatus" CssClass="form-control" runat="server" AutoPostBack="True" CausesValidation="True" OnSelectedIndexChanged="DropDownListStatus_SelectedIndexChanged"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
</asp:Content>

