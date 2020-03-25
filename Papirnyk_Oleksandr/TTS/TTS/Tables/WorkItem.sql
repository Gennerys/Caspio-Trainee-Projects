CREATE TABLE [dbo].[WorkItem]
(
	[RevisionId] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [WorkItemId] INT NOT NULL,
    [WorkItemTypeId] INT NOT NULL,
    [Title] VARCHAR(200) NOT NULL,
    [Timestamp] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [DateOfClose] DATETIME NULL DEFAULT NULL,
    [Priority] INT NULL DEFAULT NULL,
    [Description] VARCHAR(MAX) NULL DEFAULT NULL,
    [Estimate] INT NULL DEFAULT NULL,
    [StateId] INT NOT NULL,
    [AreaId] INT NOT NULL,
    [AssignedUserId] INT  NULL DEFAULT NULL,
    [ParentWorkItem] INT NULL DEFAULT NULL,
    [IsDeleted] INT NOT NULL DEFAULT 0, 
    CONSTRAINT FK_State_Id FOREIGN KEY (StateId)
        REFERENCES State (Id),
    CONSTRAINT FK_Area_Id FOREIGN KEY (AreaId)
        REFERENCES Area(Id),
    CONSTRAINT FK_UserAssigned_Id FOREIGN KEY ([AssignedUserId])
        REFERENCES [User] (Id),
	CONSTRAINT FK_WorkItemType_Id FOREIGN KEY (WorkItemTypeId)
		REFERENCES [WorkItemType] (Id),
    CONSTRAINT CHECKPriority
        CHECK([Priority]>=1 AND [Priority] <=4),
    CONSTRAINT CHECKEstimate
        CHECK([Estimate]>=1 AND [Estimate] <=100)
)
