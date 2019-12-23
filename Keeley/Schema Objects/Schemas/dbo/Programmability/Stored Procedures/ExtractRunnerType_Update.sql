USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractRunnerType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractRunnerType_Update]
GO

CREATE PROCEDURE DBO.[ExtractRunnerType_Update]
		@ExtractRunnerTypeID int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractRunnerType_hst (
			ExtractRunnerTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractRunnerTypeID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractRunnerType
	WHERE	ExtractRunnerTypeID = @ExtractRunnerTypeID

	UPDATE	ExtractRunnerType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractRunnerTypeID = @ExtractRunnerTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractRunnerType
	WHERE	ExtractRunnerTypeID = @ExtractRunnerTypeID
	AND		@@ROWCOUNT > 0

GO
