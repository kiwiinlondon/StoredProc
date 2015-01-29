USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolio_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolio_Update]
GO

CREATE PROCEDURE DBO.[ClientPortfolio_Update]
		@ClientPortfolioId int, 
		@ClientAccountId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@Quantity numeric(27,8), 
		@ChangeInQuantity numeric(27,8), 
		@MarketValue numeric(27,8), 
		@PriceId int, 
		@Price numeric(27,8), 
		@Cost numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@TodayRealisedPnl numeric(27,8), 
		@OpeningValue numeric(27,8), 
		@TodayUnRealisedPnl numeric(27,8), 
		@ChangeInCost numeric(27,8), 
		@EqualisationFactor numeric(27,8), 
		@FirstTradeDate datetime, 
		@IsLast bit, 
		@ManagerQuantity numeric(27,8), 
		@ManagerValue numeric(27,8), 
		@TodayRedemptionValue numeric(27,8), 
		@TodayRedemptionQuantity numeric(27,8), 
		@TodaySubscriptionValue numeric(27,8), 
		@TodaySubscriptionQuantity numeric(27,8), 
		@FirstNavDate datetime, 
		@ITDRedemptionValue numeric(27,8), 
		@ITDRedemptionCost numeric(27,8), 
		@ITDSubscriptionCost numeric(27,8), 
		@TodayRedemptionCost numeric(27,8), 
		@DaysSinceInception int, 
		@isFlat bit, 
		@FirstNavDateCurrent datetime, 
		@IndexUnits numeric(27,8), 
		@CostEuro numeric(27,8), 
		@CostUSD numeric(27,8), 
		@CostGBP numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolio_hst (
			ClientPortfolioId, ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, StartDt, UpdateUserID, DataVersion, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, FirstTradeDate, IsLast, ManagerQuantity, ManagerValue, TodayRedemptionValue, TodayRedemptionQuantity, TodaySubscriptionValue, TodaySubscriptionQuantity, FirstNavDate, ITDRedemptionValue, ITDRedemptionCost, ITDSubscriptionCost, TodayRedemptionCost, DaysSinceInception, isFlat, FirstNavDateCurrent, IndexUnits, CostEuro, CostUSD, CostGBP, EndDt, LastActionUserID)
	SELECT	ClientPortfolioId, ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, StartDt, UpdateUserID, DataVersion, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, FirstTradeDate, IsLast, ManagerQuantity, ManagerValue, TodayRedemptionValue, TodayRedemptionQuantity, TodaySubscriptionValue, TodaySubscriptionQuantity, FirstNavDate, ITDRedemptionValue, ITDRedemptionCost, ITDSubscriptionCost, TodayRedemptionCost, DaysSinceInception, isFlat, FirstNavDateCurrent, IndexUnits, CostEuro, CostUSD, CostGBP, @StartDt, @UpdateUserID
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = @ClientPortfolioId

	UPDATE	ClientPortfolio
	SET		ClientAccountId = @ClientAccountId, FundId = @FundId, ReferenceDate = @ReferenceDate, Quantity = @Quantity, ChangeInQuantity = @ChangeInQuantity, MarketValue = @MarketValue, PriceId = @PriceId, Price = @Price, Cost = @Cost, UpdateUserID = @UpdateUserID, TodayRealisedPnl = @TodayRealisedPnl, OpeningValue = @OpeningValue, TodayUnRealisedPnl = @TodayUnRealisedPnl, ChangeInCost = @ChangeInCost, EqualisationFactor = @EqualisationFactor, FirstTradeDate = @FirstTradeDate, IsLast = @IsLast, ManagerQuantity = @ManagerQuantity, ManagerValue = @ManagerValue, TodayRedemptionValue = @TodayRedemptionValue, TodayRedemptionQuantity = @TodayRedemptionQuantity, TodaySubscriptionValue = @TodaySubscriptionValue, TodaySubscriptionQuantity = @TodaySubscriptionQuantity, FirstNavDate = @FirstNavDate, ITDRedemptionValue = @ITDRedemptionValue, ITDRedemptionCost = @ITDRedemptionCost, ITDSubscriptionCost = @ITDSubscriptionCost, TodayRedemptionCost = @TodayRedemptionCost, DaysSinceInception = @DaysSinceInception, isFlat = @isFlat, FirstNavDateCurrent = @FirstNavDateCurrent, IndexUnits = @IndexUnits, CostEuro = @CostEuro, CostUSD = @CostUSD, CostGBP = @CostGBP,  StartDt = @StartDt
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		@@ROWCOUNT > 0

GO
