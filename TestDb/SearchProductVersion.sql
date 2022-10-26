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