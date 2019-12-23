USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractType_Delete]
GO

CREATE PROCEDURE DBO.[ExtractType_Delete]
		@ExtractTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractType_hst (
			ExtractTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractTypeID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractType
	WHERE	ExtractTypeID = @ExtractTypeID

	DELETE	ExtractType
	WHERE	ExtractTypeID = @ExtractTypeID
	AND		DataVersion = @DataVersion
GO
