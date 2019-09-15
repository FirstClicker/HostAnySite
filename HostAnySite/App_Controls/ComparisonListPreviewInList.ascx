<%@ Control Language="VB" ClassName="ComparisonListPreviewInList" %>

<script runat="server">
    Public Property UserID() As String
        Get
            Return LabelUserID.Text
        End Get
        Set(ByVal value As String)
            LabelUserID.Text = value
        End Set
    End Property

    Public Property UserName() As String
        Get
            Return HyperLinkUserName.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUserName.Text = value
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUsername.Text = value
            HyperLinkUserName.NavigateUrl = "~/user/" & value
        End Set
    End Property

    Public Property ListID() As String
        Get
            Return LabelListID.Text
        End Get
        Set(ByVal value As String)
            LabelListID.Text = value
        End Set
    End Property

    Public Property ListHeading() As String
        Get
            Return HyperLinkListHeading.Text
        End Get
        Set(ByVal value As String)
            HyperLinkListHeading.Text = value
        End Set
    End Property

    Public Property EntryDescription() As String
        Get
            Return LabelListDescription.Text
        End Get
        Set(ByVal value As String)
            LabelListDescription.Text = value
        End Set
    End Property

    Public Property CreateDate() As String
        Get
            Return LabelDatetime.Text
        End Get
        Set(ByVal value As String)
            LabelDatetime.Text = value
        End Set
    End Property




    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkListHeading.NavigateUrl = "~/compare/" & FirstClickerService.common.ConvertSpace2Dass(ListHeading) & "/" & ListID & "/"
    End Sub



    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub
</script>

<asp:Label ID="LabelUserID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelListID" runat="server" Text="" Visible="False"></asp:Label>


<asp:Label ID="LabelListDescription" runat="server" Text=""></asp:Label>
<asp:Panel runat="server" ID="PanelEntryView" CssClass="card m-0" >
    <div class="card-body">
        <div class="media">
           
                <asp:Image runat="server" ID="ImageEntryPic" CssClass=" " Width="45" Height="60" ImageUrl="~/Content/image/ComparisonEntry.png" />
           
            <div class="media-body">
                <div class="row">
                    <div class="col-lg-12">
                          <div class="dropdown float-right">
                            <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                            <ul class="dropdown-menu">
                                <li runat="server" id="LIActionEditEntry"  visible="false">
                                    <asp:LinkButton ID="LinkButtonEditEntry" runat="server" ><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; <small>Edit</small></asp:LinkButton></li>
                                 <li runat="server" id="LIActionDelete" visible="false">
                                    <asp:LinkButton ID="LinkButtonDelete" runat="server" ><i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp; <small>Delete</small></asp:LinkButton></li>
                                <li runat="server" id="LIActionViewEntry">
                                    <asp:HyperLink ID="HyperLinkViewEntry" runat="server"><i class="fa fa-eye" aria-hidden="true"></i>&nbsp; <small>View</small></asp:HyperLink></li>
                                 <li runat="server" id="LIActionReport"><a href="#"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp; <small>Report</small></a></li>
                                
                            </ul>
                        </div>
                        <h4 style="margin: 3px;">
                            <asp:HyperLink ID="HyperLinkListHeading" runat="server"></asp:HyperLink>
                        </h4>
                        <ul class="list-inline small">
                            <li><i class="fa fa-user"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUserName" runat="server">User Name</asp:HyperLink></li>
                            <li><i class="fa fa-calendar"></i>&nbsp;Posted on&nbsp;<asp:Label ID="LabelDatetime" runat="server" Text=""></asp:Label></li>
                        </ul>

                    </div>
                </div>

            </div>
        </div>
        <div class="row" style="padding-left: 75px;">
           
        </div> 
    </div>
</asp:Panel>
