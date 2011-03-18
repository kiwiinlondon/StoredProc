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
		@Quantity numeric(27,8), 
		@Price numeric(35,16), 
		@FXRate numeric(35,16), 
		@CurrencyId int, 
		@CounterpartyId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TradeEvent
			(EventID, InstrumentMarketID, TradeDate, SettlementDate, TraderId, Quantity, Price, FXRate, CurrencyId, CounterpartyId, UpdateUserID, StartDt)
	VALUES
			(@EventID, @InstrumentMarketID, @TradeDate, @SettlementDate, @TraderId, @Quantity, @Price, @FXRate, @CurrencyId, @CounterpartyId, @UpdateUserID, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	TradeEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
