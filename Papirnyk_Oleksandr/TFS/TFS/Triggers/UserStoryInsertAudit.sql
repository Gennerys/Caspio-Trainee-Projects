CREATE TRIGGER [UserStoryInsertAudit]
ON [dbo].[UserStory]
AFTER INSERT
AS
SET NOCOUNT ON;
INSERT INTO [dbo].[UserStoryHistory]([Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[AuditActionId])
	SELECT [Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],1 FROM inserted
GO