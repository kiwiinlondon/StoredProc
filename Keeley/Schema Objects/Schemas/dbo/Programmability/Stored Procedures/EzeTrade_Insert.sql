USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EzeTrade_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EzeTrade_Insert]
GO

CREATE PROCEDURE DBO.[EzeTrade_Insert]
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
		@BrokerSettlementCurrency varchar(20), 
		@Exchange varchar(50)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EzeTrade
			(ParentTradeID, TradeID, LotID, FMID, BrokerCode, OrderTimestamp, TradeTimestamp, Quantity, ResearchCommission, ExecutionCommission, CFD_GrossPrice, CFD_GrossMoney, CFD_ResearchCommission, CFDFlag, CashFlag, ImpliedCommsFlag, TradeEntrySource, BrokerSettlementCurrency, Exchange, StartDt)
	VALUES
			(@ParentTradeID, @TradeID, @LotID, @FMID, @BrokerCode, @OrderTimestamp, @TradeTimestamp, @Quantity, @ResearchCommission, @ExecutionCommission, @CFD_GrossPrice, @CFD_GrossMoney, @CFD_ResearchCommission, @CFDFlag, @CashFlag, @ImpliedCommsFlag, @TradeEntrySource, @BrokerSettlementCurrency, @Exchange, @StartDt)

	SELECT	EzeTradeId, StartDt, DataVersion
	FROM	EzeTrade
	WHERE	EzeTradeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
