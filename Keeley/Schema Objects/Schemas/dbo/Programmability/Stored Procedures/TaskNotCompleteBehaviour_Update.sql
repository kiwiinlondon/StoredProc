USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskNotCompleteBehaviour_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskNotCompleteBehaviour_Update]
GO

CREATE PROCEDURE DBO.[TaskNotCompleteBehaviour_Update]
		@TaskNotCompleteBehaviourId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TaskNotCompleteBehaviour_hst (
			TaskNotCompleteBehaviourId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	TaskNotCompleteBehaviourId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TaskNotCompleteBehaviour
	WHERE	TaskNotCompleteBehaviourId = @TaskNotCompleteBehaviourId

	UPDATE	TaskNotCompleteBehaviour
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	TaskNotCompleteBehaviourId = @TaskNotCompleteBehaviourId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TaskNotCompleteBehaviour
	WHERE	TaskNotCompleteBehaviourId = @TaskNotCompleteBehaviourId
	AND		@@ROWCOUNT > 0

GO
