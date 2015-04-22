USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TransferEvent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TransferEvent_Delete]
GO

CREATE PROCEDURE DBO.[TransferEvent_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TransferEvent_hst (
			EventID, FromAccountId, ToAccountId, Quantity, InstrumentMarketID, AmendmentNumber, IsCancelled, TradeDate, SettlementDate, InputDate, StartDt, UpdateUserID, DataVersion, Notes, ApprovedByUserId, EndDt, LastActionUserID)
	SELECT	EventID, FromAccountId, ToAccountId, Quantity, InstrumentMarketID, AmendmentNumber, IsCancelled, TradeDate, SettlementDate, InputDate, StartDt, UpdateUserID, DataVersion, Notes, ApprovedByUserId, @EndDt, @UpdateUserID
	FROM	TransferEvent
	WHERE	EventID = @EventID

	DELETE	TransferEvent
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
