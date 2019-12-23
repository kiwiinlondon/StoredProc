USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskState_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskState_Insert]
GO

CREATE PROCEDURE DBO.[TaskState_Insert]
		@TaskId int, 
		@TaskStateTypeId int, 
		@UpdateUserID int, 
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

	INSERT into TaskState
			(TaskId, TaskStateTypeId, UpdateUserID, LastTaskRunId, ExecutionSet, RetryAttempts, InitiatingTime, CompletionTime, Acknowledged, StartDt)
	VALUES
			(@TaskId, @TaskStateTypeId, @UpdateUserID, @LastTaskRunId, @ExecutionSet, @RetryAttempts, @InitiatingTime, @CompletionTime, @Acknowledged, @StartDt)

	SELECT	TaskId, StartDt, DataVersion
	FROM	TaskState
	WHERE	TaskId = @TaskId
	AND		@@ROWCOUNT > 0

GO
