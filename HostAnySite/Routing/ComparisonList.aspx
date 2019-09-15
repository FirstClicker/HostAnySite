<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Implements Interface="RoutIDHeadingInterface" %>

<%@ Register Src="~/app_controls/ImageUploader.ascx" TagPrefix="uc1" TagName="ImageUploader" %>
<%@ Register Src="~/App_Controls/ComparisonEntryPreviewInList.ascx" TagPrefix="uc1" TagName="ComparisonEntryPreviewInList" %>




<script runat="server">
    Private m_RoutIFace_ID As String
    Public Property RoutIFace_ID() As String Implements RoutIDHeadingInterface.RoutIFace_ID
        Get
            Return m_RoutIFace_ID
        End Get
        Set(ByVal value As String)
            m_RoutIFace_ID = value
        End Set
    End Property

    Private m_RoutIFace_Heading As String
    Public Property RoutIFace_Heading() As String Implements RoutIDHeadingInterface.RoutIFace_Heading
        Get
            Return m_RoutIFace_Heading
        End Get
        Set(ByVal value As String)
            m_RoutIFace_Heading = value
        End Set
    End Property


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Trim(Session("routusername")) <> "" Then

        End If

        If IsPostBack = False Then
            Dim listdetails As FirstClickerService.Version1.ComparisonList.StructureComparisonList = FirstClickerService.Version1.ComparisonList.GetList_ByID(RoutIFace_ID, WebAppSettings.DBCS)
            If listdetails.Result = False Then
                Response.Redirect("~/List/")
            Else
                LabelListId.Text = listdetails.ListID
                HyperLinkHeading.Text = listdetails.Heading
                LabelListDescription.Text = listdetails.Description
                LabelDatetime.Text = listdetails.CreateDate.ToString("MMM ddd d HH:mm yyyy")

                TextBoxEditListHeading.Text = listdetails.Heading
                TextBoxEditListDescription.Text = listdetails.Description

                Dim userdetails As FirstClickerService.Version1.User.StructureUser = FirstClickerService.Version1.User.UserDetail_UserID(listdetails.UserID, WebAppSettings.DBCS)
                If userdetails.Result = True Then
                    HyperLinkUsername.Text = userdetails.UserName
                    HyperLinkUsername.NavigateUrl = "~/user/" & userdetails.RoutUserName
                    LabelListRoutUserName.Text = userdetails.RoutUserName

                    If Val(Session("userid")) = userdetails.UserID Then
                        LIActionEditList.Visible = True
                        LIActionDelete.Visible = True
                    End If
                End If

                LabelTagKeyword.Text = "Comparison List"
                Dim listtags As List(Of FirstClickerService.Version1.TagOfComparisonList.StructureTagOfList) = FirstClickerService.Version1.TagOfComparisonList.GetListOfTag(RoutIFace_ID, WebAppSettings.DBCS)
                For ii As Integer = 0 To listtags.Count - 1
                    LabelTags.Text = LabelTags.Text & " <a href=""" & ResolveUrl("~/tag/" & FirstClickerService.common.ConvertSpace2Dass(listtags(ii).TagDetails.TagName)) & "/""><span class=""badge badge-info"">" & listtags(ii).TagDetails.TagName & "</span></a>"
                    LabelTagKeyword.Text = LabelTagKeyword.Text & ", " & listtags(ii).TagDetails.TagName
                Next


                Dim listCriterias As List(Of FirstClickerService.Version1.ComparisonCriteriaOfList.StructureCriteriaOfComparison) = FirstClickerService.Version1.ComparisonCriteriaOfList.GetListOfCriteria(RoutIFace_ID, WebAppSettings.DBCS)
                For ii As Integer = 0 To listCriterias.Count - 1
                    LabelCriterias.Text = LabelCriterias.Text & " <a href=""" & ResolveUrl("~/Criteria/" & FirstClickerService.common.ConvertSpace2Dass(listCriterias(ii).CriteriaDetails.Heading)) & "/""><span class=""badge badge-info"">" & listCriterias(ii).CriteriaDetails.Heading & "</span></a>"
                Next


            End If
        End If

        Title = HyperLinkHeading.Text
        MetaDescription = LabelListDescription.Text
        MetaKeywords = LabelTagKeyword.Text

    End Sub


    Protected Sub LinkButtonEditList_Click(sender As Object, e As EventArgs)
        PanelListEdit.Visible = True
        PanelListView.Visible = False
    End Sub

    Protected Sub ButtonCancelListEdit_Click(sender As Object, e As EventArgs)
        PanelListEdit.Visible = False
        PanelListView.Visible = True
    End Sub

    Protected Sub ButtonSaveListEdit_Click(sender As Object, e As EventArgs)
        Dim editListDetails As FirstClickerService.Version1.ComparisonList.StructureComparisonList = FirstClickerService.Version1.ComparisonList.EditList(RoutIFace_ID, TextBoxEditListHeading.Text, TextBoxEditListDescription.Text, WebAppSettings.DBCS)
        If editListDetails.Result = True Then
            Response.Redirect("~/list/" & editListDetails.ListID & "/" & FirstClickerService.common.ConvertSpace2Dass(editListDetails.Heading))
        Else
            LabelEditListEM.Text = "Failed to save edit."
        End If
    End Sub



    Protected Sub LinkButtonDelete_Click(sender As Object, e As EventArgs)

    End Sub



    Protected Sub ButtonAddNewEntry_Click(sender As Object, e As EventArgs)
        Dim EntrySubmit As FirstClickerService.Version1.ComparisonEntry.StructureComparisonEntry = FirstClickerService.Version1.ComparisonEntry.CheckandAddEntry(TextBoxAddEntryName.Text, TextBoxAddEntryDescription.Text, ImageUploaderAddEntry.ImageID, Val(Session("UserId")), WebAppSettings.DBCS)
        If EntrySubmit.Result = True Then

            Dim MyEntryImageId As Long
            If ImageUploaderAddEntry.ImageID <> 0 Then
                MyEntryImageId = ImageUploaderAddEntry.ImageID
            Else
                MyEntryImageId = WebAppSettings.DefaultImgID_ComparisonEntry
            End If

            Dim ListEntryubmit As FirstClickerService.Version1.ComparisonEntryOfList.StructureEntryOfComparison = FirstClickerService.Version1.ComparisonEntryOfList.AddEntryOfComparisonList(EntrySubmit.EntryID, RoutIFace_ID, Val(Session("UserId")), MyEntryImageId, TextBoxAddEntryDescription.Text, WebAppSettings.DBCS)
            If ListEntryubmit.Result = True Then
                LabelAddEntryEM.Text = "New entry added."
                TextBoxAddEntryName.Text = ""
                TextBoxAddEntryDescription.Text = ""
                ImageUploaderAddEntry.ResetControl2Starting()

                Dim Tagoflist As List(Of FirstClickerService.Version1.TagOfComparisonList.StructureTagOfList) = FirstClickerService.Version1.TagOfComparisonList.GetListOfTag(RoutIFace_ID, WebAppSettings.DBCS)
                Dim i2 As Integer = 0
                For i2 = 0 To Tagoflist.Count - 1
                    Dim ListEntryTagsubmit As firstclickerservice.version1.TagOfComparisonListEntry.StructureTagOfListEntry = firstclickerservice.version1.TagOfComparisonListEntry.AddTagOfListEntry(Tagoflist(i2).TagId, ListEntryubmit.EntryID, Val(Session("UserId")), WebAppSettings.dbcs)
                Next

                ListViewComparisonListEntry.DataBind()
            Else
                LabelAddEntryEM.Text = "Failed to Add Entry."
            End If
        Else
            LabelAddEntryEM.Text = "Failed to Add Entry."
        End If

        PanelAddNewEntry.CssClass = "card card-collapse collapse show"
    End Sub

    Protected Sub ImageUploaderAddEntry_PostBackNotifier(sender As Object, e As EventArgs)
        PanelAddNewEntry.CssClass = "card card-collapse collapse show"
    End Sub






</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-2 col-md-3 col-sm-3">
        </div>

        <div class="col-lg-10 col-md-9 col-sm-9">
            <div class="card">
                <asp:Panel runat="server" ID="PanelListView" CssClass="card-body ">
                    <div class="dropdown float-right">
                        <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-cog fa-lg"></i></a>
                        <ul class="dropdown-menu">
                            <li runat="server" id="LIActionEditList" visible="false">
                                <asp:LinkButton ID="LinkButtonEditList" runat="server" OnClick="LinkButtonEditList_Click"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp; <small>Edit</small></asp:LinkButton>
                            </li>
                            <li runat="server" id="LIActionDelete" visible="false">
                                <asp:LinkButton ID="LinkButtonDelete" runat="server" OnClick="LinkButtonDelete_Click"><i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp; <small>Delete</small></asp:LinkButton>
                            </li>
                            <li runat="server" id="LIActionReport">
                                <a href="#"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp; <small>Report</small></a>
                            </li>

                        </ul>
                    </div>
                    <h2>
                        <asp:HyperLink ID="HyperLinkHeading" runat="server" Font-Underline="False"></asp:HyperLink>
                    </h2>
                    <ul class="list-inline">
                        <li>
                            <i class="fa fa-user"></i>&nbsp;By&nbsp;<asp:HyperLink ID="HyperLinkUsername" CssClass="text-info " runat="server">User Name</asp:HyperLink>
                            <asp:Label ID="LabelListRoutUserName" runat="server" Text="" Visible="False"></asp:Label>
                        </li>
                        <li><i class="fa fa-calendar"></i>&nbsp;Posted on&nbsp;<asp:Label ID="LabelDatetime" CssClass="text-info " runat="server" Text=""></asp:Label></li>
                    </ul>



                    <p>
                        <i class="fa fa-tags"></i>&nbsp;Tags:&nbsp;<asp:Label ID="LabelTags" runat="server" Text=""></asp:Label>
                        <asp:Label ID="LabelTagKeyword" runat="server" Text="" Visible="False"></asp:Label>
                    </p>

                    <p>
                        <i class="fa  fa-ticket"></i>&nbsp;Criteria:&nbsp;<asp:Label ID="LabelCriterias" runat="server" Text=""></asp:Label>
                    </p>



                    <hr />
                    <asp:Image runat="server" ID="Blogimage" CssClass="img-rounded img-fluid " />
                    <p>
                        <asp:Label ID="LabelListDescription" runat="server" Text=""></asp:Label>
                    </p>
                </asp:Panel>
                <asp:Panel runat="server" ID="PanelListEdit" CssClass="card-body" Visible="False">
                    <div class="card" style="margin: 0px;">
                        <div class="card-header">
                            <h1 class="card-title">Edit List -
                                <asp:Label ID="LabelListId" runat="server" Text=""></asp:Label></h1>
                        </div>
                        <div class="card-body">
                            <div role="form">
                                <div class="form-group">
                                    <label for="TextBoxEditListHeading">List Heading:</label>
                                    <asp:TextBox ID="TextBoxEditListHeading" CssClass="form-control" runat="server" Enabled="False"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="TextBoxEditListDescription">Description:</label>
                                    <asp:TextBox ID="TextBoxEditListDescription" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <div class="float-left">
                                <asp:Label ID="LabelEditListEM" runat="server" Text=""></asp:Label>
                            </div>
                            <div class="float-right">
                                <div class="btn-group">
                                    <asp:Button ID="ButtonCancelListEdit" CssClass="btn btn-sm btn-danger" runat="server" OnClick="ButtonCancelListEdit_Click" Text="Cancel" /><asp:Button ID="ButtonSaveListEdit" CssClass="btn btn-sm btn-info" runat="server" Text="Save" OnClick="ButtonSaveListEdit_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                </asp:Panel>
                <div class="card-footer clearfix ">
                    <label><strong>Entry :</strong></label>
                    <a data-toggle="collapse" href="#<%=PanelAddNewEntry.ClientID%>">Add New Entry</a>

                    <div class="float-right">
                        <asp:DropDownList ID="DropDownListOrderBy" runat="server" CssClass=" form-control input-sm" Enabled="false" AutoPostBack="True" Width="100">
                            <asp:ListItem>Ratings</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <asp:Panel ID="PanelAddNewEntry" runat="server" CssClass="card collapse">
                    <div class="card-body ">
                        <h3 class=" card-title ">New List Entry</h3>
                        <hr style="margin-top: 2px;" />
                        <div>
                            <div class="form-group">
                                <label for="email">Entry Name:</label>
                                <asp:TextBox ID="TextBoxAddEntryName" CssClass="form-control input-sm " runat="server"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="pwd">Description:</label>
                                <asp:TextBox ID="TextBoxAddEntryDescription" CssClass="form-control input-sm" runat="server" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <uc1:ImageUploader runat="server" ID="ImageUploaderAddEntry" />
                        </div>
                    </div>
                    <div class="card-footer clearfix">
                        <div class="float-left ">
                            <asp:Label ID="LabelAddEntryEM" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="float-right ">
                            <div class=" btn-group ">
                                <button data-toggle="collapse" data-target="#<%=PanelAddNewEntry.ClientID %>" class="btn btn-sm btn-default " type="button">Close</button>
                                <asp:Button ID="ButtonAddNewEntry" runat="server" CssClass="btn btn-sm btn-default " OnClick="ButtonAddNewEntry_Click" Text="Save" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <asp:ListView ID="ListViewComparisonListEntry" runat="server" DataSourceID="SqlDataSourceComparisonListEntry">
                    <EmptyDataTemplate>
                        <span>No data was returned.</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <uc1:ComparisonEntryPreviewInList runat="server" ID="ComparisonEntryPreviewInList" ListID='<%# Eval("ListID") %>' EntryID='<%# Eval("EntryID") %>' EntryHeading='<%# Eval("Heading") %>' EntryDescription='<%# Eval("Description") %>' EntryDescriptionInList='<%# Eval("EntryDescriptionInList") %>' UserID='<%# Eval("UserID") %>' UserName='<%# Eval("UserName") %>' RoutUserName='<%# Eval("RoutUserName") %>' EntryImageID='<%# Eval("ImageID") %>' EntryImageFileName='<%# Eval("ImageFileName") %>' EntryImageIDInList='<%# Eval("EntryImageIDInList") %>' EntryImageFileNameInList='<%# Eval("EntryImageFileNameInList") %>' EntryCreatedDate='<%# DateTime.ParseExact(Eval("CreatedDateF"), "yyyy-MM-dd HH:mm:ss", Nothing).ToString("MMM ddd d HH:mm yyyy") %>' ListRoutUserName='<%# LabelListRoutUserName .text %>' />
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholderContainer">
                            <div runat="server" id="itemPlaceholder" />
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceComparisonListEntry" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                    SelectCommand="SELECT TECL.ListID, TECL.entryID, TCE.heading, TCE.Description, CONVERT(VARCHAR(19), TCE.CreatedDate, 120) AS CreatedDateF, TECL.Description as EntryDescriptionInList, TU.UserID, Tu.UserName, TU.Routusername, TEImg.imageid, TEImg.imagefilename, TEImgInList.imageid as EntryImageIDInList, TEImgInList.imagefilename as EntryImageFileNameInList, isnull(AVG(TCER.vote), 0) as vote   
                    FROM [Table_EntryOfComparisonList] TECL
                    left join Table_ComparisonEntry TCE on TCE.EntryID=TECL.EntryID
                    Left join Table_User TU on TECL.UserID=tu.UserID
                    Left join Table_image TEImg on TCE.imageid=TEImg.imageid
                    Left join Table_image TEImgInList on TECL.imageid=TEImgInList.imageid
                    left join Table_ComparisionEntryRating TCER on TCER.EntryID=TCE.EntryID
                    WHERE (TECL.[ListID] = @ListID)
                    Group By TECL.ListID, TECL.entryID, TCE.heading, TCE.Description, TCE.CreatedDate, TECL.Description, TU.UserID, Tu.UserName, TU.Routusername, TEImg.imageid, TEImg.imagefilename, TEImgInList.imageid, TEImgInList.imagefilename
                    order by vote desc">
                    <SelectParameters>
                        <asp:RouteParameter RouteKey="ID" Name="ListID" Type="Decimal"></asp:RouteParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <div class="row">
                    <div class="col-lg-12 ">
                        <div class="float-right">
                            <asp:DataPager runat="server" ID="DataPagerComparisonListEntry" PagedControlID="ListviewComparisonListEntry">
                                <Fields>
                                    <asp:NumericPagerField></asp:NumericPagerField>
                                </Fields>
                            </asp:DataPager>
                        </div>
                        <div class="float-Left"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>

