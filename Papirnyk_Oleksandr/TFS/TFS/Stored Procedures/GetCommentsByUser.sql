CREATE PROCEDURE [dbo].[GetCommentsByUser]
	@UserId int
AS
BEGIN
	SET NOCOUNT ON;
	(SELECT Id,CommentMessage,DatePosted AS DateOfPost,TaskId AS WorkItemId, 'Task' AS WorkItem, @UserId AS UserId
	FROM [TaskComments] TC
	WHERE TC.UserId = @UserId
	UNION
	SELECT Id,CommentMessage,DatePosted AS DateOfPost,BugId AS WorkItemId, 'Bug' AS WorkItem, @UserId AS UserId
	FROM [BugComments] BC
	WHERE BC.UserId = @UserId
	UNION
	SELECT Id,CommentMessage,DatePosted AS DateOfPost,UserStoryId AS WorkItemId, 'UserStory' AS WorkItem, @UserId AS UserId
	FROM [UserStoryComments] UC
	WHERE UC.UserId = @UserId)
	ORDER BY DateOfPost
END
