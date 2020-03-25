CREATE TABLE [dbo].[SubscribedToWorkItem]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [WorkItemId] INT NOT NULL,
    [UserId] INT NOT NULL,
    CONSTRAINT FK_SubscribedUser_Id FOREIGN KEY (UserId)
        REFERENCES [User] (Id),
    CONSTRAINT UniqueSubWorkItemIDs UNIQUE([WorkItemId],[UserId])
)
