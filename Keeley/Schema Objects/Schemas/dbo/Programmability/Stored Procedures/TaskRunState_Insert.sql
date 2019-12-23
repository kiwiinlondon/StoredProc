USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskRunState_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskRunState_Insert]
GO

CREATE PROCEDURE DBO.[TaskRunState_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskRunState
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	TaskRunStateId, StartDt, DataVersion
	FROM	TaskRunState
	WHERE	TaskRunStateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
