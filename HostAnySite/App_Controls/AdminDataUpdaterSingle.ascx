<%@ Control Language="VB" ClassName="AdminDataUpdaterSingle" %>
<%@ Import Namespace ="System.Data.SqlClient"  %>

<script runat="server">
    ' version 19/09/2018 # 11.27 



    Public Property KeyField() As String
        Get
            Return LabelKeyField.Text
        End Get
        Set(ByVal value As String)
            LabelKeyField.Text = value
        End Set
    End Property

    Public Property KeyFieldValue() As String
        Get
            Return LabelKeyFieldValue.Text
        End Get
        Set(ByVal value As String)
            LabelKeyFieldValue.Text = value
        End Set
    End Property

    Public Property UpdateField() As String
        Get
            Return LabelUpdateField.Text
        End Get
        Set(ByVal value As String)
            LabelUpdateField.Text = value
        End Set
    End Property

    Public Property UpdateFieldValue() As String
        Get
            Return TextBoxNewValue.Text
        End Get
        Set(ByVal value As String)
            TextBoxNewValue.Text = value
        End Set
    End Property

    Public Property TableName() As String
        Get
            Return LabelTableName.Text
        End Get
        Set(ByVal value As String)
            LabelTableName.Text = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As FirstClickerService.Version1.User.UserType = FirstClickerService.Version1.User.ParseEnum_UserType(Trim(Session("UserType")))
        If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
        Else
            Me.Visible = False
        End If
    End Sub

    Protected Sub ButtonUpdate_Click(sender As Object, e As EventArgs)


        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myCmd.CommandText = "update " & TableName & " set " & UpdateField & "=N'" & UpdateFieldValue.Replace("'", "''") & "' where " & KeyField & "='" & KeyFieldValue & "'"

        myConn.Open()
        Try
            myReader = myCmd.ExecuteReader
            myReader.Close()
            myConn.Close()
        Catch ex As Exception
            FirstClickerService.Version1.ReportError.ReportErrorRaw("1", "admindataupdater single", ex.Message & myCmd.CommandText, WebAppSettings.DBCS)

        End Try


    End Sub
</script>



<asp:Label ID="LabelKeyField" runat="server" Text="" Visible="false"></asp:Label>
<asp:Label ID="LabelKeyFieldValue" runat="server" Text="" Visible="false"></asp:Label>

<asp:Label ID="LabelUpdateField" runat="server" Text="" Visible="false"></asp:Label>

<asp:Label ID="LabelTableName" runat="server" Text="" Visible="false"></asp:Label>



<asp:LinkButton ID="lnkDummy" runat="server">EDIT</asp:LinkButton>
<ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1"  runat="server"
    PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground" CancelControlID="btnHide">
</ajaxToolkit:ModalPopupExtender>
<asp:Panel ID="pnlPopup" runat="server" CssClass="card" Style="display: none; min-width :300px;">
    <div class="card-header ">
        Update
         <div class="float-right clearfix">
            <asp:Button ID="btnHide" runat="server" CssClass="btn btn-sm btn-danger" Text="Cancel" />
        </div>
    </div>
    <div class="card-body ">
         <div class="form-group"> 
                    <asp:TextBox ID="TextBoxNewValue" CssClass="form-control" runat="server" Height="200px" TextMode="MultiLine"></asp:TextBox>
            <div style="visibility: hidden">
                <ajaxToolkit:HtmlEditorExtender runat="server" BehaviorID="HtmlEditor1_HtmlEditorExtender" TargetControlID="TextBoxNewValue" ID="HtmlEditor1_HtmlEditorExtender">
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
                        <ajaxToolkit:BackgroundColorSelector />

                        <ajaxToolkit:JustifyLeft />
                        <ajaxToolkit:JustifyCenter />
                        <ajaxToolkit:JustifyRight />
                        <ajaxToolkit:JustifyFull />

                        <ajaxToolkit:CreateLink />
                        <ajaxToolkit:UnLink />

                        <ajaxToolkit:RemoveFormat />

                    </Toolbar>
                </ajaxToolkit:HtmlEditorExtender>
            </div>

         </div> 
          <div class="form-group">
              <asp:Button ID="ButtonUpdate" runat="server" Text="Update" OnClick ="ButtonUpdate_Click" />
          </div>
    </div>
</asp:Panel>
