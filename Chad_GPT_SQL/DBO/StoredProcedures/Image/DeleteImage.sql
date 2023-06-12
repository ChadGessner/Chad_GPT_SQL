CREATE PROCEDURE [dbo].[DeleteImage]
	@Id INT
AS
begin
	DELETE FROM dbo.[Image]
	WHERE Id = @Id
end
