CREATE PROCEDURE [dbo].[InsertImage]
	@Prompt NVARCHAR(MAX),
	@URL NVARCHAR(MAX),
	@CategoryId INT
AS
begin
	INSERT INTO dbo.[Image] (Prompt, [URL], CategoryId)
	VALUES (
		@Prompt,
		@URL,
		@CategoryId
	)
end
