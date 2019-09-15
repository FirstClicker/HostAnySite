<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Implements Interface ="RoutBoardUniInterface"  %>


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

    Private m_RoutIFace_String2 As String
    Public Property RoutIFace_String2 As String Implements RoutBoardUniInterface.RoutIFace_String2
        Get
            Return m_RoutIFace_String2
        End Get
        Set(value As String)
            m_RoutIFace_String2 = value
        End Set
    End Property

    Private m_RoutIFace_String3 As String
    Public Property RoutIFace_String3 As String Implements RoutBoardUniInterface.RoutIFace_String3
        Get
            Return m_RoutIFace_String3
        End Get
        Set(value As String)
            m_RoutIFace_String3 = value
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
        Label1.Text = RoutIFace_String1
        Label2.Text = RoutIFace_String2
        Label3.Text = RoutIFace_String3
        Label4.Text = RoutIFace_String4
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:Label ID="Label1" runat="server" Text="Label"/><br />

    <asp:Label ID="Label2" runat="server" Text="Label"/><br />

   <asp:Label ID="Label3" runat="server" Text="Label"/><br />

   <asp:Label ID="Label4" runat="server" Text="Label"/>




</asp:Content>

