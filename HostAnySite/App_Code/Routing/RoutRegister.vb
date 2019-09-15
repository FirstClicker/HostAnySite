' version 13/10/2018 # 20.27 

Imports System.Web.Routing
Imports Microsoft.VisualBasic

Public Class RoutRegister
    Public Shared Sub Register()

        'required to avoid script error as script get confused by rout url
        RouteTable.Routes.Ignore("{resource}.axd/{*pathInfo}")

        Dim WebSiteHomepath As FirstClickerService.Version1.WebSetting.StructureWebSetting_WebSiteHomepath = FirstClickerService.Version1.WebSetting.WEBAppSetting_LoadWebSiteHomePath(WebAppSettings.DBCS)
        If WebSiteHomepath.Result = True Then
            Select Case WebSiteHomepath.websiteHomePath
                Case FirstClickerService.Version1.WebSetting.websiteHomePathEnum.Blog
                    RouteTable.Routes.Add("SiteHome", New Route("", New RoutSiteHome("~/Blog/Default.aspx")))
                Case FirstClickerService.Version1.WebSetting.websiteHomePathEnum.Board
                    RouteTable.Routes.Add("SiteHome", New Route("", New RoutSiteHome("~/Board/Default.aspx")))
                Case FirstClickerService.Version1.WebSetting.websiteHomePathEnum.Forum
                    RouteTable.Routes.Add("SiteHome", New Route("", New RoutSiteHome("~/Forum/Default.aspx")))
                Case FirstClickerService.Version1.WebSetting.websiteHomePathEnum.Image
                    RouteTable.Routes.Add("SiteHome", New Route("", New RoutSiteHome("~/Image/Default.aspx")))
                Case FirstClickerService.Version1.WebSetting.websiteHomePathEnum.Question
                    RouteTable.Routes.Add("SiteHome", New Route("", New RoutSiteHome("~/Question/Default.aspx")))
                Case FirstClickerService.Version1.WebSetting.websiteHomePathEnum.Wall
                    RouteTable.Routes.Add("SiteHome", New Route("", New RoutSiteHome("~/wall/Default.aspx")))
            End Select
        Else
            RouteTable.Routes.Add("SiteHome", New Route("", New RoutSiteHome("~/wall/Default.aspx")))
        End If




        RouteTable.Routes.Add("ComparisonListView", New Route("Compare/{Heading}/{ID}/", New RoutIDHeading("~/Routing/ComparisonList.aspx")))


        RouteTable.Routes.Add("UserProfile", New Route("User/{RoutUserName}/", New RoutUser("~/Routing/UserProfile.aspx")))

        RouteTable.Routes.Add("UserFollower", New Route("User/{RoutUsername}/Follower", New RoutUser("~/Routing/UserFollower.aspx")))
        RouteTable.Routes.Add("UserFollowing", New Route("User/{RoutUsername}/Following", New RoutUser("~/Routing/UserFollowing.aspx")))
        RouteTable.Routes.Add("UserFriend", New Route("User/{RoutUsername}/Friend", New RoutUser("~/Routing/UserFriends.aspx")))
        RouteTable.Routes.Add("UserFriendRequestSent", New Route("User/{RoutUsername}/Friendship_Requested", New RoutUser("~/Routing/UserFriendshipRequested.aspx")))
        RouteTable.Routes.Add("UserFriendRequestReceived", New Route("User/{RoutUsername}/Friendship_Request_Received", New RoutUser("~/Routing/UserFriendshipReceived.aspx")))

        RouteTable.Routes.Add("UserBlog", New Route("User/{RoutUsername}/Blog", New RoutUser("~/Routing/UserBlog.aspx")))
        RouteTable.Routes.Add("UserForum", New Route("User/{RoutUsername}/Forum", New RoutUser("~/Routing/UserForum.aspx")))
        RouteTable.Routes.Add("UserQuestion", New Route("User/{RoutUsername}/Question", New RoutUser("~/Routing/UserQuestion.aspx")))
        RouteTable.Routes.Add("UserImage", New Route("User/{RoutUsername}/Image", New RoutUser("~/Routing/UserImage.aspx")))
        RouteTable.Routes.Add("UserMessage", New Route("Message/{RoutUserName}/", New RoutUser("~/Routing/UserMessage.aspx")))


        'its must come last to avoid conflict with others..
        RouteTable.Routes.Add("BoardUni1", New Route("{string1}/", New RoutBoardUni()))
        RouteTable.Routes.Add("BoardUni2", New Route("{string1}/{string2}/", New RoutBoardUni()))
        RouteTable.Routes.Add("BoardUni3", New Route("{string1}/{string2}/{string3}", New RoutBoardUni()))
        RouteTable.Routes.Add("BoardUni4", New Route("{string1}/{string2}/{string3}/{string4}", New RoutBoardUni()))
    End Sub
End Class
