USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TradeEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TradeEvent_Update]
GO

CREATE PROCEDURE DBO.[TradeEvent_Update]
		@EventID int, 
		@InstrumentMarketID int, 
		@TradeDate datetime, 
		@SettlementDate datetime, 
		@TraderId int, 
		@GrossPrice numeric(35,16), 
		@NetPrice numeric(35,16), 
		@Quantity numeric(27,8), 
		@BuySellReasonId int, 
		@TradedNet bit, 
		@PriceIsClean bit, 
		@TradeCurrencyId int, 
		@SettlementCurrencyId int, 
		@NetConsideration numeric(27,8), 
		@GrossConsideration numeric(27,8), 
		@CounterpartyId int, 
		@TradeSettlementFXRate numeric(35,16), 
		@TradeSettlementFXRateMultiply bit, 
		@TradeInstrumentFXRate numeric(35,16), 
		@TradeInstrumentFXRateMultiply bit, 
		@Ticket varchar(100), 
		@IsCancelled bit, 
		@AmendmentNumber int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@InputDate datetime, 
		@SupressFromExtracts bit, 
		@TradeEuroFXRate numeric(27,8), 
		@TradeEuroFXRateId int, 
		@IsRoll bit, 
		@ContraEventId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TradeEvent_hst (
			EventID, InstrumentMarketID, TradeDate, SettlementDate, TraderId, GrossPrice, NetPrice, Quantity, BuySellReasonId, TradedNet, PriceIsClean, TradeCurrencyId, SettlementCurrencyId, NetConsideration, GrossConsideration, CounterpartyId, TradeSettlementFXRate, TradeSettlementFXRateMultiply, TradeInstrumentFXRate, TradeInstrumentFXRateMultiply, Ticket, IsCancelled, AmendmentNumber, StartDt, UpdateUserID, DataVersion, InputDate, SupressFromExtracts, TradeEuroFXRate, TradeEuroFXRateId, IsRoll, ContraEventId, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentMarketID, TradeDate, SettlementDate, TraderId, GrossPrice, NetPrice, Quantity, BuySellReasonId, TradedNet, PriceIsClean, TradeCurrencyId, SettlementCurrencyId, NetConsideration, GrossConsideration, CounterpartyId, TradeSettlementFXRate, TradeSettlementFXRateMultiply, TradeInstrumentFXRate, TradeInstrumentFXRateMultiply, Ticket, IsCancelled, AmendmentNumber, StartDt, UpdateUserID, DataVersion, InputDate, SupressFromExtracts, TradeEuroFXRate, TradeEuroFXRateId, IsRoll, ContraEventId, @StartDt, @UpdateUserID
	FROM	TradeEvent
	WHERE	EventID = @EventID

	UPDATE	TradeEvent
	SET		InstrumentMarketID = @InstrumentMarketID, TradeDate = @TradeDate, SettlementDate = @SettlementDate, TraderId = @TraderId, GrossPrice = @GrossPrice, NetPrice = @NetPrice, Quantity = @Quantity, BuySellReasonId = @BuySellReasonId, TradedNet = @TradedNet, PriceIsClean = @PriceIsClean, TradeCurrencyId = @TradeCurrencyId, SettlementCurrencyId = @SettlementCurrencyId, NetConsideration = @NetConsideration, GrossConsideration = @GrossConsideration, CounterpartyId = @CounterpartyId, TradeSettlementFXRate = @TradeSettlementFXRate, TradeSettlementFXRateMultiply = @TradeSettlementFXRateMultiply, TradeInstrumentFXRate = @TradeInstrumentFXRate, TradeInstrumentFXRateMultiply = @TradeInstrumentFXRateMultiply, Ticket = @Ticket, IsCancelled = @IsCancelled, AmendmentNumber = @AmendmentNumber, UpdateUserID = @UpdateUserID, InputDate = @InputDate, SupressFromExtracts = @SupressFromExtracts, TradeEuroFXRate = @TradeEuroFXRate, TradeEuroFXRateId = @TradeEuroFXRateId, IsRoll = @IsRoll, ContraEventId = @ContraEventId,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TradeEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
