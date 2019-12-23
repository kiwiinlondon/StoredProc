USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskRun_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskRun_Update]
GO

CREATE PROCEDURE DBO.[TaskRun_Update]
		@TaskRunId int, 
		@InitiatingTaskId int, 
		@InitiatingTime datetime, 
		@CompletionTime datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@TaskRunStateId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskRun_hst (
			TaskRunId, InitiatingTaskId, InitiatingTime, CompletionTime, StartDt, UpdateUserID, DataVersion, TaskRunStateId, EndDt, LastActionUserID)
	SELECT	TaskRunId, InitiatingTaskId, InitiatingTime, CompletionTime, StartDt, UpdateUserID, DataVersion, TaskRunStateId, @StartDt, @UpdateUserID
	FROM	TaskRun
	WHERE	TaskRunId = @TaskRunId

	UPDATE	TaskRun
	SET		InitiatingTaskId = @InitiatingTaskId, InitiatingTime = @InitiatingTime, CompletionTime = @CompletionTime, UpdateUserID = @UpdateUserID, TaskRunStateId = @TaskRunStateId,  StartDt = @StartDt
	WHERE	TaskRunId = @TaskRunId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskRun
	WHERE	TaskRunId = @TaskRunId
	AND		@@ROWCOUNT > 0

GO
