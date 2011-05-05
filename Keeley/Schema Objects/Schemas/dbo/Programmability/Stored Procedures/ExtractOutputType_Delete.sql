USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractOutputType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractOutputType_Delete]
GO

CREATE PROCEDURE DBO.[ExtractOutputType_Delete]
		@ExtractOutputTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractOutputType_hst (
			ExtractOutputTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractOutputTypeID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractOutputType
	WHERE	ExtractOutputTypeID = @ExtractOutputTypeID

	DELETE	ExtractOutputType
	WHERE	ExtractOutputTypeID = @ExtractOutputTypeID
	AND		DataVersion = @DataVersion
GO
