<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>




<script runat="server">

    Protected Sub ButtonDelete_Click(sender As Object, e As EventArgs)


    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card">
                <div class=" card-header">
                    Delete Wallpaper By WallID
                </div>
                <div class="card-body ">
                    <div class="form-group ">
                        <div class="input-group ">
                            <div class="input-group-prepend ">
                                <span class="input-group-text ">Wall Id</span>
                            </div>
                            <asp:TextBox ID="TextBoxId" CssClass="form-control " runat="server"></asp:TextBox>
                            <div class="input-group-append ">
                                <asp:Button ID="ButtonDelete" runat="server" OnClick="ButtonDelete_Click" Text="Delete" />
                            </div>

                        </div>
                    </div>
                    <div class="form-group ">
                        <asp:Label ID="LabelEM" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

