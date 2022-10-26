CREATE TABLE [dbo].[EventLog]
(
	[ID] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT (newid()), 
    [EventDate] DATETIME NOT NULL DEFAULT (getdate()), 
    [Description] NTEXT NULL 
)

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Уникальное обозначение версии изделия',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'EventLog',
    @level2type = N'COLUMN',
    @level2name = N'ID'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Дата совершения события',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'EventLog',
    @level2type = N'COLUMN',
    @level2name = N'EventDate'
GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'Описание события',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'EventLog',
    @level2type = N'COLUMN',
    @level2name = N'Description'
GO

CREATE NONCLUSTERED INDEX [IX_EventLog_EventDate] ON [dbo].[EventLog] ([EventDate])

GO
