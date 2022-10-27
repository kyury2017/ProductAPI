CREATE PROCEDURE [dbo].[ProductChenge]
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
