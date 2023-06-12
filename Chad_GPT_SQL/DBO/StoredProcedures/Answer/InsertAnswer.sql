CREATE PROCEDURE [dbo].[InsertAnswer]
	@Prompt NVARCHAR(MAX),
	@Answer NVARCHAR(MAX),
	@CategoryId INT,
	@CreatedBy INT,
	@CreatedOn DATE
	
AS
begin
	INSERT INTO dbo.Answer (
	Prompt, 
	Answer, 
	CategoryId, 
	CreatedBy, 
	CreatedOn
	)
	VALUES (
		@Prompt,
		@Answer,
		@CategoryId,
		@CreatedBy,
		@CreatedOn
	)
end
