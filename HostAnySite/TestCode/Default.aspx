<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<script runat="server">

    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        Dim blogd As FirstClickerService.V3.IBlog

        Label1.Text = blogd.Heading

    End Sub

    Protected Sub Buttonload_Click(sender As Object, e As EventArgs)
        Dim blogd As New FirstClickerService.V3.IBlog(TextBox1.Text, WebAppSettings.DBCS, True)
        Label1.Text = blogd.Heading
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" Text="withoutload" OnClick ="Button1_Click"  /><asp:Button ID="Buttonload" runat="server" Text="withload" OnClick ="Buttonload_Click" />
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>


</asp:Content>

