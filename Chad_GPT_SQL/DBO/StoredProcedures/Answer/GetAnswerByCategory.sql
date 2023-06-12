CREATE PROCEDURE [dbo].[GetAnswerByCategory]
	@CategoryId INT
AS
begin
	SELECT 
		Id,
		Prompt,
		Answer,
		CategoryId,
		CreatedBy,
		CreatedOn

	FROM dbo.[Answer]
	WHERE CategoryId = @CategoryId
end
