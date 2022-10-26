CREATE TABLE [dbo].[ProductVersion]
(
	[ID] UNIQUEIDENTIFIER NOT NULL  DEFAULT newid(), 
    [ProductID] UNIQUEIDENTIFIER NOT NULL, 
    [Name] NCHAR(255) NOT NULL, 
    [Description] NTEXT NULL, 
    [CreatingDate] DATETIME NOT NULL, 
    [Width] [dbo].[ubigint] NOT NULL, 
    [Height] [dbo].[ubigint] NOT NULL, 
    [Length] [dbo].[ubigint] NOT NULL, 
    
)

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Уникальное обозначение версии изделия',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ProductVersion',
    @level2type = N'COLUMN',
    @level2name = N'ID'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Уникальное обозначение изделия к которому относится версия издения',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ProductVersion',
    @level2type = N'COLUMN',
    @level2name = N'ProductID'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Наименование версии изделия',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ProductVersion',
    @level2type = N'COLUMN',
    @level2name = N'Name'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Описание версии изделия',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ProductVersion',
    @level2type = N'COLUMN',
    @level2name = N'Description'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Дата создания версии изделия',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ProductVersion',
    @level2type = N'COLUMN',
    @level2name = N'CreatingDate'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Габаритная ширина изделия в миллиметрах',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ProductVersion',
    @level2type = N'COLUMN',
    @level2name = N'Width'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Габаритная высота изделия в миллиметрах',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ProductVersion',
    @level2type = N'COLUMN',
    @level2name = N'Height'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Габаритная длина изделия в миллиметрах',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'ProductVersion',
    @level2type = N'COLUMN',
    @level2name = N'Length'
GO

CREATE NONCLUSTERED INDEX [Ix_Name] ON [dbo].[ProductVersion] ([Name])

GO

CREATE NONCLUSTERED INDEX [IxCreatingDate] ON [dbo].[ProductVersion] ([CreatingDate])

GO

CREATE NONCLUSTERED INDEX [IxWidth] ON [dbo].[ProductVersion] ([Width])

GO

CREATE NONCLUSTERED INDEX [IxHeight] ON [dbo].[ProductVersion] ([Height])

GO

CREATE INDEX [IxLength] ON [dbo].[ProductVersion] ([Length])

GO

CREATE TRIGGER [dbo].[Trigger_ProductVersion]
    ON [dbo].[ProductVersion]
    FOR DELETE, INSERT, UPDATE
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