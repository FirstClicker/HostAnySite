USE [DatabaseName]
GO
/****** Object:  Table [dbo].[Table_Acc_AccountDetails]    Script Date: 9/15/2019 5:37:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Acc_AccountDetails](
	[AccountID] [numeric](18, 0) NOT NULL,
	[AccountName] [nvarchar](100) NOT NULL,
	[AccountType] [nvarchar](50) NOT NULL,
	[Derescption] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Table_Acc_AccountDetails_AccountID] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Acc_JournalBook]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Acc_JournalBook](
	[JournalID] [numeric](18, 0) NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[Heading] [nvarchar](100) NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[DebitAccountID] [numeric](18, 0) NOT NULL,
	[CreditAccountID] [numeric](18, 0) NOT NULL,
	[Amount] [numeric](18, 2) NOT NULL,
	[DebitAccountBalance] [numeric](18, 2) NOT NULL,
	[CreditAccountBalance] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_Table_Acc_JournalBook] PRIMARY KEY CLUSTERED 
(
	[JournalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Acc_OrderBook]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Acc_OrderBook](
	[OrderID] [numeric](18, 0) NOT NULL,
	[AccountID] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](50) NOT NULL,
	[OrderType] [nvarchar](20) NOT NULL,
	[OrderNote] [nvarchar](200) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[DeliveryDate] [datetime] NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[BillID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Table_Acc_OrderBook] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Acc_OrderBookItems]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Acc_OrderBookItems](
	[OrderItemID] [numeric](18, 0) NOT NULL,
	[OrderID] [numeric](18, 0) NOT NULL,
	[StockItemID] [numeric](18, 0) NOT NULL,
	[Quantity] [numeric](18, 3) NOT NULL,
	[Rate] [numeric](18, 2) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Table_Acc_OrderBookItems] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Acc_Production]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Acc_Production](
	[ProductionID] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](50) NOT NULL,
	[ProductionDate] [datetime] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Table_Acc_Production] PRIMARY KEY CLUSTERED 
(
	[ProductionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Acc_ProductionCost]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Acc_ProductionCost](
	[ProductionID] [numeric](18, 0) NOT NULL,
	[RawItemID] [numeric](18, 0) NOT NULL,
	[CostPerUnit] [numeric](18, 2) NOT NULL,
	[Cost] [numeric](18, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Acc_ProductionProducts]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Acc_ProductionProducts](
	[EntryID] [numeric](18, 0) NOT NULL,
	[StockItemID] [numeric](18, 0) NOT NULL,
	[ProductionID] [numeric](18, 0) NOT NULL,
	[Weight] [numeric](18, 3) NOT NULL,
 CONSTRAINT [PK_Table_Acc_ProductionProducts] PRIMARY KEY CLUSTERED 
(
	[EntryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Acc_StockBook]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Acc_StockBook](
	[EntryId] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Table_Acc_StockBook] PRIMARY KEY CLUSTERED 
(
	[EntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Acc_StockBookItems]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Acc_StockBookItems](
	[StockItemID] [numeric](18, 0) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Drescption] [nvarchar](max) NOT NULL,
	[Unit] [nvarchar](20) NOT NULL,
	[ItemCount] [numeric](18, 3) NOT NULL,
	[ItemPrice] [numeric](18, 3) NOT NULL,
 CONSTRAINT [PK_Table_Acc_ProductDetails] PRIMARY KEY CLUSTERED 
(
	[StockItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Blog]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Blog](
	[BlogId] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](500) NOT NULL,
	[Highlight] [nvarchar](max) NOT NULL,
	[Containt] [nvarchar](max) NOT NULL,
	[ImageId] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[Status] [nvarchar](10) NOT NULL,
	[ShowInHome] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_Blog] PRIMARY KEY CLUSTERED 
(
	[BlogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_ComparisionEntryRating]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ComparisionEntryRating](
	[EntryID] [numeric](18, 0) NOT NULL,
	[CriteriaID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[Vote] [numeric](18, 0) NOT NULL,
	[Message] [nvarchar](250) NOT NULL,
	[VoteDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_ComparisonCriteria]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ComparisonCriteria](
	[CriteriaID] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](40) NOT NULL,
	[Description] [nvarchar](400) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_ComparisonCriteria] PRIMARY KEY CLUSTERED 
(
	[CriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_ComparisonEntry]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ComparisonEntry](
	[EntryID] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_ComparisonEntry] PRIMARY KEY CLUSTERED 
(
	[EntryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_ComparisonList]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ComparisonList](
	[ListID] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_ComparisonList] PRIMARY KEY CLUSTERED 
(
	[ListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_CriteriaOfComparison]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_CriteriaOfComparison](
	[ListID] [numeric](18, 0) NOT NULL,
	[CriteriaID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[Description] [nvarchar](250) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_EntryOfComparisonList]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_EntryOfComparisonList](
	[ListID] [numeric](18, 0) NOT NULL,
	[EntryID] [numeric](18, 0) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_ErrorPublic]    Script Date: 9/15/2019 5:37:36 PM ******/
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
/****** Object:  Table [dbo].[Table_Feedback]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Feedback](
	[ID] [numeric](18, 0) NOT NULL,
	[Email] [nvarchar](250) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[FeedbackType] [nvarchar](50) NOT NULL,
	[Domain] [nvarchar](50) NOT NULL,
	[Heading] [nvarchar](250) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[FeedbackDate] [datetime] NOT NULL,
	[ThreadID] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Table_Feedback] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Forum]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Forum](
	[ForumID] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](100) NOT NULL,
	[Drescption] [nvarchar](500) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[VisibleTo] [nvarchar](20) NOT NULL,
	[CanCreateTopic] [nvarchar](20) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[ShowInHome] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_forum] PRIMARY KEY CLUSTERED 
(
	[ForumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_ForumTopic]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ForumTopic](
	[TopicID] [numeric](18, 0) NOT NULL,
	[Heading] [nvarchar](200) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[ForumID] [numeric](18, 0) NOT NULL,
	[VisibleTo] [nvarchar](20) NOT NULL,
	[CanReply] [nvarchar](20) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_topic] PRIMARY KEY CLUSTERED 
(
	[TopicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_ForumTopicReply]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ForumTopicReply](
	[ID] [numeric](18, 0) NOT NULL,
	[TopicID] [numeric](18, 0) NOT NULL,
	[Reply] [nvarchar](max) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_topicReply] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Image]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Image](
	[ImageID] [numeric](18, 0) NOT NULL,
	[ImageFileName] [nvarchar](200) NOT NULL,
	[ImageName] [nvarchar](185) NOT NULL,
	[Drescption] [nvarchar](max) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[ImageAlbumID] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_Image] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_ImageIcon]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ImageIcon](
	[TempId] [numeric](18, 0) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[Height] [numeric](18, 0) NOT NULL,
	[Width] [numeric](18, 0) NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
	[UpdateCount] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Table_ImageIcon] PRIMARY KEY CLUSTERED 
(
	[TempId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_ImageTemp]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_ImageTemp](
	[TempID] [numeric](18, 0) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[Height] [numeric](18, 0) NOT NULL,
	[Width] [numeric](18, 0) NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
	[UpdateCount] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Table_ImageTemp] PRIMARY KEY CLUSTERED 
(
	[TempID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Question]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Question](
	[QuestionID] [numeric](18, 0) NOT NULL,
	[Question] [nvarchar](100) NOT NULL,
	[Drescption] [nvarchar](max) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[BestAnswerID] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Table_Question] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_QuestionAnswer]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_QuestionAnswer](
	[AnswerID] [numeric](18, 0) NOT NULL,
	[QuestionID] [numeric](18, 0) NOT NULL,
	[Answer] [nvarchar](max) NOT NULL,
	[Source] [nvarchar](200) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[PostDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_QuestionAnswer] PRIMARY KEY CLUSTERED 
(
	[AnswerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_StaticPage]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_StaticPage](
	[PageName] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Keyword] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[PageBody] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Table_StaticPage] PRIMARY KEY CLUSTERED 
(
	[PageName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_SysEmailDetails]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_SysEmailDetails](
	[EmailName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[UserName] [nvarchar](200) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Host] [nvarchar](200) NOT NULL,
	[Port] [numeric](18, 0) NOT NULL,
	[VerificationCode] [numeric](18, 0) NOT NULL,
	[IsVerified] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Table_EmailDetails] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Table_EmailDetails_EmailName] UNIQUE NONCLUSTERED 
(
	[EmailName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_SysEmailQueue]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_SysEmailQueue](
	[QueueID] [nchar](10) NOT NULL,
	[SenderEmail] [nvarchar](500) NOT NULL,
	[ReceiverEmail] [nvarchar](500) NOT NULL,
	[EmailSubject] [nvarchar](500) NOT NULL,
	[EmailBody] [nvarchar](max) NOT NULL,
	[EmailBodyIsHTML] [nvarchar](10) NOT NULL,
	[DateOnAdded] [datetime] NOT NULL,
	[DateOnSent] [datetime] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[TrackerID] [numeric](18, 0) NOT NULL,
	[TrackedBack] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Table_EmailQueue] PRIMARY KEY CLUSTERED 
(
	[QueueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_Tag]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Tag](
	[TagID] [numeric](18, 0) NOT NULL,
	[TagName] [nvarchar](50) NOT NULL,
	[Tag] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[Importance] [int] NOT NULL,
 CONSTRAINT [PK_Table_Tag_TagID] PRIMARY KEY CLUSTERED 
(
	[TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_TagOfBlog]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_TagOfBlog](
	[TagID] [numeric](18, 0) NOT NULL,
	[BlogID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_TagOFComparisonList]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_TagOFComparisonList](
	[TagID] [numeric](18, 0) NOT NULL,
	[ComparisonListID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_TagOFComparisonListEntry]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_TagOFComparisonListEntry](
	[TagID] [numeric](18, 0) NOT NULL,
	[ComparisonEntryID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_TagOfForum]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_TagOfForum](
	[TagID] [numeric](18, 0) NOT NULL,
	[ForumID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_TagOfImage]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_TagOfImage](
	[TagID] [numeric](18, 0) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_TagOfQuestion]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_TagOfQuestion](
	[TagID] [numeric](18, 0) NOT NULL,
	[QuestionID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_TagOfTag]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_TagOfTag](
	[TagID] [numeric](18, 0) NOT NULL,
	[ParentTagID] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_User]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_User](
	[UserID] [numeric](18, 0) NOT NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[RoutUserName] [nvarchar](50) NOT NULL,
	[UserType] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[EmailVerified] [nvarchar](5) NOT NULL,
	[EmailVcode] [numeric](18, 0) NOT NULL,
	[AccountStatus] [nvarchar](15) NOT NULL,
	[JoinDate] [datetime] NOT NULL,
	[LastLogInDate] [datetime] NOT NULL,
	[Facebook_ID] [numeric](18, 0) NOT NULL,
	[Twitter_ID] [numeric](18, 0) NOT NULL,
	[Google_ID] [numeric](30, 0) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[BannerImageID] [numeric](18, 0) NOT NULL,
	[IsSystemUser] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IK_Table_User_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Table_User_RoutUserName] UNIQUE NONCLUSTERED 
(
	[RoutUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_UserChat]    Script Date: 9/15/2019 5:37:36 PM ******/
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
/****** Object:  Table [dbo].[Table_UserChatMessage]    Script Date: 9/15/2019 5:37:36 PM ******/
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
/****** Object:  Table [dbo].[Table_UserLike]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_UserLike](
	[LikeID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[WallID] [numeric](18, 0) NOT NULL,
	[WallCommentID] [numeric](18, 0) NOT NULL,
	[BlogID] [numeric](18, 0) NOT NULL,
	[QuestionID] [numeric](18, 0) NOT NULL,
	[QuestionAnswerID] [numeric](18, 0) NOT NULL,
	[ForumID] [numeric](18, 0) NOT NULL,
	[ForumTopicID] [numeric](18, 0) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[IsLike] [nvarchar](10) NOT NULL,
	[Vote] [numeric](18, 0) NOT NULL,
	[PostDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_UserLike] PRIMARY KEY CLUSTERED 
(
	[LikeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_UserNotification]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_UserNotification](
	[NotificationID] [numeric](18, 0) NOT NULL,
	[UserID] [numeric](18, 0) NOT NULL,
	[Notify2UserID] [numeric](18, 0) NOT NULL,
	[Notification] [nvarchar](100) NOT NULL,
	[TargetUrl] [nvarchar](200) NOT NULL,
	[ImageID] [numeric](18, 0) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[NotifyDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_UserNotification] PRIMARY KEY CLUSTERED 
(
	[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_UserNotificationEmail]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_UserNotificationEmail](
	[UserID] [numeric](18, 0) NOT NULL,
	[EmailEnabled] [nvarchar](20) NOT NULL,
	[IntervalHour] [numeric](18, 0) NOT NULL,
	[LastEmailTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_UserNotificationEmail] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_UserRelation]    Script Date: 9/15/2019 5:37:36 PM ******/
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
/****** Object:  Table [dbo].[Table_UserWall]    Script Date: 9/15/2019 5:37:36 PM ******/
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
	[Status] [nvarchar](20) NOT NULL,
	[UserId] [numeric](18, 0) NOT NULL,
	[Wall_UserId] [numeric](18, 0) NOT NULL,
	[Preview_Type] [nvarchar](20) NOT NULL,
	[Preview_ID] [numeric](18, 0) NOT NULL,
	[Preview_Heading] [nvarchar](250) NOT NULL,
	[Preview_TargetURL] [nvarchar](200) NOT NULL,
	[Preview_ImageURL] [nvarchar](250) NOT NULL,
	[Preview_BodyText] [nvarchar](500) NOT NULL,
	[ShowInHome] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Table_Notification] PRIMARY KEY CLUSTERED 
(
	[WallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table_UserWallComment]    Script Date: 9/15/2019 5:37:36 PM ******/
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
/****** Object:  Table [dbo].[Table_WebSetting]    Script Date: 9/15/2019 5:37:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_WebSetting](
	[SettingName] [nvarchar](50) NOT NULL,
	[SettingValue] [nvarchar](max) NOT NULL,
	[DefaultValue] [nvarchar](max) NOT NULL,
	[SettingType] [nvarchar](20) NOT NULL,
	[SettingGroup] [nvarchar](20) NOT NULL,
	[About] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Table_WebSetting] PRIMARY KEY CLUSTERED 
(
	[SettingName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Table_Acc_AccountDetails] ADD  CONSTRAINT [DF_Table_Acc_AccountDetails_Derescption]  DEFAULT (N' ') FOR [Derescption]
GO
ALTER TABLE [dbo].[Table_Acc_JournalBook] ADD  CONSTRAINT [DF_Table_Acc_JournalBook_Comment]  DEFAULT (N' ') FOR [Comment]
GO
ALTER TABLE [dbo].[Table_Acc_OrderBook] ADD  CONSTRAINT [DF_Table_Acc_OrderBook_OrderType]  DEFAULT (N'Sale') FOR [OrderType]
GO
ALTER TABLE [dbo].[Table_Acc_Production] ADD  CONSTRAINT [DF_Table_Acc_Production_Comment]  DEFAULT (N' ') FOR [Comment]
GO
ALTER TABLE [dbo].[Table_Acc_StockBookItems] ADD  CONSTRAINT [DF_Table_Acc_StockBookItems_Unit]  DEFAULT (N'Kg') FOR [Unit]
GO
ALTER TABLE [dbo].[Table_Blog] ADD  CONSTRAINT [DF_Table_Blog_ImageId]  DEFAULT ((0)) FOR [ImageId]
GO
ALTER TABLE [dbo].[Table_Blog] ADD  CONSTRAINT [DF_Table_Blog_Status]  DEFAULT (N'Visible') FOR [Status]
GO
ALTER TABLE [dbo].[Table_Blog] ADD  CONSTRAINT [DF_Table_Blog_ShowInHome]  DEFAULT (N'False') FOR [ShowInHome]
GO
ALTER TABLE [dbo].[Table_ComparisonCriteria] ADD  CONSTRAINT [DF_Table_ComparisonCriteria_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_ComparisonEntry] ADD  CONSTRAINT [DF_Table_ComparisonEntry_ImageID]  DEFAULT ((11111113)) FOR [ImageID]
GO
ALTER TABLE [dbo].[Table_ComparisonEntry] ADD  CONSTRAINT [DF_Table_ComparisonEntry_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_ComparisonEntry] ADD  CONSTRAINT [DF_Table_ComparisonEntry_UserID]  DEFAULT ((11111111)) FOR [UserID]
GO
ALTER TABLE [dbo].[Table_EntryOfComparisonList] ADD  CONSTRAINT [DF_Table_EntryOfComparisonList_ImageID]  DEFAULT ((11111113)) FOR [ImageID]
GO
ALTER TABLE [dbo].[Table_Feedback] ADD  CONSTRAINT [DF_Table_Feedback_Phone]  DEFAULT ((0)) FOR [Phone]
GO
ALTER TABLE [dbo].[Table_Feedback] ADD  CONSTRAINT [DF_Table_Feedback_Address]  DEFAULT (N' ') FOR [Address]
GO
ALTER TABLE [dbo].[Table_Feedback] ADD  CONSTRAINT [DF_Table_Feedback_FeedbackType]  DEFAULT (N'General') FOR [FeedbackType]
GO
ALTER TABLE [dbo].[Table_Forum] ADD  CONSTRAINT [DF_Table_forum_UserName]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[Table_Forum] ADD  CONSTRAINT [DF_Table_forum_Visible]  DEFAULT (N'Every_One') FOR [VisibleTo]
GO
ALTER TABLE [dbo].[Table_Forum] ADD  CONSTRAINT [DF_Table_Forum_CanCreateTopic]  DEFAULT (N'Site_Members') FOR [CanCreateTopic]
GO
ALTER TABLE [dbo].[Table_Forum] ADD  CONSTRAINT [DF_Table_forum_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_Forum] ADD  CONSTRAINT [DF_Table_Forum_ShowInHome]  DEFAULT (N'False') FOR [ShowInHome]
GO
ALTER TABLE [dbo].[Table_ForumTopic] ADD  CONSTRAINT [DF_Table_topic_VisibleTo]  DEFAULT (N'Every_One') FOR [VisibleTo]
GO
ALTER TABLE [dbo].[Table_ForumTopic] ADD  CONSTRAINT [DF_Table_ForumTopic_CanReply]  DEFAULT (N'Site_Members') FOR [CanReply]
GO
ALTER TABLE [dbo].[Table_ForumTopic] ADD  CONSTRAINT [DF_Table_topic_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_ForumTopicReply] ADD  CONSTRAINT [DF_Table_ForumTopicReply_ImageID]  DEFAULT ((0)) FOR [ImageID]
GO
ALTER TABLE [dbo].[Table_ForumTopicReply] ADD  CONSTRAINT [DF_Table_topicReply_Status]  DEFAULT (N'Visible') FOR [Status]
GO
ALTER TABLE [dbo].[Table_Image] ADD  CONSTRAINT [DF_Table_Image_PictureAlbum_ID]  DEFAULT ((0)) FOR [ImageAlbumID]
GO
ALTER TABLE [dbo].[Table_Image] ADD  CONSTRAINT [DF_Table_Image_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_ImageIcon] ADD  CONSTRAINT [DF_Table_ImageIcon_UpdateCount]  DEFAULT ((0)) FOR [UpdateCount]
GO
ALTER TABLE [dbo].[Table_ImageTemp] ADD  CONSTRAINT [DF_Table_ImageTemp_UpdateCount]  DEFAULT ((0)) FOR [UpdateCount]
GO
ALTER TABLE [dbo].[Table_StaticPage] ADD  CONSTRAINT [DF_Table_StaticPage_Title]  DEFAULT (N' ') FOR [Title]
GO
ALTER TABLE [dbo].[Table_StaticPage] ADD  CONSTRAINT [DF_Table_StaticPage_Keyword]  DEFAULT (N' ') FOR [Keyword]
GO
ALTER TABLE [dbo].[Table_StaticPage] ADD  CONSTRAINT [DF_Table_StaticPage_Description]  DEFAULT (N' ') FOR [Description]
GO
ALTER TABLE [dbo].[Table_StaticPage] ADD  CONSTRAINT [DF_Table_StaticPage_PageBody]  DEFAULT (N' ') FOR [PageBody]
GO
ALTER TABLE [dbo].[Table_SysEmailDetails] ADD  CONSTRAINT [DF_Table_EmailDetails_IsVerified]  DEFAULT (N'False') FOR [IsVerified]
GO
ALTER TABLE [dbo].[Table_SysEmailQueue] ADD  CONSTRAINT [DF_Table_EmailQueue_EmailBodyIsHTML]  DEFAULT (N'True') FOR [EmailBodyIsHTML]
GO
ALTER TABLE [dbo].[Table_SysEmailQueue] ADD  CONSTRAINT [DF_Table_EmailQueue_Status]  DEFAULT (N'Queued') FOR [Status]
GO
ALTER TABLE [dbo].[Table_SysEmailQueue] ADD  CONSTRAINT [DF_Table_EmailQueue_TrackerID]  DEFAULT ((0)) FOR [TrackerID]
GO
ALTER TABLE [dbo].[Table_SysEmailQueue] ADD  CONSTRAINT [DF_Table_EmailQueue_TrackedBack]  DEFAULT (N'False') FOR [TrackedBack]
GO
ALTER TABLE [dbo].[Table_Tag] ADD  CONSTRAINT [DF_Table_Tag_Description]  DEFAULT (N' ') FOR [Description]
GO
ALTER TABLE [dbo].[Table_Tag] ADD  CONSTRAINT [DF_Table_Tag_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_Tag] ADD  CONSTRAINT [DF_Table_Tag_Importance]  DEFAULT ((5)) FOR [Importance]
GO
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [DF_Table_User_UserType]  DEFAULT (N'Member') FOR [UserType]
GO
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [DF_Table_User_EmailVerified]  DEFAULT (N'No') FOR [EmailVerified]
GO
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [DF_Table_User_AccountStatus]  DEFAULT (N'Unverified') FOR [AccountStatus]
GO
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [DF_Table_User_Facebook_ID]  DEFAULT ((0)) FOR [Facebook_ID]
GO
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [DF_Table_User_Twitter_ID]  DEFAULT ((0)) FOR [Twitter_ID]
GO
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [DF_Table_User_Google_ID]  DEFAULT ((0)) FOR [Google_ID]
GO
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [DF_Table_User_ImageId]  DEFAULT ((11111111)) FOR [ImageID]
GO
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [DF_Table_User_BannerImageID]  DEFAULT ((11111112)) FOR [BannerImageID]
GO
ALTER TABLE [dbo].[Table_User] ADD  CONSTRAINT [DF_Table_User_IsSystemUser]  DEFAULT (N'False') FOR [IsSystemUser]
GO
ALTER TABLE [dbo].[Table_UserChat] ADD  CONSTRAINT [DF_Table_UserChat_Status]  DEFAULT (N'Active') FOR [Status]
GO
ALTER TABLE [dbo].[Table_UserChatMessage] ADD  CONSTRAINT [DF_Table_UserMessage_Chat_Id]  DEFAULT ((0)) FOR [ChatId]
GO
ALTER TABLE [dbo].[Table_UserChatMessage] ADD  CONSTRAINT [DF_Table_UserChatMessage_IsRead]  DEFAULT (N'False') FOR [IsRead]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_WallID]  DEFAULT ((0)) FOR [WallID]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_WallCommentID]  DEFAULT ((0)) FOR [WallCommentID]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_BlogID]  DEFAULT ((0)) FOR [BlogID]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_Question]  DEFAULT ((0)) FOR [QuestionID]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_QuestionAnswer]  DEFAULT ((0)) FOR [QuestionAnswerID]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_ForumID]  DEFAULT ((0)) FOR [ForumID]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_ForumTopicID]  DEFAULT ((0)) FOR [ForumTopicID]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_ImageID]  DEFAULT ((0)) FOR [ImageID]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_IsLike]  DEFAULT (N'True') FOR [IsLike]
GO
ALTER TABLE [dbo].[Table_UserLike] ADD  CONSTRAINT [DF_Table_UserLike_Vote]  DEFAULT ((1)) FOR [Vote]
GO
ALTER TABLE [dbo].[Table_UserNotification] ADD  CONSTRAINT [DF_Table_UserNotification_UserID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[Table_UserNotification] ADD  CONSTRAINT [DF_Table_UserNotification_TargetUrl]  DEFAULT (N' ') FOR [TargetUrl]
GO
ALTER TABLE [dbo].[Table_UserNotification] ADD  CONSTRAINT [DF_Table_UserNotification_ImageID]  DEFAULT ((0)) FOR [ImageID]
GO
ALTER TABLE [dbo].[Table_UserNotification] ADD  CONSTRAINT [DF_Table_UserNotification_Status]  DEFAULT (N'UnRead') FOR [Status]
GO
ALTER TABLE [dbo].[Table_UserNotificationEmail] ADD  CONSTRAINT [DF_Table_UserNotificationEmail_EmailEnabled]  DEFAULT (N'False') FOR [EmailEnabled]
GO
ALTER TABLE [dbo].[Table_UserNotificationEmail] ADD  CONSTRAINT [DF_Table_UserNotificationEmail_IntervalHour]  DEFAULT ((24)) FOR [IntervalHour]
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
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_Type]  DEFAULT (N'None') FOR [Preview_Type]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_ID]  DEFAULT ((0)) FOR [Preview_ID]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_Heading]  DEFAULT (N' ') FOR [Preview_Heading]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_TargetURL]  DEFAULT (N' ') FOR [Preview_TargetURL]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_ImageURL]  DEFAULT (N' ') FOR [Preview_ImageURL]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_Preview_Body]  DEFAULT (N' ') FOR [Preview_BodyText]
GO
ALTER TABLE [dbo].[Table_UserWall] ADD  CONSTRAINT [DF_Table_UserWall_ShowInHome]  DEFAULT (N'Pending') FOR [ShowInHome]
GO
ALTER TABLE [dbo].[Table_WebSetting] ADD  CONSTRAINT [DF_Table_WebSetting_SettingValue]  DEFAULT (N' ') FOR [SettingValue]
GO
ALTER TABLE [dbo].[Table_WebSetting] ADD  CONSTRAINT [DF_Table_WebSetting_DefaultSettingValue]  DEFAULT (N' ') FOR [DefaultValue]
GO
ALTER TABLE [dbo].[Table_WebSetting] ADD  CONSTRAINT [DF_Table_WebSetting_Type]  DEFAULT (N'Text') FOR [SettingType]
GO
ALTER TABLE [dbo].[Table_WebSetting] ADD  CONSTRAINT [DF_Table_WebSetting_Group]  DEFAULT (N'None') FOR [SettingGroup]
GO
ALTER TABLE [dbo].[Table_WebSetting] ADD  CONSTRAINT [DF_Table_WebSetting_About]  DEFAULT (N' ') FOR [About]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'[ Active | Closed | ClosedByAdmin | SuspendedByAdmin ]' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Table_Forum', @level2type=N'COLUMN',@level2name=N'Status'
GO