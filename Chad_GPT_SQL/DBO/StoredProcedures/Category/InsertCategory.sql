CREATE PROCEDURE [dbo].[InsertCategory]
	@CategoryName NVARCHAR(100),
	@Type INT
AS

begin
	INSERT INTO dbo.Category (CategoryName, [Type])
	VALUES(
		@CategoryName,
		@Type
	)
end
