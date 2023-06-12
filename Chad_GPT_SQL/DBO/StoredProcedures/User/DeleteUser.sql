CREATE PROCEDURE [dbo].[DeleteUser]
	@Id INT
AS
begin
	DELETE FROM dbo.[User]
	WHERE Id = @Id
end	