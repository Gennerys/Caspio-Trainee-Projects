DECLARE @UpdatedArea TABLE
(	Id INT IDENTITY(1,1) NOT NULL,
	AreaName VARCHAR(50)
)

INSERT INTO @UpdatedArea ([AreaName])
VALUES('Development'),('Production'),('Administration');

MERGE INTO [TFS].[dbo].[Area] as TARGET
USING @UpdatedArea as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[AreaName] = SOURCE.[AreaName]
WHEN NOT MATCHED THEN
INSERT ([AreaName])
VALUES(SOURCE.[AreaName]);
GO

DECLARE @UpdatedAuditAction TABLE
(	Id INT IDENTITY(1,1) NOT NULL,
	ActionName VARCHAR(50)
)

INSERT INTO @UpdatedAuditAction ([ActionName])
VALUES('Inserted'),('Updated'),('Deleted');

MERGE INTO [TFS].[dbo].[AuditAction] as TARGET
USING @UpdatedAuditAction as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[ActionName] = SOURCE.[ActionName]
WHEN NOT MATCHED THEN
INSERT ([ActionName])
VALUES(SOURCE.[ActionName]);
GO

DECLARE @UpdatedState TABLE
(	Id INT IDENTITY(1,1) NOT NULL,
	StateName VARCHAR(50)
)

INSERT INTO @UpdatedState ([StateName])
VALUES('In Proccess'),('Completed'),('BugFix');

MERGE INTO [TFS].[dbo].[State] as TARGET
USING @UpdatedState as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[StateName] = SOURCE.[StateName]
WHEN NOT MATCHED THEN
INSERT ([StateName])
VALUES(SOURCE.[StateName]);
GO

DECLARE @UpdatedUser TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    FirstName VARCHAR(50) NOT NULL, 
    LastName VARCHAR(50) NOT NULL, 
    Email VARCHAR(50) NOT NULL, 
    Title VARCHAR(50) NOT NULL, 
    DateTimeOfCreation DATE NOT NULL 
)

INSERT INTO @UpdatedUser([FirstName],[LastName],[Email],[Title],[DateTimeOfCreation])
VALUES
('Oleksandr','Papirnyk','gennerys1515@gmail.com','Developer',DATEADD(MONTH,-1,GETDATE())),
('Bohdan', 'Rubtsov','bohdanrubtsov@gmail.com','Developer',DATEADD(YEAR,-2,GETDATE())),
('Oleksandr','Pokhylko','mev.proff@gmail.com','Developer',DATEADD(MONTH,-6,GETDATE())),
('Inna','Ruban','innaruban@gmail.com','HR',DATEADD(YEAR,-1,GETDATE())),
('Anna','Neikina','neikina@gmail.com','HR',DATEADD(YEAR,-1,GETDATE())),
('Yaroslav','Lohvynenko','yarlohvynenko@gmail.com','Developer',DATEADD(MONTH,-1,GETDATE())),
('Yuliia','Hryn','yuliahryn@gmail.com','Support',DATEADD(YEAR,-1,GETDATE())),
('Dmytro','Amelchev','amelchev@gmail.com','Support',DATEADD(YEAR,-1,GETDATE())),
('Namik','Zeinalov','zeinalov@gmail.com','Administration',DATEADD(YEAR,-1,GETDATE())),
('Yana','Talash','yanatalash@gmail.com','Administration',DATEADD(YEAR,2,GETDATE()))

MERGE INTO [TFS].[dbo].[User] as TARGET
USING @UpdatedUser as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[FirstName] = SOURCE.[FirstName],
TARGET.[LastName] = SOURCE.[LastName],
TARGET.[Email] = SOURCE.[Email],
TARGET.[Title] = SOURCE.[Title],
TARGET.[DateTimeOfCreation] = SOURCE.[DateTimeOfCreation]
WHEN NOT MATCHED THEN
INSERT ([FirstName],[LastName],[Email],[Title],[DateTimeOfCreation])
VALUES(SOURCE.[FirstName],SOURCE.[LastName],SOURCE.[Email],SOURCE.[Title],SOURCE.[DateTimeOfCreation]);
GO

DECLARE @UpdatedTask TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    Title VARCHAR(50) NOT NULL, 
    DateOfCreation DATE NOT NULL, 
    DateOfClose DATE NULL, 
    Priority INT NULL, 
    Description VARCHAR(MAX) NULL, 
    Estimate INT NULL, 
    StateId INT NOT NULL, 
    AreaId INT NOT NULL, 
    UserId INT NULL
)

INSERT INTO @UpdatedTask([Title],[DateOfCreation],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId])
VALUES
('Develop Database',GETDATE(),1,'Develop TMS database, see message in Teams for more.',72,1,1,1),
('Mentor Database',GETDATE(),1,'Mentor development of TMS database.',72,1,1,2),
('Support customers',GETDATE(),2,'Give advice to new customers as fast as you can.',99,2,3,7),
('Find new employees',GETDATE(),3,'Find new employees among students or bachelors.',84,1,3,4),
('Merge branches',GETDATE(),1,'Merge up-to-date branches to production branch.',24,1,2,3),
('Fix bugs in front-end branch',GETDATE(),2,'New bugs found in front-end branch, see comments in pull request.',48,3,1,6)

MERGE INTO [TFS].[dbo].[Task] as TARGET
USING @UpdatedTask as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[Title] = SOURCE.[Title],
TARGET.[DateOfCreation] = SOURCE.[DateOfCreation],
TARGET.[Priority] = SOURCE.[Priority],
TARGET.[Description] = SOURCE.[Description],
TARGET.[Estimate] = SOURCE.[Estimate],
TARGET.[StateId] = SOURCE.[StateId],
TARGET.[AreaId] = SOURCE.[AreaId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([Title],[DateOfCreation],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId])
VALUES(SOURCE.[Title],SOURCE.[DateOfCreation],SOURCE.[Priority],SOURCE.[Description],SOURCE.[Estimate],SOURCE.[StateId],SOURCE.[AreaId],SOURCE.[UserId]);
GO

DECLARE @UpdatedBug TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    Title VARCHAR(50) NOT NULL, 
    DateOfCreation DATE NOT NULL, 
    DateOfClose DATE NULL, 
    Priority INT NULL, 
    Description VARCHAR(MAX) NULL, 
    Estimate INT NULL, 
    StateId INT NOT NULL, 
    AreaId INT NOT NULL, 
    UserId INT NULL
)

INSERT INTO @UpdatedBug([Title],[DateOfCreation],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId])
VALUES
('Front bug #1',GETDATE(),1,'Index page have 2 bugs',12,3,2,3),
('Front bug #2',GETDATE(),2,'Admin page customer count bug',12,3,2,6),
('Fix contraints in db',GETDATE(),1,'Fix FK constraints in Task_History',24,1,1,1),
('Merge branches',GETDATE(),1,'Solve conflicts in dev and local branches',72,3,2,3)

MERGE INTO [TFS].[dbo].[Bug] as TARGET
USING @UpdatedBug as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[Title] = SOURCE.[Title],
TARGET.[DateOfCreation] = SOURCE.[DateOfCreation],
TARGET.[Priority] = SOURCE.[Priority],
TARGET.[Description] = SOURCE.[Description],
TARGET.[Estimate] = SOURCE.[Estimate],
TARGET.[StateId] = SOURCE.[StateId],
TARGET.[AreaId] = SOURCE.[AreaId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([Title],[DateOfCreation],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId])
VALUES(SOURCE.[Title],SOURCE.[DateOfCreation],SOURCE.[Priority],SOURCE.[Description],SOURCE.[Estimate],SOURCE.[StateId],SOURCE.[AreaId],SOURCE.[UserId]);
GO

DECLARE @UpdatedUserStory TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    Title VARCHAR(50) NOT NULL, 
    DateOfCreation DATE NOT NULL, 
    DateOfClose DATE NULL, 
    Priority INT NULL, 
    Description VARCHAR(MAX) NULL, 
    Estimate INT NULL, 
    StateId INT NOT NULL, 
    AreaId INT NOT NULL, 
    UserId INT NULL
)
INSERT INTO @UpdatedUserStory([Title],[DateOfCreation],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId])
VALUES
('Database TMS update',GETDATE(),1,'See info in subtask',72,1,1,1),
('New Constraints',GETDATE(),2,'Develop properly working check constraints',28,1,1,1),
('Angular > React',GETDATE(),1,'Switch from React to Angular',56,2,2,3)

MERGE INTO [TFS].[dbo].[UserStory] as TARGET
USING @UpdatedUserStory as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[Title] = SOURCE.[Title],
TARGET.[DateOfCreation] = SOURCE.[DateOfCreation],
TARGET.[Priority] = SOURCE.[Priority],
TARGET.[Description] = SOURCE.[Description],
TARGET.[Estimate] = SOURCE.[Estimate],
TARGET.[StateId] = SOURCE.[StateId],
TARGET.[AreaId] = SOURCE.[AreaId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([Title],[DateOfCreation],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId])
VALUES(SOURCE.[Title],SOURCE.[DateOfCreation],SOURCE.[Priority],SOURCE.[Description],SOURCE.[Estimate],SOURCE.[StateId],SOURCE.[AreaId],SOURCE.[UserId]);
GO

DECLARE @UpdatedTaskComments TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    CommentMessage VARCHAR(100) NOT NULL, 
    DatePosted DATE NOT NULL, 
    TaskId INT NOT NULL, 
    UserId INT NOT NULL
)
INSERT INTO @UpdatedTaskComments([CommentMessage],[DatePosted],[TaskId],[UserId])
VALUES
('Good work, keep it up',DATEADD(MONTH,+1,GETDATE()),1,2),
('Learn more about constraints',GETDATE(),1,3),
('Merge this branch already',DATEADD(MONTH,-1,GETDATE()),5,3)

MERGE INTO [TFS].[dbo].[TaskComments] as TARGET
USING @UpdatedTaskComments as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[CommentMessage] = SOURCE.[CommentMessage],
TARGET.[DatePosted] = SOURCE.[DatePosted],
TARGET.[TaskId] = SOURCE.[TaskId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([CommentMessage],[DatePosted],[TaskId],[UserId])
VALUES(SOURCE.[CommentMessage],SOURCE.[DatePosted],SOURCE.[TaskId],SOURCE.[UserId]);
GO

DECLARE @UpdatedBugComments TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    CommentMessage VARCHAR(100) NOT NULL, 
    DatePosted DATE NOT NULL, 
    BugId INT NOT NULL, 
    UserId INT NOT NULL
)
INSERT INTO @UpdatedBugComments([CommentMessage],[DatePosted],[BugId],[UserId])
VALUES
('I dont know what to do',GETDATE(),1,6),
('Dont give up!',GETDATE(),1,3),
('I hate production',GETDATE(),4,3)


MERGE INTO [TFS].[dbo].[BugComments] as TARGET
USING @UpdatedBugComments as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[CommentMessage] = SOURCE.[CommentMessage],
TARGET.[DatePosted] = SOURCE.[DatePosted],
TARGET.[BugId] = SOURCE.[BugId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([CommentMessage],[DatePosted],[BugId],[UserId])
VALUES(SOURCE.[CommentMessage],SOURCE.[DatePosted],SOURCE.[BugId],SOURCE.[UserId]);
GO

DECLARE @UpdatedUserStoryComments TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    CommentMessage VARCHAR(100) NOT NULL, 
    DatePosted DATE NOT NULL, 
    UserStoryId INT NOT NULL, 
    UserId INT NOT NULL
)

INSERT INTO @UpdatedUserStoryComments([CommentMessage],[DatePosted],[UserStoryId],[UserId])
VALUES
('You have 3 more days to get it done',GETDATE(),1,2),
('I will do my best',GETDATE(),1,1),
('Im backend developer why do i have to do front-end tasks?',GETDATE(),3,3),
('Someone have to...',GETDATE(),3,7)

MERGE INTO [TFS].[dbo].[UserStoryComments] as TARGET
USING @UpdatedUserStoryComments as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[CommentMessage] = SOURCE.[CommentMessage],
TARGET.[DatePosted] = SOURCE.[DatePosted],
TARGET.[UserStoryId] = SOURCE.[UserStoryId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([CommentMessage],[DatePosted],[UserStoryId],[UserId])
VALUES(SOURCE.[CommentMessage],SOURCE.[DatePosted],SOURCE.[UserStoryId],SOURCE.[UserId]);
GO

DECLARE @UpdatedBugChilds TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    BugId INT NOT NULL, 
    TaskId INT NOT NULL
)

INSERT INTO @UpdatedBugChilds([BugId],[TaskId])
VALUES 
(1,6),
(2,6)

MERGE INTO [TFS].[dbo].[BugChilds] as TARGET
USING @UpdatedBugChilds as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[BugId] = SOURCE.[BugId],
TARGET.[TaskId] = SOURCE.[TaskId]
WHEN NOT MATCHED THEN
INSERT ([BugId],[TaskId])
VALUES(SOURCE.[BugId],SOURCE.[TaskId]);
GO

DECLARE @UpdatedUserStoryChilds TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    UserStoryId INT NOT NULL, 
    TaskId INT NOT NULL
)

INSERT INTO @UpdatedUserStoryChilds([UserStoryId],[TaskId])
VALUES
(1,1),
(1,2),
(2,1),
(3,5),
(3,6)

MERGE INTO [TFS].[dbo].[UserStoryChilds] as TARGET
USING @UpdatedUserStoryChilds as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[UserStoryId] = SOURCE.[UserStoryId],
TARGET.[TaskId] = SOURCE.[TaskId]
WHEN NOT MATCHED THEN
INSERT ([UserStoryId],[TaskId])
VALUES(SOURCE.[UserStoryId],SOURCE.[TaskId]);
GO

DECLARE @UpdatedSubscribedToTask TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    TaskId INT NOT NULL, 
    UserId INT NOT NULL
)

INSERT INTO @UpdatedSubscribedToTask([TaskId],[UserId])
VALUES
(1,1),
(1,6),
(1,3)

MERGE INTO [TFS].[dbo].[SubscribedToTask] as TARGET
USING @UpdatedSubscribedToTask as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[TaskId] = SOURCE.[TaskId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([TaskId],[UserId])
VALUES(SOURCE.[TaskId],SOURCE.[UserId]);
GO

DECLARE @UpdatedSubscribedToBug TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    BugId INT NOT NULL, 
    UserId INT NOT NULL
)

INSERT INTO @UpdatedSubscribedToBug([BugId],[UserId])
VALUES
(1,3),
(1,2),
(3,1),
(4,3)

MERGE INTO [TFS].[dbo].[SubscribedToBug] as TARGET
USING @UpdatedSubscribedToBug as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[BugId] = SOURCE.[BugId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([BugId],[UserId])
VALUES(SOURCE.[BugId],SOURCE.[UserId]);
GO

DECLARE @UpdatedSubscribedToUserStory TABLE
(	Id INT IDENTITY(1,1) NOT NULL, 
    UserStoryId INT NOT NULL, 
    UserId INT NOT NULL
)

INSERT INTO @UpdatedSubscribedToUserStory([UserStoryId],[UserId])
VALUES
(1,1),
(2,1),
(3,3)

MERGE INTO [TFS].[dbo].[SubscribedToUserStory] as TARGET
USING @UpdatedSubscribedToUserStory as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[UserStoryId] = SOURCE.[UserStoryId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([UserStoryId],[UserId])
VALUES(SOURCE.[UserStoryId],SOURCE.[UserId]);
GO

