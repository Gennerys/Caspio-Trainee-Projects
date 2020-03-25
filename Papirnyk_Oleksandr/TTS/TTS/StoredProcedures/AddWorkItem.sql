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
