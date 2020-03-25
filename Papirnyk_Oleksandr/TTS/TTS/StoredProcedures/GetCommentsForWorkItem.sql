CREATE PROCEDURE [dbo].[GetCommentsForWorkItem]
	@WorkItemId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM [dbo].[Comments]
	WHERE [Comments].[WorkItemId] = @WorkItemId
	ORDER BY [Comments].DatePosted
END
