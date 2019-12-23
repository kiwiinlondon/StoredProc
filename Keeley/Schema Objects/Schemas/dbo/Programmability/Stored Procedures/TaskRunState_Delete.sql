USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskRunState_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskRunState_Delete]
GO

CREATE PROCEDURE DBO.[TaskRunState_Delete]
		@TaskRunStateId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskRunState_hst (
			TaskRunStateId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskRunStateId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskRunState
	WHERE	TaskRunStateId = @TaskRunStateId

	DELETE	TaskRunState
	WHERE	TaskRunStateId = @TaskRunStateId
	AND		DataVersion = @DataVersion
GO
