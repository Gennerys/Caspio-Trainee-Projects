CREATE PROCEDURE [dbo].[WorkItemAtSpecificDate]
	@SpecifiedDate DATETIME,
	@WorkItemId INT
AS
BEGIN
	SET NOCOUNT ON;
	SET dateformat dmy
	SELECT *
	FROM [dbo].[WorkItem]
	WHERE [dbo].[WorkItem].[Timestamp] > @SpecifiedDate
		AND [dbo].[WorkItem].[WorkItemId] = @WorkItemId
END
