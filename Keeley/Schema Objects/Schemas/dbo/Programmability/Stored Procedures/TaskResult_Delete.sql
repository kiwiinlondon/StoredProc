USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskResult_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskResult_Delete]
GO

CREATE PROCEDURE DBO.[TaskResult_Delete]
		@TaskResultId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskResult_hst (
			TaskResultId, TaskId, TaskResultTypeId, Notes, StartDt, UpdateUserID, DataVersion, TaskRunId, AffectedEntityCount, RetryAttempt, EndDt, LastActionUserID)
	SELECT	TaskResultId, TaskId, TaskResultTypeId, Notes, StartDt, UpdateUserID, DataVersion, TaskRunId, AffectedEntityCount, RetryAttempt, @EndDt, @UpdateUserID
	FROM	TaskResult
	WHERE	TaskResultId = @TaskResultId

	DELETE	TaskResult
	WHERE	TaskResultId = @TaskResultId
	AND		DataVersion = @DataVersion
GO
