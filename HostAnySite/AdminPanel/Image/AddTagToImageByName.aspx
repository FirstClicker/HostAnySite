<%@ Page Title="" Language="VB" MasterPageFile="~/default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>
<%@ Register Src="~/App_Controls/ImageThumb.ascx" TagPrefix="uc1" TagName="ImageThumb" %>
<%@ Register Src="~/App_Controls/TagHolderMax5.ascx" TagPrefix="uc1" TagName="TagHolderMax5" %>




<script runat="server">
    ' version 22/08/2018 # 4.27 AM
    ' AdminValidation Is done by NavAdminMenu control

    Protected Sub ButtonSearch_Click(sender As Object, e As EventArgs)
        DataPagerTopGallery.PageSize = Val(DropDownListPageSize.SelectedValue)


        LabelSearchTag.Text = TextBoxSuggestionTag.Text

        Dim temptext As String = LabelSearchTag.Text.ToLower.Replace(" and ", "+")
        Dim andtags As String() = temptext.Split("+")
        Dim mmm As Integer = 0
        Dim wherestring As String = " where "
        For mmm = 0 To andtags.Length - 1
            wherestring = wherestring & "(' '+Ti.ImageName+' ' LIKE '%[^A-Za-z]" & Trim(andtags(mmm)) & "[^A-Za-z]%' or ' '+Ti.ImageFileName+' ' LIKE '%[^A-Za-z]" & Trim(andtags(mmm)) & "[^A-Za-z]%') "
            If mmm < andtags.Length - 1 Then
                wherestring = wherestring & " and "
            End If
        Next


        Dim excepttagids As String() = TagHolderMax5.TagIds.Split(",")
        Dim exceptstring As String = ""
        If excepttagids.Length > 0 Then
            For nnn As Integer = 0 To excepttagids.Length - 1
                If Trim(exceptstring) = "" Then
                    exceptstring = "and ((ttoi.tagid = '" & excepttagids(nnn) & "') "
                Else
                    exceptstring = exceptstring & "or (ttoi.tagid = '" & excepttagids(nnn) & "') "
                End If
            Next
            exceptstring = exceptstring & ")"
        End If


        SqlDataSourceTopGallery.SelectCommand = "SELECT TI.imageid, TI.imageFileName, ti.imagename, ti.PostDate FROM Table_Image TI " & wherestring
        SqlDataSourceTopGallery.SelectCommand = SqlDataSourceTopGallery.SelectCommand & " group by ti.imageid, TI.imageFileName, ti.imagename, ti.PostDate "



        SqlDataSourceTopGallery.SelectCommand = SqlDataSourceTopGallery.SelectCommand & "EXCEPT SELECT TI.imageid, TI.imageFileName, ti.imagename, ti.PostDate FROM Table_Image TI right join Table_tagOfimage ttoi on ttoi.ImageId=ti.Imageid " & exceptstring
        SqlDataSourceTopGallery.SelectCommand = SqlDataSourceTopGallery.SelectCommand & " group by ti.imageid, TI.imageFileName, ti.imagename, ti.PostDate "

    End Sub




    Protected Sub SqlDataSourceTopGallery_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        LabelwallpaperCount.Text = e.AffectedRows
    End Sub

    Protected Sub ListViewTopGallery_ItemDataBound(sender As Object, e As ListViewItemEventArgs)
        If CheckBoxUpdateSuggestion.Checked = True Then
            If e.Item.ItemType = ListViewItemType.DataItem Then
                Dim dataItem As ListViewDataItem = DirectCast(e.Item, ListViewDataItem)
                Dim lvrow As Data.DataRowView = DirectCast(dataItem.DataItem, Data.DataRowView)
                If lvrow("ImageId") IsNot System.DBNull.Value Then
                    'add image tag
                    Dim excepttagids As String() = TagHolderMax5.TagIds.Split(",")
                    For nnn As Integer = 0 To excepttagids.Length - 1
                        Dim TagSubmit As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.GetDetails_BYTagID(Val(excepttagids(nnn)), WebAppSettings.DBCS)
                        If TagSubmit.Result = True Then
                            Dim ListTagsubmit As FirstClickerService.Version1.TagOfimage.StructureTagOfimage = FirstClickerService.Version1.TagOfimage.AddTagOfimage(TagSubmit.TagId, Val(lvrow("ImageId")), Val(Session("UserId")), WebAppSettings.DBCS)
                        Else
                            'report
                        End If
                    Next
                End If
            End If
        End If
    End Sub




</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">

            <div class="card">
                <div class="card-header ">
                    <div class="card-title ">
                        Add Tag By Searching ImageName
                    </div>
                </div>
                <div class="card-body" >
                     <div class="form-group ">
                         <uc1:TagHolderMax5 runat="server" ID="TagHolderMax5" />
                     </div> 

                    <div class="form-group ">
                        <label>
                            SearchTag
                        </label>
                        <asp:TextBox ID="TextBoxSuggestionTag" CssClass="form-control " runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group ">

                            <asp:CheckBox ID="CheckBoxUpdateSuggestion" runat="server" CssClass="btn" Text="Save Tag " />
                            <asp:Button ID="ButtonSearch" CssClass="btn btn-sm" runat="server" Text="Search" OnClick="ButtonSearch_Click" />

                    </div>


                 
                </div>
            </div>
            <div class="card">
                <div class="card-header clearfix">
                    <h5 class="card-title text-capitalize">
                            <asp:Label ID="LabelSearchTag" runat="server" Text=""></asp:Label>:
                            <asp:Label ID="LabelwallpaperCount" runat="server" Text="0"></asp:Label>
                    </h5>
                    <div class="float-right ">
                        <asp:DropDownList ID="DropDownListPageSize" runat="server">
                            <asp:ListItem Selected="True">15</asp:ListItem>
                            <asp:ListItem>30</asp:ListItem>
                            <asp:ListItem>60</asp:ListItem>
                            <asp:ListItem>120</asp:ListItem>
                            <asp:ListItem>240</asp:ListItem>
                            <asp:ListItem>480</asp:ListItem>
                        </asp:DropDownList>
                    </div>
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

        </div>
    </div>
</asp:Content>

