USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskSubTask_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskSubTask_Insert]
GO

CREATE PROCEDURE DBO.[TaskSubTask_Insert]
		@ParentTaskId int, 
		@SubTaskId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskSubTask
			(ParentTaskId, SubTaskId, UpdateUserID, StartDt)
	VALUES
			(@ParentTaskId, @SubTaskId, @UpdateUserID, @StartDt)

	SELECT	TaskSubTaskId, StartDt, DataVersion
	FROM	TaskSubTask
	WHERE	TaskSubTaskId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
