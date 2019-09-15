<%@ Control Language="VB" ClassName="AdminAutoImageTag" %>
<%@ Register Src="~/App_Controls/ImageThumb.ascx" TagPrefix="uc1" TagName="ImageThumb" %>

<script runat="server">
    ' version 26/08/2018 # 4.27 AM

    Public Property TagName() As String
        Get
            Return LabelTagName.Text
        End Get
        Set(ByVal value As String)
            Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.GetDetails_BYTagName(value, WebAppSettings.DBCS)
            If tagdetails.Result = True Then
                LabelTagName.Text = value
                LabelTagId.Text = tagdetails.TagId
            End If
            LabelTagId.Enabled = tagdetails.Result
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If LabelTagId.Enabled = False Then            'not found 
            Me.Visible = False
            Exit Sub
        End If

        LabelSearchTag.Text = TagName
        Dim wherestring As String = " where (' '+Ti.ImageName+' ' LIKE '%[^A-Za-z]" & LabelSearchTag.Text & "[^A-Za-z]%' or ' '+Ti.ImageFileName+' ' LIKE '%[^A-Za-z]" & LabelSearchTag.Text & "[^A-Za-z]%') "
        Dim exceptstring As String = "and (ttoi.tagid = '" & LabelTagId.Text & "')"

        SqlDataSourceTopGallery.SelectCommand = "SELECT TI.imageid, TI.imageFileName, ti.imagename, ti.PostDate FROM Table_Image TI " & wherestring
        SqlDataSourceTopGallery.SelectCommand = SqlDataSourceTopGallery.SelectCommand & " group by ti.imageid, TI.imageFileName, ti.imagename, ti.PostDate "

        SqlDataSourceTopGallery.SelectCommand = SqlDataSourceTopGallery.SelectCommand & "EXCEPT SELECT TI.imageid, TI.imageFileName, ti.imagename, ti.PostDate FROM Table_Image TI right join Table_tagOfimage ttoi on ttoi.ImageId=ti.Imageid " & exceptstring
        SqlDataSourceTopGallery.SelectCommand = SqlDataSourceTopGallery.SelectCommand & " group by ti.imageid, TI.imageFileName, ti.imagename, ti.PostDate "

    End Sub


    Protected Sub SqlDataSourceTopGallery_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        LabelwallpaperCount.Text = e.AffectedRows
        If e.AffectedRows <= 0 Then Me.Visible = False
    End Sub

    Protected Sub ListViewTopGallery_ItemDataBound(sender As Object, e As ListViewItemEventArgs)

        If e.Item.ItemType = ListViewItemType.DataItem Then
            Dim dataItem As ListViewDataItem = DirectCast(e.Item, ListViewDataItem)
            Dim lvrow As Data.DataRowView = DirectCast(dataItem.DataItem, Data.DataRowView)
            If lvrow("ImageId") IsNot System.DBNull.Value Then
                'add image tag
                Dim ListTagsubmit As FirstClickerService.Version1.TagOfimage.StructureTagOfimage = FirstClickerService.Version1.TagOfimage.AddTagOfimage(LabelTagId.Text, Val(lvrow("ImageId")), Val(Session("UserId")), WebAppSettings.DBCS)
            End If
        End If

    End Sub


</script>

<asp:Label ID="LabelTagId" runat="server" Text="0" Visible="false"></asp:Label>
<asp:Label ID="LabelTagName" runat="server" Text="" Visible="false"></asp:Label>
<div class="card">
    <div class="card-header clearfix">
        <h5 class="card-title text-capitalize">Add Tag By Searching ImageName - (<asp:Label ID="LabelSearchTag" runat="server" Text=""></asp:Label>):
                            <asp:Label ID="LabelwallpaperCount" runat="server" Text="0"></asp:Label>
        </h5>
    </div>
    <div class="card-body">
        <asp:ListView ID="ListViewTopGallery" runat="server" DataKeyNames="ImageId" DataSourceID="SqlDataSourceTopGallery" OnItemDataBound="ListViewTopGallery_ItemDataBound">
            <EmptyDataTemplate>
                <div class="col-12 p-2 ">
                    No wallpaper found with your search.
                </div>
            </EmptyDataTemplate>
            <ItemTemplate>
                <div class="col-lg-4 col-md-4 col-6 p-2">
                    <uc1:ImageThumb runat="server" ID="ImageThumb" ImageId='<%# Eval("ImageId") %>' ImageName='<%# Eval("ImageName") %>' ImageFileName='<%# Eval("ImageFileName") %>' PostDate="date time" UserId="11111111" UserName="User Name" RoutUserName="RoutUserName" />
                </div>
            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server" class="row">
                    <div runat="server" id="itemPlaceholder" />
                </div>
            </LayoutTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSourceTopGallery" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>" OnSelected="SqlDataSourceTopGallery_Selected"></asp:SqlDataSource>
    </div>
    <div class="card-footer clearfix">
        <div class="float-right">
            <asp:DataPager ID="DataPagerTopGallery" runat="server" PageSize="15" PagedControlID="ListViewTopGallery" QueryStringField="Page">
                <Fields>
                    <asp:NextPreviousPagerField FirstPageText="First" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" ButtonCssClass="btn btn-sm btn-info" />
                    <asp:NumericPagerField PreviousPageText="<<" NextPageText=">>" ButtonCount="5" NumericButtonCssClass="btn btn-sm btn-info" CurrentPageLabelCssClass="btn btn-sm btn-primary" NextPreviousButtonCssClass="btn btn-sm btn-primary" />
                    <asp:NextPreviousPagerField LastPageText="Last" ShowNextPageButton="False" ShowPreviousPageButton="False" ShowFirstPageButton="False" ShowLastPageButton="True" ButtonCssClass="btn btn-sm btn-info" />
                </Fields>
            </asp:DataPager>
        </div>
    </div>
</div>
