CREATE PROCEDURE [dbo].[ProjectDelete]
	@id uniqueidentifier
AS
BEGIN
	SET NOCOUNT OFF;
	DELETE FROM Product
	WHERE  (ID = @id)
END
