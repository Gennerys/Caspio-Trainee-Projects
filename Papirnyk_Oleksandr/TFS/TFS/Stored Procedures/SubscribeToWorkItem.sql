CREATE PROCEDURE [dbo].[SubscribeToWorkItem]
	@WorkItemType VARCHAR(100),
	@WorkItemId int,
	@UserId int
AS
	IF (@WorkItemType = 'Task')
BEGIN
	INSERT INTO [TFS].[dbo].[SubscribedToTask]
	VALUES (@WorkItemId,@UserId)
END
	IF (@WorkItemType = 'UserStory')
BEGIN
	INSERT INTO [TFS].[dbo].[SubscribedToUserStory]
	VALUES (@WorkItemId,@UserId)
END
	IF (@WorkItemType = 'Bug')
BEGIN
	INSERT INTO [TFS].[dbo].[SubscribedToBug]
	VALUES (@WorkItemId,@UserId)
END