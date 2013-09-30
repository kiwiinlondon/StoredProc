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
		@ITDSumCost numeric(27,8), 
		@ITDRealisedPnl numeric(27,8), 
		@ITDNumberDays int, 
		@TwelveMonthSumCost numeric(27,8), 
		@TwelveMonthRealisedPnl numeric(27,8), 
		@TwelveMonthNumberDays int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolio_hst (
			ClientPortfolioId, ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, StartDt, UpdateUserID, DataVersion, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, ITDSumCost, ITDRealisedPnl, ITDNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, TwelveMonthNumberDays, EndDt, LastActionUserID)
	SELECT	ClientPortfolioId, ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, StartDt, UpdateUserID, DataVersion, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, ITDSumCost, ITDRealisedPnl, ITDNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, TwelveMonthNumberDays, @StartDt, @UpdateUserID
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = @ClientPortfolioId

	UPDATE	ClientPortfolio
	SET		ClientAccountId = @ClientAccountId, FundId = @FundId, ReferenceDate = @ReferenceDate, Quantity = @Quantity, ChangeInQuantity = @ChangeInQuantity, MarketValue = @MarketValue, PriceId = @PriceId, Price = @Price, Cost = @Cost, UpdateUserID = @UpdateUserID, TodayRealisedPnl = @TodayRealisedPnl, OpeningValue = @OpeningValue, TodayUnRealisedPnl = @TodayUnRealisedPnl, ChangeInCost = @ChangeInCost, EqualisationFactor = @EqualisationFactor, ITDSumCost = @ITDSumCost, ITDRealisedPnl = @ITDRealisedPnl, ITDNumberDays = @ITDNumberDays, TwelveMonthSumCost = @TwelveMonthSumCost, TwelveMonthRealisedPnl = @TwelveMonthRealisedPnl, TwelveMonthNumberDays = @TwelveMonthNumberDays,  StartDt = @StartDt
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		@@ROWCOUNT > 0

GO
