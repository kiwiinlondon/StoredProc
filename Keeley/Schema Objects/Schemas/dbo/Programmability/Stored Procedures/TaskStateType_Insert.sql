USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskStateType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskStateType_Insert]
GO

CREATE PROCEDURE DBO.[TaskStateType_Insert]
		@Name varchar(100), 
		@UpdateUserID int, 
		@Description varchar(1000)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskStateType
			(Name, UpdateUserID, Description, StartDt)
	VALUES
			(@Name, @UpdateUserID, @Description, @StartDt)

	SELECT	TaskStateTypeId, StartDt, DataVersion
	FROM	TaskStateType
	WHERE	TaskStateTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
