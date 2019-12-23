USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractInputType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractInputType_Delete]
GO

CREATE PROCEDURE DBO.[ExtractInputType_Delete]
		@ExtractInputTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractInputType_hst (
			ExtractInputTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractInputTypeID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractInputType
	WHERE	ExtractInputTypeID = @ExtractInputTypeID

	DELETE	ExtractInputType
	WHERE	ExtractInputTypeID = @ExtractInputTypeID
	AND		DataVersion = @DataVersion
GO
