CREATE PROCEDURE [dbo].[GetCommentsByUser]
	@UserId int
AS
BEGIN
	SELECT [Id],[CommentMessage],[DatePosted],[WorkItemId],[UserId]
	FROM [dbo].[Comments]
	WHERE [Comments].[UserId] = @UserId
	ORDER BY [Comments].[DatePosted]

END