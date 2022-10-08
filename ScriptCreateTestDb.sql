USE [master]
GO
CREATE DATABASE [TestDb] 
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TestDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TestDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TestDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestDb] SET RECOVERY FULL 
GO
ALTER DATABASE [TestDb] SET  MULTI_USER 
GO
ALTER DATABASE [TestDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TestDb', N'ON'
GO
ALTER DATABASE [TestDb] SET QUERY_STORE = OFF
GO
USE [TestDb]
GO
/****** Object:  Rule [Checkubigint]    Script Date: 04.10.2022 12:29:02 ******/
CREATE RULE [dbo].[Checkubigint] 
AS
@ubigint> -1
GO
/****** Object:  UserDefinedDataType [dbo].[ubigint]    Script Date: 04.10.2022 12:29:02 ******/
CREATE TYPE [dbo].[ubigint] FROM [bigint] NOT NULL
GO
/****** Object:  UserDefinedFunction [dbo].[SearchProductVersion]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SearchProductVersion] 
(
	@nameProduct nvarchar(255), 
	@nameProductVersion nvarchar(255),
	@minVolume bigint,
	@maxVolume bigint 
)
RETURNS 
@SerchResult TABLE 
(
	ProductVertionID uniqueidentifier,
	ProductName nvarchar(255), 
	ProductVersionName nvarchar(255), 
	Width bigint, 
	[Length] bigint, 
	Height bigint 
)
AS
BEGIN
	SET @nameProduct = '%'+RTRIM(@nameProduct) + '%';
	SET @nameProductVersion = '%'+RTRIM(@nameProductVersion) + '%';
	INSERT @SerchResult
	SELECT  
	pv.ID AS ProductVertionID, 
	p.Name AS ProductName, 
	pv.Name AS ProductVersionName, 
	pv.Width AS Width, 
	pv.Length AS [Length], 
	pv.Height AS Height 
	FROM dbo.Product AS p LEFT OUTER JOIN
                         dbo.ProductVersion AS pv ON p.ID = pv.ProductID
	WHERE p.Name LIKE @nameProduct AND pv.Name LIKE @nameProductVersion 
	AND pv.Length*pv.Width*pv.Height>@minVolume AND pv.Length*pv.Width*pv.Height< @maxVolume
	
	RETURN 
END
GO
/****** Object:  Table [dbo].[Product]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nchar](255) NOT NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vProduct]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vProduct]
AS
SELECT        ID, Name, Description
FROM            dbo.Product
GO
/****** Object:  Table [dbo].[ProductVersion]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductVersion](
	[ID] [uniqueidentifier] NOT NULL,
	[ProductID] [uniqueidentifier] NOT NULL,
	[Name] [nchar](255) NOT NULL,
	[Description] [ntext] NULL,
	[CreatingDate] [datetime] NOT NULL,
	[Width] [dbo].[ubigint] NOT NULL,
	[Height] [dbo].[ubigint] NOT NULL,
	[Length] [dbo].[ubigint] NOT NULL,
 CONSTRAINT [PK_ProductVersion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vProductVersions]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vProductVersions]
AS
SELECT        ID, ProductID, Name, Description, CreatingDate, Width, Height, Length
FROM            dbo.ProductVersion
GO
/****** Object:  View [dbo].[vProductFull]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vProductFull]
AS
SELECT        dbo.Product.ID AS ProductID, dbo.Product.Name AS ProductName, dbo.ProductVersion.ID AS ProductVrtionID, dbo.ProductVersion.Name AS ProductVrtionName, dbo.ProductVersion.CreatingDate, dbo.ProductVersion.Width, 
                         dbo.ProductVersion.Height, dbo.ProductVersion.Length
FROM            dbo.Product LEFT OUTER JOIN
                         dbo.ProductVersion ON dbo.Product.ID = dbo.ProductVersion.ProductID
GO
/****** Object:  Table [dbo].[EventLog]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLog](
	[ID] [uniqueidentifier] NOT NULL,
	[EventDate] [datetime] NOT NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IxEventDate]    Script Date: 04.10.2022 12:29:02 ******/
CREATE NONCLUSTERED INDEX [IxEventDate] ON [dbo].[EventLog]
(
	[EventDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_Name]    Script Date: 04.10.2022 12:29:02 ******/
CREATE UNIQUE NONCLUSTERED INDEX [U_Name] ON [dbo].[Product]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IxCreatingDate]    Script Date: 04.10.2022 12:29:02 ******/
CREATE NONCLUSTERED INDEX [IxCreatingDate] ON [dbo].[ProductVersion]
(
	[CreatingDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IxHeight]    Script Date: 04.10.2022 12:29:02 ******/
CREATE NONCLUSTERED INDEX [IxHeight] ON [dbo].[ProductVersion]
(
	[Height] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IxLength]    Script Date: 04.10.2022 12:29:02 ******/
CREATE NONCLUSTERED INDEX [IxLength] ON [dbo].[ProductVersion]
(
	[Length] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IxName]    Script Date: 04.10.2022 12:29:02 ******/
CREATE NONCLUSTERED INDEX [IxName] ON [dbo].[ProductVersion]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IxWidth]    Script Date: 04.10.2022 12:29:02 ******/
CREATE NONCLUSTERED INDEX [IxWidth] ON [dbo].[ProductVersion]
(
	[Width] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventLog] ADD  CONSTRAINT [DF_EventLog_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[EventLog] ADD  CONSTRAINT [DF_EventLog_EventDate]  DEFAULT (getdate()) FOR [EventDate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[ProductVersion] ADD  CONSTRAINT [DF_ProductVersion_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[ProductVersion] ADD  CONSTRAINT [DF_ProductVersion_CreatingDate]  DEFAULT (getdate()) FOR [CreatingDate]
GO
ALTER TABLE [dbo].[ProductVersion]  WITH CHECK ADD  CONSTRAINT [FK_ProductVersion_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductVersion] CHECK CONSTRAINT [FK_ProductVersion_Product]
GO
/****** Object:  StoredProcedure [dbo].[ProductAdd]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProductAdd]
	@name nchar(255),
	@description ntext
AS
BEGIN
	SET NOCOUNT OFF;
	INSERT INTO Product (Name, Description) VALUES (@name,@description)
END
GO
/****** Object:  StoredProcedure [dbo].[ProjectChenge]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ProjectChenge] 
	@id uniqueidentifier, 
	@name nchar(255),
	@description ntext
AS
BEGIN
	SET NOCOUNT OFF;
	UPDATE Product 
	SET Name=@name, Description =@description 
	WHERE ID=@id
END
GO
/****** Object:  StoredProcedure [dbo].[ProjectDelete]    Script Date: 04.10.2022 12:29:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProjectDelete] 
	@id uniqueidentifier
AS
BEGIN
	SET NOCOUNT OFF;
	DELETE FROM Product
	WHERE  (ID = @id)
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Уникальное обозначение изделия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Наименование изделия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Описание изделия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Уникальное обозначение версии изделия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductVersion', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Уникальное обозначение изделия к которому относится версия издения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductVersion', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Наименование версии изделия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductVersion', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Описание версии изделия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductVersion', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Дата создания версии изделия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductVersion', @level2type=N'COLUMN',@level2name=N'CreatingDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Габаритная ширина изделия в миллиметрах' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductVersion', @level2type=N'COLUMN',@level2name=N'Width'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Габаритная высота изделия в миллиметрах' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductVersion', @level2type=N'COLUMN',@level2name=N'Height'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Габаритная длина изделия в миллиметрах' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ProductVersion', @level2type=N'COLUMN',@level2name=N'Length'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product"
            Begin Extent = 
               Top = 51
               Left = 32
               Bottom = 170
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductVersion"
            Begin Extent = 
               Top = 41
               Left = 449
               Bottom = 272
               Right = 623
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1425
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProductFull'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProductFull'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ProductVersion"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 212
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProductVersions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vProductVersions'
GO
USE [master]
GO
ALTER DATABASE [TestDb] SET  READ_WRITE 
GO
-- Add Test Data
print('Add Test data.')

USE TestDb

DECLARE @pID uniqueidentifier;
SET @pID = NEWID();
INSERT INTO Product (ID, Name, Description) VALUES (@pID,'Name 01',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 5,7,9)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 15,17,19)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 02',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 25,27,29)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 35,37,39)

SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 03',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 45,47,49)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 55,57,59)

SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 04',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 65,67,69)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 75,77,79)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 05',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 85,87,89)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 95,97,99)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 06',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 3,5,7)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 13,15,17)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 07',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 23,25,27)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 33,35,37)

SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 08',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 43,45,47)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 53,55,57)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 09',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 63,65,67)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 73,75,77)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 10',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 83,85,87)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 93,95,97)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 11',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 5,7,9)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 15,17,19)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 12',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 25,27,29)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 35,37,39)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 13',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 55,57,59)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 65,67,69)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 14',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 75,77,79)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 85,87,89)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 15',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 95,97,99)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 95,97,199)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 16',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 105,107,199)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 195,197,200)
SET @pID = NEWID();
INSERT INTO Product (ID,Name, Description) VALUES (@pID,'Name 17',NULL)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 01', NULL, 115,117,200)
		INSERT INTO ProductVersion (ProductID, Name, Description, Width, Height, Length) VALUES (@pID,'Version 02', NULL, 205,207,210)

-- Create Trigger for Product
print('Create triggers.')

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[OnProductChangeWriter] ON [dbo].[Product]
   FOR INSERT, UPDATE, DELETE  
AS 
IF(@@ROWCOUNT = 0) 
RETURN 

IF (SELECT COUNT(*) from inserted) <> 0
BEGIN
	IF((select count(*) from deleted) = 0)
	BEGIN
		INSERT INTO EventLog (Description) SELECT  'insert Product ID={'+CONVERT(nchar(200), inserted.ID)+'}' FROM inserted 
		RETURN
	END
	ELSE
	BEGIN
		INSERT INTO EventLog (Description) SELECT  'update Product ID={'+CONVERT(nchar(200), inserted.ID)+'}' FROM inserted 
	END
END
ELSE
BEGIN
	INSERT INTO EventLog (Description) SELECT  'delete Product ID={'+CONVERT(nchar(200), deleted.ID)+'}' FROM    deleted
END
GO

ALTER TABLE [dbo].[Product] ENABLE TRIGGER [OnProductChangeWriter]
GO
-- Create Trigger for ProductVersion

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[OnProductVersionChangeWriter] ON [dbo].[ProductVersion]
  FOR INSERT, UPDATE, DELETE
AS 
IF(@@ROWCOUNT = 0) 
RETURN 

IF (SELECT COUNT(*) from inserted) <> 0
BEGIN
	IF((select count(*) from deleted) = 0)
	BEGIN
		INSERT INTO EventLog (Description) SELECT  'insert ProductVersion ID={'+CONVERT(nchar(200), inserted.ID)+'}' FROM inserted    
		RETURN
	END
	ELSE
	BEGIN
		INSERT INTO EventLog (Description) SELECT  'update ProductVersion ID={'+CONVERT(nchar(200), inserted.ID)+'}' FROM inserted    
		RETURN
	END
END
ELSE
BEGIN
	INSERT INTO EventLog (Description) SELECT  'delete ProductVersion ID={'+CONVERT(nchar(200), deleted.ID)+'}' FROM    deleted 
END
GO

ALTER TABLE [dbo].[ProductVersion] ENABLE TRIGGER [OnProductVersionChangeWriter]
GO
