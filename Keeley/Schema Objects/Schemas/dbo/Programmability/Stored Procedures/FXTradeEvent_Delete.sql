USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FXTradeEvent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FXTradeEvent_Delete]
GO

CREATE PROCEDURE DBO.[FXTradeEvent_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FXTradeEvent_hst (
			EventID, ReceiveCurrencyId, PayCurrencyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, Ticket, IsCancelled, CounterpartyId, AmendmentNumber, MaturityDate, TraderId, StartDt, UpdateUserID, DataVersion, TradeDate, IsForward, InputDate, SettlementCurrencyId, SupressFromExtracts, NonEuroPairReceiveToEuroFXRate, NonEuroPairReceiveToEuroFXRateId, IsRoll, ContraEventId, InstrumentMarketId, OriginalInputDate, ReceiveToBookFXRateOverride, PayToBookFXRateOverride, PNLInstrumentMarketId, RebuildTrade, OrderSentToBrokerDate, EzeParentTradeId, EndDt, LastActionUserID)
	SELECT	EventID, ReceiveCurrencyId, PayCurrencyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, Ticket, IsCancelled, CounterpartyId, AmendmentNumber, MaturityDate, TraderId, StartDt, UpdateUserID, DataVersion, TradeDate, IsForward, InputDate, SettlementCurrencyId, SupressFromExtracts, NonEuroPairReceiveToEuroFXRate, NonEuroPairReceiveToEuroFXRateId, IsRoll, ContraEventId, InstrumentMarketId, OriginalInputDate, ReceiveToBookFXRateOverride, PayToBookFXRateOverride, PNLInstrumentMarketId, RebuildTrade, OrderSentToBrokerDate, EzeParentTradeId, @EndDt, @UpdateUserID
	FROM	FXTradeEvent
	WHERE	EventID = @EventID

	DELETE	FXTradeEvent
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
