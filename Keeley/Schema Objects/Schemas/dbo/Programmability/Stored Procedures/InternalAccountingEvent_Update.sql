USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAccountingEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAccountingEvent_Update]
GO

CREATE PROCEDURE DBO.[InternalAccountingEvent_Update]
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
		@DataVersion rowversion, 
		@SettlementCurrencyId int, 
		@InputDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InternalAccountingEvent_hst (
			EventID, InstrumentMarketID, InternalAccountingEventTypeId, TradeDate, SettlementDate, TraderId, NetPrice, GrossPrice, Quantity, NetConsideration, InstrumentBookFXRate, IsCancelled, AmendmentNumber, StartDt, UpdateUserID, DataVersion, SettlementCurrencyId, InputDate, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentMarketID, InternalAccountingEventTypeId, TradeDate, SettlementDate, TraderId, NetPrice, GrossPrice, Quantity, NetConsideration, InstrumentBookFXRate, IsCancelled, AmendmentNumber, StartDt, UpdateUserID, DataVersion, SettlementCurrencyId, InputDate, @StartDt, @UpdateUserID
	FROM	InternalAccountingEvent
	WHERE	EventID = @EventID

	UPDATE	InternalAccountingEvent
	SET		InstrumentMarketID = @InstrumentMarketID, InternalAccountingEventTypeId = @InternalAccountingEventTypeId, TradeDate = @TradeDate, SettlementDate = @SettlementDate, TraderId = @TraderId, NetPrice = @NetPrice, GrossPrice = @GrossPrice, Quantity = @Quantity, NetConsideration = @NetConsideration, InstrumentBookFXRate = @InstrumentBookFXRate, IsCancelled = @IsCancelled, AmendmentNumber = @AmendmentNumber, UpdateUserID = @UpdateUserID, SettlementCurrencyId = @SettlementCurrencyId, InputDate = @InputDate,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InternalAccountingEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
