USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentEvent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentEvent_Delete]
GO

CREATE PROCEDURE DBO.[InstrumentEvent_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentEvent_hst (
			EventID, InstrumentMarketID, InstrumentEventTypeID, EventDate, ValueDate, Quantity, AmendmentNumber, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, ExDate, Price, EventDateOverride, IsPNLOnly, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentMarketID, InstrumentEventTypeID, EventDate, ValueDate, Quantity, AmendmentNumber, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, ExDate, Price, EventDateOverride, IsPNLOnly, @EndDt, @UpdateUserID
	FROM	InstrumentEvent
	WHERE	EventID = @EventID

	DELETE	InstrumentEvent
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
