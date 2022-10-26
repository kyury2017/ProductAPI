CREATE VIEW [dbo].[vEventLog]
	AS 
SELECT        ID, ProductID, Name, Description, CreatingDate, Width, Height, Length
FROM            dbo.ProductVersion
