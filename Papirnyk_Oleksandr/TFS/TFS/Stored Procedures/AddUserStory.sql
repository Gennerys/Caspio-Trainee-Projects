CREATE PROCEDURE [dbo].[AddUserStory]
	@Title VARCHAR(50),
	@Priority int, 
    @Description VARCHAR(MAX),
	@Estimate int,
	@StateId int,
	@AreaId int
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [TFS].[dbo].[UserStory]
	VALUES (@Title,GETDATE(),NULL,@Priority,@Description,@Estimate,@StateId,@AreaId,NULL)
END