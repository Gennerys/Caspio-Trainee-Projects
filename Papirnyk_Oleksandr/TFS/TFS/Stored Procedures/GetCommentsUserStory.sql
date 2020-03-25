CREATE PROCEDURE [dbo].[GetCommentsUserStory]
	@UserStoryId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM [TFS].[dbo].[UserStory_Comments]
	WHERE [UserStory_Comments].[UserStoryId] = @UserStoryId
	ORDER BY [UserStory_Comments].[DatePosted]
END