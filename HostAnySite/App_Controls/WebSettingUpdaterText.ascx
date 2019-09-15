<%@ Control Language="VB" ClassName="WebSettingUpdaterText" %>

<script runat="server">
    Public Event Setting_UpdateSuccess As EventHandler

    Public Property SettingHeading() As String
        Get
            Return LabelSettingHeading.Text
        End Get
        Set(ByVal value As String)
            LabelSettingHeading.Text = value
        End Set
    End Property

    Public Property SettingName() As String
        Get
            Return LabelSettingName.Text
        End Get
        Set(ByVal value As String)
            LabelSettingName.Text = value
        End Set
    End Property

    Public Property SettingValue() As String
        Get
            Return TextBoxSettingValue.Text
        End Get
        Set(ByVal value As String)
            TextBoxSettingValue.Text = value
        End Set
    End Property

    Protected Sub ButtonUpdateSetting_Click(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(SettingName, TextBoxSettingValue.Text, WebAppSettings.DBCS)

        RaiseEvent Setting_UpdateSuccess(Me, EventArgs.Empty)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
            websetting = FirstClickerService.Version1.WebSetting.WebSetting_Get(LabelSettingName.Text, WebAppSettings.DBCS)
            If websetting.Result = True Then
                TextBoxSettingValue.Text = websetting.SettingValue
            Else
                ButtonUpdateSetting.Enabled = False
            End If
        End If
    End Sub


</script>


<asp:Label ID="LabelSettingName" runat="server" Text="" Visible="False"></asp:Label>

<div class="form-group">
    <label>
        <asp:Label ID="LabelSettingHeading" runat="server" Text=""></asp:Label></label> 
    <div class="input-group">
        <div class="input-group-prepend">
            <span class="input-group-text ">
                <i class="fas fa-cogs"></i></span>
        </div>
        <asp:TextBox ID="TextBoxSettingValue" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
        <div class="input-group-append">
            <asp:Button class="btn " runat="server" ID="ButtonUpdateSetting" type="button" OnClick="ButtonUpdateSetting_Click" Text="Update"></asp:Button>
        </div>
    </div>
</div>
