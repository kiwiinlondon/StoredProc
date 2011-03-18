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
		@Quantity numeric(27,8), 
		@Price numeric(35,16), 
		@FXRate numeric(35,16), 
		@CurrencyId int, 
		@CounterpartyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TradeEvent_hst (
			EventID, InstrumentMarketID, TradeDate, SettlementDate, TraderId, Quantity, Price, FXRate, CurrencyId, CounterpartyId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentMarketID, TradeDate, SettlementDate, TraderId, Quantity, Price, FXRate, CurrencyId, CounterpartyId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TradeEvent
	WHERE	EventID = @EventID

	UPDATE	TradeEvent
	SET		InstrumentMarketID = @InstrumentMarketID, TradeDate = @TradeDate, SettlementDate = @SettlementDate, TraderId = @TraderId, Quantity = @Quantity, Price = @Price, FXRate = @FXRate, CurrencyId = @CurrencyId, CounterpartyId = @CounterpartyId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TradeEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
