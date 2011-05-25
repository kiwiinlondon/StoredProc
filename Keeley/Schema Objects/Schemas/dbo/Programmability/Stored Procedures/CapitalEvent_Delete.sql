USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CapitalEvent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CapitalEvent_Delete]
GO

CREATE PROCEDURE DBO.[CapitalEvent_Delete]
		@EventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO CapitalEvent_hst (
			EventID, TradeDate, SettlementDate, Quantity, FXRate, FXRateMultiply, AmendmentNumber, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, EndDt, LastActionUserID)
	SELECT	EventID, TradeDate, SettlementDate, Quantity, FXRate, FXRateMultiply, AmendmentNumber, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, @EndDt, @UpdateUserID
	FROM	CapitalEvent
	WHERE	EventID = @EventID

	DELETE	CapitalEvent
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion
GO
