CREATE PROCEDURE [dbo].[GetImageByCategory]
	@CategoryId INT
AS
begin
	SELECT Id, Prompt, [URL], CategoryId FROM dbo.[Image]
	WHERE CategoryId = @CategoryId
	ORDER BY Id
end
