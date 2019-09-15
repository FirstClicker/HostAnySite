<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Session("UserName") = ""
        Session("RoutUserName") = ""
        Session("UserID") = ""
        Session("UserType") = ""

        Dim myCookie As HttpCookie
        myCookie = New HttpCookie("HASApp")
        myCookie.Expires = DateTime.Now.AddDays(-7D)
        myCookie.Item("UserName") = ""
        myCookie.Item("UserID") = ""
        myCookie.Item("UserType") = ""
        Response.Cookies.Add(myCookie)

        Response.Redirect("~/")
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>
