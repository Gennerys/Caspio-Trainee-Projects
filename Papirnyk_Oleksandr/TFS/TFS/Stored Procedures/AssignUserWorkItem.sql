CREATE PROCEDURE [dbo].[AssignUserWorkItem]
	@WorkItemType VARCHAR(100),
	@WorkItemId int,
	@UserId int
AS
	IF (@WorkItemType = 'Task')
BEGIN
	UPDATE [TFS].[dbo].[Task]
	SET [Task].[UserId] = @UserId
	WHERE [Task].[Id] = @WorkItemId
END
	IF (@WorkItemType = 'UserStory')
BEGIN
	UPDATE [TFS].[dbo].[UserStory]
	SET [UserStory].[UserId] = @UserId
	WHERE [UserStory].[Id] = @WorkItemId
END
	IF (@WorkItemType = 'Bug')
BEGIN
	UPDATE [TFS].[dbo].[Bug]
	SET [Bug].[UserId] = @UserId
	WHERE [Bug].[Id] = @WorkItemId
END