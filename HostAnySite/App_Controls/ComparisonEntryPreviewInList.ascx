<%@ Control Language="VB" ClassName="ComparisonEntryPreviewInList" %>
<%@ Import Namespace ="System.Data.SqlClient" %>

<%@ Register Src="~/app_controls/ImageUploader.ascx" TagPrefix="uc1" TagName="ImageUploader" %>
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
            Return HyperLinkUsername.Text
        End Get
        Set(ByVal value As String)
            HyperLinkUsername.Text = value
        End Set
    End Property

    Public Property RoutUserName() As String
        Get
            Return LabelRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelRoutUserName.Text = value
            HyperLinkUsername.NavigateUrl = "~/user/" & value
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

    Public Property ListRoutUserName() As String
        Get
            Return LabelListRoutUserName.Text
        End Get
        Set(ByVal value As String)
            LabelListRoutUserName.Text = value
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

    Public Property EntryImageIDInList() As Long
        Get
            Return LabelEntryImageIDInList.Text
        End Get
        Set(ByVal value As Long)
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

    Public Property EntryCreatedDate() As String
        Get
            Return LabelDatetime.Text
        End Get
        Set(ByVal value As String)
            LabelDatetime.Text = value
        End Set
    End Property



    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        HyperLinkEntryHeading.NavigateUrl = "~/review/" & FirstClickerService.Common.ConvertSpace2Dass(EntryHeading) & "/" & EntryID & "/"

        If Trim(EntryDescriptionInList) = "" Then
            LabelEntryDescriptionInList.Visible = False
            LabelEntryDescription.Visible = True
        End If

        If EntryImageIDInList = WebAppSettings.DefaultImgID_ComparisonEntry Then
            ImageEntryPic.ImageUrl = "~/storage/image/" & EntryImageFileName
        Else
            ImageEntryPic.ImageUrl = "~/storage/image/" & EntryImageFileNameInList
        End If

        If Trim(Session("RoutUsername")).ToLower = RoutUserName.ToLower Then
            LIActionDelete.Visible = True
            LIActionEditEntry.Visible = True
        End If
        If Trim(Session("RoutUsername")).ToLower = ListRoutUserName.ToLower Then
            LIActionDelete.Visible = True
            LIActionEditEntry.Visible = True
        End If

        Dim myConn As SqlConnection
        Dim myCmd As SqlCommand
        Dim myReader As SqlDataReader

        myConn = New SqlConnection(WebAppSettings.DBCS)
        myCmd = myConn.CreateCommand
        myConn.Open()

        myCmd.CommandText = "SELECT AVG(vote) as vote, Count(vote) as VoteCount  FROM Table_ComparisionEntryRating where (EntryID='" & EntryID & "') group by EntryID"
        myReader = myCmd.ExecuteReader
        If myReader.HasRows = True Then
            myReader.Read()
            RatingEntryOverall.CurrentRating = myReader.Item("vote")
            LabelOverallVotecount.Text = myReader.Item("VoteCount")
        Else
            RatingEntryOverall.CurrentRating = 0
            LabelOverallVotecount.Text = 0
        End If
        myReader.Close()


        myCmd.CommandText = "SELECT AVG(vote) as vote FROM Table_ComparisionEntryRating where (EntryID='" & EntryID & "') and (userid='" & Val(Session("UserId")) & "') group by EntryID"
        myReader = myCmd.ExecuteReader
        If myReader.HasRows = True Then
            myReader.Read()
            RatingMyrating.CurrentRating = myReader.Item("vote")
        Else
            RatingMyrating.CurrentRating = 0
        End If
        myReader.Close()

        myConn.Close()


    End Sub



    Protected Sub LinkButtonEditEntry_Click(sender As Object, e As EventArgs)
        TextBoxEditHeading.Text = EntryHeading
        TextBoxEditDescription.Text = EntryDescription

        ImageUploader.ImageID = EntryImageID
        ImageUploader.LoadExistingImage()

        PanelEntryView.Visible = False
        PanelEntryEdit.Visible = True
    End Sub

    Protected Sub ButtonCancelEdit_Click(sender As Object, e As EventArgs)
        PanelEntryView.Visible = True
        PanelEntryEdit.Visible = False
    End Sub

    Protected Sub ButtonSaveEdit_Click(sender As Object, e As EventArgs)
        Dim imageid As Long = WebAppSettings.DefaultImgID_ComparisonEntry

        If ImageUploader.UploadSuccess = True Then
            imageid = ImageUploader.ImageID
        End If


        'save to list entry db
        Dim editentryOflist As FirstClickerService.Version1.ComparisonEntryOfList.StructureEntryOfComparison = FirstClickerService.Version1.ComparisonEntryOfList.UpdateEntry_ByID(EntryID, ListID, TextBoxEditDescription.Text, imageid, WebAppSettings.DBCS)
        If editentryOflist.Result = False Then
            LabelEditEM.Text = "Failed to save edit."
        Else
            EntryDescription = editentryOflist.Description
            EntryImageID = editentryOflist.ImageID
            EntryImageFileName = ImageUploader.ImageFileName


            Dim saveEntryDes As FirstClickerService.Version1.ComparisonEntry.StructureComparisonEntry = FirstClickerService.Version1.ComparisonEntry.CheckAndUpdateEntryDescription_ByID(EntryID, TextBoxEditDescription.Text, WebAppSettings.DBCS)
            If saveEntryDes.Result = False Then
                'report error
            End If

            Dim saveEntryImg As FirstClickerService.Version1.ComparisonEntry.StructureComparisonEntry = FirstClickerService.Version1.ComparisonEntry.CheckAndUpdateEntryImageID_ByID(EntryID, imageid, WebAppSettings.DefaultImgID_ComparisonEntry, WebAppSettings.DBCS)
            If saveEntryImg.Result = False Then
                'report error
            End If

        End If

        PanelEntryView.Visible = True
        PanelEntryEdit.Visible = False
    End Sub

    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)

        Dim removeEntry As FirstClickerService.Version1.ComparisonEntryOfList.StructureEntryOfComparison = FirstClickerService.Version1.ComparisonEntryOfList.RemoveEntryFromList(EntryID, ListID, WebAppSettings.DBCS)
        If removeEntry.Result = True Then
            Response.Redirect(Request.RawUrl.ToString)
        End If



    End Sub
</script>

<asp:Label ID="LabelUserID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelRoutUserName" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelListID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelListRoutUserName" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelEntryID" runat="server" Text="" Visible="False"></asp:Label>
<asp:Label ID="LabelEntryImageID" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelEntryImageFileName" runat="server" Text="" Visible="False"></asp:Label>

<asp:Label ID="LabelEntryImageIDInList" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelEntryImageFileNameInList" runat="server" Text="" Visible="False"></asp:Label>


<asp:Panel runat="server" ID="PanelEntryView" CssClass="card" Style="margin: 0px;">
    <div class="card-body">
        <div class="media">
            <div class="media-left">
                <asp:Image runat="server" ID="ImageEntryPic" CssClass=" " Width="75" Height="100" ImageUrl="~/Content/Images/reviewClicker.png" />
            </div>
            <div class="media-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="dropdown float-right">
                            <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                            <ul class="dropdown-menu">
                                <li runat="server" id="LIActionEditEntry"  visible="false">
                                    <asp:LinkButton ID="LinkButtonEditEntry" runat="server" OnClick="LinkButtonEditEntry_Click"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; <small>Edit</small></asp:LinkButton></li>
                                 <li runat="server" id="LIActionDelete" visible="false">
                                    <asp:LinkButton ID="LinkButtonDelete" runat="server" OnClick ="LinkButtonDelete_Click"><i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp; <small>Delete</small></asp:LinkButton></li>
                                <li runat="server" id="LIActionViewEntry">
                                    <asp:HyperLink ID="HyperLinkViewEntry" runat="server"><i class="fa fa-eye" aria-hidden="true"></i>&nbsp; <small>View</small></asp:HyperLink></li>
                                 <li runat="server" id="LIActionReport"><a href="#"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp; <small>Report</small></a></li>
                                
                            </ul>
                        </div>
                        <div>
                            <h4>
                                <asp:HyperLink ID="HyperLinkEntryHeading" runat="server">Entry Heading</asp:HyperLink>
                            </h4>
                            <ul class="list-inline small">
                                <li><i class="fa fa-user"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUsername" runat="server">User Name</asp:HyperLink></li>
                                <li><i class="fa fa-calendar"></i>&nbsp;Posted on&nbsp;<asp:Label ID="LabelDatetime" runat="server" Text=""></asp:Label></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <hr style="margin: 1px;" />
                <div class="row">
                    <div class="col-lg-12">
                        <p>
                            <asp:Label ID="LabelEntryDescription" runat="server" Text="" Visible="False"></asp:Label>
                             <asp:Label ID="LabelEntryDescriptionInList" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                </div>
                <hr style="margin: 3px;" />

                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="email">
                                    <a data-toggle="collapse" href="#<%=PanelOverallRating.ClientID%>"><i class="fa fa-plus-square-o" aria-hidden="true"></i>
                                    All Rating</a> <strong>(<asp:Label ID="LabelOverallVotecount" runat="server" Text="0"></asp:Label>)</strong>:</label>
                                <div class="col-sm-9">
                                    <ajaxToolkit:Rating ID="RatingEntryOverall" runat="server" MaxRating="10"
                                        CurrentRating="0"
                                        CssClass="form-control" Style="border: 0; box-shadow: none;"
                                        StarCssClass="ratingStar"
                                        WaitingStarCssClass="savedRatingStar"
                                        FilledStarCssClass="filledRatingStar"
                                        EmptyStarCssClass="emptyRatingStar" AutoPostBack="True" ReadOnly="True">
                                    </ajaxToolkit:Rating>  
                                </div>
                            </div>

                            <asp:Panel runat="server" CssClass="card card-collapse collapse" ID="PanelOverallRating">
                                <div class="card-body">
                                    <asp:ListView ID="ListViewOverallRating" runat="server" DataSourceID="SqlDataSourceOverallRating">
                                        <EmptyDataTemplate>
                                            <span>No data was returned.</span>
                                        </EmptyDataTemplate>
                                        <ItemTemplate>
                                            <uc1:CriteriaRatingvote runat="server" ID="CriteriaRatingvote" EntryID='<%# Eval("EntryID") %>' CriteriaName='<%# Eval("Heading") %>' CriteriaID='<%# Eval("CriteriaID") %>' RatingValue='<%#Eval("vote") %>' RatingIsReadOnly="true" RatingCount='<%#Eval("votecount") %>' />
                                        </ItemTemplate>
                                        <LayoutTemplate>
                                            <div runat="server" id="itemPlaceholderContainer">
                                                <div runat="server" id="itemPlaceholder" />
                                            </div>
                                        </LayoutTemplate>
                                    </asp:ListView>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSourceOverallRating" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                        SelectCommand="SELECT TCC.listId,  TCCriteria.heading, isnull(TCCriteria.CriteriaID, 0) as CriteriaID, isnull(TCER.EntryID, @EntryID) as EntryID, isnull(AVG(TCER.vote), 0) as vote, isnull(count(TCER.vote), 0) as voteCount   
                                        FROM [Table_CriteriaOfComparison] TCC
                                        left join Table_ComparisonCriteria TCCriteria on TCC.CriteriaID=TCCriteria.CriteriaID
                                        left join Table_ComparisionEntryRating TCER on TCER.CriteriaID=TCC.CriteriaID and (TCER.EntryID=@EntryID)
                                        WHERE (TCC.[ListID] = @ListID)
                                        group by TCC.listId, TCCriteria.heading, TCCriteria.CriteriaID, TCER.EntryID">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="LabelListID" PropertyName="Text" Name="ListID" Type="Decimal"></asp:ControlParameter>
                                            <asp:ControlParameter ControlID="LabelEntryID" PropertyName="Text" Name="EntryID" Type="Decimal"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </asp:Panel>

                            <div class="form-group">
                                <label class="control-label col-sm-3" for="email">
                                    <a data-toggle="collapse" href="#<%=PanelMyRating.ClientID%>"><i class="fa fa-plus-square-o" aria-hidden="true"></i>
                                    My Rating</a> :
                                </label>
                                <div class="col-sm-9">
                                    <ajaxToolkit:Rating ID="RatingMyrating" runat="server" MaxRating="10"
                                        CssClass="form-control" Style="border: 0; box-shadow: none;"
                                        CurrentRating="0"
                                        StarCssClass="ratingStar"
                                        WaitingStarCssClass="savedRatingStar"
                                        FilledStarCssClass="filledRatingStar"
                                        EmptyStarCssClass="emptyRatingStar" AutoPostBack="True" ReadOnly="True">
                                    </ajaxToolkit:Rating>
                                </div>
                            </div>
                            <asp:Panel runat="server" CssClass="card card-collapse collapse" ID="PanelMyRating">
                                <div class="card-body">
                                    <asp:ListView ID="ListViewMyrating" runat="server" DataSourceID="SqlDataSourceMyrating">
                                        <EmptyDataTemplate>
                                            <span>Please login to make rating.</span>
                                        </EmptyDataTemplate>
                                        <ItemTemplate>
                                            <uc1:CriteriaRatingvote runat="server" ID="CriteriaRatingvote" EntryID='<%# Eval("EntryID") %>' CriteriaName='<%# Eval("Heading") %>' CriteriaID='<%# Eval("CriteriaID") %>' RatingValue='<%#Eval("vote") %>' Ratingmessage='<%#Eval("message") %>' RatingCountShow=false />
                                        </ItemTemplate>
                                        <LayoutTemplate>
                                            <div runat="server" id="itemPlaceholderContainer" style="">
                                                <div runat="server" id="itemPlaceholder" />
                                            </div>
                                        </LayoutTemplate>
                                    </asp:ListView>
                                    <asp:SqlDataSource runat="server" ID="SqlDataSourceMyrating" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                                        SelectCommand="SELECT TCC.listId, TCCriteria.heading, isnull(TCCriteria.CriteriaID, 0) as CriteriaID, isnull(TCER.EntryID, @EntryID) as EntryID, TCER.message, isnull(TCER.vote, 0) as vote 
                                        FROM [Table_CriteriaOfComparison] TCC
                                        left join Table_ComparisonCriteria TCCriteria on TCC.CriteriaID=TCCriteria.CriteriaID
                                        left join Table_ComparisionEntryRating TCER on TCER.CriteriaID=tcc.CriteriaID and (TCER.EntryID=@EntryID) and (TCER.userid=@userid)
                                        WHERE (TCC.[ListID] = @ListID)
                                        group by TCC.listId, TCCriteria.heading, TCCriteria.CriteriaID, TCER.EntryID, TCER.vote, TCER.message">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="LabelListID" PropertyName="Text" Name="ListID" Type="Decimal"/>
                                            <asp:ControlParameter ControlID="LabelEntryID" PropertyName="Text" Name="EntryID" Type="Decimal"/>
                                           <asp:SessionParameter SessionField ="userid" Name ="Userid" Type ="Decimal"  /> 
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="PanelEntryEdit" CssClass="card" Style="margin: 0px;" Visible="False">
    <div class="card-header">
        <h1 class="card-title">Edit Entry</h1>
    </div>
    <div class="card-body">
        <div role="form">
            <div class="form-group">
                <label for="email">Entry Heading:</label>
                <asp:TextBox ID="TextBoxEditHeading" CssClass="form-control" runat="server" Enabled="False"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="pwd">Description:</label>
                <asp:TextBox ID="TextBoxEditDescription" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
            </div>
            <div class="form-group">
                <uc1:ImageUploader runat="server" ID="ImageUploader" />
            </div>

        </div>
    </div>
    <div class="card-footer clearfix">
        <div class="float-left">
            <asp:Label ID="LabelEditEM" runat="server" Text=""></asp:Label>
        </div>
        <div class="float-right">
            <div class="btn-group">
                <asp:Button ID="ButtonCancelEdit" CssClass="btn btn-sm btn-danger" runat="server" OnClick="ButtonCancelEdit_Click" Text="Cancel" /><asp:Button ID="ButtonSaveEdit" CssClass="btn btn-sm btn-info" runat="server" Text="Save" OnClick="ButtonSaveEdit_Click" />
            </div>
        </div>
    </div>
</asp:Panel>



