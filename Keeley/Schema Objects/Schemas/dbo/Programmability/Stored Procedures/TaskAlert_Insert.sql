USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlert_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlert_Insert]
GO

CREATE PROCEDURE DBO.[TaskAlert_Insert]
		@TaskAlertTypeId int, 
		@TaskId int, 
		@UpdateUserID int, 
		@ApplyToSubTask bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskAlert
			(TaskAlertTypeId, TaskId, UpdateUserID, ApplyToSubTask, StartDt)
	VALUES
			(@TaskAlertTypeId, @TaskId, @UpdateUserID, @ApplyToSubTask, @StartDt)

	SELECT	TaskAlertId, StartDt, DataVersion
	FROM	TaskAlert
	WHERE	TaskAlertId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
