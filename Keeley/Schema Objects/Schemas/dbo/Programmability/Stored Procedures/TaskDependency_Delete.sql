USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskDependency_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskDependency_Delete]
GO

CREATE PROCEDURE DBO.[TaskDependency_Delete]
		@TaskDependencyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskDependency_hst (
			TaskDependencyId, TaskId, DependentTaskId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskDependencyId, TaskId, DependentTaskId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskDependency
	WHERE	TaskDependencyId = @TaskDependencyId

	DELETE	TaskDependency
	WHERE	TaskDependencyId = @TaskDependencyId
	AND		DataVersion = @DataVersion
GO
