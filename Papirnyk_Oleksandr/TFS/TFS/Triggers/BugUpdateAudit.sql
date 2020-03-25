CREATE TRIGGER [BugUpdateAudit]
ON [dbo].[Bug]
AFTER UPDATE
AS
SET NOCOUNT ON;
INSERT INTO [dbo].[BugHistory]([Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[AuditActionId])
	SELECT [Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],2 FROM deleted
GO