USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolio_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolio_Delete]
GO

CREATE PROCEDURE DBO.[ClientPortfolio_Delete]
		@ClientPortfolioId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientPortfolio_hst (
			ClientPortfolioId, ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, StartDt, UpdateUserID, DataVersion, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, FirstTradeDate, IsLast, ManagerQuantity, ManagerValue, SubscriptionRedemptionValue, TodayRedemptionPnl, OpeningValueAfterTodaysTrades, TodayPnl, ClientPortfolioByClientShareClassId, TodayReturn, ITDReturn, TodayRedemptionValue, TodayRedemptionQuantity, TodaySubscriptionValue, TodaySubscriptionQuantity, ValueOfTodaysSubscriptionRedeemed, FirstNavDate, ITDRedemptionValue, ITDRedemptionCost, ITDSubscriptionCost, TodayRedemptionCost, SumITDSubscriptionCost, DaysSinceInception, isFlat, FirstNavDateCurrent, IndexUnits, CostEuro, CostUSD, CostGBP, EndDt, LastActionUserID)
	SELECT	ClientPortfolioId, ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, StartDt, UpdateUserID, DataVersion, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, FirstTradeDate, IsLast, ManagerQuantity, ManagerValue, SubscriptionRedemptionValue, TodayRedemptionPnl, OpeningValueAfterTodaysTrades, TodayPnl, ClientPortfolioByClientShareClassId, TodayReturn, ITDReturn, TodayRedemptionValue, TodayRedemptionQuantity, TodaySubscriptionValue, TodaySubscriptionQuantity, ValueOfTodaysSubscriptionRedeemed, FirstNavDate, ITDRedemptionValue, ITDRedemptionCost, ITDSubscriptionCost, TodayRedemptionCost, SumITDSubscriptionCost, DaysSinceInception, isFlat, FirstNavDateCurrent, IndexUnits, CostEuro, CostUSD, CostGBP, @EndDt, @UpdateUserID
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = @ClientPortfolioId

	DELETE	ClientPortfolio
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		DataVersion = @DataVersion
GO
