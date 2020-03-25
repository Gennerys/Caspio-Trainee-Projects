﻿CREATE PROCEDURE [dbo].[AddUser]
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
