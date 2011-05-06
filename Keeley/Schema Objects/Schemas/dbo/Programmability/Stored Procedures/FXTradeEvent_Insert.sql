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
		@ReceiveAmount decimal, 
		@PayAmount decimal, 
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
		@PayBookXrate numeric(35,16), 
		@ReceiveBookXrate numeric(35,16), 
		@InputDate datetime, 
		@SettlementCurrencyId int, 
		@SettlementBookXrate numeric(35,16), 
		@SupressFromExtracts bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FXTradeEvent
			(EventID, ReceiveCurrencyId, PayCurrencyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, Ticket, IsCancelled, CounterpartyId, AmendmentNumber, MaturityDate, TraderId, UpdateUserID, TradeDate, IsForward, PayBookXrate, ReceiveBookXrate, InputDate, SettlementCurrencyId, SettlementBookXrate, SupressFromExtracts, StartDt)
	VALUES
			(@EventID, @ReceiveCurrencyId, @PayCurrencyId, @ReceiveAmount, @PayAmount, @IsProp, @EnteredMultiply, @Ticket, @IsCancelled, @CounterpartyId, @AmendmentNumber, @MaturityDate, @TraderId, @UpdateUserID, @TradeDate, @IsForward, @PayBookXrate, @ReceiveBookXrate, @InputDate, @SettlementCurrencyId, @SettlementBookXrate, @SupressFromExtracts, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	FXTradeEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
