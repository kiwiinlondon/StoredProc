﻿USE Keeley

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
		@ITDSumCost numeric(27,8), 
		@ITDRealisedPnl numeric(27,8), 
		@ITDNumberDays int, 
		@TwelveMonthSumCost numeric(27,8), 
		@TwelveMonthRealisedPnl numeric(27,8), 
		@TwelveMonthNumberDays int, 
		@FirstTradeDate datetime, 
		@UpdateBridge bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPortfolio
			(ClientAccountId, FundId, ReferenceDate, Quantity, ChangeInQuantity, MarketValue, PriceId, Price, Cost, UpdateUserID, TodayRealisedPnl, OpeningValue, TodayUnRealisedPnl, ChangeInCost, EqualisationFactor, ITDSumCost, ITDRealisedPnl, ITDNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, TwelveMonthNumberDays, FirstTradeDate, UpdateBridge, StartDt)
	VALUES
			(@ClientAccountId, @FundId, @ReferenceDate, @Quantity, @ChangeInQuantity, @MarketValue, @PriceId, @Price, @Cost, @UpdateUserID, @TodayRealisedPnl, @OpeningValue, @TodayUnRealisedPnl, @ChangeInCost, @EqualisationFactor, @ITDSumCost, @ITDRealisedPnl, @ITDNumberDays, @TwelveMonthSumCost, @TwelveMonthRealisedPnl, @TwelveMonthNumberDays, @FirstTradeDate, @UpdateBridge, @StartDt)

	SELECT	ClientPortfolioId, StartDt, DataVersion
	FROM	ClientPortfolio
	WHERE	ClientPortfolioId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
