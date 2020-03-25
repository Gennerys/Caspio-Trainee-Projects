CREATE PROCEDURE [dbo].[AddBug]
	@Title VARCHAR(50),
	@Priority int, 
    @Description VARCHAR(MAX),
	@Estimate int,
	@StateId int,
	@AreaId int
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [TFS].[dbo].[Bug]
	VALUES (@Title,GETDATE(),NULL,@Priority,@Description,@Estimate,@StateId,@AreaId,NULL)
END