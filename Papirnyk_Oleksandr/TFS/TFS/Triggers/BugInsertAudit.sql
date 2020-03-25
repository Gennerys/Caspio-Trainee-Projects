CREATE TRIGGER [BugInsertAudit]
ON [dbo].[Bug]
AFTER INSERT
AS
SET NOCOUNT ON;
INSERT INTO [dbo].[BugHistory]([Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[AuditActionId])
	SELECT [Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],1 FROM inserted
GO