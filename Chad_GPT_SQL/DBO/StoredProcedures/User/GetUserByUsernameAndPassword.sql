CREATE PROCEDURE [dbo].[GetUserByUsernameAndPassword]
	@UserName NVARCHAR(40),
	@Password NVARCHAR(40)
AS
begin
	SELECT Id, UserName, [Password]
	FROM [dbo].[User]
	WHERE UserName = @UserName AND [Password] = @Password
end
