USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OptionExerciseType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OptionExerciseType_Update]
GO

CREATE PROCEDURE DBO.[OptionExerciseType_Update]
		@OptionExerciseTypeId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO OptionExerciseType_hst (
			OptionExerciseTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	OptionExerciseTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	OptionExerciseType
	WHERE	OptionExerciseTypeId = @OptionExerciseTypeId

	UPDATE	OptionExerciseType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	OptionExerciseTypeId = @OptionExerciseTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	OptionExerciseType
	WHERE	OptionExerciseTypeId = @OptionExerciseTypeId
	AND		@@ROWCOUNT > 0

GO
