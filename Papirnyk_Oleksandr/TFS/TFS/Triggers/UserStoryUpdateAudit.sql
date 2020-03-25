CREATE TRIGGER [UserStoryUpdateAudit]
ON [dbo].[UserStory]
AFTER UPDATE
AS
SET NOCOUNT ON;
INSERT INTO [dbo].[UserStoryHistory]([Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[AuditActionId])
	SELECT [Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],2 FROM deleted
GO