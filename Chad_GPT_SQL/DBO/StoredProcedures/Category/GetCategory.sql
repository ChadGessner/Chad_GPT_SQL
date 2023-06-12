CREATE PROCEDURE [dbo].[GetCategory]
	@Id INT
AS
begin 
	SELECT 1 FROM dbo.[Category]
	WHERE Id = @Id
end
