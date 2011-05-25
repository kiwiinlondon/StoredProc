USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventInstrumentMap_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventInstrumentMap_Update]
GO

CREATE PROCEDURE DBO.[EventInstrumentMap_Update]
		@EventID int, 
		@InstrumentID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EventInstrumentMap_hst (
			EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EventInstrumentMap
	WHERE	InstrumentID = @InstrumentID

	UPDATE	EventInstrumentMap
	SET		EventID = @EventID, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EventInstrumentMap
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
