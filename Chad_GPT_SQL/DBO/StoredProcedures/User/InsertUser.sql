CREATE PROCEDURE [dbo].[InsertUser]
	@UserName NVARCHAR(40),
	@Password NVARCHAR(40)
AS
begin 
	INSERT INTO dbo.[User] (UserName, [Password])
	VALUES(
		@UserName,
		@Password
	)
end
