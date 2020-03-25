CREATE TABLE [dbo].[BugHistory]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [Title] VARCHAR(50) NULL, 
    [DateOfCreation] DATE NULL, 
    [DateOfClose] DATE NULL, 
    [Priority] INT NULL, 
    [Description] VARCHAR(MAX) NULL, 
    [Estimate] INT NULL, 
    [StateId] INT NULL, 
    [AreaId] INT NULL, 
    [UserId] INT NULL,
	[DateOfChange] DATETIME NOT NULL DEFAULT(SYSDATETIME()), 
	[AuditActionId] INT NOT NULL,
	CONSTRAINT FK_BugAuditAction_Id FOREIGN KEY (AuditActionId)
	REFERENCES [AuditAction] (Id)
)
