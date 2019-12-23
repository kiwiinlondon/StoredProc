USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Task_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Task_Insert]
GO

CREATE PROCEDURE DBO.[Task_Insert]
		@TaskTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@TaskNotCompleteBehaviourId int, 
		@MaxRetryAttempts int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Task
			(TaskTypeId, Name, UpdateUserID, TaskNotCompleteBehaviourId, MaxRetryAttempts, StartDt)
	VALUES
			(@TaskTypeId, @Name, @UpdateUserID, @TaskNotCompleteBehaviourId, @MaxRetryAttempts, @StartDt)

	SELECT	TaskId, StartDt, DataVersion
	FROM	Task
	WHERE	TaskId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
