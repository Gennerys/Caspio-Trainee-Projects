﻿CREATE TABLE [dbo].[BugComments]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [CommentMessage] VARCHAR(MAX) NOT NULL, 
    [DatePosted] DATE NOT NULL, 
    [BugId] INT NOT NULL, 
    [UserId] INT NOT NULL,
	CONSTRAINT FK_BugComment_Id FOREIGN KEY (BugId)
		REFERENCES [Bug] (Id) ON DELETE CASCADE,
	CONSTRAINT FK_UserBugComment_Id FOREIGN KEY (UserId)
		REFERENCES [User] (Id)
)
