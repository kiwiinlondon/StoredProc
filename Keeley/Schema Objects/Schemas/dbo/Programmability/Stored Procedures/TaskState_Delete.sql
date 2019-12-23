USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskState_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskState_Delete]
GO

CREATE PROCEDURE DBO.[TaskState_Delete]
		@TaskId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskState_hst (
			TaskId, TaskStateTypeId, StartDt, UpdateUserID, DataVersion, LastTaskRunId, ExecutionSet, RetryAttempts, InitiatingTime, CompletionTime, Acknowledged, EndDt, LastActionUserID)
	SELECT	TaskId, TaskStateTypeId, StartDt, UpdateUserID, DataVersion, LastTaskRunId, ExecutionSet, RetryAttempts, InitiatingTime, CompletionTime, Acknowledged, @EndDt, @UpdateUserID
	FROM	TaskState
	WHERE	TaskId = @TaskId

	DELETE	TaskState
	WHERE	TaskId = @TaskId
	AND		DataVersion = @DataVersion
GO
