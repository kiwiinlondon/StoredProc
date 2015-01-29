USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolio_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolio_Insert]
GO

CREATE PROCEDURE DBO.[ClientPortfolio_Insert]
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

	INSERT into ClientPortfolio
			(ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, UpdateUserID, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, FirstTradeDate, IsLast, ManagerQuantity, ManagerValue, TodayRedemptionValue, TodayRedemptionQuantity, TodaySubscriptionValue, TodaySubscriptionQuantity, FirstNavDate, ITDRedemptionValue, ITDRedemptionCost, ITDSubscriptionCost, TodayRedemptionCost, DaysSinceInception, isFlat, FirstNavDateCurrent, IndexUnits, CostEuro, CostUSD, CostGBP, StartDt)
	VALUES
			(@ClientAccountId, @FundId, @ReferenceDate, @Quantity, @ChangeInQuantity, @MarketValue, @PriceId, @Price, @Cost, @UpdateUserID, @TodayRealisedPnl, @OpeningValue, @TodayUnRealisedPnl, @ChangeInCost, @EqualisationFactor, @FirstTradeDate, @IsLast, @ManagerQuantity, @ManagerValue, @TodayRedemptionValue, @TodayRedemptionQuantity, @TodaySubscriptionValue, @TodaySubscriptionQuantity, @FirstNavDate, @ITDRedemptionValue, @ITDRedemptionCost, @ITDSubscriptionCost, @TodayRedemptionCost, @DaysSinceInception, @isFlat, @FirstNavDateCurrent, @IndexUnits, @CostEuro, @CostUSD, @CostGBP, @StartDt)

	SELECT	ClientPortfolioId, StartDt, DataVersion
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
