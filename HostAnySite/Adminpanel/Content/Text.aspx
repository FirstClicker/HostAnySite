<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Src="~/app_controls/web/NavigationSideAdmin.ascx" TagPrefix="uc1" TagName="NavigationSideAdmin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/app_controls/web/ValidateAdminUserAccess.ascx" TagPrefix="uc1" TagName="ValidateAdminUserAccess" %>


<script runat="server">

    Protected Sub ButtonSubmit_Click(sender As Object, e As EventArgs)
        Dim updatesetting As ClassHostAnySite.WebSetting.StructureWebSetting = ClassHostAnySite.WebSetting.WebSetting_Update(DropDownListSetting.SelectedItem.Text, TextBoxContent.Text, ClassAppDetails.DBCS)
        LabelEm.Text = updatesetting.My_Error_message


    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Me.IsPostBack = False Then
            DropDownListSetting.Items.Clear()

            DropDownListSetting.Items.Add("Setect Setting")

            Dim myConn As SqlConnection
            Dim myCmd As SqlCommand
            Dim myReader As SqlDataReader

            myConn = New SqlConnection(ClassAppDetails.DBCS)
            myCmd = myConn.CreateCommand
            myConn.Open()

            myCmd.CommandText = "select * from Table_Websetting where Type='Text' order by SettingName"
            myReader = myCmd.ExecuteReader
            Do While myReader.Read
                DropDownListSetting.Items.Add(myReader.Item("SettingName"))
            Loop

            myReader.Close()
            myConn.Close()
        End If

    End Sub

    Protected Sub DropDownListSetting_SelectedIndexChanged(sender As Object, e As EventArgs)
        If DropDownListSetting.SelectedIndex = 0 Then Exit Sub

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(ClassAppDetails.DBCS)
        myCmd = myConn.CreateCommand
        myConn.Open()

        myCmd.CommandText = "select * from Table_Websetting where SettingName='" & DropDownListSetting.SelectedItem.Text & "'"
        myReader = myCmd.ExecuteReader
        Do While myReader.Read
            TextBoxContent.Text = myReader.Item("Settingvalue")
        Loop

        myReader.Close()
        myConn.Close()


    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:ValidateAdminUserAccess runat="server" ID="ValidateAdminUserAccess" />
        <div class="row">
      <div class="col-md-3 col-sm-3">
            <uc1:NavigationSideAdmin runat="server" ID="NavigationSideAdmin" />
        </div>
        <div class="col-md-8 col-sm-8">
            <div class="panel panel-default">
                <div class="panel-heading">Change Text</div>
                <div class="panel-body">
                    <div class="form">
                        <div class="form-group">
                            <asp:DropDownList ID="DropDownListSetting" CssClass ="form-control " runat="server" OnSelectedIndexChanged="DropDownListSetting_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="TextBoxContent" CssClass ="form-control " runat="server" TextMode="MultiLine" Height="200"></asp:TextBox>
                            <div style="visibility: hidden">
                                <cc1:HtmlEditorExtender ID="TextBoxContent_HtmlEditorExtender" runat="server" BehaviorID="TextBoxContent_HtmlEditorExtender" EnableSanitization="False" TargetControlID="TextBoxContent" DisplaySourceTab="True">
                                    <Toolbar>
                                        <cc1:Undo />
                                        <cc1:Redo />
                                        <cc1:Bold />
                                        <cc1:Italic />
                                        <cc1:Underline />
                                        <cc1:StrikeThrough />
                                        <cc1:Subscript />
                                        <cc1:Superscript />
                                        <cc1:JustifyLeft />
                                        <cc1:JustifyCenter />
                                        <cc1:JustifyRight />
                                        <cc1:JustifyFull />
                                        <cc1:RemoveFormat />
                                        
                                    </Toolbar>
                                </cc1:HtmlEditorExtender>
                            </div>
                        </div>
                        <div class="form-group">
                              <asp:Label ID="LabelEm" runat="server" Text="" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                        </div>
                        <div class="form-group">

                            <div class="pull-right ">
                                <asp:Button ID="ButtonSubmit" runat="server" CssClass="btn btn-info " OnClick="ButtonSubmit_Click" Text="Submit" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>

