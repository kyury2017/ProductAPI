CREATE VIEW [dbo].[vProductFull]
	AS 
	SELECT        dbo.Product.ID AS ProductID, dbo.Product.Name AS ProductName, dbo.ProductVersion.ID AS ProductVrtionID, dbo.ProductVersion.Name AS ProductVrtionName, dbo.ProductVersion.CreatingDate, dbo.ProductVersion.Width, 
                         dbo.ProductVersion.Height, dbo.ProductVersion.Length
FROM            dbo.Product LEFT OUTER JOIN
                         dbo.ProductVersion ON dbo.Product.ID = dbo.ProductVersion.ProductID
