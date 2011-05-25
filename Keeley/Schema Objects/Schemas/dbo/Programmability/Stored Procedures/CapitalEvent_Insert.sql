USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CapitalEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CapitalEvent_Insert]
GO

CREATE PROCEDURE DBO.[CapitalEvent_Insert]
		@EventID int, 
		@TradeDate datetime, 
		@SettlementDate datetime, 
		@Quantity numeric(27,8), 
		@FXRate numeric(35,16), 
		@FXRateMultiply bit, 
		@AmendmentNumber int, 
		@IsCancelled bit, 
		@CurrencyId int, 
		@UpdateUserID int, 
		@InputDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into CapitalEvent
			(EventID, TradeDate, SettlementDate, Quantity, FXRate, FXRateMultiply, AmendmentNumber, IsCancelled, CurrencyId, UpdateUserID, InputDate, StartDt)
	VALUES
			(@EventID, @TradeDate, @SettlementDate, @Quantity, @FXRate, @FXRateMultiply, @AmendmentNumber, @IsCancelled, @CurrencyId, @UpdateUserID, @InputDate, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	CapitalEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
