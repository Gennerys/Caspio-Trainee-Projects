CREATE TABLE [dbo].[ct_vote]
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [value] NVARCHAR(100) NOT NULL, 
    [poll_id] INT NOT NULL,
	[date_of_vote] DATETIME NOT NULL DEFAULT GETUTCDATE(), 
    [user_agent] NVARCHAR(150) NOT NULL, 
    [user_ip] NVARCHAR(50) NOT NULL, 
    CONSTRAINT FK_PK_poll_vote_id FOREIGN KEY([poll_id])
		REFERENCES ct_poll([PK_poll_id])
)
