USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[eventinstrumentmap_tmp_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[eventinstrumentmap_tmp_Delete]
GO

CREATE PROCEDURE DBO.[eventinstrumentmap_tmp_Delete]
		@InstrumentID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO eventinstrumentmap_tmp_hst (
			EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	eventinstrumentmap_tmp
	WHERE	InstrumentID = @InstrumentID

	DELETE	eventinstrumentmap_tmp
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion
GO
