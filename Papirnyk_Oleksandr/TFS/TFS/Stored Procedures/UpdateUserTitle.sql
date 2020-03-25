CREATE PROCEDURE [dbo].[UpdateUserTitle]
	@Id int,
	@Title varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [TFS].[dbo].[User] SET [Title] = @Title
	WHERE [Id] = @id
END	

