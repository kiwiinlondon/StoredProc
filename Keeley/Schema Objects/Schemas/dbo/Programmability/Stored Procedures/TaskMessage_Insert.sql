USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskMessage_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskMessage_Insert]
GO

CREATE PROCEDURE DBO.[TaskMessage_Insert]
		@TaskId int, 
		@Message varchar(-1), 
		@UpdateUserID int, 
		@InitiatingEntityId int, 
		@InitiatingEntityTypeId int, 
		@InitiatingTaskId int, 
		@InitiatingTaskRunId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskMessage
			(TaskId, Message, UpdateUserID, InitiatingEntityId, InitiatingEntityTypeId, InitiatingTaskId, InitiatingTaskRunId, StartDt)
	VALUES
			(@TaskId, @Message, @UpdateUserID, @InitiatingEntityId, @InitiatingEntityTypeId, @InitiatingTaskId, @InitiatingTaskRunId, @StartDt)

	SELECT	TaskMessageId, StartDt, DataVersion
	FROM	TaskMessage
	WHERE	TaskMessageId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
