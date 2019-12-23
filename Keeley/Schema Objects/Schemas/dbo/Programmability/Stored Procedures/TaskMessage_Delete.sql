USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskMessage_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskMessage_Delete]
GO

CREATE PROCEDURE DBO.[TaskMessage_Delete]
		@TaskMessageId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskMessage_hst (
			TaskMessageId, TaskId, Message, StartDt, DataVersion, UpdateUserID, InitiatingEntityId, InitiatingEntityTypeId, InitiatingTaskId, InitiatingTaskRunId, EndDt, LastActionUserID)
	SELECT	TaskMessageId, TaskId, Message, StartDt, DataVersion, UpdateUserID, InitiatingEntityId, InitiatingEntityTypeId, InitiatingTaskId, InitiatingTaskRunId, @EndDt, @UpdateUserID
	FROM	TaskMessage
	WHERE	TaskMessageId = @TaskMessageId

	DELETE	TaskMessage
	WHERE	TaskMessageId = @TaskMessageId
	AND		DataVersion = @DataVersion
GO
