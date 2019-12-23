USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Task_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Task_Update]
GO

CREATE PROCEDURE DBO.[Task_Update]
		@TaskId int, 
		@TaskTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@TaskNotCompleteBehaviourId int, 
		@MaxRetryAttempts int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Task_hst (
			TaskId, TaskTypeId, Name, StartDt, UpdateUserID, DataVersion, TaskNotCompleteBehaviourId, MaxRetryAttempts, EndDt, LastActionUserID)
	SELECT	TaskId, TaskTypeId, Name, StartDt, UpdateUserID, DataVersion, TaskNotCompleteBehaviourId, MaxRetryAttempts, @StartDt, @UpdateUserID
	FROM	Task
	WHERE	TaskId = @TaskId

	UPDATE	Task
	SET		TaskTypeId = @TaskTypeId, Name = @Name, UpdateUserID = @UpdateUserID, TaskNotCompleteBehaviourId = @TaskNotCompleteBehaviourId, MaxRetryAttempts = @MaxRetryAttempts,  StartDt = @StartDt
	WHERE	TaskId = @TaskId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Task
	WHERE	TaskId = @TaskId
	AND		@@ROWCOUNT > 0

GO
