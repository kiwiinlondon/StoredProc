USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FXTradeEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FXTradeEvent_Update]
GO

CREATE PROCEDURE DBO.[FXTradeEvent_Update]
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
		@DataVersion rowversion, 
		@TradeDate datetime, 
		@IsForward bit, 
		@PayBookXrate numeric(35,16), 
		@ReceiveBookXrate numeric(35,16)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FXTradeEvent_hst (
			EventID, ReceiveCurrencyId, PayCurrencyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, Ticket, IsCancelled, CounterpartyId, AmendmentNumber, MaturityDate, TraderId, StartDt, UpdateUserID, DataVersion, TradeDate, IsForward, PayBookXrate, ReceiveBookXrate, EndDt, LastActionUserID)
	SELECT	EventID, ReceiveCurrencyId, PayCurrencyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, Ticket, IsCancelled, CounterpartyId, AmendmentNumber, MaturityDate, TraderId, StartDt, UpdateUserID, DataVersion, TradeDate, IsForward, PayBookXrate, ReceiveBookXrate, @StartDt, @UpdateUserID
	FROM	FXTradeEvent
	WHERE	EventID = @EventID

	UPDATE	FXTradeEvent
	SET		ReceiveCurrencyId = @ReceiveCurrencyId, PayCurrencyId = @PayCurrencyId, ReceiveAmount = @ReceiveAmount, PayAmount = @PayAmount, IsProp = @IsProp, EnteredMultiply = @EnteredMultiply, Ticket = @Ticket, IsCancelled = @IsCancelled, CounterpartyId = @CounterpartyId, AmendmentNumber = @AmendmentNumber, MaturityDate = @MaturityDate, TraderId = @TraderId, UpdateUserID = @UpdateUserID, TradeDate = @TradeDate, IsForward = @IsForward, PayBookXrate = @PayBookXrate, ReceiveBookXrate = @ReceiveBookXrate,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FXTradeEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
