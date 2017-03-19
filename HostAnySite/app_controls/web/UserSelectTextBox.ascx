<%@ Control Language="VB" ClassName="UserSelectTextBox" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    Public Property RoutUserName() As String
        Get
            Return txtCustomer.Text
        End Get
        Set(ByVal value As String)
            Dim userinfo As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.UserDetail_RoutUserName(value, ClassAppDetails.DBCS)
            If userinfo.Result = False Then
                txtCustomer.Text = ""
                
                txtCustomer.Enabled = True
                txtCustomer.ForeColor = Drawing.Color.Red
                
                ButtonAction.Text = "V"
            Else
                txtCustomer.Text = userinfo.RoutUserName
                hfCustomerId.Value = userinfo.UserID
                
                txtCustomer.Enabled = False
                txtCustomer.ForeColor = Drawing.Color.Blue
                
                ButtonAction.Text = "X"
            End If
            
            RaiseEvent RoutUserNameUpdated(Me, EventArgs.Empty)
        End Set
    End Property
    
    Public Property UserId() As String
        Get
            Return hfCustomerId.Value
        End Get
        Set(ByVal value As String)
            Dim userinfo As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.UserDetail_UserID(value, ClassAppDetails.DBCS)
            If userinfo.Result = False Then
                hfCustomerId.Value = "0"
                
                txtCustomer.Enabled = True
                txtCustomer.ForeColor = Drawing.Color.Red
                
                ButtonAction.Text = "V"
            Else
                hfCustomerId.Value = value
                txtCustomer.Text = userinfo.RoutUserName
                
                txtCustomer.Enabled = False
                txtCustomer.ForeColor = Drawing.Color.Blue
                
                ButtonAction.Text = "X"
            End If
            
            RaiseEvent RoutUserNameUpdated(Me, EventArgs.Empty)

        End Set
    End Property
    
    Public Event RoutUserNameUpdated As EventHandler
    
    'to get the value
    '   Dim customerId As String = Request.Form(hfCustomerId.UniqueID)
    
     
    Protected Sub ButtonAction_Click(sender As Object, e As EventArgs)
        If ButtonAction.Text = "X" Then
            ButtonAction.Text = "V"
            txtCustomer.Enabled = True
            txtCustomer.ForeColor = Drawing.Color.Red
            
            txtCustomer.Text = ""
        Else
            Dim userinfo As ClassHostAnySite.User.StructureUser = ClassHostAnySite.User.UserDetail_RoutUserName(txtCustomer.Text, ClassAppDetails.DBCS)
            If userinfo.Result = False Then
                             
                txtCustomer.Enabled = True
                txtCustomer.ForeColor = Drawing.Color.Red
                
                ButtonAction.Text = "V"
            Else
                txtCustomer.Text = userinfo.RoutUserName
                hfCustomerId.Value = userinfo.UserID
                
                txtCustomer.Enabled = False
                txtCustomer.ForeColor = Drawing.Color.Blue
                
                ButtonAction.Text = "X"
            End If
            
         
        End If
            
      
        
        RaiseEvent RoutUserNameUpdated(Me, EventArgs.Empty)
    End Sub

    Protected Sub hfCustomerId_ValueChanged(sender As Object, e As EventArgs)
        txtCustomer.Enabled = False
        txtCustomer.ForeColor = Drawing.Color.Blue
        ButtonAction.Visible = True
        
        
        RaiseEvent RoutUserNameUpdated(Me, EventArgs.Empty)
    End Sub
</script>


<script type = "text/javascript">
    function ClientItemSelected(sender, e) {
        var hdnValueID = "<%= hfCustomerId.ClientID%>";

        document.getElementById(hdnValueID).value = e.get_value();
        __doPostBack(hdnValueID, "");


      //  $get("<%=hfCustomerId.ClientID %>").value = e.get_value();

      //  prehfCustomerId = document.getElementById('<%=txtCustomer.ClientID%>');
      //  pretxtCustomer.disabled = true;

      //  preButtonAction = document.getElementById('<%=ButtonAction.ClientID%>');
      //  preButtonAction.style.display = "block";

      
    }
</script>



<div class="input-group">
   <asp:TextBox ID="txtCustomer" CssClass ="form-control" runat="server" Font-Bold="True" ForeColor="#CC3300">
</asp:TextBox>
<ajaxToolkit:AutoCompleteExtender 
    ID="txtCustomer_AutoCompleteExtender" 
    runat="server" 
    BehaviorID="txtCustomer_AutoCompleteExtender" 
    DelimiterCharacters="" 
    ServicePath="~/WebService/UserAutoComplete.asmx" 
    ServiceMethod="GetUserList"
    MinimumPrefixLength="2"
    OnClientItemSelected = "ClientItemSelected"
    TargetControlID="txtCustomer">
</ajaxToolkit:AutoCompleteExtender>
    

<asp:HiddenField ID="hfCustomerId" runat="server" OnValueChanged="hfCustomerId_ValueChanged" Value="0" />

   <span class="input-group-btn">
        <asp:Button ID="ButtonAction" runat="server" CssClass ="btn btn-default" Text="V" OnClick="ButtonAction_Click" />

   </span>
</div>

