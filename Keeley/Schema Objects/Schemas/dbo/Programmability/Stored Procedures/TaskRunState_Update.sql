USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskRunState_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskRunState_Update]
GO

CREATE PROCEDURE DBO.[TaskRunState_Update]
		@TaskRunStateId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskRunState_hst (
			TaskRunStateId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskRunStateId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskRunState
	WHERE	TaskRunStateId = @TaskRunStateId

	UPDATE	TaskRunState
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskRunStateId = @TaskRunStateId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskRunState
	WHERE	TaskRunStateId = @TaskRunStateId
	AND		@@ROWCOUNT > 0

GO
