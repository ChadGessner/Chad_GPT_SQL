CREATE PROCEDURE [dbo].[DeleteAnswer]
	@Id INT
AS
begin
	DELETE FROM dbo.[Answer]
	WHERE Id = @Id
end
