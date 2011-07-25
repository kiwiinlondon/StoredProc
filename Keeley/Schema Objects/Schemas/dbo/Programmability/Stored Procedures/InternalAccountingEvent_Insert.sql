USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAccountingEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAccountingEvent_Insert]
GO

CREATE PROCEDURE DBO.[InternalAccountingEvent_Insert]
		@EventID int, 
		@InstrumentMarketID int, 
		@InternalAccountingEventTypeId int, 
		@TradeDate datetime, 
		@SettlementDate datetime, 
		@TraderId int, 
		@NetPrice numeric(35,16), 
		@GrossPrice numeric(35,16), 
		@Quantity numeric(27,8), 
		@NetConsideration numeric(27,8), 
		@InstrumentBookFXRate numeric(35,16), 
		@IsCancelled bit, 
		@AmendmentNumber int, 
		@UpdateUserID int, 
		@SettlementCurrencyId int, 
		@InputDate datetime, 
		@TradeInstrumentFXRate numeric(35,16), 
		@TradeInstrumentFXRateMultiply bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InternalAccountingEvent
			(EventID, InstrumentMarketID, InternalAccountingEventTypeId, TradeDate, SettlementDate, TraderId, NetPrice, GrossPrice, Quantity, NetConsideration, InstrumentBookFXRate, IsCancelled, AmendmentNumber, UpdateUserID, SettlementCurrencyId, InputDate, TradeInstrumentFXRate, TradeInstrumentFXRateMultiply, StartDt)
	VALUES
			(@EventID, @InstrumentMarketID, @InternalAccountingEventTypeId, @TradeDate, @SettlementDate, @TraderId, @NetPrice, @GrossPrice, @Quantity, @NetConsideration, @InstrumentBookFXRate, @IsCancelled, @AmendmentNumber, @UpdateUserID, @SettlementCurrencyId, @InputDate, @TradeInstrumentFXRate, @TradeInstrumentFXRateMultiply, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	InternalAccountingEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
