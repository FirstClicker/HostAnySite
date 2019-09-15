<%@ Control Language="VB" ClassName="ComparisonEntryRating" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Src="~/App_Controls/ComparisonCriteriaRatingVote.ascx" TagPrefix="uc1" TagName="CriteriaRatingvote" %>


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
            HyperLinkUsername.NavigateUrl = "~/user/" & value
        End Set
    End Property

    Public Property EntryID() As String
        Get
            Return LabelEntryID.Text
        End Get
        Set(ByVal value As String)
            LabelEntryID.Text = value
        End Set
    End Property

    Public Property EntryHeading() As String
        Get
            Return HyperLinkEntryHeading.Text
        End Get
        Set(ByVal value As String)
            HyperLinkEntryHeading.Text = value
        End Set
    End Property

    Public Property EntryDescription() As String
        Get
            Return LabelEntryDescription.Text
        End Get
        Set(ByVal value As String)
            LabelEntryDescription.Text = value
        End Set
    End Property

    Public Property EntryImageID() As String
        Get
            Return LabelEntryImageID.Text
        End Get
        Set(ByVal value As String)
            LabelEntryImageID.Text = value
        End Set
    End Property

    Public Property EntryImageFileName() As String
        Get
            Return LabelEntryImageFileName.Text
        End Get
        Set(ByVal value As String)
            LabelEntryImageFileName.Text = value
        End Set
    End Property




    Public Property EntryDescriptionInList() As String
        Get
            Return LabelEntryDescriptionInList.Text
        End Get
        Set(ByVal value As String)
            LabelEntryDescriptionInList.Text = value
        End Set
    End Property

    Public Property EntryImageIDInList() As String
        Get
            Return LabelEntryImageIDInList.Text
        End Get
        Set(ByVal value As String)
            LabelEntryImageIDInList.Text = value
        End Set
    End Property

    Public Property EntryImageFileNameInList() As String
        Get
            Return LabelEntryImageFileNameInList.Text
        End Get
        Set(ByVal value As String)
            LabelEntryImageFileNameInList.Text = value
        End Set
    End Property



    Public Property CriteriaID() As String
        Get
            Return LabelCriteriaID.Text
        End Get
        Set(ByVal value As String)
            LabelCriteriaID.Text = value
        End Set
    End Property

    Public Property CriteriaHeading() As String
        Get
            Return HyperLinkCriteriaHeading.Text
        End Get
        Set(ByVal value As String)
            HyperLinkCriteriaHeading.Text = value
        End Set
    End Property

    Public Property Vote() As Integer
        Get
            Return RatingMyrating.CurrentRating
        End Get
        Set(ByVal value As Integer)
            RatingMyrating.CurrentRating = value
        End Set
    End Property

    Public Property VoteMessage() As String
        Get
            Return LabelVoteMessage.Text
        End Get
        Set(ByVal value As String)
            LabelVoteMessage.Text = value
        End Set
    End Property

    Public Property VoteDate() As String
        Get
            Return LabelDatetime.Text
        End Get
        Set(ByVal value As String)
            LabelDatetime.Text = value
        End Set
    End Property

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkEntryHeading.NavigateUrl = "~/Review/" & FirstClickerService.common.ConvertSpace2Dass(EntryHeading) & "/" & EntryID

        HyperLinkUsername.Text = UserName
        HyperLinkUsername.NavigateUrl = "~/user/" & RoutUserName

        If Trim(EntryDescriptionInList) = "" Then
            LabelEntryDescriptionInList.Visible = False
            LabelEntryDescription.Visible = True
        End If


        ImageEntryPic.ImageUrl = "~/storage/image/" & EntryImageFileName


        If Val(Session("userID")) = UserID Then
            LIActionDelete.Visible = True
            LIActionEdit.Visible = True
        End If


    End Sub




</script>

<asp:Label ID="LabelUserID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>


<asp:Label ID="LabelListID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelEntryID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelCriteriaID" runat="server" Text="" Visible="False"></asp:Label>


<asp:Label ID="LabelEntryImageID" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelEntryImageFileName" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelEntryImageIDInList" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelEntryImageFileNameInList" runat="server" Text="" Visible="False"></asp:Label>

<asp:Panel runat="server" ID="PanelEntryView" CssClass="card" Style="margin: 0px;">
    <div class="card-body">
        <div class="media">
            <div class="media-left">
                <asp:Image runat="server" ID="ImageEntryPic" CssClass=" " Width="60" Height="80" ImageUrl="~/Content/Images/reviewClicker.png" />
            </div>
            <div class="media-body" style="overflow :visible; ">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="dropdown float-right">
                            <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                            <ul class="dropdown-menu">
                                <li runat="server" id="LIActionEdit" visible="false">
                                    <asp:LinkButton ID="LinkButtonEditEntry" runat="server"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; <small>Edit</small></asp:LinkButton></li>
                                <li runat="server" id="LIActionDelete" visible="false">
                                    <asp:LinkButton ID="LinkButtonDelete" runat="server"><i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp; <small>Delete</small></asp:LinkButton></li>
                                <li runat="server" id="LIActionReport"><a href="#"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp; <small>Report</small></a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 >
                            <asp:HyperLink ID="HyperLinkUsername" runat="server" >User Name</asp:HyperLink> reviewed <asp:HyperLink ID="HyperLinkEntryHeading" runat="server">Entry Heading</asp:HyperLink>
                            </h4>
                            <ul class="list-inline small">
                                <li>Voted On Criteria&nbsp;<asp:HyperLink ID="HyperLinkCriteriaHeading" runat="server"></asp:HyperLink></li>
                                <li><i class="fa fa-calendar"></i>&nbsp;Voted on&nbsp;<asp:Label ID="LabelDatetime" runat="server" Text=""></asp:Label></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <hr style="margin: 1px;" />
                <div class="row">
                    <div class="col-lg-12">
                        <p>
                            <ajaxToolkit:Rating ID="RatingMyrating" runat="server" MaxRating="10"
                                CssClass="form-control" Style="border: 0; box-shadow: none;"
                                CurrentRating="0"
                                StarCssClass="ratingStar"
                                WaitingStarCssClass="savedRatingStar"
                                FilledStarCssClass="filledRatingStar"
                                EmptyStarCssClass="emptyRatingStar" AutoPostBack="True" ReadOnly="True">
                            </ajaxToolkit:Rating>
                        </p>
                        <p>
                            <asp:Label ID="LabelVoteMessage" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                </div>


                <div class="row" hidden="hidden">
                    <div class="col-lg-12">
                        <p>
                            <asp:Label ID="LabelEntryDescription" runat="server" Text=""></asp:Label>
                            <asp:Label ID="LabelEntryDescriptionInList" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Panel>




