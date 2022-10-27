CREATE PROCEDURE [dbo].[ProductDelete]
	@id uniqueidentifier
AS
BEGIN
	SET NOCOUNT OFF;
	DELETE FROM Product
	WHERE  (ID = @id)
END
