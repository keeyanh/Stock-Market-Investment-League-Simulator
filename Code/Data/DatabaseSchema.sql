USE [master]
GO
/****** Object:  Database [ducklabdb]    Script Date: 5/3/2019 2:24:40 PM ******/
CREATE DATABASE [ducklabdb]
GO
ALTER DATABASE [ducklabdb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ducklabdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ducklabdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ducklabdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ducklabdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ducklabdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ducklabdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [ducklabdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ducklabdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ducklabdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ducklabdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ducklabdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ducklabdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ducklabdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ducklabdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ducklabdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ducklabdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ducklabdb] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [ducklabdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ducklabdb] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [ducklabdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ducklabdb] SET  MULTI_USER 
GO
ALTER DATABASE [ducklabdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ducklabdb] SET ENCRYPTION ON
GO
ALTER DATABASE [ducklabdb] SET QUERY_STORE = ON
GO
ALTER DATABASE [ducklabdb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 7), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 10, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [ducklabdb]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 5/3/2019 2:24:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[companyID] [int] IDENTITY(1,1) NOT NULL,
	[companyName] [varchar](200) NULL,
	[companySymbol] [varchar](50) NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[companyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyStock]    Script Date: 5/3/2019 2:24:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyStock](
	[companyStockId] [int] IDENTITY(1,1) NOT NULL,
	[companyId] [int] NOT NULL,
	[stockTime] [datetime] NULL,
	[stockPrice] [decimal](18, 2) NULL,
	[isOpen] [bit] NULL,
 CONSTRAINT [PK_CompanyStock] PRIMARY KEY CLUSTERED 
(
	[companyStockId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Game]    Script Date: 5/3/2019 2:24:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Game](
	[gameId] [int] IDENTITY(1,1) NOT NULL,
	[gameType] [varchar](100) NULL,
	[gameName] [varchar](200) NULL,
	[adminId] [int] NOT NULL,
	[gameStatus] [nchar](10) NULL,
	[startingBalance] [decimal](18, 2) NULL,
	[endDate] [datetime] NULL,
	[profitGoal] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Game] PRIMARY KEY CLUSTERED 
(
	[gameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GameUser]    Script Date: 5/3/2019 2:24:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameUser](
	[gameUserId] [int] IDENTITY(1,1) NOT NULL,
	[gameId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[availableBalance] [decimal](18, 2) NULL,
 CONSTRAINT [PK_GameUser] PRIMARY KEY CLUSTERED 
(
	[gameUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/3/2019 2:24:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserStock]    Script Date: 5/3/2019 2:24:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserStock](
	[userStockId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[gameId] [int] NOT NULL,
	[companyId] [int] NOT NULL,
	[timePurchased] [datetime] NULL,
	[quantityPurchased] [int] NULL,
 CONSTRAINT [PK_UserStock] PRIMARY KEY CLUSTERED 
(
	[userStockId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyStock]  WITH CHECK ADD  CONSTRAINT [FK_CompanyStock_Company] FOREIGN KEY([companyId])
REFERENCES [dbo].[Company] ([companyID])
GO
ALTER TABLE [dbo].[CompanyStock] CHECK CONSTRAINT [FK_CompanyStock_Company]
GO
ALTER TABLE [dbo].[Game]  WITH CHECK ADD  CONSTRAINT [FK_Game_User] FOREIGN KEY([adminId])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[Game] CHECK CONSTRAINT [FK_Game_User]
GO
ALTER TABLE [dbo].[GameUser]  WITH CHECK ADD  CONSTRAINT [FK_GameUser_Game] FOREIGN KEY([gameId])
REFERENCES [dbo].[Game] ([gameId])
GO
ALTER TABLE [dbo].[GameUser] CHECK CONSTRAINT [FK_GameUser_Game]
GO
ALTER TABLE [dbo].[GameUser]  WITH CHECK ADD  CONSTRAINT [FK_GameUser_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[GameUser] CHECK CONSTRAINT [FK_GameUser_User]
GO
ALTER TABLE [dbo].[UserStock]  WITH CHECK ADD  CONSTRAINT [FK_UserStock_Company] FOREIGN KEY([companyId])
REFERENCES [dbo].[Company] ([companyID])
GO
ALTER TABLE [dbo].[UserStock] CHECK CONSTRAINT [FK_UserStock_Company]
GO
ALTER TABLE [dbo].[UserStock]  WITH CHECK ADD  CONSTRAINT [FK_UserStock_Game] FOREIGN KEY([gameId])
REFERENCES [dbo].[Game] ([gameId])
GO
ALTER TABLE [dbo].[UserStock] CHECK CONSTRAINT [FK_UserStock_Game]
GO
ALTER TABLE [dbo].[UserStock]  WITH CHECK ADD  CONSTRAINT [FK_UserStock_User] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[UserStock] CHECK CONSTRAINT [FK_UserStock_User]
GO
USE [master]
GO
ALTER DATABASE [ducklabdb] SET  READ_WRITE 
GO
