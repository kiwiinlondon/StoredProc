USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Task_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Task_Delete]
GO

CREATE PROCEDURE DBO.[Task_Delete]
		@TaskId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Task_hst (
			TaskId, TaskTypeId, Name, StartDt, UpdateUserID, DataVersion, TaskNotCompleteBehaviourId, MaxRetryAttempts, EndDt, LastActionUserID)
	SELECT	TaskId, TaskTypeId, Name, StartDt, UpdateUserID, DataVersion, TaskNotCompleteBehaviourId, MaxRetryAttempts, @EndDt, @UpdateUserID
	FROM	Task
	WHERE	TaskId = @TaskId

	DELETE	Task
	WHERE	TaskId = @TaskId
	AND		DataVersion = @DataVersion
GO
