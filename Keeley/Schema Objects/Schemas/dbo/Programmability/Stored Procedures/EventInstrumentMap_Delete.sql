USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventInstrumentMap_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventInstrumentMap_Delete]
GO

CREATE PROCEDURE DBO.[EventInstrumentMap_Delete]
		@InstrumentID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EventInstrumentMap_hst (
			EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EventInstrumentMap
	WHERE	InstrumentID = @InstrumentID

	DELETE	EventInstrumentMap
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion
GO
