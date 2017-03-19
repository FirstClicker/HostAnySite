<%@ Control Language="VB" ClassName="UserDetailsInListView" %>
<%@ Import Namespace="System.ComponentModel" %>

<script runat="server">
    Public Property Userid() As String
        Get
            Return LabelUserid.Text
        End Get
        Set(ByVal value As String)
            LabelUserid.Text = value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return LabelUserName.Text
        End Get
        Set(ByVal value As String)
            LabelUserName.Text = value
        End Set
    End Property

    Public Property UserEmail() As String
        Get
            Return LabelUserEmail.Text
        End Get
        Set(ByVal value As String)
            LabelUserEmail.Text = value
        End Set
    End Property

    <DefaultValue(ClassHostAnySite.User.UserType.Guest)>
    Public Property UserType() As ClassHostAnySite.User.UserType
        Get
            If Trim(LabelUserType.Text) <> "" Then
                Return [Enum].Parse(GetType(ClassHostAnySite.User.UserType), LabelUserType.Text, True)
            Else
                Return ClassHostAnySite.User.UserType.Guest
            End If

        End Get
        Set(ByVal value As ClassHostAnySite.User.UserType)
            LabelUserType.Text = value.ToString
        End Set
    End Property

    <DefaultValue(ClassHostAnySite.User.AccountStatus.Unverified)>
    Public Property AccountStatus() As ClassHostAnySite.User.AccountStatus
        Get
            If Trim(LabelAccountStatus.Text) <> "" Then
                Return [Enum].Parse(GetType(ClassHostAnySite.User.AccountStatus), LabelAccountStatus.Text, True)
            Else
                Return ClassHostAnySite.User.AccountStatus.Unverified
            End If

        End Get
        Set(ByVal value As ClassHostAnySite.User.AccountStatus)
            LabelAccountStatus.Text = value.ToString
        End Set
    End Property




    Protected Sub LinkButtonAdmin_Click(sender As Object, e As EventArgs)
        If Val(Userid) = Val(Session("UserId")) Then
            Exit Sub ' can't make changes for self to protect last admin
        End If



        If UserType = ClassHostAnySite.User.UserType.Administrator Then
            ClassHostAnySite.User.User_ChangeUserType(Userid, ClassHostAnySite.User.UserType.Member, ClassAppDetails.DBCS)
            UserType = ClassHostAnySite.User.UserType.Member
        Else
            ClassHostAnySite.User.User_ChangeUserType(Userid, ClassHostAnySite.User.UserType.Administrator, ClassAppDetails.DBCS)
            UserType = ClassHostAnySite.User.UserType.Administrator
        End If

    End Sub

    Protected Sub LinkButtonSuspend_Click(sender As Object, e As EventArgs)
        If Val(Userid) = Val(Session("UserId")) Then
            Exit Sub ' can't make changes for self to protect last admin
        End If

        If AccountStatus = ClassHostAnySite.User.AccountStatus.Suspended Then
            ClassHostAnySite.User.User_ChangeAccountStatus(Userid, ClassHostAnySite.User.AccountStatus.Unverified, ClassAppDetails.DBCS)
            AccountStatus = ClassHostAnySite.User.AccountStatus.Unverified
        Else
            ClassHostAnySite.User.User_ChangeAccountStatus(Userid, ClassHostAnySite.User.AccountStatus.Suspended, ClassAppDetails.DBCS)
            AccountStatus = ClassHostAnySite.User.AccountStatus.Suspended
        End If


    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            Dim Cusertype As New ClassHostAnySite.User.UserType
            Try
                Cusertype = [Enum].Parse(GetType(ClassHostAnySite.User.UserType), Trim(Session("UserType")), True)
                If Cusertype = ClassHostAnySite.User.UserType.Administrator Or Cusertype = ClassHostAnySite.User.UserType.Moderator Then
                    LIActionSuspend.Visible = True
                    LIActionMakeAdmin.Visible = True
                End If
            Catch ex As Exception

            End Try

            If AccountStatus = ClassHostAnySite.User.AccountStatus.Suspended Then
                LinkButtonSuspend.Text = "<small>UnSuspend</small>"
            Else
                LinkButtonSuspend.Text = "<small>Suspend</small>"
            End If

            If UserType = ClassHostAnySite.User.UserType.Administrator Then
                LinkButtonAdmin.Text = "<small>Remove Admin</small>"
            Else
                LinkButtonAdmin.Text = "<small>Make Admin</small>"
            End If
        End If
    End Sub
</script>



<div class="panel no-margin">
    <div class="panel-heading clearfix">
        <div class="dropdown pull-right">
            <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
            <ul class="dropdown-menu">
                <li runat="server" id="LIActionSuspend" visible="false">
                    <asp:LinkButton ID="LinkButtonSuspend" runat="server" OnClick="LinkButtonSuspend_Click"><small>Suspend</small></asp:LinkButton>
                </li>
                <li runat="server" id="LIActionMakeAdmin" visible="false">
                   <asp:LinkButton ID="LinkButtonAdmin" OnClick="LinkButtonAdmin_Click" runat="server"> <small>Make Admin</small></asp:LinkButton>
                </li>
            </ul>
        </div>
        <h4 class="panel-title">
            <a data-toggle="collapse" href="#<%# PanelDetails.ClientID %>">
                <asp:Label ID="LabelUserName" runat="server" Text="Label"></asp:Label>
                -
                  <asp:Label ID="LabelUserEmail" runat="server" Text="Label"></asp:Label>
            </a>
        </h4>
    </div>
    <asp:Panel runat="server" ID="PanelDetails" CssClass="panel-collapse collapse">
        <div class="panel-body">
            UserID:
                         <asp:Label Text="" runat="server" ID="LabelUserid" /><br />
            UserName:
                         <asp:Label Text='<%# Eval("UserName") %>' runat="server" ID="UserNameLabel" /><br />
            RoutUserName:
                         <asp:Label Text='<%# Eval("RoutUserName") %>' runat="server" ID="RoutUserNameLabel" /><br />
            UserType:
                      <asp:Label ID="LabelUserType" runat="server" Text="" ></asp:Label><br />
            Email:
                         <asp:Label Text='<%# Eval("Email") %>' runat="server" ID="EmailLabel" /><br />
            EmailVerified:
                         <asp:Label Text='<%# Eval("EmailVerified") %>' runat="server" ID="EmailVerifiedLabel" /><br />
            AccountStatus:
                       <asp:Label ID="LabelAccountStatus" runat="server" Text="" ></asp:Label>
<br />
            JoinDate:
                         <asp:Label Text='<%# Eval("JoinDate") %>' runat="server" ID="JoinDateLabel" /><br />
            LastLogInDate:
                         <asp:Label Text='<%# Eval("LastLogInDate") %>' runat="server" ID="LastLogInDateLabel" /><br />

            <br />
        </div>
        <div class="panel-footer">
        </div>
    </asp:Panel>
</div>
