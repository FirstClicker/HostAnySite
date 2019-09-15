<%@ Control Language="VB" ClassName="TagOfImage" %>
<%@ Register Src="~/App_Controls/TagOfImageItem.ascx" TagPrefix="uc1" TagName="TagOfImageItem" %>


<script runat="server">
    ' version 25/08/2018 # 4.27 AM


    Public Property ImageId() As Long
        Get
            Return LabelIMAGEID.Text
        End Get
        Set(ByVal value As Long)
            LabelIMAGEID.Text = value
        End Set
    End Property

    Public Property ImageUserId() As Long
        Get
            Return LabelImageUserID.Text
        End Get
        Set(ByVal value As Long)
            LabelImageUserID.Text = value
        End Set
    End Property

    Protected Sub Page_PreRender(sender As Object, e As EventArgs)
        If Val(Trim(Session("UserId"))) = ImageUserId And Val(Trim(Session("UserId"))) > 100 Then
            DivAddTag.Visible = True
        End If

        Dim Cusertype As New FirstClickerService.Version1.User.UserType
        Try
            Cusertype = [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Trim(Session("UserType")), True)
            If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
                DivAddTag.Visible = True
            End If
        Catch ex As Exception

        End Try
    End Sub


    Protected Sub Buttonaddtag_Click(sender As Object, e As EventArgs)
        Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.CheckandAddTag(TextBoxTag.Text, WebAppSettings.dbcs)
        If tagdetails.Result = True Then
            Dim addimagetag As FirstClickerService.Version1.TagOfimage.StructureTagOfimage = FirstClickerService.Version1.TagOfimage.AddTagOfimage(tagdetails.TagId, ImageId, Session("UserId"), WebAppSettings.DBCS)
            If addimagetag.Result = True Then
                TextBoxTag.Text = ""
                ListViewTags.DataBind()
            Else
                'report error
            End If
        End If
    End Sub

</script>
<asp:Label ID="LabelIMAGEID" runat="server" Text="0" Visible="False"></asp:Label>
<asp:Label ID="LabelImageUserID" runat="server" Text="0" Visible="False"></asp:Label>

<div class="card mb-2 mt-1 border-0">
    <div class="card-body p-1 clearfix">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <i class="fa fa-tags"></i>&nbsp;Tags:&nbsp;&nbsp;
                <asp:ListView ID="ListViewTags" runat="server" DataSourceID="SqlDataSourceTags">
                    <EmptyDataTemplate>
                        <span>Tag Not found.</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <uc1:TagOfImageItem runat="server" ID="TagOfImageItem" Tagid='<%# Eval("Tagid") %>' TagName='<%# Eval("TagName") %>' ImageId='<%# Eval("ImageID") %>' ImageUserId='<%# ImageUserId %>' />
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholderContainer" class="btn-toolbar btn-sm d-inline">
                            <div runat="server" id="itemPlaceholder" />
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="SqlDataSourceTags" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
                    SelectCommand="SELECT TTOI.tagID, tt.tagName, TTOI.imageid  FROM [Table_TagOfImage] TTOI
                    left join Table_Tag tt on tt.tagid=TTOI.tagid
                    WHERE ([ImageID] = @ImageID) and TTOI.status='Active'">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="LabelIMAGEID" PropertyName="Text" Name="ImageID" Type="Decimal"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>
                <div runat="server" id="DivAddTag" class="d-inline ml-3" visible="false">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-plus-square"></i></a>
                    <div class="dropdown-menu dropdown-menu-right text-white bg-secondary">
                        <div class="p-2">
                            <div class="form-group m-1">
                                <div class="input-group input-group-sm mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Tag</span>
                                    </div>
                                    <asp:TextBox ID="TextBoxTag" CssClass="form-control" runat="server"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:Button ID="Buttonaddtag" CssClass="btn btn-sm float-right" runat="server" Text="ADD" OnClick="Buttonaddtag_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</div>
