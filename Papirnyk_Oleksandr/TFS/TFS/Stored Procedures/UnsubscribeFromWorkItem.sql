CREATE PROCEDURE [dbo].[UnsubscribeFromWorkItem]
	@WorkItemType VARCHAR(100),
	@WorkItemId int,
	@UserId int
AS
	IF (@WorkItemType = 'Task')
BEGIN
	DELETE FROM [TFS].[dbo].[SubscribedToTask]
	WHERE [SubscribedToTask].[TaskId] = @WorkItemId
	AND [SubscribedToTask].[UserId] = @UserId
END
	IF (@WorkItemType = 'UserStory')
BEGIN
	DELETE FROM [TFS].[dbo].[SubscribedToUserStory]
	WHERE [SubscribedToUserStory].[UserStoryId] = @WorkItemId
	AND [SubscribedToUserStory].[UserId] = @UserId
END
	IF (@WorkItemType = 'Bug')
BEGIN
	DELETE  FROM [TFS].[dbo].[SubscribedToBug]
	WHERE [SubscribedToBug].[BugId] = @WorkItemId
	AND [SubscribedToBug].[UserId] = @UserId
END