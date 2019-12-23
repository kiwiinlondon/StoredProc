USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractRunnerType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractRunnerType_Delete]
GO

CREATE PROCEDURE DBO.[ExtractRunnerType_Delete]
		@ExtractRunnerTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractRunnerType_hst (
			ExtractRunnerTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractRunnerTypeID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractRunnerType
	WHERE	ExtractRunnerTypeID = @ExtractRunnerTypeID

	DELETE	ExtractRunnerType
	WHERE	ExtractRunnerTypeID = @ExtractRunnerTypeID
	AND		DataVersion = @DataVersion
GO
