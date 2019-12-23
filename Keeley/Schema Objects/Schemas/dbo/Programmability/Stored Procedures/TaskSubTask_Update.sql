USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskSubTask_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskSubTask_Update]
GO

CREATE PROCEDURE DBO.[TaskSubTask_Update]
		@TaskSubTaskId int, 
		@ParentTaskId int, 
		@SubTaskId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskSubTask_hst (
			TaskSubTaskId, ParentTaskId, SubTaskId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskSubTaskId, ParentTaskId, SubTaskId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskSubTask
	WHERE	TaskSubTaskId = @TaskSubTaskId

	UPDATE	TaskSubTask
	SET		ParentTaskId = @ParentTaskId, SubTaskId = @SubTaskId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskSubTaskId = @TaskSubTaskId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskSubTask
	WHERE	TaskSubTaskId = @TaskSubTaskId
	AND		@@ROWCOUNT > 0

GO
