USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAccountingEvent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAccountingEvent_Delete]
GO

CREATE PROCEDURE DBO.[InternalAccountingEvent_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InternalAccountingEvent_hst (
			EventID, InstrumentMarketID, InternalAccountingEventTypeId, TradeDate, SettlementDate, TraderId, NetPrice, GrossPrice, Quantity, NetConsideration, InstrumentBookFXRate, IsCancelled, AmendmentNumber, StartDt, UpdateUserID, DataVersion, SettlementCurrencyId, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentMarketID, InternalAccountingEventTypeId, TradeDate, SettlementDate, TraderId, NetPrice, GrossPrice, Quantity, NetConsideration, InstrumentBookFXRate, IsCancelled, AmendmentNumber, StartDt, UpdateUserID, DataVersion, SettlementCurrencyId, @EndDt, @UpdateUserID
	FROM	InternalAccountingEvent
	WHERE	EventID = @EventID

	DELETE	InternalAccountingEvent
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
