CREATE TABLE [dbo].[AuditAction]
(
	[Id] INT Identity(1,1) NOT NULL PRIMARY KEY, 
    [ActionName] NVARCHAR(50) NULL
)
