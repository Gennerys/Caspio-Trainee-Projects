CREATE PROCEDURE [dbo].[RestoreTaskAtDate]
	@Id int,
	@DateForRestore datetime
AS
BEGIN
	SET NOCOUNT ON;
	Select *
	FROM [TFS].[dbo].[TaskHistory]
	WHERE [DateOfChange] = @DateForRestore
	AND [Id] = @Id
END
