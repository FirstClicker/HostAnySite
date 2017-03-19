<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Src="~/app_controls/web/NavigationSideAdmin.ascx" TagPrefix="uc1" TagName="NavigationSideAdmin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/app_controls/web/ValidateAdminUserAccess.ascx" TagPrefix="uc1" TagName="ValidateAdminUserAccess" %>


<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Page.IsPostBack = False Then
            loaddata()
        End If
    End Sub

    Public Function loaddata() As Boolean
        loaddata = False

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(ClassAppDetails.DBCS)
        myCmd = myConn.CreateCommand
        myConn.Open()

        myCmd.CommandText = "select * from Table_Websetting where Type='Image' order by SettingName"
        myReader = myCmd.ExecuteReader
        Do While myReader.Read

            Dim mylistitem1 As New ListItem
            mylistitem1.Text = myReader.Item("SettingName")
            mylistitem1.Value = myReader.Item("SettingName")

            DropDownListSetting.Items.Add(mylistitem1)
        Loop

        myReader.Close()
        myConn.Close()
    End Function


    Protected Sub DropDownListSetting_SelectedIndexChanged(sender As Object, e As EventArgs)
        If DropDownListSetting.SelectedIndex = 0 Then
            Exit Sub
        End If

        Dim selecvalue As String = ""

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(ClassAppDetails.DBCS)
        myCmd = myConn.CreateCommand
        myConn.Open()

        myCmd.CommandText = "select * from Table_Websetting where SettingName='" & DropDownListSetting.SelectedItem.Text & "'"
        myReader = myCmd.ExecuteReader
        If myReader.HasRows = True Then
            myReader.Read()
            selecvalue = myReader.Item("SettingValue")
        End If

        myReader.Close()
        myConn.Close()



        contentimage.ImageUrl = "~/content/image/" & selecvalue
        contentimage.Visible = CBool(Len(Trim(selecvalue)))

        LabelEm.Text = ""
    End Sub



    Protected Sub ButtonSubmit_Click(sender As Object, e As EventArgs)
        If FileUpload1.HasFile = True Then
            Dim fileExt As String
            fileExt = System.IO.Path.GetExtension(FileUpload1.FileName)

            If Not (fileExt.ToLower = ".jpg") Then
                LabelEm.Text = "Only .Jpg files allowed!"
                Exit Sub
            End If

            If IO.File.Exists(Server.MapPath("~/content/Image/" & DropDownListSetting.SelectedItem.Text.Trim & ".jpg")) = True Then
                Try
                    IO.File.Delete(Server.MapPath("~/content/Image/" & DropDownListSetting.SelectedItem.Text.Trim & ".jpg"))
                Catch ex As Exception
                    LabelEm.Text = ex.Message
                    Exit Sub
                End Try
            End If

            FileUpload1.PostedFile.SaveAs(Server.MapPath("~/content/Image/" & DropDownListSetting.SelectedItem.Text.Trim & ".jpg"))
        Else
            LabelEm.Text = "Select a .JPG image."
        End If
        ''''''''''''''''''''''
        'up load image

        Dim updatesetting As ClassHostAnySite.WebSetting.StructureWebSetting = ClassHostAnySite.WebSetting.WebSetting_Update(DropDownListSetting.SelectedItem.Text, DropDownListSetting.SelectedItem.Text.Trim & ".jpg", ClassAppDetails.DBCS)
        LabelEm.Text = updatesetting.My_Error_message

        contentimage.ImageUrl = "~/content/image/" & updatesetting.SettingValue
        contentimage.Visible = CBool(Len(Trim(updatesetting.SettingValue)))
    End Sub

    Protected Sub ButtonRemove_Click(sender As Object, e As EventArgs)
        Dim updatesetting As ClassHostAnySite.WebSetting.StructureWebSetting = ClassHostAnySite.WebSetting.WebSetting_Update(DropDownListSetting.SelectedItem.Text, " ", ClassAppDetails.DBCS)
        If updatesetting.Result = True Then
            contentimage.Visible = False

            Try
                IO.File.Delete(Server.MapPath("~/content/Image/" & DropDownListSetting.SelectedItem.Text.Trim & ".jpg"))
            Catch ex As Exception
                LabelEm.Text = ex.Message
                Exit Sub
            End Try

        End If
        LabelEm.Text = updatesetting.My_Error_message
    End Sub


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateAdminUserAccess runat="server" ID="ValidateAdminUserAccess" />
    <div class="row">
         <div class="col-md-3 col-sm-3">
            <uc1:NavigationSideAdmin runat="server" ID="NavigationSideAdmin" />
        </div>
        <div class="col-md-8 col-sm-8">
            <div class="panel panel-default">
                <div class="panel-heading">Change Image</div>
                <div class="panel-body">
                    <div class="form">
                        <div class="form-group">
                            <asp:DropDownList ID="DropDownListSetting" runat="server" CssClass ="form-control " AutoPostBack="True" OnSelectedIndexChanged="DropDownListSetting_SelectedIndexChanged">
                                <asp:ListItem>Setect Setting</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Image runat="server" ID="contentimage" CssClass="img-rounded img-responsive " />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="LabelEm" runat="server" Text="" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                        </div>
                        <div class="form-group">
                            <div class="pull-left ">
                                <asp:FileUpload ID="FileUpload1" runat="server" />
                            </div>
                            <div class="pull-right ">
                                <asp:Button ID="ButtonSubmit" runat="server" CssClass="btn btn-info " OnClick="ButtonSubmit_Click" Text="Submit" />
                                <asp:Button ID="ButtonRemove" runat="server" CssClass="btn btn-danger " Text="Remove" OnClick="ButtonRemove_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

