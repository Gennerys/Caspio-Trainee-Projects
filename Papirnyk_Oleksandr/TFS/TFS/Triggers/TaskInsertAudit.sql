﻿CREATE TRIGGER [TaskInsertAudit]
ON [dbo].[Task]
AFTER INSERT
AS
SET NOCOUNT ON;
INSERT INTO [dbo].[TaskHistory]([Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[AuditActionId])
	SELECT [Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],1 FROM inserted
GO
