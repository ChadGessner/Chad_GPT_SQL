CREATE PROCEDURE [dbo].[UpdateUser]
	@Id INT,
	@UserName NVARCHAR(40),
	@Password NVARCHAR(40)
AS
begin
	UPDATE dbo.[User] 
	SET UserName = @UserName,
	[Password] = @Password
	WHERE Id = @Id
end
