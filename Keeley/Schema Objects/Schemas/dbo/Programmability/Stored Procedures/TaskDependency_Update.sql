USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskDependency_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskDependency_Update]
GO

CREATE PROCEDURE DBO.[TaskDependency_Update]
		@TaskDependencyId int, 
		@TaskId int, 
		@DependentTaskId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskDependency_hst (
			TaskDependencyId, TaskId, DependentTaskId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskDependencyId, TaskId, DependentTaskId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskDependency
	WHERE	TaskDependencyId = @TaskDependencyId

	UPDATE	TaskDependency
	SET		TaskId = @TaskId, DependentTaskId = @DependentTaskId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskDependencyId = @TaskDependencyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskDependency
	WHERE	TaskDependencyId = @TaskDependencyId
	AND		@@ROWCOUNT > 0

GO
