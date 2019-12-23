USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskResult_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskResult_Update]
GO

CREATE PROCEDURE DBO.[TaskResult_Update]
		@TaskResultId int, 
		@TaskId int, 
		@TaskResultTypeId int, 
		@Notes varchar(2000), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@TaskRunId int, 
		@AffectedEntityCount int, 
		@RetryAttempt int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskResult_hst (
			TaskResultId, TaskId, TaskResultTypeId, Notes, StartDt, UpdateUserID, DataVersion, TaskRunId, AffectedEntityCount, RetryAttempt, EndDt, LastActionUserID)
	SELECT	TaskResultId, TaskId, TaskResultTypeId, Notes, StartDt, UpdateUserID, DataVersion, TaskRunId, AffectedEntityCount, RetryAttempt, @StartDt, @UpdateUserID
	FROM	TaskResult
	WHERE	TaskResultId = @TaskResultId

	UPDATE	TaskResult
	SET		TaskId = @TaskId, TaskResultTypeId = @TaskResultTypeId, Notes = @Notes, UpdateUserID = @UpdateUserID, TaskRunId = @TaskRunId, AffectedEntityCount = @AffectedEntityCount, RetryAttempt = @RetryAttempt,  StartDt = @StartDt
	WHERE	TaskResultId = @TaskResultId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskResult
	WHERE	TaskResultId = @TaskResultId
	AND		@@ROWCOUNT > 0

GO
