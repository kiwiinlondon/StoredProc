USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskNotCompleteBehaviour_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskNotCompleteBehaviour_Delete]
GO

CREATE PROCEDURE DBO.[TaskNotCompleteBehaviour_Delete]
		@TaskNotCompleteBehaviourId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TaskNotCompleteBehaviour_hst (
			TaskNotCompleteBehaviourId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskNotCompleteBehaviourId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	TaskNotCompleteBehaviour
	WHERE	TaskNotCompleteBehaviourId = @TaskNotCompleteBehaviourId

	DELETE	TaskNotCompleteBehaviour
	WHERE	TaskNotCompleteBehaviourId = @TaskNotCompleteBehaviourId
	AND		DataVersion = @DataVersion
GO
