CREATE TABLE [dbo].[TaskComments]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [CommentMessage] VARCHAR(MAX) NOT NULL, 
    [DatePosted] DATE NOT NULL, 
    [TaskId] INT NOT NULL, 
    [UserId] INT NOT NULL,
	CONSTRAINT FK_TaskComment_Id FOREIGN KEY (TaskId)
		REFERENCES [Task] (Id) ON  DELETE CASCADE,
	CONSTRAINT FK_UserTaskComment_Id FOREIGN KEY (UserId)
		REFERENCES [User] (Id)
)
