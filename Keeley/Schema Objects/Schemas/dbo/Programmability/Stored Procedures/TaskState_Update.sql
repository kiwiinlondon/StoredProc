USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskState_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskState_Update]
GO

CREATE PROCEDURE DBO.[TaskState_Update]
		@TaskId int, 
		@TaskStateTypeId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@LastTaskRunId int, 
		@ExecutionSet int, 
		@RetryAttempts int, 
		@InitiatingTime datetime, 
		@CompletionTime datetime, 
		@Acknowledged bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskState_hst (
			TaskId, TaskStateTypeId, StartDt, UpdateUserID, DataVersion, LastTaskRunId, ExecutionSet, RetryAttempts, InitiatingTime, CompletionTime, Acknowledged, EndDt, LastActionUserID)
	SELECT	TaskId, TaskStateTypeId, StartDt, UpdateUserID, DataVersion, LastTaskRunId, ExecutionSet, RetryAttempts, InitiatingTime, CompletionTime, Acknowledged, @StartDt, @UpdateUserID
	FROM	TaskState
	WHERE	TaskId = @TaskId

	UPDATE	TaskState
	SET		TaskStateTypeId = @TaskStateTypeId, UpdateUserID = @UpdateUserID, LastTaskRunId = @LastTaskRunId, ExecutionSet = @ExecutionSet, RetryAttempts = @RetryAttempts, InitiatingTime = @InitiatingTime, CompletionTime = @CompletionTime, Acknowledged = @Acknowledged,  StartDt = @StartDt
	WHERE	TaskId = @TaskId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskState
	WHERE	TaskId = @TaskId
	AND		@@ROWCOUNT > 0

GO
