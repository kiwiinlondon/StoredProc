USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlert_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlert_Update]
GO

CREATE PROCEDURE DBO.[TaskAlert_Update]
		@TaskAlertId int, 
		@TaskAlertTypeId int, 
		@TaskId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ApplyToSubTask bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskAlert_hst (
			TaskAlertId, TaskAlertTypeId, TaskId, StartDt, UpdateUserID, DataVersion, ApplyToSubTask, EndDt, LastActionUserID)
	SELECT	TaskAlertId, TaskAlertTypeId, TaskId, StartDt, UpdateUserID, DataVersion, ApplyToSubTask, @StartDt, @UpdateUserID
	FROM	TaskAlert
	WHERE	TaskAlertId = @TaskAlertId

	UPDATE	TaskAlert
	SET		TaskAlertTypeId = @TaskAlertTypeId, TaskId = @TaskId, UpdateUserID = @UpdateUserID, ApplyToSubTask = @ApplyToSubTask,  StartDt = @StartDt
	WHERE	TaskAlertId = @TaskAlertId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskAlert
	WHERE	TaskAlertId = @TaskAlertId
	AND		@@ROWCOUNT > 0

GO
