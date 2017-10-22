USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OptionExerciseType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OptionExerciseType_Insert]
GO

CREATE PROCEDURE DBO.[OptionExerciseType_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into OptionExerciseType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	OptionExerciseTypeId, StartDt, DataVersion
	FROM	OptionExerciseType
	WHERE	OptionExerciseTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
