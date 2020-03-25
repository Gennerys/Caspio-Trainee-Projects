CREATE TABLE [dbo].[Bug]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [Title] VARCHAR(50) NOT NULL, 
    [DateOfCreation] DATE NOT NULL, 
    [DateOfClose] DATE NULL, 
    [Priority] INT NULL, 
    [Description] VARCHAR(MAX) NULL, 
    [Estimate] INT NULL, 
    [StateId] INT NOT NULL, 
    [AreaId] INT NOT NULL, 
    [UserId] INT  NULL, 
	CONSTRAINT FK_StateBug_Id FOREIGN KEY (StateId)
        REFERENCES State (Id),
	CONSTRAINT FK_AreaBug_Id FOREIGN KEY (AreaId)
		REFERENCES Area(Id),
	CONSTRAINT FK_UserBug_Id FOREIGN KEY (UserId)
		REFERENCES [User] (Id),
	CONSTRAINT CHECKPriority_Bug
		CHECK([Priority]>=1 AND [Priority] <=4),
	CONSTRAINT CHECKEstimate_Bug
		CHECK([Estimate]>=1 AND [Estimate] <=100)
)
