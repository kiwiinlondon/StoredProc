USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskResult_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskResult_Insert]
GO

CREATE PROCEDURE DBO.[TaskResult_Insert]
		@TaskId int, 
		@TaskResultTypeId int, 
		@Notes varchar(2000), 
		@UpdateUserID int, 
		@TaskRunId int, 
		@AffectedEntityCount int, 
		@RetryAttempt int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskResult
			(TaskId, TaskResultTypeId, Notes, UpdateUserID, TaskRunId, AffectedEntityCount, RetryAttempt, StartDt)
	VALUES
			(@TaskId, @TaskResultTypeId, @Notes, @UpdateUserID, @TaskRunId, @AffectedEntityCount, @RetryAttempt, @StartDt)

	SELECT	TaskResultId, StartDt, DataVersion
	FROM	TaskResult
	WHERE	TaskResultId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
