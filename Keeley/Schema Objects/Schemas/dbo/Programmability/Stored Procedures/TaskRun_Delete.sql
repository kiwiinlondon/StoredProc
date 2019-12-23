USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskRun_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskRun_Delete]
GO

CREATE PROCEDURE DBO.[TaskRun_Delete]
		@TaskRunId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskRun_hst (
			TaskRunId, InitiatingTaskId, InitiatingTime, CompletionTime, StartDt, UpdateUserID, DataVersion, TaskRunStateId, EndDt, LastActionUserID)
	SELECT	TaskRunId, InitiatingTaskId, InitiatingTime, CompletionTime, StartDt, UpdateUserID, DataVersion, TaskRunStateId, @EndDt, @UpdateUserID
	FROM	TaskRun
	WHERE	TaskRunId = @TaskRunId

	DELETE	TaskRun
	WHERE	TaskRunId = @TaskRunId
	AND		DataVersion = @DataVersion
GO
