USE [DatabaseName]
GO
/****** Object:  Table [dbo].[Table_Activity]    Script Date: 3/16/2017 10:45:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Activity](
	[ActivityId] [numeric](18, 0) NOT NULL,
	[Activity] [nvarchar](max) NOT NULL,
	[UserId] [numeric](18, 0) NOT NULL,
	[ActivityPoint] [numeric](18, 0) NOT NULL,
	[ActivityDate] [datetime] NOT NULL,
	[ActivityImportance] [nvarchar](20) NOT NULL,
	[Activity_UserID] [numeric](18, 0) NOT NULL,
	[Activity_WorkGroupID] [numeric](18, 0) NOT NULL,
	[Activity_BlogBoardID] [numeric](18, 0) NOT NULL,
	[Activity_BlogID] [numeric](18, 0) NOT NULL,
	[Activity_ForumBoardID] [numeric](18, 0) NOT NULL,
	[Activity_ForumID] [numeric](18, 0) NOT NULL,
	[Activity_ErrorNum] [numeric](18, 0) NOT NULL,
	[Activity_ErrorMessage] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Table_Activity] PRIMARY KEY CLUSTERED 
(
	[ActivityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_Blog]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Blog](
	[BlogId] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](500) NOT NULL,
	[Highlight] [nvarchar](max) NOT NULL,
	[Containt] [nvarchar](max) NOT NULL,
	[ImageId] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Table_Blog_ImageId]  DEFAULT ((0)),
	[UserID] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[Status] [nvarchar](10) NOT NULL,
	[BlogBoard_ID] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Table_Blog_BlogBoard_ID]  DEFAULT ((0)),
	[ShowInHome] [nvarchar](20) NOT NULL CONSTRAINT [DF_Table_Blog_ShowInHome]  DEFAULT (N'No'),
 CONSTRAINT [PK_Table_Blog] PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_ErrorPublic]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ErrorPublic](
	[ErrorTime] [datetime] NOT NULL,
	[ErrorCode] [numeric](18, 0) NOT NULL,
	[ErrorLocation] [nvarchar](max) NOT NULL,
	[Message] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_Forum]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Forum](
	[Forum_Id] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](100) NOT NULL,
	[Drescption] [nvarchar](500) NOT NULL,
	[UserId] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Table_forum_UserName]  DEFAULT ((0)),
	[VisibleTo] [nvarchar](20) NOT NULL CONSTRAINT [DF_Table_forum_Visible]  DEFAULT (N'EveryOne'),
	[Status] [nvarchar](50) NOT NULL CONSTRAINT [DF_Table_forum_Status]  DEFAULT (N'Active'),
	[CreateDate] [datetime] NOT NULL,
	[ForumBoard_id] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Table_Forum_ForumBoard_id]  DEFAULT ((0)),
	[ShowInHome] [nvarchar](20) NOT NULL CONSTRAINT [DF_Table_Forum_ShowInHome]  DEFAULT (N'No'),
 CONSTRAINT [PK_Table_forum] PRIMARY KEY CLUSTERED 
(
	[Forum_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_ForumTopic]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ForumTopic](
	[Topic_Id] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](200) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[UserId] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[Forum_Id] [numeric](18, 0) NOT NULL,
	[VisibleTo] [nvarchar](20) NOT NULL,
	[Status] [nvarchar](10) NOT NULL,
	[Tag] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Table_topic] PRIMARY KEY CLUSTERED 
(
	[Topic_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_ForumTopicReply]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ForumTopicReply](
	[Id] [numeric](18, 0) NOT NULL,
	[Topic_Id] [numeric](18, 0) NOT NULL,
	[Reply] [nvarchar](max) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[UserId] [numeric](18, 0) NOT NULL,
	[VisibleTo] [nvarchar](20) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_topicReply] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_Image]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Image](
	[ImageId] [numeric](18, 0) NOT NULL,
	[ImageFileName] [nvarchar](200) NOT NULL,
	[ImageName] [nvarchar](185) NOT NULL,
	[Drescption] [nvarchar](max) NOT NULL,
	[UserId] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[Tag] [nvarchar](200) NOT NULL,
	[IsSystemImage] [nvarchar](20) NOT NULL CONSTRAINT [DF_Table_Image_IsSystemImage]  DEFAULT (N'No'),
 CONSTRAINT [PK_Table_Image] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_User]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_User](
	[UserId] [numeric](18, 0) NOT NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[RoutUserName] [nvarchar](50) NOT NULL,
	[UserType] [nvarchar](20) NOT NULL CONSTRAINT [DF_Table_User_UserType]  DEFAULT (N'Member'),
	[Password] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[EmailVerified] [nvarchar](5) NOT NULL CONSTRAINT [DF_Table_User_EmailVerified]  DEFAULT (N'No'),
	[EmailVcode] [numeric](18, 0) NOT NULL,
	[AccountStatus] [nvarchar](15) NOT NULL CONSTRAINT [DF_Table_User_AccountStatus]  DEFAULT (N'Unverified'),
	[JoinDate] [datetime] NOT NULL,
	[LastLogInDate] [datetime] NOT NULL,
	[Facebook_ID] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Table_User_Facebook_ID]  DEFAULT ((0)),
	[Twitter_ID] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Table_User_Twitter_ID]  DEFAULT ((0)),
	[ImageId] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Table_User_ImageId]  DEFAULT ((11111111)),
	[BannerImageID] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Table_User_BannerImageID]  DEFAULT ((11111112)),
 CONSTRAINT [PK_Table_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_UserChat]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_UserChat](
	[ChatId] [numeric](18, 0) NOT NULL,
	[First_UserId] [numeric](18, 0) NOT NULL,
	[Second_UserId] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_UserChat] PRIMARY KEY CLUSTERED 
(
	[ChatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_UserChatMessage]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_UserChatMessage](
	[MessageId] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[Message] [nvarchar](1000) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[ChatId] [numeric](18, 0) NOT NULL,
	[IsRead] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Table_UserMessage] PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_UserLike]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_UserLike](
	[LikeId] [numeric](18, 0) NOT NULL,
	[UserId] [numeric](18, 0) NOT NULL,
	[IsLike] [nvarchar](10) NOT NULL,
	[Vote] [numeric](18, 0) NOT NULL,
	[WallId] [numeric](18, 0) NOT NULL,
	[WallCommentId] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_UserLike] PRIMARY KEY CLUSTERED 
(
	[LikeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_UserRelation]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_UserRelation](
	[RelationID] [numeric](18, 0) NOT NULL,
	[First_UserId] [numeric](18, 0) NOT NULL,
	[Second_UserId] [numeric](18, 0) NOT NULL,
	[First_UserName] [nvarchar](50) NOT NULL,
	[Second_Username] [nvarchar](50) NOT NULL,
	[FollowStatus] [nvarchar](20) NOT NULL,
	[FriendStatus] [nvarchar](20) NOT NULL,
	[Date_Follow] [datetime] NOT NULL,
	[Date_Friend] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_UserRelation] PRIMARY KEY CLUSTERED 
(
	[RelationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_UserWall]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_UserWall](
	[WallID] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](1000) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[ImageId] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[UserId] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Wall_UserId] [numeric](18, 0) NOT NULL,
	[Wall_ImageID] [numeric](18, 0) NOT NULL,
	[Wall_BlogId] [numeric](18, 0) NOT NULL,
	[Wall_WorkGroupID] [numeric](18, 0) NOT NULL,
	[Wall_BlogBoardID] [numeric](18, 0) NOT NULL,
	[Wall_ForumBoardID] [numeric](18, 0) NOT NULL,
	[Preview_Heading] [nvarchar](250) NOT NULL,
	[Preview_TargetURL] [nvarchar](200) NOT NULL,
	[Preview_BodyText] [nvarchar](500) NOT NULL,
	[Preview_Type] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_Notification] PRIMARY KEY CLUSTERED 
(
	[WallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_UserWallComment]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_UserWallComment](
	[WallCommentId] [numeric](18, 0) NOT NULL,
	[WallId] [numeric](18, 0) NOT NULL,
	[Comment] [nvarchar](1000) NOT NULL,
	[UserId] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_UserWallComment] PRIMARY KEY CLUSTERED 
(
	[WallCommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_WebSetting]    Script Date: 3/16/2017 10:45:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_WebSetting](
	[SettingName] [nvarchar](50) NOT NULL,
	[SettingValue] [nvarchar](max) NOT NULL CONSTRAINT [DF_Table_WebSetting_SettingValue]  DEFAULT (N' '),
	[DefaultSettingValue] [nvarchar](max) NOT NULL CONSTRAINT [DF_Table_WebSetting_DefaultSettingValue]  DEFAULT (N' '),
	[Type] [nvarchar](20) NOT NULL CONSTRAINT [DF_Table_WebSetting_Type]  DEFAULT (N'Text'),
	[About] [nvarchar](max) NOT NULL CONSTRAINT [DF_Table_WebSetting_About]  DEFAULT (N' '),
 CONSTRAINT [PK_Table_WebSetting] PRIMARY KEY CLUSTERED 
(
	[SettingName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[Table_Blog] ([BlogId], [Heading], [Highlight], [Containt], [ImageId], [UserID], [PostDate], [Status], [BlogBoard_ID], [ShowInHome]) VALUES (CAST(29582808 AS Numeric(18, 0)), N'Happy Womens day', N'celebrating Happy Women''s day....', N'celebrating Happy Women''s day....', CAST(75619048 AS Numeric(18, 0)), CAST(78945612 AS Numeric(18, 0)), CAST(N'2017-03-08 12:30:22.000' AS DateTime), N'Visible', CAST(0 AS Numeric(18, 0)), N'Yes')
GO
INSERT [dbo].[Table_Blog] ([BlogId], [Heading], [Highlight], [Containt], [ImageId], [UserID], [PostDate], [Status], [BlogBoard_ID], [ShowInHome]) VALUES (CAST(31561324 AS Numeric(18, 0)), N'WHY BUILDING A BLOGGING COMMUNITY IS MORE IMPORTANT THAN ANYTHING ELSE', N'When you start out blogging you’re going to hear a lot of different things on what you should be concentrating on first.You should focus on SEO, keywords, search engine marketing, building back links, or having a great commenting system. Those things are great and will have to be taken care of in time but when starting out blogging or even trying to expand on your blog your focus should be building and creating a community around your blog.You can have about 1000 incoming links that rank you high on Alexa but if no one is ever reading or interacting with your blog it means nothing. I started out blogging in 2009 and when I first started out I thought that if my entire focus was not on SEO that my blog would die and no one would ever find me. Well, as you would probably assume my entire focus was on SEO and I got a lot of back links and I ranked high for great keywords but I started to realize that no one was commenting on blog posts and my bounce rate was entirely too high.One day I wa', N'When you start out blogging you’re going to hear a lot of different things on what you should be concentrating on first.<br><br>You should focus on SEO, keywords, search engine marketing, building back links, or having a great commenting system. Those things are great and will have to be taken care of in time but when starting out blogging or even trying to expand on your blog your focus should be building and creating a community around your blog.<br><br>You can have about 1000 incoming links that rank you high on Alexa but if no one is ever reading or interacting with your blog it means nothing. I started out blogging in 2009 and when I first started out I thought that if my entire focus was not on SEO that my blog would die and no one would ever find me. Well, as you would probably assume my entire focus was on SEO and I got a lot of back links and I ranked high for great keywords but I started to realize that no one was commenting on blog posts and my bounce rate was entirely too high.<br><br><br>One day I was out in a Starbucks and was just looking around at everyone conversing and realized that their were so many people working on different tasks in a group.<br><br>It made me think that some of the best work is sometimes done when in a group of people that think and act like you.<br><br>I took that mindset and brought it into blogging and how having a community of like minded people is the one focus that I should concentrate on first with starting out in the biosphere.<br><br>Building a solid interacting community online is something that you won’t be advised to do when starting out online unless you have a mentor that tells you to or by examples of other great bloggers. You won’t be told to create a brand and a buzz that will have people going bonkers over your blog posts as Christian has on Smart Boy Designs. But, that’s what you should be doing. When you start to think of the idea of creating a community you want to WHY you should create one and how you should grow that community in a unique way to get the best benefits for both your community and your brand.<br><br>Blogging Community When I first created the idea of the community is to offer generation-y the opportunity to voice their opinions on topics that they feel are important. With doing that we then expand on our community by offering great resources and tools that gen-y should be using to network and explore within our generation. The hardest part was to distinguish the unique side of the community and how we are going to be different from other blogs and companies that focus their attention on generation-y.<br><br>That’s what you should be thinking of when building your community.<br><br>What are you going to offer them that no one else is and how are you going to make it unique for them that they feel special when visiting your site each time.<br><br>So, when you look at your blogging community look to see what you’re offering them that is unique? What brand and voice are you creating to make your blog unique?<br><br>If you are having trouble with building a community for your blog look into expanding your social media into different areas. Build a LinkedIn group so that you can build a professional community to gather different ideas and perspectives. You’re going to have to think outside of the box with creating your community. The normal pushing content and guest blogging is a great way but you want to build a sustainable community as you would a business by trying different social platforms to create and grow your community.', CAST(33410164 AS Numeric(18, 0)), CAST(68256048 AS Numeric(18, 0)), CAST(N'2015-10-12 14:59:51.000' AS DateTime), N'Visible', CAST(0 AS Numeric(18, 0)), N'No')
GO
INSERT [dbo].[Table_Blog] ([BlogId], [Heading], [Highlight], [Containt], [ImageId], [UserID], [PostDate], [Status], [BlogBoard_ID], [ShowInHome]) VALUES (CAST(32757460 AS Numeric(18, 0)), N'Writing a Good Blog', N'Blogs, or Web logs, are online journals that are updated frequently, sometimes even daily. An update, (also called an entry or a post) is usually quite short, perhaps just a few sentences, and readers can often respond to an entry online. People who write blogs are commonly called bloggers. Bloggers, tongue in cheek, call themselves and their blogs the blogosphere.Blogs are a great way to keep everyone in a family abreast of the latest family news without running up the phone bill — you can simply read back over important updates to find out the latest news. In addition, many blogs are being used to host photographs, and their chronological structure can be a great way to keep track of a baby''s growth, a trip, or the process of planning a wedding.Professional writers often look down on bloggers, because their informal online writing rarely benefits from a good editor. Blogs are known for their casual writing and unpredictable subject material, but the best blogs have proven that — rega', N'<div><b>B</b>logs, or Web logs, are online journals that are updated frequently, sometimes even daily. An update, (also called an entry or a post) is usually quite short, perhaps just a few sentences, and readers can often respond to an entry online. People who write blogs are commonly called bloggers. Bloggers, tongue in cheek, call themselves and their blogs the blogosphere.</div><div><br></div><div><b>B</b>logs are a great way to keep everyone in a family abreast of the latest family news without running up the phone bill — you can simply read back over important updates to find out the latest news. In addition, many blogs are being used to host photographs, and their chronological structure can be a great way to keep track of a baby''s growth, a trip, or the process of planning a wedding.</div><div><br></div><div><b>P</b>rofessional writers often look down on bloggers, because their informal online writing rarely benefits from a good editor. Blogs are known for their casual writing and unpredictable subject material, but the best blogs have proven that — regardless of punctuation and spelling — even "novice" writers can be entertaining enough to attract a broad audience.</div><div><br></div><div><b>B</b>loggers with an especially engaging subject, such as chronicling a trip around the world, have the advantage of inherently interesting material, but even mundane material can attract an audience if you have an engaging style and voice.</div><div><br></div><div><b>Here are three guiding principles to writing a successful blog:</b></div><div><br></div><div>Develop a writing style and tone appropriate to your subject material.</div><div><br></div><div>Post often, even if your posts are short.</div><div><br></div><div>Allow your readers to comment on your posts.</div>', CAST(28997780 AS Numeric(18, 0)), CAST(52140480 AS Numeric(18, 0)), CAST(N'2015-10-12 14:52:47.000' AS DateTime), N'Visible', CAST(0 AS Numeric(18, 0)), N'Yes')
GO
INSERT [dbo].[Table_Forum] ([Forum_Id], [Heading], [Drescption], [UserId], [VisibleTo], [Status], [CreateDate], [ForumBoard_id], [ShowInHome]) VALUES (CAST(86402720 AS Numeric(18, 0)), N'Support', N'How can we help you?', CAST(78945612 AS Numeric(18, 0)), N'EveryOne', N'Active', CAST(N'2017-03-11 12:26:24.000' AS DateTime), CAST(0 AS Numeric(18, 0)), N'No')
GO
INSERT [dbo].[Table_Image] ([ImageId], [ImageFileName], [ImageName], [Drescption], [UserId], [PostDate], [Tag], [IsSystemImage]) VALUES (CAST(11111111 AS Numeric(18, 0)), N'UserProfilePic-11111111.png', N'UserProfilePic', N'Blank-76948984', CAST(11111111 AS Numeric(18, 0)), CAST(N'2015-12-12 00:00:00.000' AS DateTime), N'Blank-76948984', N'Yes')
GO
INSERT [dbo].[Table_Image] ([ImageId], [ImageFileName], [ImageName], [Drescption], [UserId], [PostDate], [Tag], [IsSystemImage]) VALUES (CAST(11111112 AS Numeric(18, 0)), N'UserProfileBanner-11111112.png', N'UserProfileBanner', N'dfgdfg', CAST(11111111 AS Numeric(18, 0)), CAST(N'2012-12-12 00:00:00.000' AS DateTime), N'esafsef', N'Yes')
GO
INSERT [dbo].[Table_Image] ([ImageId], [ImageFileName], [ImageName], [Drescption], [UserId], [PostDate], [Tag], [IsSystemImage]) VALUES (CAST(12099435 AS Numeric(18, 0)), N'administrator-12099435.jpg', N'administrator', N'administrator', CAST(78945612 AS Numeric(18, 0)), CAST(N'2017-03-06 21:03:09.000' AS DateTime), N'administrator', N'No')
GO
INSERT [dbo].[Table_Image] ([ImageId], [ImageFileName], [ImageName], [Drescption], [UserId], [PostDate], [Tag], [IsSystemImage]) VALUES (CAST(13268106 AS Numeric(18, 0)), N'raju-das-13268106.jpg', N'raju das', N'raju das', CAST(68256048 AS Numeric(18, 0)), CAST(N'2015-10-12 15:02:16.000' AS DateTime), N'raju das', N'No')
GO
INSERT [dbo].[Table_Image] ([ImageId], [ImageFileName], [ImageName], [Drescption], [UserId], [PostDate], [Tag], [IsSystemImage]) VALUES (CAST(28997780 AS Numeric(18, 0)), N'Writing-a-Good-Blog-28997780.jpg', N'Writing a Good Blog', N'Writing a Good Blog', CAST(52140480 AS Numeric(18, 0)), CAST(N'2015-10-12 14:52:47.000' AS DateTime), N'Writing a Good Blog', N'No')
GO
INSERT [dbo].[Table_Image] ([ImageId], [ImageFileName], [ImageName], [Drescption], [UserId], [PostDate], [Tag], [IsSystemImage]) VALUES (CAST(33410164 AS Numeric(18, 0)), N'WHY-BUILDING-A-BLOGGING-COMMUNITY-IS-MORE-IMPORTANT-THAN-ANYTHING-ELSE-33410164.jpg', N'WHY BUILDING A BLOGGING COMMUNITY IS MORE IMPORTANT THAN ANYTHING ELSE', N'WHY BUILDING A BLOGGING COMMUNITY IS MORE IMPORTANT THAN ANYTHING ELSE', CAST(68256048 AS Numeric(18, 0)), CAST(N'2015-10-12 14:59:51.000' AS DateTime), N'WHY BUILDING A BLOGGING COMMUNITY IS MORE IMPORTANT THAN ANYTHING ELSE', N'No')
GO
INSERT [dbo].[Table_Image] ([ImageId], [ImageFileName], [ImageName], [Drescption], [UserId], [PostDate], [Tag], [IsSystemImage]) VALUES (CAST(56622904 AS Numeric(18, 0)), N'administrator-56622904.jpg', N'administrator', N'administrator', CAST(78945612 AS Numeric(18, 0)), CAST(N'2017-03-08 19:34:32.000' AS DateTime), N'administrator', N'No')
GO
INSERT [dbo].[Table_Image] ([ImageId], [ImageFileName], [ImageName], [Drescption], [UserId], [PostDate], [Tag], [IsSystemImage]) VALUES (CAST(75619048 AS Numeric(18, 0)), N'Happy-Womens-day-75619048.jpg', N'Happy Womens day', N'Happy Womens day', CAST(78945612 AS Numeric(18, 0)), CAST(N'2017-03-08 12:30:21.000' AS DateTime), N'Happy Womens day', N'No')
GO
INSERT [dbo].[Table_Image] ([ImageId], [ImageFileName], [ImageName], [Drescption], [UserId], [PostDate], [Tag], [IsSystemImage]) VALUES (CAST(79147232 AS Numeric(18, 0)), N'administrator-79147232.jpg', N'administrator', N'administrator', CAST(78945612 AS Numeric(18, 0)), CAST(N'2017-03-08 19:35:18.000' AS DateTime), N'administrator', N'No')
GO
INSERT [dbo].[Table_User] ([UserId], [UserName], [RoutUserName], [UserType], [Password], [Email], [EmailVerified], [EmailVcode], [AccountStatus], [JoinDate], [LastLogInDate], [Facebook_ID], [Twitter_ID], [ImageId], [BannerImageID]) VALUES (CAST(52140480 AS Numeric(18, 0)), N'Riya Sen', N'Riya_Sen', N'Member', N'pass', N'Riya_Sen@domain.com', N'No', CAST(33466078 AS Numeric(18, 0)), N'Unverified', CAST(N'2015-10-11 16:36:48.000' AS DateTime), CAST(N'2017-03-07 22:44:11.000' AS DateTime), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(11111111 AS Numeric(18, 0)), CAST(11111112 AS Numeric(18, 0)))
GO
INSERT [dbo].[Table_User] ([UserId], [UserName], [RoutUserName], [UserType], [Password], [Email], [EmailVerified], [EmailVcode], [AccountStatus], [JoinDate], [LastLogInDate], [Facebook_ID], [Twitter_ID], [ImageId], [BannerImageID]) VALUES (CAST(68029456 AS Numeric(18, 0)), N'bidyut das', N'bidyut_das', N'Member', N'pass', N'bidyutdas@domain.com', N'No', CAST(66180616 AS Numeric(18, 0)), N'Unverified', CAST(N'2015-11-16 13:01:48.000' AS DateTime), CAST(N'2015-11-16 13:01:48.000' AS DateTime), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(11111111 AS Numeric(18, 0)), CAST(11111112 AS Numeric(18, 0)))
GO
INSERT [dbo].[Table_User] ([UserId], [UserName], [RoutUserName], [UserType], [Password], [Email], [EmailVerified], [EmailVcode], [AccountStatus], [JoinDate], [LastLogInDate], [Facebook_ID], [Twitter_ID], [ImageId], [BannerImageID]) VALUES (CAST(68256048 AS Numeric(18, 0)), N'raju das', N'raju_das', N'Member', N'pass', N'rajudas@domain.com', N'No', CAST(22066390 AS Numeric(18, 0)), N'Suspended', CAST(N'2015-10-11 19:29:06.000' AS DateTime), CAST(N'2015-11-17 02:28:42.000' AS DateTime), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(13268106 AS Numeric(18, 0)), CAST(11111112 AS Numeric(18, 0)))
GO
INSERT [dbo].[Table_User] ([UserId], [UserName], [RoutUserName], [UserType], [Password], [Email], [EmailVerified], [EmailVcode], [AccountStatus], [JoinDate], [LastLogInDate], [Facebook_ID], [Twitter_ID], [ImageId], [BannerImageID]) VALUES (CAST(78945612 AS Numeric(18, 0)), N'My Admin', N'My_Admin', N'Member', N'idonotknow', N'support@hostanysite.com', N'No', CAST(123 AS Numeric(18, 0)), N'Unverified', CAST(N'2015-12-12 00:00:00.000' AS DateTime), CAST(N'2017-03-14 19:37:13.000' AS DateTime), CAST(0 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), CAST(56622904 AS Numeric(18, 0)), CAST(79147232 AS Numeric(18, 0)))
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Cerulean', N'Content\bootswatch\cerulean\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'CopyRight', N'Copyright @ HostAnySite.Com', N'Copyright @ HostAnySite.Com', N'Text', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Cosmo', N'Content\bootswatch\Cosmo\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'CurrentTheme', N'Content\bootstrap-theme.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Cyborg', N'Content\bootswatch\Cyborg\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Darkly', N'Content\bootswatch\Darkly\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'DatabaseVersion', N'3', N' ', N'Text', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Default', N'Content\bootstrap-theme.min.css', N'Yes', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'EmailVerificationCodeNote', N'Get email verification code by registered email.', N'Get email verification code by registered email.', N'Text', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Flatly', N'Content\bootswatch\Flatly\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'HomeCarouselImage1', N'HomeCarouselImage1.jpg', N' ', N'Image', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'HomeCarouselImage2', N'HomeCarouselImage2.jpg', N' ', N'Image', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'HomeCarouselImage3', N'HomeCarouselImage3.jpg', N' ', N'Image', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'HomeWelcomeNote', N'Welcome to HostAnySite.Com community website.', N'Welcome to HostAnySite.Com community website.', N'Text', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Journal', N'Content\bootswatch\Journal\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Lumen', N'Content\bootswatch\Lumen\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Paper', N'Content\bootswatch\Paper\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Readable', N'Content\bootswatch\Readable\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'RecoverPasswordNote', N'Recover your password by registered email.', N'Recover your password by registered email.', N'Text', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Sandstone', N'Content\bootswatch\Sandstone\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'ServiceEmail_Email', N'Support@Domain.Com', N' ', N'Email', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'ServiceEmail_Enabled', N'False', N' ', N'Boolean', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'ServiceEmail_Host', N'mail.domain.com', N' ', N'Email', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'ServiceEmail_Password', N'', N' ', N'Email', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'ServiceEmail_Port', N'25', N' ', N'Email', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'ServiceEmail_UserName', N'Support@Domain.Com', N' ', N'Email', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SignInCarouselImage1', N'SignInCarouselImage1.jpg', N' ', N'Image', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SignInCarouselImage2', N' ', N' ', N'Image', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SignInCarouselImage3', N' ', N' ', N'Image', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SignInNote', N'Please sign into your account.', N' ', N'Text', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SignUpCarouselImage1', N'SignUpCarouselImage1.jpg', N' ', N'Image', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SignUpCarouselImage2', N' ', N' ', N'Image', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SignUpCarouselImage3', N' ', N' ', N'Image', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SignUpEmailVerificationRequired', N'No', N'No', N'Boolean', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SignupNote', N'Please create acccount with us.', N' ', N'Text', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Simplex', N'Content\bootswatch\Simplex\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Slate', N'Content\bootswatch\Slate\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Spacelab', N'Content\bootswatch\Spacelab\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'SubdomianAllowed', N'No', N'No', N'Boolean', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Superhero', N'Content\bootswatch\Superhero\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'United', N'Content\bootswatch\United\bootstrap.min.css', N'No', N'Theme', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'VerifyEmailNote', N'Please verify your registered email.', N' ', N'Text', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'WebSiteName', N'HostAnySite', N' ', N'Text', N' ')
GO
INSERT [dbo].[Table_WebSetting] ([SettingName], [SettingValue], [DefaultSettingValue], [Type], [About]) VALUES (N'Yeti', N'Content\bootswatch\Yeti\bootstrap.min.css', N'No', N'Theme', N' ')
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IK_Table_User_Email]    Script Date: 3/16/2017 10:45:12 PM ******/
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [IK_Table_User_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Table_User_RoutUserName]    Script Date: 3/16/2017 10:45:12 PM ******/
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [IX_Table_User_RoutUserName] UNIQUE NONCLUSTERED 
(
	[RoutUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_UserId]  DEFAULT ((0)) FOR [UserId]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_ActivityPoint]  DEFAULT ((0)) FOR [ActivityPoint]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_ActivityImportance]  DEFAULT (N'Info') FOR [ActivityImportance]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_Activity_UserID]  DEFAULT ((0)) FOR [Activity_UserID]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_ActivityLocation]  DEFAULT ((0)) FOR [Activity_WorkGroupID]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_ActivityLocationID]  DEFAULT ((0)) FOR [Activity_BlogBoardID]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_Activity_Blog]  DEFAULT ((0)) FOR [Activity_BlogID]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_Activity_ForumBoard]  DEFAULT ((0)) FOR [Activity_ForumBoardID]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_Activity_Forum]  DEFAULT ((0)) FOR [Activity_ForumID]
GO
ALTER TABLE [dbo].[Table_Activity] ADD  CONSTRAINT [DF_Table_Activity_Activity_ErrorNum]  DEFAULT ((0)) FOR [Activity_ErrorNum]
GO
ALTER TABLE [dbo].[Table_ForumTopic] ADD  CONSTRAINT [DF_Table_topic_VisibleTo]  DEFAULT (N'EveryOne') FOR [VisibleTo]
GO
ALTER TABLE [dbo].[Table_ForumTopic] ADD  CONSTRAINT [DF_Table_topic_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_ForumTopicReply] ADD  CONSTRAINT [DF_Table_topicReply_VisibleTo]  DEFAULT (N'EveryOne') FOR [VisibleTo]
GO
ALTER TABLE [dbo].[Table_ForumTopicReply] ADD  CONSTRAINT [DF_Table_topicReply_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_UserChat] ADD  CONSTRAINT [DF_Table_UserChat_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_UserChatMessage] ADD  CONSTRAINT [DF_Table_UserMessage_Chat_Id]  DEFAULT ((0)) FOR [ChatId]
GO
ALTER TABLE [dbo].[Table_UserChatMessage] ADD  CONSTRAINT [DF_Table_UserChatMessage_IsRead]  DEFAULT (N'False') FOR [IsRead]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_IsLike]  DEFAULT (N'IsLike') FOR [IsLike]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_Vote]  DEFAULT ((1)) FOR [Vote]
GO
ALTER TABLE [dbo].[Table_UserRelation] ADD  CONSTRAINT [DF_Table_UserRelation_RelationStatus]  DEFAULT (N'Unknown') FOR [FollowStatus]
GO
ALTER TABLE [dbo].[Table_UserRelation] ADD  CONSTRAINT [DF_Table_UserRelation_FriendStatus]  DEFAULT (N'Unknown') FOR [FriendStatus]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_Notification_ImageId]  DEFAULT ((0)) FOR [ImageId]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Status]  DEFAULT (N'Visible') FOR [Status]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_WallUserId]  DEFAULT ((0)) FOR [Wall_UserId]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Wall_ImageID]  DEFAULT ((0)) FOR [Wall_ImageID]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_WallAuthor_Id]  DEFAULT ((0)) FOR [Wall_BlogId]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Wall_WorkGroupID]  DEFAULT ((0)) FOR [Wall_WorkGroupID]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Wall_BlogBoardID]  DEFAULT ((0)) FOR [Wall_BlogBoardID]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Wall_ForumBoardID]  DEFAULT ((0)) FOR [Wall_ForumBoardID]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_Heading]  DEFAULT (N' ') FOR [Preview_Heading]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_TargetURL]  DEFAULT (N' ') FOR [Preview_TargetURL]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_Body]  DEFAULT (N' ') FOR [Preview_BodyText]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_Type]  DEFAULT (N'None') FOR [Preview_Type]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[ Active | Closed | ClosedByAdmin | SuspendedByAdmin ]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Table_Forum', @level2type=N'COLUMN',@level2name=N'Status'
