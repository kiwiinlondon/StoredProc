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
		@AmendmentNumber int, 
		@IsCancelled bit, 
		@CurrencyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@InputDate datetime, 
		@AdministratorTradeDate datetime=null
AS
	SET NOCOUNT ON

	if @AdministratorTradeDate is null
	begin
		set @AdministratorTradeDate = @TradeDate
	end

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO CapitalEvent_hst (
			EventID, TradeDate, SettlementDate, Quantity, AmendmentNumber, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, AdministratorTradeDate, EndDt, LastActionUserID)
	SELECT	EventID, TradeDate, SettlementDate, Quantity, AmendmentNumber, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, AdministratorTradeDate, @StartDt, @UpdateUserID
	FROM	CapitalEvent
	WHERE	EventID = @EventID

	UPDATE	CapitalEvent
	SET		TradeDate = @TradeDate, SettlementDate = @SettlementDate, Quantity = @Quantity, AmendmentNumber = @AmendmentNumber, IsCancelled = @IsCancelled, CurrencyId = @CurrencyId, UpdateUserID = @UpdateUserID, InputDate = @InputDate, AdministratorTradeDate = @AdministratorTradeDate,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	CapitalEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
