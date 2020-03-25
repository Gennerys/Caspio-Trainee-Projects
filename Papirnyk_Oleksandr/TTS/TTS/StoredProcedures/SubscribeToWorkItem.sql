CREATE PROCEDURE [dbo].[SubscribeToWorkItem]
	@WorkItemId int,
	@UserId int
AS
BEGIN
	INSERT INTO [dbo].[SubscribedToWorkItem] (WorkItemId,UserId)
	VALUES (@WorkItemId,@UserId)
END
