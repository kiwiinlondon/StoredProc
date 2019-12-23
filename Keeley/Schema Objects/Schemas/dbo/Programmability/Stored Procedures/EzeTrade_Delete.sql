USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EzeTrade_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EzeTrade_Delete]
GO

CREATE PROCEDURE DBO.[EzeTrade_Delete]
		@EzeTradeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EzeTrade_hst (
			ParentTradeID, TradeID, LotID, FMID, BrokerCode, OrderTimestamp, TradeTimestamp, Quantity, ResearchCommission, ExecutionCommission, CFD_GrossPrice, CFD_GrossMoney, CFD_ResearchCommission, CFDFlag, CashFlag, ImpliedCommsFlag, TradeEntrySource, EzeTradeId, BrokerSettlementCurrency, Exchange, EndDt, LastActionUserID)
	SELECT	ParentTradeID, TradeID, LotID, FMID, BrokerCode, OrderTimestamp, TradeTimestamp, Quantity, ResearchCommission, ExecutionCommission, CFD_GrossPrice, CFD_GrossMoney, CFD_ResearchCommission, CFDFlag, CashFlag, ImpliedCommsFlag, TradeEntrySource, EzeTradeId, BrokerSettlementCurrency, Exchange, @EndDt, @UpdateUserID
	FROM	EzeTrade
	WHERE	EzeTradeId = @EzeTradeId

	DELETE	EzeTrade
	WHERE	EzeTradeId = @EzeTradeId
	AND		DataVersion = @DataVersion
GO
