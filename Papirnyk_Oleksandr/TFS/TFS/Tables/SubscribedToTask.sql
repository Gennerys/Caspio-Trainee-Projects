CREATE TABLE [dbo].[SubscribedToTask]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [TaskId] INT NOT NULL, 
    [UserId] INT NOT NULL,
	CONSTRAINT FK_SubscribedTask_Id FOREIGN KEY (TaskId)
		REFERENCES [Task] (Id) ON DELETE CASCADE,
	CONSTRAINT FK_SubscribedToTaskUser_Id FOREIGN KEY (UserId)
		REFERENCES [User] (Id),
	CONSTRAINT UniqueSubTaskIDs UNIQUE([TaskId],[UserId])
)
