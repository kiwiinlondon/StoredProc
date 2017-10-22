USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[OptionExerciseType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[OptionExerciseType_Delete]
GO

CREATE PROCEDURE DBO.[OptionExerciseType_Delete]
		@OptionExerciseTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO OptionExerciseType_hst (
			OptionExerciseTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	OptionExerciseTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	OptionExerciseType
	WHERE	OptionExerciseTypeId = @OptionExerciseTypeId

	DELETE	OptionExerciseType
	WHERE	OptionExerciseTypeId = @OptionExerciseTypeId
	AND		DataVersion = @DataVersion
GO
