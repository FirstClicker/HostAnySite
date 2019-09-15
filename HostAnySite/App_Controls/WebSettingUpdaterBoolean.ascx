<%@ Control Language="VB" ClassName="WebSettingUpdaterBoolean" %>

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

    Public Property SettingValue() As Boolean
        Get
            Return CheckBoxSetting.Checked
        End Get
        Set(ByVal value As Boolean)
            CheckBoxSetting.Checked = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
            websetting = FirstClickerService.Version1.WebSetting.WebSetting_Get(LabelSettingName.Text, WebAppSettings.DBCS)
            If websetting.Result = True Then
                Try
                    CheckBoxSetting.Checked = CBool(websetting.SettingValue)
                Catch ex As Exception
                    'report error
                    CheckBoxSetting.Enabled = False
                End Try
            Else
                CheckBoxSetting.Enabled = False
            End If
        End If
    End Sub

    Protected Sub CheckBoxSetting_CheckedChanged(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(SettingName, CheckBoxSetting.Checked.ToString, WebAppSettings.DBCS)
    End Sub
</script>


<asp:Label ID="LabelSettingName" runat="server" Text="" Visible="False"></asp:Label>
<div class="form-group">
    <div class="checkbox">
        <label>
            <asp:CheckBox ID="CheckBoxSetting" runat="server" OnCheckedChanged="CheckBoxSetting_CheckedChanged" AutoPostBack="True" CausesValidation="True" />
            <asp:Label ID="LabelSettingHeading" CssClass="ml-1" runat="server" Text="Label"></asp:Label>
        </label>
    </div>
</div>

