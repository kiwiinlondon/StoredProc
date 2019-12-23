USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskMessage_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskMessage_Update]
GO

CREATE PROCEDURE DBO.[TaskMessage_Update]
		@TaskMessageId int, 
		@TaskId int, 
		@Message varchar(-1), 
		@DataVersion rowversion, 
		@UpdateUserID int, 
		@InitiatingEntityId int, 
		@InitiatingEntityTypeId int, 
		@InitiatingTaskId int, 
		@InitiatingTaskRunId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskMessage_hst (
			TaskMessageId, TaskId, Message, StartDt, DataVersion, UpdateUserID, InitiatingEntityId, InitiatingEntityTypeId, InitiatingTaskId, InitiatingTaskRunId, EndDt, LastActionUserID)
	SELECT	TaskMessageId, TaskId, Message, StartDt, DataVersion, UpdateUserID, InitiatingEntityId, InitiatingEntityTypeId, InitiatingTaskId, InitiatingTaskRunId, @StartDt, @UpdateUserID
	FROM	TaskMessage
	WHERE	TaskMessageId = @TaskMessageId

	UPDATE	TaskMessage
	SET		TaskId = @TaskId, Message = @Message, UpdateUserID = @UpdateUserID, InitiatingEntityId = @InitiatingEntityId, InitiatingEntityTypeId = @InitiatingEntityTypeId, InitiatingTaskId = @InitiatingTaskId, InitiatingTaskRunId = @InitiatingTaskRunId,  StartDt = @StartDt
	WHERE	TaskMessageId = @TaskMessageId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskMessage
	WHERE	TaskMessageId = @TaskMessageId
	AND		@@ROWCOUNT > 0

GO
