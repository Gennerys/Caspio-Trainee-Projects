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

	  
