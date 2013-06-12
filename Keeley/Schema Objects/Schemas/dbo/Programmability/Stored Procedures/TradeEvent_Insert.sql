USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TradeEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TradeEvent_Insert]
GO

CREATE PROCEDURE DBO.[TradeEvent_Insert]
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
		@InputDate datetime, 
		@SupressFromExtracts bit, 
		@TradeEuroFXRate numeric(27,8), 
		@TradeEuroFXRateId int, 
		@IsRoll bit, 
		@ContraEventId int, 
		@OriginalInputDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TradeEvent
			(EventID, InstrumentMarketID, TradeDate, SettlementDate, TraderId, GrossPrice, NetPrice, Quantity, BuySellReasonId, TradedNet, PriceIsClean, TradeCurrencyId, SettlementCurrencyId, NetConsideration, GrossConsideration, CounterpartyId, TradeSettlementFXRate, TradeSettlementFXRateMultiply, TradeInstrumentFXRate, TradeInstrumentFXRateMultiply, Ticket, IsCancelled, AmendmentNumber, UpdateUserID, InputDate, SupressFromExtracts, TradeEuroFXRate, TradeEuroFXRateId, IsRoll, ContraEventId, OriginalInputDate, StartDt)
	VALUES
			(@EventID, @InstrumentMarketID, @TradeDate, @SettlementDate, @TraderId, @GrossPrice, @NetPrice, @Quantity, @BuySellReasonId, @TradedNet, @PriceIsClean, @TradeCurrencyId, @SettlementCurrencyId, @NetConsideration, @GrossConsideration, @CounterpartyId, @TradeSettlementFXRate, @TradeSettlementFXRateMultiply, @TradeInstrumentFXRate, @TradeInstrumentFXRateMultiply, @Ticket, @IsCancelled, @AmendmentNumber, @UpdateUserID, @InputDate, @SupressFromExtracts, @TradeEuroFXRate, @TradeEuroFXRateId, @IsRoll, @ContraEventId, @OriginalInputDate, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	TradeEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
