CREATE TRIGGER [BugDeleteAudit]
ON [dbo].[Bug]
AFTER DELETE
AS
SET NOCOUNT ON;
BEGIN
INSERT INTO [dbo].[BugHistory]([Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[AuditActionId])
	SELECT [Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],3 FROM deleted
END
GO
