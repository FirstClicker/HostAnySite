<%@ Page Title="" Language="VB" MasterPageFile="~/Default.master" %>

<%@ Register Src="~/App_Controls/NavigationSideDashboard.ascx" TagPrefix="uc1" TagName="NavigationSideDashboard" %>
<%@ Register Src="~/App_Controls/ValidateUserAccess.ascx" TagPrefix="uc1" TagName="ValidateUserAccess" %>
<%@ Register Src="~/App_Controls/ForumVisibleTo.ascx" TagPrefix="uc1" TagName="ForumVisibleTo" %>
<%@ Register Src="~/App_Controls/TagHolderMax5.ascx" TagPrefix="uc1" TagName="TagHolderMax5" %>



<script runat="server">
    ' version 06/09/2018 # 1.17 AM



    Protected Sub ButtonPostForum_Click(sender As Object, e As EventArgs)
        If TagHolderMax5.TagIds = "0" Then
            LabelEM.Text = "Atleast 1 tag is neeed to create comparison list."
            Exit Sub
        End If

        Dim createforum As FirstClickerService.Version1.Forum.StructureForum
        createforum = FirstClickerService.Version1.Forum.Create_Forum(TextBoxHeading.Text, TextBoxDrescption.Text, Session("UserID"), FirstClickerService.Version1.Forum.ForumVisibleToEnum.Every_One, WebAppSettings.DBCS)
        If createforum.Result = True Then

            'xxxxxxxxxxxxxxx submit Tag xxxxxxxxxxxxxxxxxxxx 
            If TagHolderMax5.TagIds = "0" Then
                ' no tag
            Else
                Dim tagids As String() = TagHolderMax5.TagIds.Split(",")

                Dim i As Integer = 0
                For i = 0 To tagids.Length - 1
                    Dim ListTagsubmit As FirstClickerService.Version1.TagOfForum.StructureTagOfForum = FirstClickerService.Version1.TagOfForum.AddTagOfForum(tagids(i), createforum.ForumId, Val(Session("UserId")), WebAppSettings.DBCS)
                Next
            End If
            'xxxxxxxxxxxxxxx submit Tag xxxxxxxxxxxxxxxxxxxx 

            If CheckBoxPostToMyWall.Checked = True Then  'post to userwall
                Dim submituserwall2 As FirstClickerService.Version1.UserWall.StructureUserWall
                submituserwall2 = FirstClickerService.Version1.UserWall.UserWall_Add("Created A New Forum", " ", 0, Session("userId"), Session("userid"), FirstClickerService.Version1.UserWall.StatusEnum.Visible, WebAppSettings.DBCS, FirstClickerService.Version1.UserWall.PreviewTypeEnum.Forum, createforum.ForumId)
            End If
            Response.Redirect("~/forum/" & FirstClickerService.Common.ConvertSpace2Dass(createforum.Heading) & "/" & createforum.ForumId)
        Else
            LabelEM.Text = createforum.My_Error_message
        End If

    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ValidateUserAccess runat="server" ID="ValidateUserAccess" />
    <div class="row">
        <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3">
            <uc1:NavigationSideDashboard runat="server" ID="NavigationSideDashboard" />
        </div>
        <div class="col-12 col-sm-12 col-md-9 col-lg-9 col-xl-9">
            <div class="card  mt-2 BoxEffect6 ">
                <div class="card-header clearfix">
                    <div class="float-right"></div>
                    <h5 class="card-title m-0 ">
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Dashboard/Forum/Create.aspx">Create Forum</asp:HyperLink>
                    </h5>
                </div>
                <div class="card-body">
                    <div class="form">
                        <div class="form-group">
                            <label>Forum Heading</label>
                            <asp:TextBox ID="TextBoxHeading" runat="server" CssClass="form-control" placeholder="Forum Heading"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Forum Drescption</label>
                            <asp:TextBox ID="TextBoxDrescption" CssClass="form-control" runat="server" TextMode="MultiLine" placeholder="Forum Drescption"></asp:TextBox>
                        </div>

                        <uc1:ForumVisibleTo runat="server" ID="ForumVisibleTo" />

                        <uc1:TagHolderMax5 runat="server" ID="TagHolderMax5" />


                        <div class="form-group">
                            <asp:Label ID="LabelEM" runat="server" ForeColor="Maroon"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="card-footer clearfix">
                    <div class="float-left">
                        <asp:CheckBox ID="CheckBoxPostToMyWall" CssClass="text-info small text-muted" Text="Share on my wall" runat="server" Checked="true" />
                    </div>
                    <div class="float-right">
                        <asp:Button ID="ButtonPostForum" runat="server" Text="Create Forum" class="btn btn-sm btn-info" OnClick="ButtonPostForum_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

