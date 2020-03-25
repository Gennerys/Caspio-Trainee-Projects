CREATE TABLE [dbo].[User]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [FirstName] VARCHAR(50) NOT NULL, 
    [LastName] VARCHAR(50) NOT NULL, 
    [Email] VARCHAR(50) NOT NULL, 
    [Title] VARCHAR(50) NOT NULL, 
    [DateTimeOfCreation] DATE NOT NULL 
)
