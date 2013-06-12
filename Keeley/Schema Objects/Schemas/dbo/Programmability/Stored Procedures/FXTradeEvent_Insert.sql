USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FXTradeEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FXTradeEvent_Insert]
GO

CREATE PROCEDURE DBO.[FXTradeEvent_Insert]
		@EventID int, 
		@ReceiveCurrencyId int, 
		@PayCurrencyId int, 
		@ReceiveAmount numeric(27,8), 
		@PayAmount numeric(27,8), 
		@IsProp bit, 
		@EnteredMultiply bit, 
		@Ticket varchar(100), 
		@IsCancelled bit, 
		@CounterpartyId int, 
		@AmendmentNumber int, 
		@MaturityDate datetime, 
		@TraderId int, 
		@UpdateUserID int, 
		@TradeDate datetime, 
		@IsForward bit, 
		@InputDate datetime, 
		@SettlementCurrencyId int, 
		@SupressFromExtracts bit, 
		@NonEuroPairReceiveToEuroFXRate numeric(27,8), 
		@NonEuroPairReceiveToEuroFXRateId int, 
		@IsRoll bit, 
		@ContraEventId int, 
		@InstrumentMarketId int, 
		@OriginalInputDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FXTradeEvent
			(EventID, ReceiveCurrencyId, PayCurrencyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, Ticket, IsCancelled, CounterpartyId, AmendmentNumber, MaturityDate, TraderId, UpdateUserID, TradeDate, IsForward, InputDate, SettlementCurrencyId, SupressFromExtracts, NonEuroPairReceiveToEuroFXRate, NonEuroPairReceiveToEuroFXRateId, IsRoll, ContraEventId, InstrumentMarketId, OriginalInputDate, StartDt)
	VALUES
			(@EventID, @ReceiveCurrencyId, @PayCurrencyId, @ReceiveAmount, @PayAmount, @IsProp, @EnteredMultiply, @Ticket, @IsCancelled, @CounterpartyId, @AmendmentNumber, @MaturityDate, @TraderId, @UpdateUserID, @TradeDate, @IsForward, @InputDate, @SettlementCurrencyId, @SupressFromExtracts, @NonEuroPairReceiveToEuroFXRate, @NonEuroPairReceiveToEuroFXRateId, @IsRoll, @ContraEventId, @InstrumentMarketId, @OriginalInputDate, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	FXTradeEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
