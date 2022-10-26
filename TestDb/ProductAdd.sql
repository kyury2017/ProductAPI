CREATE PROCEDURE [dbo].[ProductAdd]
	@name nchar(255),
	@description ntext
AS
BEGIN
	SET NOCOUNT OFF;
	INSERT INTO Product (Name, Description) VALUES (@name,@description)
END
