﻿CREATE TABLE [dbo].[BugChilds]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [BugId] INT NOT NULL, 
    [TaskId] INT NOT NULL,
	CONSTRAINT FK_BugWithChilds_Id FOREIGN KEY (BugId)
		REFERENCES [Bug] (Id) ON DELETE CASCADE,
	CONSTRAINT FK_BugTaskChild_Id FOREIGN KEY (TaskId)
		REFERENCES [Task] (Id) ON DELETE CASCADE,
	CONSTRAINT UniqueBugIDs UNIQUE([BugId],[TaskId])
)
