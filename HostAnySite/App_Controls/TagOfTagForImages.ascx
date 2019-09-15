<%@ Control Language="VB" ClassName="TagOfTagForImages" %>

<script runat="server">
    ' version 15/08/2018 # 10.27 PM


    Public Property ParentTagId() As Long
        Get
            Return LabelParentTagId.Text
        End Get
        Set(ByVal value As Long)
            LabelParentTagId.Text = value
        End Set
    End Property

    Protected Sub Buttonaddtag_Click(sender As Object, e As EventArgs)
        Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag = FirstClickerService.Version1.Tag.CheckandAddTag(TextBoxTag.Text, WebAppSettings.DBCS)
        If tagdetails.Result = True Then
            Dim adtag As FirstClickerService.Version1.TagOfTag.StructureTagOfTag = FirstClickerService.Version1.TagOfTag.AddTagOfTag(tagdetails.TagId, ParentTagId, WebAppSettings.DBCS)
            If adtag.Result = True Then
                ListViewTagList.DataBind()
            End If
        End If
    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim Cusertype As New FirstClickerService.Version1.User.UserType
        Try
            Cusertype = [Enum].Parse(GetType(FirstClickerService.Version1.User.UserType), Trim(Session("UserType")), True)
            If Cusertype = FirstClickerService.Version1.User.UserType.Administrator Or Cusertype = FirstClickerService.Version1.User.UserType.Moderator Then
                PanelAdminWork.Visible = True
            End If
        Catch ex As Exception

        End Try


    End Sub
</script>

<asp:Label ID="LabelParentTagId" runat="server" Text="0" Visible="False"></asp:Label>

<div class="card mt-2 BoxEffect6 ">
    <div class="card-header">
        Related Image Tags
    </div>
    <asp:ListView ID="ListViewTagList" runat="server" DataSourceID="SqlDataSourceTag" >
        <EmptyDataTemplate>
            <div class="list-group-item ">Tag Not found.</div>
        </EmptyDataTemplate>
        <ItemTemplate>
            <div class="list-group-item d-flex justify-content-between align-items-center">
                <asp:HyperLink ID="HyperLink2" runat="server" CssClass ="text-capitalize" NavigateUrl='<%# "~/image/" & Eval("Tagname").ToString.Replace(" ", "-") %>' Text='<%# Eval("Tagname") %>'></asp:HyperLink>
             <span class="badge badge-primary badge-pill">
                 <asp:Label ID="Label1" runat="server" Text='<%# Eval("ImageCount") %>'></asp:Label></span>
                </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" id="itemPlaceholderContainer" class="list-group ">
                <div runat="server" id="itemPlaceholder" />
            </div>
            <div class="card-footer">
                <asp:DataPager runat="server" ID="DataPager2" QueryStringField="NavPage" PageSize="20">
                    <Fields>
                        <asp:NumericPagerField></asp:NumericPagerField>
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="SqlDataSourceTag" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
        SelectCommand="SELECT TTOI.TagID, tt.tagname, TT.importance, count(TTOI.imageid) as ImageCount FROM Table_TagOFTag TTT 
        INNER join table_tag tt on tt.tagid=TTT.tagid 
        INNER join table_tagofimage TTOI on tt.tagid=TTOI.tagid 
        where (TTt.ParentTagID=@ParentTagID) and (tt.status='Active')
        group by TTOI.TagID, TT.tagname, TT.importance 
        order by TT.Importance desc, ImageCount desc">
        <SelectParameters >
              <asp:ControlParameter ControlID="LabelParentTagId" PropertyName="Text" Name="ParentTagId" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:Panel runat="server" ID="PanelAdminWork" CssClass="card-body" Visible="false">
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
    </asp:Panel>

</div>


