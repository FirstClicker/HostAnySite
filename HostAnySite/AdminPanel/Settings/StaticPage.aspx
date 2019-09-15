<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>




<script runat="server">
    Protected Sub ButtonSubmit_Click(sender As Object, e As EventArgs)
        Dim updatesetting As FirstClickerService.Version1.StaticPage.StructureStaticPage = FirstClickerService.Version1.StaticPage.StaticPage_Update(DropDownListSetting.SelectedItem.Text, TextBoxPageTitle.Text, TextBoxPageKeyword.Text, TextBoxDescription.Text, TextBoxContent.Text, WebAppSettings.DBCS)
        LabelEm.Text = updatesetting.My_Error_message
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Response.Redirect("~/user/signin.aspx?returnURL=" & "~" & Request.RawUrl)
        End If

        If Me.IsPostBack = False Then
            DropDownListSetting.Items.Clear()
            DropDownListSetting.Items.Add("Setect Page")
            For Each i In [Enum].GetValues(GetType(FirstClickerService.Version1.StaticPage.PageNameList))
                DropDownListSetting.Items.Add(i.ToString)
            Next
        End If
    End Sub

    Protected Sub DropDownListSetting_SelectedIndexChanged(sender As Object, e As EventArgs)
        If DropDownListSetting.SelectedIndex = 0 Then
            TextBoxPageTitle.Text = ""
            TextBoxPageKeyword.Text = ""
            TextBoxDescription.Text = ""
            TextBoxContent.Text = ""
            Exit Sub
        End If

        Dim pageinfo As FirstClickerService.Version1.StaticPage.StructureStaticPage
        pageinfo = FirstClickerService.Version1.StaticPage.StaticPage_Get([Enum].Parse(GetType(FirstClickerService.Version1.StaticPage.PageNameList), DropDownListSetting.SelectedItem.Text, True), WebAppSettings.DBCS)
        If pageinfo.Result = True Then
            TextBoxPageTitle.Text = pageinfo.Title
            TextBoxPageKeyword.Text = pageinfo.Keyword
            TextBoxDescription.Text = pageinfo.Description
            TextBoxContent.Text = pageinfo.PageBody
        Else
            LabelEm.Text = "Failed to load"
        End If

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
         <div class="col-12 col-sm-12 col-md-12 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
       <div class="col-12 col-sm-12 col-md-12 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header">Static Page Content</div>
                <div class="card-body">
                    <div class="form">
                        <div class="form-group">
                            <asp:DropDownList ID="DropDownListSetting" CssClass ="form-control " runat="server" OnSelectedIndexChanged="DropDownListSetting_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                        </div>
                          <div class="form-group">
                              <label >Page Title</label>
                              <asp:TextBox ID="TextBoxPageTitle" CssClass ="form-control" runat="server"></asp:TextBox>
                          </div> 
                         <div class="form-group">
                               <label >Page Keyword</label>
                              <asp:TextBox ID="TextBoxPageKeyword" CssClass ="form-control" runat="server"></asp:TextBox>
                         </div> 
                         <div class="form-group">
                               <label >Meta Description</label>
                              <asp:TextBox ID="TextBoxDescription" CssClass ="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                         </div> 
                        <div class="form-group">
                            <asp:TextBox ID="TextBoxContent" CssClass ="form-control " runat="server" TextMode="MultiLine" Height="400"></asp:TextBox>
                            <div style="visibility: hidden">
                                <ajaxToolkit:HtmlEditorExtender ID="TextBoxContent_HtmlEditorExtender" runat="server" BehaviorID="TextBoxContent_HtmlEditorExtender" EnableSanitization="False" TargetControlID="TextBoxContent" DisplaySourceTab="True">
                                    <Toolbar>
                                        <ajaxToolkit:Undo />
                                        <ajaxToolkit:Redo />
                                        <ajaxToolkit:Bold />
                                        <ajaxToolkit:Italic />
                                        <ajaxToolkit:Underline />
                                        <ajaxToolkit:StrikeThrough />
                                        <ajaxToolkit:Subscript />
                                        <ajaxToolkit:Superscript />
                                        <ajaxToolkit:FontNameSelector />
                                        <ajaxToolkit:FontSizeSelector />
                                        <ajaxToolkit:ForeColorSelector />
                                        
                                        <ajaxToolkit:JustifyLeft />
                                        <ajaxToolkit:JustifyCenter />
                                        <ajaxToolkit:JustifyRight />
                                        <ajaxToolkit:JustifyFull />
                                        <ajaxToolkit:RemoveFormat />
                                        <ajaxToolkit:CreateLink />
                                        
                                    </Toolbar>
                                </ajaxToolkit:HtmlEditorExtender>
                            </div>
                        </div>
                        <div class="form-group">
                              <asp:Label ID="LabelEm" runat="server" Text="" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                        </div>
                        <div class="form-group">

                            <div class="float-right ">
                                <asp:Button ID="ButtonSubmit" runat="server" CssClass="btn btn-info " OnClick="ButtonSubmit_Click" Text="Submit" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>



        </div>
    </div>
</asp:Content>

