USE [master]
GO
/****** Object:  Database [Assignment8]    Script Date: 19/06/2018 09:17:19 PM ******/
CREATE DATABASE [Assignment8]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Assignment8', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Assignment8.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Assignment8_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Assignment8_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Assignment8] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Assignment8].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Assignment8] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Assignment8] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Assignment8] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Assignment8] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Assignment8] SET ARITHABORT OFF 
GO
ALTER DATABASE [Assignment8] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Assignment8] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Assignment8] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Assignment8] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Assignment8] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Assignment8] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Assignment8] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Assignment8] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Assignment8] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Assignment8] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Assignment8] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Assignment8] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Assignment8] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Assignment8] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Assignment8] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Assignment8] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Assignment8] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Assignment8] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Assignment8] SET  MULTI_USER 
GO
ALTER DATABASE [Assignment8] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Assignment8] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Assignment8] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Assignment8] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Assignment8] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Assignment8] SET QUERY_STORE = OFF
GO
USE [Assignment8]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Assignment8]
GO
/****** Object:  User [ali]    Script Date: 19/06/2018 09:17:19 PM ******/
CREATE USER [ali] FOR LOGIN [ali] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Files]    Script Date: 19/06/2018 09:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Files](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[parentfolderid] [int] NOT NULL,
	[fileext] [varchar](50) NOT NULL,
	[filesizeinkb] [int] NOT NULL,
	[uploadedon] [datetime] NOT NULL,
	[isactive] [bit] NOT NULL,
 CONSTRAINT [PK_Files] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Folder]    Script Date: 19/06/2018 09:17:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Folder](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[parentfolderid] [int] NOT NULL,
	[createdon] [datetime] NOT NULL,
	[isactive] [bit] NOT NULL,
 CONSTRAINT [PK_Folder] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 19/06/2018 09:17:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[login] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Files] ON 

INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (3, N'56936624-802e-4c99-a6ac-ed5f6300650a.jpg', 0, N'.jpg', 107696, CAST(N'2018-05-23T09:51:01.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (5, N'7919afb1-db58-44c5-8618-4385ba6bb29e.jpg', 9, N'.jpg', 107696, CAST(N'2018-05-23T09:53:02.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (6, N'43877268-dc98-4f42-88a4-79084b0eabde.txt', 9, N'.txt', 0, CAST(N'2018-05-23T09:55:04.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (7, N'a874577e-149a-4dfe-9a75-5bf09ce5f4f0.pdf', 3, N'.pdf', 2249, CAST(N'2018-05-23T10:23:53.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (9, N'0bda7ac4-d69d-4665-9aaa-da2cb050bc0f.pdf', 3, N'.pdf', 2249, CAST(N'2018-05-23T10:30:27.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (11, N'3fa4672b-d118-4e74-9722-3b5e526378b8.pdf', 3, N'.pdf', 431, CAST(N'2018-05-23T10:37:07.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (12, N'a9dfc705-fc59-4b01-8fb4-7d106111def6.pdf', 9, N'.pdf', 672, CAST(N'2018-05-23T11:23:17.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (13, N'9d23a358-0b98-4c3b-bc63-552d781c99dc.png', 10, N'.png', 308, CAST(N'2018-05-23T11:46:18.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (14, N'27316ef1-fe40-49f9-959a-cd9676f9d608.pdf', 22, N'.pdf', 672, CAST(N'2018-05-24T02:26:07.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (15, N'547515c3-91af-42e8-bab5-ec097934b41b.png', 20, N'.png', 308, CAST(N'2018-05-24T02:26:22.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (16, N'ee9919fd-ae4c-4b57-8b04-201d10dc2dab.png', 23, N'.png', 308, CAST(N'2018-05-24T02:26:58.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (17, N'0fc22259-7b3c-44c4-9630-83a84e1e7bcb.pdf', 25, N'.pdf', 431, CAST(N'2018-05-24T02:27:08.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (18, N'70f8c2e7-57e2-4de4-bcff-f5c4c7a5c46f.jpg', 23, N'.jpg', 33, CAST(N'2018-05-24T02:41:03.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (19, N'6b230f12-d807-4b7a-bc41-b9a7fd53023f.ppt', 23, N'.ppt', 1163, CAST(N'2018-05-24T02:42:25.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (20, N'bffd2cad-c71f-4e3c-8ad9-a9037dc75578.mp4', 24, N'.mp4', 650, CAST(N'2018-05-24T03:28:52.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (21, N'b0553df1-2275-432e-b85e-e65682d90765.txt', 21, N'.txt', 0, CAST(N'2018-05-24T03:29:09.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (22, N'a096550c-0f38-4089-86dc-03c1d271b793.mp4', 0, N'.mp4', 650, CAST(N'2018-05-24T03:29:27.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (23, N'2c2d1c53-37da-4fd0-9a8b-0dd45568a3d4.txt', 0, N'.txt', 0, CAST(N'2018-05-24T03:29:40.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (24, N'27ab8067-1554-4dc1-bcac-fc4ce0e8fb50.docx', 0, N'.docx', 252, CAST(N'2018-05-24T03:30:22.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (25, N'f1297683-6c9c-4e12-90d1-90d4d5f06291.xlsx', 0, N'.xlsx', 8, CAST(N'2018-05-24T03:31:08.000' AS DateTime), 1)
INSERT [dbo].[Files] ([id], [name], [parentfolderid], [fileext], [filesizeinkb], [uploadedon], [isactive]) VALUES (26, N'dc06b7b1-07d8-42a0-8818-7266788459e7.pdf', 0, N'.pdf', 672, CAST(N'2018-05-24T03:31:36.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Files] OFF
SET IDENTITY_INSERT [dbo].[Folder] ON 

INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (1, N'my', 0, CAST(N'2018-05-21T01:35:48.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (6, N'new folder', 1, CAST(N'2018-05-21T02:54:39.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (7, N'Last', 1, CAST(N'2018-05-23T05:57:37.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (8, N'folder2', 1, CAST(N'2018-05-23T06:34:20.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (9, N'pics', 2, CAST(N'2018-05-23T06:41:14.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (10, N'videos', 2, CAST(N'2018-05-23T06:41:20.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (11, N'Folder', 5, CAST(N'2018-05-23T07:50:50.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (12, N'files', 4, CAST(N'2018-05-23T09:16:11.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (13, N'files', 4, CAST(N'2018-05-23T09:16:19.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (14, N'New Folder', 3, CAST(N'2018-05-23T10:37:31.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (15, N'folder', 10, CAST(N'2018-05-23T11:46:05.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (16, N'new folder ', 14, CAST(N'2018-05-24T12:30:59.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (17, N'options', 6, CAST(N'2018-05-24T12:35:44.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (18, N'new options', 17, CAST(N'2018-05-24T12:39:53.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (19, N'my options', 18, CAST(N'2018-05-24T12:41:02.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (20, N'New Folder', 0, CAST(N'2018-05-24T02:25:16.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (21, N'Document', 0, CAST(N'2018-05-24T02:25:30.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (22, N'Data', 20, CAST(N'2018-05-24T02:25:57.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (23, N'pics', 21, CAST(N'2018-05-24T02:26:39.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (24, N'videos', 21, CAST(N'2018-05-24T02:26:45.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (25, N'pdf', 21, CAST(N'2018-05-24T02:26:51.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (26, N'My Folder', 0, CAST(N'2018-05-24T04:27:30.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (27, N'doc', 26, CAST(N'2018-05-24T04:28:20.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (2008, N'm', 2007, CAST(N'2018-06-19T08:41:54.000' AS DateTime), 1)
INSERT [dbo].[Folder] ([id], [name], [parentfolderid], [createdon], [isactive]) VALUES (2009, N'NEW FOLDER', 0, CAST(N'2018-06-19T08:44:17.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Folder] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [name], [login], [password], [email]) VALUES (1, N'user', N'user', N'user', N'user@gmail.com')
SET IDENTITY_INSERT [dbo].[users] OFF
USE [master]
GO
ALTER DATABASE [Assignment8] SET  READ_WRITE 
GO
