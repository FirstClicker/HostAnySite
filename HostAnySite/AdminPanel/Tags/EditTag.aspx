<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>

<script runat="server">
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        ' version 22/08/2018 # 4.27 AM
        ' AdminValidation Is done by NavAdminMenu control

        If Me.IsPostBack = False Then
            DropDownListTagStatus.Items.Clear()
            DropDownListTagStatus.Items.Add("Setect Status")
            For Each i In [Enum].GetValues(GetType(FirstClickerService.Version1.Tag.TagStatusEnum))
                DropDownListTagStatus.Items.Add(i.ToString)
            Next


            TextBoxtagID.Text = Val(Trim(Request.QueryString("TagId")))
            ButtonLoadId_Click(sender, e)

        End If
    End Sub

    Protected Sub ButtonLoadId_Click(sender As Object, e As EventArgs)
        Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag
        tagdetails = FirstClickerService.Version1.Tag.GetDetails_BYTagID(TextBoxtagID.Text, WebAppSettings.DBCS)
        If tagdetails.Result = True Then
            LabelTagID.Text = tagdetails.TagId
            HyperLinkTagName.Text = tagdetails.TagName
            'HyperLinkTagName.NavigateUrl = "~/image/" & FirstClickerService.Common.ConvertSpace2Dass(tagdetails.TagName)


            Dim ItemStatus = DropDownListTagStatus.Items.FindByText(tagdetails.Status.ToString)
            If ItemStatus IsNot Nothing Then ItemStatus.Selected = True

            Dim ItemImprtance = DropDownListImportance.Items.FindByText(tagdetails.Importance)
            If ItemImprtance IsNot Nothing Then ItemImprtance.Selected = True

            HyperLinkTagSeoForImage.NavigateUrl = "~/adminpanel/image/tagseoforimage.aspx?tagid=" & LabelTagID.Text
        End If
    End Sub


    Protected Sub DropDownListTagStatus_SelectedIndexChanged(sender As Object, e As EventArgs)
        If DropDownListTagStatus.SelectedIndex = 0 Then Exit Sub
        Dim tagInfo As FirstClickerService.Version1.Tag.StructureTag
        tagInfo = FirstClickerService.Version1.Tag.UpdateStatus_ByTagID(LabelTagID.Text, [Enum].Parse(GetType(FirstClickerService.Version1.Tag.TagStatusEnum), DropDownListTagStatus.SelectedItem.ToString, True), WebAppSettings.DBCS)
        If tagInfo.Result = True Then
            LabelEM.Text = "Saved.."
        Else
            LabelEM.Text = "Failed.."
        End If
    End Sub

    Protected Sub DropDownListImportance_SelectedIndexChanged(sender As Object, e As EventArgs)
        If DropDownListImportance.SelectedIndex = 0 Then Exit Sub
        Dim tagInfo As FirstClickerService.Version1.Tag.StructureTag
        tagInfo = FirstClickerService.Version1.Tag.UpdateImportance_ByTagID(LabelTagID.Text, DropDownListImportance.SelectedItem.ToString, WebAppSettings.DBCS)
        If tagInfo.Result = True Then
            LabelEM.Text = "Saved.."
        Else
            LabelEM.Text = "Failed.."
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelTagID" runat="server" Text="0" Visible="false"></asp:Label>

    <div class="row">
        <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header ">
                    Edit Tag Details -
                    <asp:HyperLink ID="HyperLinkTagName" runat="server"></asp:HyperLink>
                </div>
                <div class="card-body">
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text ">TagId</span>
                                <asp:TextBox ID="TextBoxtagID" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:Button ID="ButtonLoadId" CssClass="btn btn-info " runat="server" Text="Load" OnClick="ButtonLoadId_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                  
                </div>
                <div class="card-body ">

                    <div class="form-group">
                        <div class="input-group ">
                            <div class=" input-group-append "><span class="input-group-text ">Status:</span></div>
                            <asp:DropDownList ID="DropDownListTagStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownListTagStatus_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group ">
                            <div class=" input-group-append "><span class="input-group-text ">Importance:</span></div>
                            <asp:DropDownList ID="DropDownListImportance" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownListImportance_SelectedIndexChanged" CssClass="form-control">
                                <asp:ListItem>Select Importance</asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem>5</asp:ListItem>
                                <asp:ListItem>6</asp:ListItem>
                                <asp:ListItem>7</asp:ListItem>
                                <asp:ListItem>8</asp:ListItem>
                                <asp:ListItem>9</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group ">
                        <asp:HyperLink ID="HyperLinkTagSeoForImage" runat="server">Tag Seo For Image</asp:HyperLink>
                    </div>
                    <div class="form-group ">
                        <asp:Label ID="LabelEM" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

