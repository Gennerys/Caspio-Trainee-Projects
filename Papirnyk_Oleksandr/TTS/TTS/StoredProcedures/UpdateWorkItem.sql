CREATE PROCEDURE [dbo].[UpdateWorkItem]
	@WorkItemId INT,
    @DateOfClose DATETIME = NULL,
    @Priority INT = NULL,
    @Description VARCHAR(MAX) = NULL,
    @Estimate INT = NULL,
	@UserId INT = NULL,
	@ParentWorkItem INT = NULL,
	@IsDeleted INT = 0

AS
BEGIN
set xact_abort on
BEGIN TRANSACTION
	SET NOCOUNT ON;
		IF EXISTS(SELECT WorkItemId FROM [dbo].[WorkItem]
					WHERE WorkItemId = @WorkItemId)
			BEGIN
				INSERT INTO [dbo].[WorkItem] 
					([WorkItemId]
					,[WorkItemTypeId]
					,[Title]
					,[DateOfClose]
					,[Priority]
					,[Description]
					,[Estimate]
					,[StateId]
					,[AreaId]
					,[AssignedUserId]
					,[ParentWorkItem]
					,[IsDeleted])
						SELECT TOP (1) 
							[WorkItemId]
							,[WorkItemTypeId]
							,[Title]
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
						WHERE  [dbo].[WorkItem].[WorkItemId] = @WorkItemId 
						ORDER BY [dbo].[WorkItem].[RevisionId] desc
 
				UPDATE [dbo].[WorkItem]
				SET [dbo].[WorkItem].[DateOfClose] = @DateOfClose, [dbo].[WorkItem].[Priority] = @Priority,
				[dbo].[WorkItem].[Description] = @Description, [dbo].[WorkItem].[Estimate] =  @Estimate,
				[dbo].[WorkItem].[AssignedUserId] = @UserId, [dbo].[WorkItem].[ParentWorkItem] = @ParentWorkItem,
				[dbo].[WorkItem].[IsDeleted] = @IsDeleted
				WHERE [dbo].[WorkItem].[RevisionId] = SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
		 RAISERROR('There are no workitem with given id', 16,16)
		END
COMMIT
END  

