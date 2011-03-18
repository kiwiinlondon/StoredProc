USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CapitalEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CapitalEvent_Update]
GO

CREATE PROCEDURE DBO.[CapitalEvent_Update]
		@EventID int, 
		@TradeDate datetime, 
		@SettlementDate datetime, 
		@Quantity numeric(27,8), 
		@FXRate numeric(35,16), 
		@CurrencyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO CapitalEvent_hst (
			EventID, TradeDate, SettlementDate, Quantity, FXRate, CurrencyId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, TradeDate, SettlementDate, Quantity, FXRate, CurrencyId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	CapitalEvent
	WHERE	EventID = @EventID

	UPDATE	CapitalEvent
	SET		TradeDate = @TradeDate, SettlementDate = @SettlementDate, Quantity = @Quantity, FXRate = @FXRate, CurrencyId = @CurrencyId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	CapitalEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
