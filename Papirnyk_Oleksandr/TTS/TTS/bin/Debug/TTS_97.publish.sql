﻿/*
Deployment script for TTS

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "TTS"
:setvar DefaultFilePrefix "TTS"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[Area]...';


GO
CREATE TABLE [dbo].[Area] (
    [Id]       INT          IDENTITY (1, 1) NOT NULL,
    [AreaName] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Comments]...';


GO
CREATE TABLE [dbo].[Comments] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [CommentMessage] VARCHAR (500) NOT NULL,
    [DatePosted]     DATETIME      NOT NULL,
    [WorkItemId]     INT           NOT NULL,
    [UserId]         INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[State]...';


GO
CREATE TABLE [dbo].[State] (
    [Id]        INT          IDENTITY (1, 1) NOT NULL,
    [StateName] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[SubscribedToWorkItem]...';


GO
CREATE TABLE [dbo].[SubscribedToWorkItem] (
    [Id]         INT IDENTITY (1, 1) NOT NULL,
    [WorkItemId] INT NOT NULL,
    [UserId]     INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UniqueSubWorkItemIDs] UNIQUE NONCLUSTERED ([WorkItemId] ASC, [UserId] ASC)
);


GO
PRINT N'Creating [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]                 INT          IDENTITY (1, 1) NOT NULL,
    [FirstName]          VARCHAR (50) NOT NULL,
    [LastName]           VARCHAR (50) NOT NULL,
    [Email]              VARCHAR (50) NOT NULL,
    [Title]              VARCHAR (50) NOT NULL,
    [DateTimeOfCreation] DATETIME     NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UniqueUser] UNIQUE NONCLUSTERED ([FirstName] ASC, [LastName] ASC)
);


GO
PRINT N'Creating [dbo].[WorkItem]...';


GO
CREATE TABLE [dbo].[WorkItem] (
    [RevisionId]     INT           IDENTITY (1, 1) NOT NULL,
    [WorkItemId]     INT           NOT NULL,
    [WorkItemTypeId] INT           NOT NULL,
    [Title]          VARCHAR (200) NOT NULL,
    [Timestamp]      DATETIME      NOT NULL,
    [DateOfClose]    DATETIME      NULL,
    [Priority]       INT           NULL,
    [Description]    VARCHAR (MAX) NULL,
    [Estimate]       INT           NULL,
    [StateId]        INT           NOT NULL,
    [AreaId]         INT           NOT NULL,
    [AssignedUserId] INT           NULL,
    [ParentWorkItem] INT           NULL,
    [IsDeleted]      INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([RevisionId] ASC)
);


GO
PRINT N'Creating [dbo].[WorkItemType]...';


GO
CREATE TABLE [dbo].[WorkItemType] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [WorkItemTypeName] NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Comments]...';


GO
ALTER TABLE [dbo].[Comments]
    ADD DEFAULT GETUTCDATE() FOR [DatePosted];


GO
PRINT N'Creating unnamed constraint on [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT GETUTCDATE() FOR [DateTimeOfCreation];


GO
PRINT N'Creating unnamed constraint on [dbo].[WorkItem]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD DEFAULT GETUTCDATE() FOR [Timestamp];


GO
PRINT N'Creating unnamed constraint on [dbo].[WorkItem]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD DEFAULT NULL FOR [DateOfClose];


GO
PRINT N'Creating unnamed constraint on [dbo].[WorkItem]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD DEFAULT NULL FOR [Priority];


GO
PRINT N'Creating unnamed constraint on [dbo].[WorkItem]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD DEFAULT NULL FOR [Description];


GO
PRINT N'Creating unnamed constraint on [dbo].[WorkItem]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD DEFAULT NULL FOR [Estimate];


GO
PRINT N'Creating unnamed constraint on [dbo].[WorkItem]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD DEFAULT NULL FOR [AssignedUserId];


GO
PRINT N'Creating unnamed constraint on [dbo].[WorkItem]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD DEFAULT NULL FOR [ParentWorkItem];


GO
PRINT N'Creating unnamed constraint on [dbo].[WorkItem]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD DEFAULT 0 FOR [IsDeleted];


GO
PRINT N'Creating [dbo].[FK_UserCommented_Id]...';


GO
ALTER TABLE [dbo].[Comments]
    ADD CONSTRAINT [FK_UserCommented_Id] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Creating [dbo].[FK_SubscribedUser_Id]...';


GO
ALTER TABLE [dbo].[SubscribedToWorkItem]
    ADD CONSTRAINT [FK_SubscribedUser_Id] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Creating [dbo].[FK_State_Id]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD CONSTRAINT [FK_State_Id] FOREIGN KEY ([StateId]) REFERENCES [dbo].[State] ([Id]);


GO
PRINT N'Creating [dbo].[FK_Area_Id]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD CONSTRAINT [FK_Area_Id] FOREIGN KEY ([AreaId]) REFERENCES [dbo].[Area] ([Id]);


GO
PRINT N'Creating [dbo].[FK_UserAssigned_Id]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD CONSTRAINT [FK_UserAssigned_Id] FOREIGN KEY ([AssignedUserId]) REFERENCES [dbo].[User] ([Id]);


GO
PRINT N'Creating [dbo].[FK_WorkItemType_Id]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD CONSTRAINT [FK_WorkItemType_Id] FOREIGN KEY ([WorkItemTypeId]) REFERENCES [dbo].[WorkItemType] ([Id]);


GO
PRINT N'Creating [dbo].[CHECKPriority]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD CONSTRAINT [CHECKPriority] CHECK ([Priority]>=1 AND [Priority] <=4);


GO
PRINT N'Creating [dbo].[CHECKEstimate]...';


GO
ALTER TABLE [dbo].[WorkItem]
    ADD CONSTRAINT [CHECKEstimate] CHECK ([Estimate]>=1 AND [Estimate] <=100);


GO
PRINT N'Creating [dbo].[WorkItemCurrentState]...';


GO
CREATE VIEW [dbo].[WorkItemCurrentState]
	AS
WITH LastRevisionCte
AS
(
	SELECT
	 ROW_NUMBER() OVER (PARTITION BY [WorkItemId] ORDER BY [RevisionId] DESC   ) as LastRevision
	,[RevisionId]
    ,[WorkItemId]
    ,[WorkItemTypeId]
    ,[Title]
    ,[Timestamp]
    ,[DateOfClose]
    ,[Priority]
    ,[Description] 
    ,[Estimate] 
    ,[StateId] 
    ,[AreaId] 
    ,[AssignedUserId] 
    ,[ParentWorkItem]
    ,[IsDeleted]
	  FROM [dbo].[WorkItem]
)
SELECT *
FROM LastRevisionCte
WHERE LastRevision = 1
GO
PRINT N'Creating [dbo].[AddUser]...';


GO
CREATE PROCEDURE [dbo].[AddUser]
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@Email VARCHAR(50), 
    @Title VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[User] (FirstName, LastName, Email, Title)
	VALUES (@FirstName, @LastName, @Email, @Title)
END
GO
PRINT N'Creating [dbo].[AddWorkItem]...';


GO
CREATE PROCEDURE [dbo].[AddWorkItem]
	@WorkItemTypeName varchar(100),
    @Title VARCHAR(200),
    @AreaId INT
AS
BEGIN
	SET NOCOUNT ON;

	
	DECLARE @WorkItemId int = 
		(SELECT DISTINCT WorkItemId
			FROM [dbo].[WorkItem]
				WHERE WorkItemId = (SELECT  MAX(WorkItemId)
								FROM [dbo].[WorkItem])) +1;
	DECLARE  @WorkItemTypeId INT = (SELECT Id
		FROM [dbo].[WorkItemType]
			WHERE WorkItemTypeName =
					(SELECT WorkItemTypeName
						FROM [dbo].[WorkItemType]
						WHERE WorkItemTypeName = @WorkItemTypeName))
	BEGIN
		INSERT INTO [dbo].[WorkItem] (WorkItemId,WorkItemTypeId,Title,StateId,AreaId)
		VALUES (@WorkItemId,@WorkItemTypeId,@Title,4,@AreaId)
	END


END
GO
PRINT N'Creating [dbo].[GetCommentsByUser]...';


GO
CREATE PROCEDURE [dbo].[GetCommentsByUser]
	@UserId int
AS
BEGIN
	SELECT [Id],[CommentMessage],[DatePosted],[WorkItemId],[UserId]
	FROM [dbo].[Comments]
	WHERE [Comments].[UserId] = @UserId
	ORDER BY [Comments].[DatePosted]

END
GO
PRINT N'Creating [dbo].[GetCommentsForWorkItem]...';


GO
CREATE PROCEDURE [dbo].[GetCommentsForWorkItem]
	@WorkItemId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM [dbo].[Comments]
	WHERE [Comments].[WorkItemId] = @WorkItemId
	ORDER BY [Comments].DatePosted
END
GO
PRINT N'Creating [dbo].[PostComment]...';


GO
CREATE PROCEDURE [dbo].[PostComment]
	@CommentMessage VARCHAR(500),
	@WorkItemId INT,
	@UserId INT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[Comments] (CommentMessage,WorkItemId,UserId)
	VALUES (@CommentMessage,@WorkItemId,@UserId)
END
GO
PRINT N'Creating [dbo].[SubscribeToWorkItem]...';


GO
CREATE PROCEDURE [dbo].[SubscribeToWorkItem]
	@WorkItemId int,
	@UserId int
AS
BEGIN
	INSERT INTO [dbo].[SubscribedToWorkItem] (WorkItemId,UserId)
	VALUES (@WorkItemId,@UserId)
END
GO
PRINT N'Creating [dbo].[UnsubscribeFromWorkItem]...';


GO
CREATE PROCEDURE [dbo].[UnsubscribeFromWorkItem]
	@WorkItemId int,
	@UserId int
AS
BEGIN
	DELETE
	FROM [dbo].[SubscribedToWorkItem]
	WHERE [SubscribedToWorkItem].[WorkItemId] = @WorkItemId
		AND [SubscribedToWorkItem].[UserId] = @UserId
END
GO
PRINT N'Creating [dbo].[UpdateWorkItem]...';


GO
CREATE PROCEDURE [dbo].[UpdateWorkItem]
	@WorkItemId INT,
    @DateOfClose DATETIME = NULL,
    @Priority INT = NULL,
    @Description VARCHAR(MAX) = NULL,
    @Estimate INT = NULL,
	@UserId INT = NULL,
	@ParentWorkItem INT = NULL,
	@IsDeleted INT = 0

AS
BEGIN
BEGIN TRANSACTION
	SET NOCOUNT ON;
		IF EXISTS(SELECT WorkItemId FROM [dbo].[WorkItem]
					WHERE WorkItemId = @WorkItemId)
			BEGIN
				INSERT INTO [dbo].[WorkItem] 
					([WorkItemId]
					,[WorkItemTypeId]
					,[Title]
					,[DateOfClose]
					,[Priority]
					,[Description]
					,[Estimate]
					,[StateId]
					,[AreaId]
					,[AssignedUserId]
					,[ParentWorkItem]
					,[IsDeleted])
						SELECT TOP (1) 
							[WorkItemId]
							,[WorkItemTypeId]
							,[Title]
							,[DateOfClose]
							,[Priority]
							,[Description]
							,[Estimate]
							,[StateId]
							,[AreaId]
							,[AssignedUserId]
							,[ParentWorkItem]
							,[IsDeleted]
						FROM [dbo].[WorkItem]
						WHERE  [dbo].[WorkItem].[WorkItemId] = @WorkItemId 
						ORDER BY [dbo].[WorkItem].[RevisionId] desc
 
				UPDATE [dbo].[WorkItem]
				SET [dbo].[WorkItem].[DateOfClose] = @DateOfClose, [dbo].[WorkItem].[Priority] = @Priority,
				[dbo].[WorkItem].[Description] = @Description, [dbo].[WorkItem].[Estimate] =  @Estimate,
				[dbo].[WorkItem].[AssignedUserId] = @UserId, [dbo].[WorkItem].[ParentWorkItem] = @ParentWorkItem,
				[dbo].[WorkItem].[IsDeleted] = @IsDeleted
				WHERE [dbo].[WorkItem].[RevisionId] = SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
		 RAISERROR('There are no workitem with given id', 16,16)
		END
COMMIT
END
GO
PRINT N'Creating [dbo].[WorkItemAtSpecificDate]...';


GO
CREATE PROCEDURE [dbo].[WorkItemAtSpecificDate]
	@SpecifiedDate DATETIME,
	@WorkItemId INT
AS
BEGIN
	SET NOCOUNT ON;
	SET dateformat dmy
	SELECT *
	FROM [dbo].[WorkItemCurrentState]
	WHERE [dbo].[WorkItemCurrentState].[Timestamp] > @SpecifiedDate
		AND [dbo].[WorkItemCurrentState].[WorkItemId] = @WorkItemId
END
GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2dee50de-6c60-4e9f-98cb-17b8ef74ff7d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2dee50de-6c60-4e9f-98cb-17b8ef74ff7d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd0e71f0c-b501-4461-bb50-4c0dd716b596')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d0e71f0c-b501-4461-bb50-4c0dd716b596')

GO

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
MERGE INTO [dbo].[Area] as TARGET
USING (VALUES ('Development'),('Production'),('Administration')) as SOURCE ([AreaName])
ON TARGET.[AreaName] = SOURCE.[AreaName]
WHEN MATCHED THEN
UPDATE SET
TARGET.[AreaName] = SOURCE.[AreaName]
WHEN NOT MATCHED THEN
INSERT ([AreaName])
VALUES(SOURCE.[AreaName]);
GO

 

MERGE INTO [dbo].[WorkItemType] as TARGET
USING (VALUES('UserStory'),('Bug'),('Task')) as SOURCE([WorkItemTypeName])
ON TARGET.[WorkItemTypeName] = SOURCE.[WorkItemTypeName]
WHEN MATCHED THEN
UPDATE SET
TARGET.[WorkItemTypeName] = SOURCE.[WorkItemTypeName]
WHEN NOT MATCHED THEN
INSERT ([WorkItemTypeName])
VALUES(SOURCE.[WorkItemTypeName]);
GO
 

MERGE INTO [dbo].[State] as TARGET
USING (VALUES('In Proccess'),('Completed'),('BugFix'),('New')) as SOURCE([StateName])
ON TARGET.[StateName] = SOURCE.[StateName]
WHEN MATCHED THEN
UPDATE SET
TARGET.[StateName] = SOURCE.[StateName]
WHEN NOT MATCHED THEN
INSERT ([StateName])
VALUES(SOURCE.[StateName]);
GO

 

DECLARE @UserSeed TABLE
(   [Id] INT IDENTITY(1,1) NOT NULL, 
    [FirstName] VARCHAR(50) NOT NULL, 
    [LastName] VARCHAR(50) NOT NULL, 
    [Email] VARCHAR(50) NOT NULL, 
    [Title] VARCHAR(50) NOT NULL, 
    [DateTimeOfCreation] DATE NOT NULL 
)

 

INSERT INTO @UserSeed([FirstName],[LastName],[Email],[Title],[DateTimeOfCreation])
VALUES
('Oleksandr','Papirnyk','gennerys1515@gmail.com','Developer',DATEADD(MONTH,-1,GETUTCDATE())),
('Bohdan', 'Rubtsov','bohdanrubtsov@gmail.com','Developer',DATEADD(YEAR,-2,GETUTCDATE())),
('Oleksandr','Pokhylko','mev.proff@gmail.com','Developer',DATEADD(MONTH,-6,GETUTCDATE())),
('Inna','Ruban','innaruban@gmail.com','HR',DATEADD(YEAR,-1,GETUTCDATE())),
('Anna','Neikina','neikina@gmail.com','HR',DATEADD(YEAR,-1,GETUTCDATE())),
('Yaroslav','Lohvynenko','yarlohvynenko@gmail.com','Developer',DATEADD(MONTH,-1,GETUTCDATE())),
('Yuliia','Hryn','yuliahryn@gmail.com','Support',DATEADD(YEAR,-1,GETUTCDATE())),
('Dmytro','Amelchev','amelchev@gmail.com','Support',DATEADD(YEAR,-1,GETUTCDATE())),
('Namik','Zeinalov','zeinalov@gmail.com','Administration',DATEADD(YEAR,-1,GETUTCDATE())),
('Yana','Talash','yanatalash@gmail.com','Administration',DATEADD(YEAR,2,GETUTCDATE()))

 

MERGE INTO [dbo].[User] as TARGET
USING @UserSeed as SOURCE
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

 

DECLARE @WorkItemSeed TABLE
(   [RevisionId] INT IDENTITY(1,1) NOT NULL,
    [WorkItemId] INT NOT NULL,
    [WorkItemTypeId] INT NOT NULL,
    [Title] VARCHAR(200) NOT NULL,
	[Timestamp] DATETIME NULL DEFAULT GETUTCDATE(),
    [DateOfClose] DATETIME NULL DEFAULT NULL, 
    [Priority] INT NULL DEFAULT NULL, 
    [Description] VARCHAR(MAX) NULL DEFAULT NULL, 
    [Estimate] INT NULL DEFAULT NULL, 
    [StateId] INT NOT NULL, 
    [AreaId] INT NOT NULL, 
    [AssignedUserId] INT  NULL DEFAULT NULL, 
    [ParentWorkItem] INT NULL DEFAULT NULL, 
	[IsDeleted] INT NOT NULL DEFAULT 0

)
INSERT INTO @WorkItemSeed([WorkItemId],[WorkItemTypeId],[Title],[Timestamp],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[AssignedUserId],[ParentWorkItem],[IsDeleted])
VALUES
(1,3,'Develop Database',DEFAULT,DEFAULT,1,'Develop TMS database, see message in Teams for more.',72,1,1,1,11,DEFAULT),
(2,3,'Mentor Database',DEFAULT,DEFAULT,2,'Mentor development of TMS database.',10,1,1,2,11,DEFAULT),
(3,3,'Support customers',DEFAULT,DEFAULT,1,'Give advice to new customers as fast as you can.',99,2,3,7,DEFAULT,DEFAULT),
(4,3,'Find new employees',DEFAULT,DEFAULT,3,'Find new employees among students or bachelors.',84,1,3,4,DEFAULT,DEFAULT),
(5,3,'Merge branches',DEFAULT,DEFAULT,1,'Merge up-to-date branches to production branch.',24,1,2,3,10,DEFAULT),
(6,2,'Fix bugs in front-end branch',DEFAULT,DEFAULT,2,'New bugs found in front-end branch, see comments in pull request.',48,3,1,6,10,DEFAULT),
(7,2,'Front bug #1',DEFAULT,DEFAULT,1,'Index page have 2 bugs',12,3,2,3,13,DEFAULT),
(8,2,'Front bug #2',DEFAULT,DEFAULT,2,'Admin page customer count bug',12,3,2,6,13,DEFAULT),
(9,2,'Fix contraints in db',DEFAULT,DEFAULT,1,'Fix FK constraints in Task_History',24,1,1,1,11,DEFAULT),
(10,1,'Merge branches',DEFAULT,DEFAULT,1,'Solve conflicts in dev and local branches',72,3,2,3,DEFAULT,DEFAULT),
(11,1,'Database TMS update',DEFAULT,DEFAULT,1,'See info in subtask',72,1,1,1,DEFAULT,DEFAULT),
(12,1,'New Constraints',DEFAULT,DEFAULT,2,'Develop properly working check constraints',28,1,1,1,DEFAULT,DEFAULT),
(13,1,'Angular > React',DEFAULT,DEFAULT,1,'Switch from React to Angular',56,2,2,3,DEFAULT,DEFAULT)



MERGE INTO [dbo].[WorkItem] as TARGET
USING @WorkItemSeed as SOURCE
ON TARGET.[RevisionId] = SOURCE.[RevisionId]
WHEN MATCHED THEN
UPDATE SET
TARGET.[WorkItemId] = SOURCE.[WorkItemId],
TARGET.[WorkItemTypeId] = SOURCE.[WorkItemTypeId],
TARGET.[Timestamp] = SOURCE.[Timestamp],
TARGET.[Title] = SOURCE.[Title],
TARGET.[DateOfClose] = SOURCE.[DateOfClose],
TARGET.[Priority] = SOURCE.[Priority],
TARGET.[Description] = SOURCE.[Description],
TARGET.[Estimate] = SOURCE.[Estimate],
TARGET.[StateId] = SOURCE.[StateId],
TARGET.[AreaId] = SOURCE.[AreaId],
TARGET.[AssignedUserId] = SOURCE.[AssignedUserId],
TARGET.[ParentWorkItem] = SOURCE.[ParentWorkItem],
TARGET.[IsDeleted] = SOURCE.[IsDeleted]
WHEN NOT MATCHED THEN
INSERT ([WorkItemId],[WorkItemTypeId],[Title],[Timestamp],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[AssignedUserId],[ParentWorkItem],[IsDeleted])
VALUES(SOURCE.[WorkItemId],SOURCE.[WorkItemTypeId],SOURCE.[Title],SOURCE.[Timestamp],SOURCE.[DateOfClose],SOURCE.[Priority],
SOURCE.[Description],SOURCE.[Estimate],SOURCE.[StateId],
SOURCE.[AreaId],SOURCE.[AssignedUserId],SOURCE.[ParentWorkItem],[IsDeleted]);
GO

DECLARE @CommentsSeed TABLE
(  	[Id] INT IDENTITY(1,1) NOT NULL,
    [CommentMessage] VARCHAR(500) NOT NULL,
    [DatePosted] DATE NOT NULL DEFAULT GETUTCDATE(),
    [WorkItemId] INT NOT NULL,
    [UserId] INT NOT NULL 
)

INSERT INTO @CommentsSeed([CommentMessage],[DatePosted],[WorkItemId],[UserId])
VALUES
('Good work, keep it up',DATEADD(MONTH,+1,GETUTCDATE()),1,2),
('Learn more about constraints',GETUTCDATE(),1,3),
('Merge this branch already',DATEADD(MONTH,-1,GETUTCDATE()),5,3),
('I dont know what to do',GETUTCDATE(),1,6),
('Dont give up!',GETUTCDATE(),1,3),
('I hate production',GETUTCDATE(),10,3),
('You have 3 more days to get it done',GETUTCDATE(),1,2),
('I will do my best',GETUTCDATE(),1,1),
('Im backend developer why do i have to do front-end tasks?',GETUTCDATE(),13,3),
('Someone have to...',GETUTCDATE(),13,7)

MERGE INTO [dbo].[Comments] as TARGET
USING @CommentsSeed as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[CommentMessage] = SOURCE.[CommentMessage],
TARGET.[DatePosted] = SOURCE.[DatePosted],
TARGET.[WorkItemId] = SOURCE.[WorkItemId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([CommentMessage],[DatePosted],[WorkItemId],[UserId])
VALUES(SOURCE.[CommentMessage],SOURCE.[DatePosted],SOURCE.[WorkItemId],SOURCE.[UserId]);
GO


DECLARE @SubscribersSeed TABLE
(	[Id] INT IDENTITY(1,1) NOT NULL, 
    [WorkItemId] INT NOT NULL, 
    [UserId] INT NOT NULL
)

INSERT INTO @SubscribersSeed([WorkItemId],[UserId])
VALUES
(1,1),
(1,2),
(1,3),
(13,3),
(13,2),
(10,1),
(11,1),
(11,2),
(7,3),
(8,3),
(8,6)

MERGE INTO [dbo].[SubscribedToWorkItem] as TARGET
USING @SubscribersSeed as SOURCE
ON TARGET.[Id] = SOURCE.[Id]
WHEN MATCHED THEN
UPDATE SET
TARGET.[Id] = SOURCE.[Id],
TARGET.[WorkItemId] = SOURCE.[WorkItemId],
TARGET.[UserId] = SOURCE.[UserId]
WHEN NOT MATCHED THEN
INSERT ([WorkItemId],[UserId])
VALUES(SOURCE.[WorkItemId],SOURCE.[UserId]);

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
