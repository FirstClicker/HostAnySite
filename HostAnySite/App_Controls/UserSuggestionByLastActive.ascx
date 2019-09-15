<%@ Control Language="VB" ClassName="UserSuggestionByLastActive" %>
<%@ Register Src="~/app_controls/UserInfoBox.ascx" TagPrefix="uc1" TagName="UserInfoBox" %>

<script runat="server">

</script>


<asp:ListView ID="ListViewFriendSuggection" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="UserId">
    <EmptyDataTemplate>
        <span>No data was returned.</span>
    </EmptyDataTemplate>
    <ItemTemplate>
        <span style="">
            <uc1:UserInfoBox runat="server" ID="UserInfoBox" RoutUserName='<%# Eval("RoutUserName") %>' UserId='<%# Eval("userid") %>' UserName='<%# Eval("userName") %>' ImageFileName='<%# Bind("userimagefilename") %>' />
        </span>
    </ItemTemplate>
    <LayoutTemplate>
        <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
        <div style="">
        </div>
    </LayoutTemplate>
</asp:ListView>
<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
    SelectCommand="SELECT TU.userName,  TU.userid, TU.imageid, TU.RoutUserName, TI.ImageFileName as userimagefilename 
                                 FROM [table_User] TU
                                 left JOIN table_image TI ON TU.ImageID=TI.ImageID 
                                 left JOIN Table_UserRelation TUR1 on TU.userid = TUR1.Second_UserId
                                 left JOIN Table_UserRelation TUR2 on TU.userid = TUR2.First_UserId 
                                 group by TU.userName, TU.userid, TU.imageid, TU.RoutUserName, TI.ImageFileName, tu.lastlogindate
    order by lastlogindate desc    "></asp:SqlDataSource>
