CREATE PROCEDURE [dbo].[GetCommentsBug]
	@BugId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM [TFS].[dbo].[Bug_Comments]
	WHERE [Bug_Comments].[BugId] = @BugId
	ORDER BY [Bug_Comments].[DatePosted]
END
