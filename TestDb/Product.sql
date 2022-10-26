CREATE TABLE [dbo].[Product]
(
	[ID] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT newid(), 
    [Name] NCHAR(255) NOT NULL, 
    [Description] NTEXT NULL, 
    CONSTRAINT [FK_Product_ProductVersion] FOREIGN KEY ([ID]) REFERENCES [ProductVersion]([ProductID]) ON DELETE CASCADE
    
)

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Уникальное обозначение изделия',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Product',
    @level2type = N'COLUMN',
    @level2name = N'ID'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Наименование изделия',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Product',
    @level2type = N'COLUMN',
    @level2name = N'Name'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Описание изделия',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'Product',
    @level2type = N'COLUMN',
    @level2name = N'Description'
GO


CREATE UNIQUE NONCLUSTERED INDEX [U_name] ON [dbo].[Product] ([Name])
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, 
ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


CREATE TRIGGER [dbo].[Trigger_Product]
    ON [dbo].[Product]
    FOR DELETE, INSERT, UPDATE
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