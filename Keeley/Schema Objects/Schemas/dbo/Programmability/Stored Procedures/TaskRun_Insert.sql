USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskRun_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskRun_Insert]
GO

CREATE PROCEDURE DBO.[TaskRun_Insert]
		@InitiatingTaskId int, 
		@InitiatingTime datetime, 
		@CompletionTime datetime, 
		@UpdateUserID int, 
		@TaskRunStateId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskRun
			(InitiatingTaskId, InitiatingTime, CompletionTime, UpdateUserID, TaskRunStateId, StartDt)
	VALUES
			(@InitiatingTaskId, @InitiatingTime, @CompletionTime, @UpdateUserID, @TaskRunStateId, @StartDt)

	SELECT	TaskRunId, StartDt, DataVersion
	FROM	TaskRun
	WHERE	TaskRunId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
