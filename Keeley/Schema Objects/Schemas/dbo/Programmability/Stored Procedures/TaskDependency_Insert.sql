USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskDependency_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskDependency_Insert]
GO

CREATE PROCEDURE DBO.[TaskDependency_Insert]
		@TaskId int, 
		@DependentTaskId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskDependency
			(TaskId, DependentTaskId, UpdateUserID, StartDt)
	VALUES
			(@TaskId, @DependentTaskId, @UpdateUserID, @StartDt)

	SELECT	TaskDependencyId, StartDt, DataVersion
	FROM	TaskDependency
	WHERE	TaskDependencyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
