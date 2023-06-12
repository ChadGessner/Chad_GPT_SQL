CREATE PROCEDURE [dbo].[GetAnswer]
	@Id INT
AS
begin
	SELECT 1 FROM dbo.[Answer]
	WHERE Id = @Id
end
