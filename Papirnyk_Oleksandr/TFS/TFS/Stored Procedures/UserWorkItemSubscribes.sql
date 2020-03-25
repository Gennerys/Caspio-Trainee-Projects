CREATE PROCEDURE [dbo].[UserWorkItemSubscribes]
	@WorkItemType VARCHAR(100),
	@UserId int
AS
	IF (@WorkItemType = 'Task')
BEGIN
	SELECT * 
	FROM [TFS].[dbo].[SubscribedToTask]
	WHERE [SubscribedToTask].[UserId] = @UserId
END
	IF (@WorkItemType = 'UserStory')
BEGIN
	SELECT *
	FROM [TFS].[dbo].[SubscribedToUserStory]
	WHERE [SubscribedToUserStory].[UserId] = @UserId
END
	IF (@WorkItemType = 'Bug')
BEGIN
	SELECT *
	FROM [TFS].[dbo].[SubscribedToBug]
	WHERE [SubscribedToBug].[UserId] = @UserId
END