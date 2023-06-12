CREATE PROCEDURE [dbo].[GetUser]
	@Id INT
AS
begin
	SELECT Id, UserName, [Password] 
	FROM dbo.[User]
	WHERE Id = @Id
end
