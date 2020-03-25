CREATE TRIGGER [TaskUpdateAudit]
ON [dbo].[Task]
AFTER UPDATE 
AS
SET NOCOUNT ON;
INSERT INTO [dbo].[TaskHistory]([Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[AuditActionId])
	SELECT [Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],2 FROM deleted
GO