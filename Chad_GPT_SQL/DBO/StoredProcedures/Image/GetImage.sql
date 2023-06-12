CREATE PROCEDURE [dbo].[GetImage]
	@Id INT
AS
begin
	SELECT 1 FROM dbo.[Image]
	WHERE Id = @Id
end
