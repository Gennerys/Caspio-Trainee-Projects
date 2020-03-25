CREATE PROCEDURE [dbo].[PostComment]
	@CommentMessage VARCHAR(500),
	@WorkItemId INT,
	@UserId INT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[Comments] (CommentMessage,WorkItemId,UserId)
	VALUES (@CommentMessage,@WorkItemId,@UserId)
END
