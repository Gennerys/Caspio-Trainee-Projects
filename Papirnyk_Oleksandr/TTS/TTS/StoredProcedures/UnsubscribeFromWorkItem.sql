CREATE PROCEDURE [dbo].[UnsubscribeFromWorkItem]
	@WorkItemId int,
	@UserId int
AS
BEGIN
	DELETE
	FROM [dbo].[SubscribedToWorkItem]
	WHERE [SubscribedToWorkItem].[WorkItemId] = @WorkItemId
		AND [SubscribedToWorkItem].[UserId] = @UserId
END
