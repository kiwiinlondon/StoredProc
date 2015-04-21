﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TransferEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TransferEvent_Update]
GO

CREATE PROCEDURE DBO.[TransferEvent_Update]
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
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TransferEvent_hst (
			EventID, FromAccountId, ToAccountId, Quantity, InstrumentMarketID, AmendmentNumber, IsCancelled, TradeDate, SettlementDate, InputDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, FromAccountId, ToAccountId, Quantity, InstrumentMarketID, AmendmentNumber, IsCancelled, TradeDate, SettlementDate, InputDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	TransferEvent
	WHERE	EventID = @EventID

	UPDATE	TransferEvent
	SET		FromAccountId = @FromAccountId, ToAccountId = @ToAccountId, Quantity = @Quantity, InstrumentMarketID = @InstrumentMarketID, AmendmentNumber = @AmendmentNumber, IsCancelled = @IsCancelled, TradeDate = @TradeDate, SettlementDate = @SettlementDate, InputDate = @InputDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TransferEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
