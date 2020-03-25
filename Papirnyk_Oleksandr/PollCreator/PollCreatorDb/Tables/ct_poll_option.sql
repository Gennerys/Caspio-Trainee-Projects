CREATE TABLE [dbo].[ct_poll_option]
(
	[PK_poll_option_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [serial_number] INT NOT NULL,
	[value] NVARCHAR(100) NOT NULL,
    [poll_id] INT NOT NULL, 
	CONSTRAINT FK_PK_poll_id FOREIGN KEY([poll_id])
		REFERENCES ct_poll([PK_poll_id]),
	CONSTRAINT CK_poll_option_serial_number
		CHECK([serial_number] >=1 AND [serial_number] <=10)
)
