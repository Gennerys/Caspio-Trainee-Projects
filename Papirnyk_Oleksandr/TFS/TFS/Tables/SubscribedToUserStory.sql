CREATE TABLE [dbo].[SubscribedToUserStory]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [UserStoryId] INT NOT NULL, 
    [UserId] INT NOT NULL,
	CONSTRAINT FK_SubscribedUS_Id FOREIGN KEY (UserStoryId)
		REFERENCES [UserStory] (Id) ON DELETE CASCADE,
	CONSTRAINT FK_SubscribedToUSUser_Id FOREIGN KEY (UserId)
		REFERENCES [User] (Id),
	CONSTRAINT UniqueSubUSIDs UNIQUE([UserStoryId],[UserId])
)
