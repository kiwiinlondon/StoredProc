USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioNonAggregated_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioNonAggregated_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioNonAggregated_Delete]
		@PortfolioNonAggregatedID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioNonAggregated_hst (
			PortfolioNonAggregatedID, PortfolioID, StrategyID, TradeTypeID, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, Accrual, CashIncome, StartDt, UpdateUserID, DataVersion, FMContViewLadderID, EndDt, LastActionUserID)
	SELECT	PortfolioNonAggregatedID, PortfolioID, StrategyID, TradeTypeID, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, Accrual, CashIncome, StartDt, UpdateUserID, DataVersion, FMContViewLadderID, @EndDt, @UpdateUserID
	FROM	PortfolioNonAggregated
	WHERE	PortfolioNonAggregatedID = @PortfolioNonAggregatedID

	DELETE	PortfolioNonAggregated
	WHERE	PortfolioNonAggregatedID = @PortfolioNonAggregatedID
	AND		DataVersion = @DataVersion
GO
