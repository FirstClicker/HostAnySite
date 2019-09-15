<%@ Control Language="VB" ClassName="WebSettingUpdaterSelectHome" %>

<script runat="server">
    Public Event Setting_UpdateSuccess As EventHandler

    Public Property SettingName() As String
        Get
            Return LabelSettingName.Text
        End Get
        Set(ByVal value As String)
            LabelSettingName.Text = value
        End Set
    End Property

    Public Property SettingValue() As FirstClickerService.Version1.WebSetting.websiteHomePathEnum
        Get
            Return [Enum].Parse(GetType(FirstClickerService.Version1.WebSetting.websiteHomePathEnum), DropDownListSettingValue.SelectedIndex.ToString, True)
        End Get
        Set(ByVal value As FirstClickerService.Version1.WebSetting.websiteHomePathEnum)
            DropDownListSettingValue.SelectedIndex = CInt([Enum].Parse(GetType(FirstClickerService.Version1.WebSetting.websiteHomePathEnum), [Enum].GetName(GetType(FirstClickerService.Version1.WebSetting.websiteHomePathEnum), value)))
        End Set
    End Property



    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            DropDownListSettingValue.DataSource = System.Enum.GetValues(GetType(FirstClickerService.Version1.WebSetting.websiteHomePathEnum))
            DropDownListSettingValue.DataBind()

            Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
            websetting = FirstClickerService.Version1.WebSetting.WebSetting_Get(LabelSettingName.Text, WebAppSettings.DBCS)
            If websetting.Result = True Then

                DropDownListSettingValue.SelectedIndex = CInt([Enum].Parse(GetType(FirstClickerService.Version1.WebSetting.websiteHomePathEnum), [Enum].GetName(GetType(FirstClickerService.Version1.WebSetting.websiteHomePathEnum), [Enum].Parse(GetType(FirstClickerService.Version1.WebSetting.websiteHomePathEnum), websetting.SettingValue, True))))
            Else
                DropDownListSettingValue.Enabled = False
            End If
        End If


    End Sub

    Protected Sub DropDownListSettingValue_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim websetting As FirstClickerService.Version1.WebSetting.StructureWebSetting
        websetting = FirstClickerService.Version1.WebSetting.WebSetting_Update(SettingName, DropDownListSettingValue.SelectedItem.Text, WebAppSettings.DBCS)

        RaiseEvent Setting_UpdateSuccess(Me, EventArgs.Empty)

    End Sub
</script>


<asp:Label ID="LabelSettingName" runat="server" Text="" Visible="False"></asp:Label>
<div class="form-group">
   <label>Website Home Path</label>
    <div class="input-group">
        <div class="input-group-prepend">
            <span class="input-group-text ">
                <i class="fas fa-cogs"></i></span>
        </div>
        <asp:DropDownList ID="DropDownListSettingValue" CssClass ="form-control" AutoPostBack="True" CausesValidation="True" OnSelectedIndexChanged="DropDownListSettingValue_SelectedIndexChanged" runat="server"></asp:DropDownList>
     
    </div>
</div>
