CREATE TABLE [dbo].[UserStoryComments]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [CommentMessage] VARCHAR(MAX) NOT NULL, 
    [DatePosted] DATE NOT NULL, 
    [UserStoryId] INT NOT NULL, 
    [UserId] INT NOT NULL,
	CONSTRAINT FK_USComment_Id FOREIGN KEY (UserStoryId)
		REFERENCES [UserStory] (Id) ON DELETE CASCADE,
	CONSTRAINT FK_UserUSComment_Id FOREIGN KEY (UserId)
		REFERENCES [User] (Id)

)
