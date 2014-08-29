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
		@SubscriptionRedemptionValue numeric(27,8), 
		@TodayRedemptionPnl numeric(27,8), 
		@OpeningValueAfterTodaysTrades numeric(27,8), 
		@TodayPnl numeric(27,8), 
		@ClientPortfolioByClientShareClassId int =null
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolio_hst (
			ClientPortfolioId, ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, StartDt, UpdateUserID, DataVersion, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, FirstTradeDate, IsLast, ManagerQuantity, ManagerValue, SubscriptionRedemptionValue, TodayRedemptionPnl, OpeningValueAfterTodaysTrades, TodayPnl, ClientPortfolioByClientShareClassId, EndDt, LastActionUserID)
	SELECT	ClientPortfolioId, ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, StartDt, UpdateUserID, DataVersion, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, FirstTradeDate, IsLast, ManagerQuantity, ManagerValue, SubscriptionRedemptionValue, TodayRedemptionPnl, OpeningValueAfterTodaysTrades, TodayPnl, ClientPortfolioByClientShareClassId, @StartDt, @UpdateUserID
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = @ClientPortfolioId

	UPDATE	ClientPortfolio
	SET		ClientAccountId = @ClientAccountId, FundId = @FundId, ReferenceDate = @ReferenceDate, Quantity = @Quantity, ChangeInQuantity = @ChangeInQuantity, MarketValue = @MarketValue, PriceId = @PriceId, Price = @Price, Cost = @Cost, UpdateUserID = @UpdateUserID, TodayRealisedPnl = @TodayRealisedPnl, OpeningValue = @OpeningValue, TodayUnRealisedPnl = @TodayUnRealisedPnl, ChangeInCost = @ChangeInCost, EqualisationFactor = @EqualisationFactor, FirstTradeDate = @FirstTradeDate, IsLast = @IsLast, ManagerQuantity = @ManagerQuantity, ManagerValue = @ManagerValue, SubscriptionRedemptionValue = @SubscriptionRedemptionValue, TodayRedemptionPnl = @TodayRedemptionPnl, OpeningValueAfterTodaysTrades = @OpeningValueAfterTodaysTrades, TodayPnl = @TodayPnl, ClientPortfolioByClientShareClassId = @ClientPortfolioByClientShareClassId,  StartDt = @StartDt
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		@@ROWCOUNT > 0

GO
