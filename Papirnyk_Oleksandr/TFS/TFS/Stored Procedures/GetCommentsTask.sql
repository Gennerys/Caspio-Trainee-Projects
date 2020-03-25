CREATE PROCEDURE [dbo].[GetCommentsTask]
	@TaskId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM [TFS].[dbo].[Task_Comments]
	WHERE [Task_Comments].[TaskId] = @TaskId
	ORDER BY [Task_Comments].[DatePosted]
END
