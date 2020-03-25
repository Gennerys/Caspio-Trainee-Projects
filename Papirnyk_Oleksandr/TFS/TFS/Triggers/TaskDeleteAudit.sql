CREATE TRIGGER [TaskDeleteAudit]
ON [dbo].[Task]
AFTER DELETE
AS
SET NOCOUNT ON;
BEGIN
INSERT INTO [dbo].[TaskHistory]([Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[AuditActionId])
	SELECT [Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],3 FROM deleted
END
GO
