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
USE [$(DatabaseName)];


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
MERGE INTO [TTS].[dbo].[Area] as TARGET
USING (VALUES ('Development'),('Production'),('Administration')) as SOURCE ([AreaName])
ON TARGET.[AreaName] = SOURCE.[AreaName]
WHEN MATCHED THEN
UPDATE SET
TARGET.[AreaName] = SOURCE.[AreaName]
WHEN NOT MATCHED THEN
INSERT ([AreaName])
VALUES(SOURCE.[AreaName]);
GO

 

MERGE INTO [TTS].[dbo].[WorkItemType] as TARGET
USING (VALUES('UserStory'),('Bug'),('Task')) as SOURCE([WorkItemTypeName])
ON TARGET.[WorkItemTypeName] = SOURCE.[WorkItemTypeName]
WHEN MATCHED THEN
UPDATE SET
TARGET.[WorkItemTypeName] = SOURCE.[WorkItemTypeName]
WHEN NOT MATCHED THEN
INSERT ([WorkItemTypeName])
VALUES(SOURCE.[WorkItemTypeName]);
GO

 

MERGE INTO [TTS].[dbo].[State] as TARGET
USING (VALUES('In Proccess'),('Completed'),('BugFix')) as SOURCE([StateName])
ON TARGET.[StateName] = SOURCE.[StateName]
WHEN MATCHED THEN
UPDATE SET
TARGET.[StateName] = SOURCE.[StateName]
WHEN NOT MATCHED THEN
INSERT ([StateName])
VALUES(SOURCE.[StateName]);
GO

 

DECLARE @UserSeed TABLE
(   Id INT IDENTITY(1,1) NOT NULL, 
    FirstName VARCHAR(50) NOT NULL, 
    LastName VARCHAR(50) NOT NULL, 
    Email VARCHAR(50) NOT NULL, 
    Title VARCHAR(50) NOT NULL, 
    DateTimeOfCreation DATE NOT NULL 
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

 

MERGE INTO [TTS].[dbo].[User] as TARGET
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
    [WorkItemType] INT NOT NULL,
    [Title] VARCHAR(200) NOT NULL, 
    [DateOfCreation] DATETIME NOT NULL DEFAULT GETUTCDATE(), 
    [DateOfClose] DATETIME NULL DEFAULT NULL, 
    [Priority] INT NULL DEFAULT NULL, 
    [Description] VARCHAR(MAX) NULL DEFAULT NULL, 
    [Estimate] INT NULL DEFAULT NULL, 
    [StateId] INT NOT NULL, 
    [AreaId] INT NOT NULL, 
    [UserId] INT  NULL DEFAULT NULL, 
    [ParentWorkItem] INT NULL DEFAULT NULL, 
    [Timestamp] DATETIME NULL DEFAULT GETUTCDATE(),
	[IsDeleted] INT NOT NULL DEFAULT 0

)
INSERT INTO @WorkItemSeed([WorkItemId],[WorkItemType],[Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[ParentWorkItem],[Timestamp],[IsDeleted])
VALUES
(1,3,'Develop Database',DEFAULT,DEFAULT,1,'Develop TMS database, see message in Teams for more.',72,1,1,1,11,DEFAULT,DEFAULT),
(2,3,'Mentor Database',DEFAULT,DEFAULT,2,'Mentor development of TMS database.',10,1,1,2,11,DEFAULT,DEFAULT),
(3,3,'Support customers',DEFAULT,DEFAULT,1,'Give advice to new customers as fast as you can.',99,2,3,7,DEFAULT,DEFAULT,DEFAULT),
(4,3,'Find new employees',DEFAULT,DEFAULT,3,'Find new employees among students or bachelors.',84,1,3,4,DEFAULT,DEFAULT,DEFAULT),
(5,3,'Merge branches',DEFAULT,DEFAULT,1,'Merge up-to-date branches to production branch.',24,1,2,3,10,DEFAULT,DEFAULT),
(6,2,'Fix bugs in front-end branch',DEFAULT,DEFAULT,2,'New bugs found in front-end branch, see comments in pull request.',48,3,1,6,10,DEFAULT,DEFAULT),
(7,2,'Front bug #1',DEFAULT,DEFAULT,1,'Index page have 2 bugs',12,3,2,3,13,DEFAULT,DEFAULT),
(8,2,'Front bug #2',DEFAULT,DEFAULT,2,'Admin page customer count bug',12,3,2,6,13,DEFAULT,DEFAULT),
(9,2,'Fix contraints in db',DEFAULT,DEFAULT,1,'Fix FK constraints in Task_History',24,1,1,1,11,DEFAULT,DEFAULT),
(10,1,'Merge branches',DEFAULT,DEFAULT,1,'Solve conflicts in dev and local branches',72,3,2,3,DEFAULT,DEFAULT,DEFAULT),
(11,1,'Database TMS update',DEFAULT,DEFAULT,1,'See info in subtask',72,1,1,1,DEFAULT,DEFAULT,DEFAULT),
(12,1,'New Constraints',DEFAULT,DEFAULT,2,'Develop properly working check constraints',28,1,1,1,DEFAULT,DEFAULT,DEFAULT),
(13,1,'Angular > React',DEFAULT,DEFAULT,1,'Switch from React to Angular',56,2,2,3,DEFAULT,DEFAULT,DEFAULT)

 

MERGE INTO [TTS].[dbo].[WorkItem] as TARGET
USING @WorkItemSeed as SOURCE
ON TARGET.[RevisionId] = SOURCE.[RevisionId]
WHEN MATCHED THEN
UPDATE SET
TARGET.[WorkItemId] = SOURCE.[WorkItemId],
TARGET.[WorkItemType] = SOURCE.[WorkItemType],
TARGET.[Title] = SOURCE.[Title],
TARGET.[DateOfClose] = SOURCE.[DateOfClose],
TARGET.[Priority] = SOURCE.[Priority],
TARGET.[Description] = SOURCE.[Description],
TARGET.[Estimate] = SOURCE.[Estimate],
TARGET.[StateId] = SOURCE.[StateId],
TARGET.[AreaId] = SOURCE.[AreaId],
TARGET.[UserId] = SOURCE.[UserId],
TARGET.[ParentWorkItem] = SOURCE.[ParentWorkItem]
WHEN NOT MATCHED THEN
INSERT ([WorkItemId],[WorkItemType],[Title],[DateOfCreation],[DateOfClose],[Priority],[Description],[Estimate],[StateId],[AreaId],[UserId],[ParentWorkItem],[Timestamp])
VALUES(SOURCE.[WorkItemId],SOURCE.[WorkItemType],SOURCE.[Title],
SOURCE.[DateOfCreation],SOURCE.[DateOfClose],SOURCE.[Priority],
SOURCE.[Description],SOURCE.[Estimate],SOURCE.[StateId],
SOURCE.[AreaId],SOURCE.[UserId],SOURCE.[ParentWorkItem],SOURCE.[Timestamp]);
GO

GO
PRINT N'Update complete.';


GO
