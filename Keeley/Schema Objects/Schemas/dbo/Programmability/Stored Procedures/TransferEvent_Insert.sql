USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TransferEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TransferEvent_Insert]
GO

CREATE PROCEDURE DBO.[TransferEvent_Insert]
		@EventID int, 
		@FromAccountId int, 
		@ToAccountId int, 
		@Quantity numeric(27,8), 
		@InstrumentMarketID int, 
		@AmendmentNumber int, 
		@IsCancelled bit, 
		@TradeDate datetime, 
		@SettlementDate datetime, 
		@InputDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into TransferEvent
			(EventID, FromAccountId, ToAccountId, Quantity, InstrumentMarketID, AmendmentNumber, IsCancelled, TradeDate, SettlementDate, InputDate, UpdateUserID, StartDt)
	VALUES
			(@EventID, @FromAccountId, @ToAccountId, @Quantity, @InstrumentMarketID, @AmendmentNumber, @IsCancelled, @TradeDate, @SettlementDate, @InputDate, @UpdateUserID, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	TransferEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
