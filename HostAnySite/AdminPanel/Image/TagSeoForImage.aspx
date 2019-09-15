<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideAdminPanel.ascx" TagPrefix="uc1" TagName="NavigationSideAdminPanel" %>

<script runat="server">
    ' version 22/08/2018 # 4.27 AM
    ' AdminValidation Is done by NavAdminMenu control

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If IsPostBack = False Then
            TextBoxtagID.Text = Val(Trim(Request.QueryString("TagId")))
            ButtonLoadId_Click(sender, e)
        End If
    End Sub

    Protected Sub ButtonLoadId_Click(sender As Object, e As EventArgs)
        Dim tagdetails As FirstClickerService.Version1.Tag.StructureTag
        tagdetails = FirstClickerService.Version1.Tag.GetDetails_BYTagID(TextBoxtagID.Text, WebAppSettings.DBCS)
        If tagdetails.Result = True Then
            LabelTagID.Text = tagdetails.TagId
            HyperLinkTagName.Text = tagdetails.TagName
            HyperLinkTagName.NavigateUrl = "~/image/" & FirstClickerService.Common.ConvertSpace2Dass(tagdetails.TagName)

            Dim TagSEO As FirstClickerService.Version1.TagSEO.TagSEOStructure = FirstClickerService.Version1.TagSEO.GetSeo_BYTagID(tagdetails.TagId, FirstClickerService.Version1.TagSEO.TagSEOForEnum.Image, WebAppSettings.DBCS)
            If TagSEO.Result = False Then
                FirstClickerService.Version1.TagSEO.CreateBlankSeo(tagdetails.TagId, FirstClickerService.Version1.TagSEO.TagSEOForEnum.Image, WebAppSettings.DBCS)
            End If
        End If

        ListViewSeoForImage.DataBind()
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="LabelTagID" runat="server" Text="0" Visible="false"></asp:Label>

    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideAdminPanel runat="server" ID="NavigationSideAdminPanel" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card mt-2 BoxEffect6 ">
                <div class="card-header ">
                    Tag Seo For Image - <asp:HyperLink ID="HyperLinkTagName" runat="server"></asp:HyperLink>
                </div>
                <div class="card-body ">
                    <div class="form-group ">
                        <div class="input-group ">
                            <div class="input-group-prepend ">
                                <span class="input-group-text ">TagId</span>
                                <asp:TextBox ID="TextBoxtagID" CssClass="form-control " runat="server"></asp:TextBox>
                                <div class="input-group-append ">
                                    <asp:Button ID="ButtonLoadId" CssClass="btn btn-info " runat="server" Text="Load" OnClick="ButtonLoadId_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group ">
                        <asp:Label ID="LabelEm" CssClass="text-success" runat="server" Text=""></asp:Label>
                    </div>
                </div> 
                <div class="card-body ">
                    <asp:ListView ID="ListViewSeoForImage" runat="server" DataSourceID="SqlDataSourceSeoForImage" DataKeyNames="TagID">
                        <EditItemTemplate>
                            <div class="card">
                                <div class="card-body ">
                                    <div class="form-group">
                                        <asp:Button runat="server" CommandName="Update" CssClass="btn btn-sm btn-success " Text="Update" ID="UpdateButton" /><asp:Button runat="server" CommandName="Cancel" CssClass="btn btn-sm" Text="Cancel" ID="CancelButton" />
                                    </div>
                                    <div class="form-group ">
                                        <label>TagID:</label>
                                        <asp:Label Text='<%# Eval("TagID") %>' runat="server" ID="TagIDLabel1" CssClass="form-control " />

                                    </div>
                                    <div class="form-group ">
                                        <label>Title:</label>
                                        <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBox" CssClass="form-control " />

                                    </div>
                                    <div class="form-group ">
                                        <label>Keyword:</label>
                                        <asp:TextBox Text='<%# Bind("Keyword") %>' runat="server" ID="KeywordTextBox" CssClass="form-control " />

                                    </div>
                                    <div class="form-group ">
                                        <label>Description:</label>
                                        <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" CssClass="form-control " />

                                    </div>
                                    <div class="form-group ">
                                        <label>Content:</label>
                                        <asp:TextBox Text='<%# Bind("Content") %>' runat="server" ID="ContentTextBox" CssClass="form-control " />

                                    </div>

                                    <div class="form-group ">
                                        <label>SeoImpression:</label>
                                        <asp:TextBox Text='<%# Bind("SeoImpression") %>' runat="server" ID="SeoImpressionTextBox" CssClass="form-control " />

                                    </div>
                                    <div class="form-group ">
                                        <label>RootRank:</label>
                                        <asp:TextBox Text='<%# Bind("RootRank") %>' runat="server" ID="RootRankTextBox" CssClass="form-control " />

                                    </div>


                                </div>

                            </div>
                         











                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <span>No tag data found.</span>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <div class="card">
                                <div class="card-body ">
                                <div class="form-group  ">
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn-sm  btn-dark float-right" Text="Edit" ID="EditButton" />
                                </div>

                                <div class="form-group ">
                                    <label>TagID:</label>

                                    <asp:Label Text='<%# Eval("TagID") %>' runat="server" ID="TagIDLabel" CssClass="form-control " />
                                </div>
                                <div class="form-group ">
                                    <label>Title:</label>

                                    <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" CssClass="form-control " />
                                </div>
                                <div class="form-group ">
                                    <label>Keyword:</label>

                                    <asp:Label Text='<%# Eval("Keyword") %>' runat="server" ID="KeywordLabel" CssClass="form-control " />
                                </div>
                                <div class="form-group ">
                                    <label>Description:</label>

                                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" CssClass="form-control " />
                                </div>
                                <div class="form-group ">
                                    <label>Content:</label>

                                    <asp:Label Text='<%# Eval("Content") %>' runat="server" ID="ContentLabel" CssClass="form-control " />
                                </div>
                                <div class="form-group ">
                                    <label>SeoImpression:</label>

                                    <asp:Label Text='<%# Eval("SeoImpression") %>' runat="server" ID="SeoImpressionLabel" CssClass="form-control " />
                                </div>
                                <div class="form-group ">
                                    <label>RootRank:</label>

                                    <asp:Label Text='<%# Eval("RootRank") %>' runat="server" ID="RootRankLabel" CssClass="form-control " />
                                </div>

                                </div>
                            </div>

                        </ItemTemplate>
                        <LayoutTemplate>
                            <div runat="server" id="itemPlaceholderContainer" style="">
                                <div runat="server" id="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <span style="">TagID:
                                <asp:Label Text='<%# Eval("TagID") %>' runat="server" ID="TagIDLabel" /><br />
                                Title:
                                <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /><br />
                                Keyword:
                                <asp:Label Text='<%# Eval("Keyword") %>' runat="server" ID="KeywordLabel" /><br />
                                Description:
                                <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                                Content:
                                <asp:Label Text='<%# Eval("Content") %>' runat="server" ID="ContentLabel" /><br />
                                SeoImpression:
                                <asp:Label Text='<%# Eval("SeoImpression") %>' runat="server" ID="SeoImpressionLabel" /><br />
                                RootRank:
                                <asp:Label Text='<%# Eval("RootRank") %>' runat="server" ID="RootRankLabel" /><br />
                                <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                <br />
                                <br />
                            </span>
                        </SelectedItemTemplate>
                    </asp:ListView>
                    <asp:SqlDataSource runat="server" ID="SqlDataSourceSeoForImage" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>' DeleteCommand="DELETE FROM [Table_TagSeoForImage] WHERE [TagID] = @TagID" InsertCommand="INSERT INTO [Table_TagSeoForImage] ([TagID], [Title], [Keyword], [Description], [Content], [SeoImpression], [RootRank]) VALUES (@TagID, @Title, @Keyword, @Description, @Content, @SeoImpression, @RootRank)" SelectCommand="SELECT * FROM [Table_TagSeoForImage] WHERE ([TagID] = @TagID)" UpdateCommand="UPDATE [Table_TagSeoForImage] SET [Title] = @Title, [Keyword] = @Keyword, [Description] = @Description, [Content] = @Content, [SeoImpression] = @SeoImpression, [RootRank] = @RootRank WHERE [TagID] = @TagID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="LabelTagID" PropertyName="Text" Name="TagID" Type="Decimal"></asp:ControlParameter>
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Title" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Keyword" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                            <asp:Parameter Name="Content" Type="String"></asp:Parameter>
                            <asp:Parameter Name="SeoImpression" Type="Decimal"></asp:Parameter>
                            <asp:Parameter Name="RootRank" Type="Decimal"></asp:Parameter>
                            <asp:Parameter Name="TagID" Type="Decimal"></asp:Parameter>
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

