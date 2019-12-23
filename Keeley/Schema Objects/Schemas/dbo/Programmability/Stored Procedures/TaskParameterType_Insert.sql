USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TaskParameterType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TaskParameterType_Insert]
GO

CREATE PROCEDURE DBO.[TaskParameterType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TaskParameterType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	TaskParameterTypeId, StartDt, DataVersion
	FROM	TaskParameterType
	WHERE	TaskParameterTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
