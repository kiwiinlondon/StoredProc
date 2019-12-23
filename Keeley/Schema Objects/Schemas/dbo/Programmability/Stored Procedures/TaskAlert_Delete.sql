USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskAlert_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskAlert_Delete]
GO

CREATE PROCEDURE DBO.[TaskAlert_Delete]
		@TaskAlertId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskAlert_hst (
			TaskAlertId, TaskAlertTypeId, TaskId, StartDt, UpdateUserID, DataVersion, ApplyToSubTask, EndDt, LastActionUserID)
	SELECT	TaskAlertId, TaskAlertTypeId, TaskId, StartDt, UpdateUserID, DataVersion, ApplyToSubTask, @EndDt, @UpdateUserID
	FROM	TaskAlert
	WHERE	TaskAlertId = @TaskAlertId

	DELETE	TaskAlert
	WHERE	TaskAlertId = @TaskAlertId
	AND		DataVersion = @DataVersion
GO
