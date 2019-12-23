USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskNotCompleteBehaviour_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskNotCompleteBehaviour_Insert]
GO

CREATE PROCEDURE DBO.[TaskNotCompleteBehaviour_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskNotCompleteBehaviour
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	TaskNotCompleteBehaviourId, StartDt, DataVersion
	FROM	TaskNotCompleteBehaviour
	WHERE	TaskNotCompleteBehaviourId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
