CREATE TABLE [dbo].[Comments]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [CommentMessage] VARCHAR(500) NOT NULL,
    [DatePosted] DATETIME NOT NULL DEFAULT GETUTCDATE(),
    [WorkItemId] INT NOT NULL,
    [UserId] INT NOT NULL,
    CONSTRAINT FK_UserCommented_Id FOREIGN KEY (UserId)
        REFERENCES [User] (Id)
)
