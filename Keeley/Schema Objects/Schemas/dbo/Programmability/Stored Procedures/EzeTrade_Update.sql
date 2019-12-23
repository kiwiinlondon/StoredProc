USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EzeTrade_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EzeTrade_Update]
GO

CREATE PROCEDURE DBO.[EzeTrade_Update]
		@ParentTradeID varchar(15), 
		@TradeID varchar(15), 
		@LotID varchar(7), 
		@FMID varchar(10), 
		@BrokerCode varchar(5), 
		@OrderTimestamp datetime, 
		@TradeTimestamp datetime, 
		@Quantity numeric(27,8), 
		@ResearchCommission numeric(27,8), 
		@ExecutionCommission float, 
		@CFD_GrossPrice float, 
		@CFD_GrossMoney float, 
		@CFD_ResearchCommission float, 
		@CFDFlag int, 
		@CashFlag int, 
		@ImpliedCommsFlag int, 
		@TradeEntrySource varchar(100), 
		@EzeTradeId int, 
		@BrokerSettlementCurrency varchar(20), 
		@Exchange varchar(50)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EzeTrade_hst (
			ParentTradeID, TradeID, LotID, FMID, BrokerCode, OrderTimestamp, TradeTimestamp, Quantity, ResearchCommission, ExecutionCommission, CFD_GrossPrice, CFD_GrossMoney, CFD_ResearchCommission, CFDFlag, CashFlag, ImpliedCommsFlag, TradeEntrySource, EzeTradeId, BrokerSettlementCurrency, Exchange, EndDt, LastActionUserID)
	SELECT	ParentTradeID, TradeID, LotID, FMID, BrokerCode, OrderTimestamp, TradeTimestamp, Quantity, ResearchCommission, ExecutionCommission, CFD_GrossPrice, CFD_GrossMoney, CFD_ResearchCommission, CFDFlag, CashFlag, ImpliedCommsFlag, TradeEntrySource, EzeTradeId, BrokerSettlementCurrency, Exchange, @StartDt, @UpdateUserID
	FROM	EzeTrade
	WHERE	EzeTradeId = @EzeTradeId

	UPDATE	EzeTrade
	SET		ParentTradeID = @ParentTradeID, TradeID = @TradeID, LotID = @LotID, FMID = @FMID, BrokerCode = @BrokerCode, OrderTimestamp = @OrderTimestamp, TradeTimestamp = @TradeTimestamp, Quantity = @Quantity, ResearchCommission = @ResearchCommission, ExecutionCommission = @ExecutionCommission, CFD_GrossPrice = @CFD_GrossPrice, CFD_GrossMoney = @CFD_GrossMoney, CFD_ResearchCommission = @CFD_ResearchCommission, CFDFlag = @CFDFlag, CashFlag = @CashFlag, ImpliedCommsFlag = @ImpliedCommsFlag, TradeEntrySource = @TradeEntrySource, BrokerSettlementCurrency = @BrokerSettlementCurrency, Exchange = @Exchange,  StartDt = @StartDt
	WHERE	EzeTradeId = @EzeTradeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EzeTrade
	WHERE	EzeTradeId = @EzeTradeId
	AND		@@ROWCOUNT > 0

GO
