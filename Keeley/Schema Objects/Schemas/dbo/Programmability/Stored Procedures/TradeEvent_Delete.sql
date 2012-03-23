USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TradeEvent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TradeEvent_Delete]
GO

CREATE PROCEDURE DBO.[TradeEvent_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TradeEvent_hst (
			EventID, InstrumentMarketID, TradeDate, SettlementDate, TraderId, GrossPrice, NetPrice, Quantity, BuySellReasonId, TradedNet, PriceIsClean, TradeCurrencyId, SettlementCurrencyId, NetConsideration, GrossConsideration, CounterpartyId, TradeSettlementFXRate, TradeSettlementFXRateMultiply, TradeInstrumentFXRate, TradeInstrumentFXRateMultiply, Ticket, IsCancelled, AmendmentNumber, StartDt, UpdateUserID, DataVersion, InputDate, SupressFromExtracts, TradeEuroFXRate, TradeEuroFXRateId, IsRoll, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentMarketID, TradeDate, SettlementDate, TraderId, GrossPrice, NetPrice, Quantity, BuySellReasonId, TradedNet, PriceIsClean, TradeCurrencyId, SettlementCurrencyId, NetConsideration, GrossConsideration, CounterpartyId, TradeSettlementFXRate, TradeSettlementFXRateMultiply, TradeInstrumentFXRate, TradeInstrumentFXRateMultiply, Ticket, IsCancelled, AmendmentNumber, StartDt, UpdateUserID, DataVersion, InputDate, SupressFromExtracts, TradeEuroFXRate, TradeEuroFXRateId, IsRoll, @EndDt, @UpdateUserID
	FROM	TradeEvent
	WHERE	EventID = @EventID

	DELETE	TradeEvent
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
