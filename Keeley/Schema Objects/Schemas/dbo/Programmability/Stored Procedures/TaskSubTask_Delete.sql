USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskSubTask_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskSubTask_Delete]
GO

CREATE PROCEDURE DBO.[TaskSubTask_Delete]
		@TaskSubTaskId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskSubTask_hst (
			TaskSubTaskId, ParentTaskId, SubTaskId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskSubTaskId, ParentTaskId, SubTaskId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskSubTask
	WHERE	TaskSubTaskId = @TaskSubTaskId

	DELETE	TaskSubTask
	WHERE	TaskSubTaskId = @TaskSubTaskId
	AND		DataVersion = @DataVersion
GO
