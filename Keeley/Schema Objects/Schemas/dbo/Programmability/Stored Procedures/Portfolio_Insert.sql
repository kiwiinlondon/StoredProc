USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Portfolio_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Portfolio_Insert]
GO

CREATE PROCEDURE DBO.[Portfolio_Insert]
		@PositionId int, 
		@ReferenceDate datetime, 
		@NetPosition numeric(27,8), 
		@NetCostInstrumentCurrency numeric(27,8), 
		@NetCostBookCurrency numeric(27,8), 
		@DeltaNetCostInstrumentCurrency numeric(27,8), 
		@DeltaNetCostBookCurrency numeric(27,8), 
		@TodayNetPostionChange numeric(27,8), 
		@TodayDeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayDeltaNetCostChangeBookCurrency numeric(27,8), 
		@TodayNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayNetCostChangeBookCurrency numeric(27,8), 
		@UpdateUserID int, 
		@Price numeric(27,8), 
		@PriceId int, 
		@FXRate numeric(35,16), 
		@FXRateId int, 
		@DeltaMarketValue numeric(27,8), 
		@TodayCashBenefit numeric(27,8), 
		@TodayCashBenefitBookCurrency numeric(27,8), 
		@TodayAccrual numeric(27,8), 
		@TodayRealisedPricePnl numeric(27,8), 
		@TodayRealisedFxPnl numeric(27,8), 
		@TotalAccrual numeric(27,8), 
		@TodayRealisedPricePnlBookCurrency numeric(27,8), 
		@TodayUnrealisedFXPnl numeric(27,8), 
		@TodayUnrealisedPricePnl numeric(27,8), 
		@MarketValue numeric(27,8), 
		@PriceToPositionFXRate numeric(35,16), 
		@PriceToPositionFXRateId int, 
		@PriceIsLastTradePrice bit, 
		@PreviousPortfolioId int, 
		@BondNominal numeric(28,7), 
		@TodayCarryAccrual numeric(27,8), 
		@Delta numeric(27,8), 
		@UnderlyingPrice numeric(27,8), 
		@DeltaId int, 
		@UnderlyingPriceId int, 
		@UnderlyingPriceToPositionFXRate numeric(27,8), 
		@UnderlyingPriceToPositionFXRateId int, 
		@ValuationFXRate numeric(35,16), 
		@ValuationNetPosition numeric(27,8), 
		@ValuationDeltaNetCostInstrumentCurrency numeric(27,8), 
		@ValuationPrice numeric(27,8), 
		@ValuationPriceToPositionFXRate numeric(27,8), 
		@ValuationMarketValue numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Portfolio
			(PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, UpdateUserID, Price, PriceId, FXRate, FXRateId, DeltaMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, TodayUnrealisedFXPnl, TodayUnrealisedPricePnl, MarketValue, PriceToPositionFXRate, PriceToPositionFXRateId, PriceIsLastTradePrice, PreviousPortfolioId, BondNominal, TodayCarryAccrual, Delta, UnderlyingPrice, DeltaId, UnderlyingPriceId, UnderlyingPriceToPositionFXRate, UnderlyingPriceToPositionFXRateId, ValuationFXRate, ValuationNetPosition, ValuationDeltaNetCostInstrumentCurrency, ValuationPrice, ValuationPriceToPositionFXRate, ValuationMarketValue, StartDt)
	VALUES
			(@PositionId, @ReferenceDate, @NetPosition, @NetCostInstrumentCurrency, @NetCostBookCurrency, @DeltaNetCostInstrumentCurrency, @DeltaNetCostBookCurrency, @TodayNetPostionChange, @TodayDeltaNetCostChangeInstrumentCurrency, @TodayDeltaNetCostChangeBookCurrency, @TodayNetCostChangeInstrumentCurrency, @TodayNetCostChangeBookCurrency, @UpdateUserID, @Price, @PriceId, @FXRate, @FXRateId, @DeltaMarketValue, @TodayCashBenefit, @TodayCashBenefitBookCurrency, @TodayAccrual, @TodayRealisedPricePnl, @TodayRealisedFxPnl, @TotalAccrual, @TodayRealisedPricePnlBookCurrency, @TodayUnrealisedFXPnl, @TodayUnrealisedPricePnl, @MarketValue, @PriceToPositionFXRate, @PriceToPositionFXRateId, @PriceIsLastTradePrice, @PreviousPortfolioId, @BondNominal, @TodayCarryAccrual, @Delta, @UnderlyingPrice, @DeltaId, @UnderlyingPriceId, @UnderlyingPriceToPositionFXRate, @UnderlyingPriceToPositionFXRateId, @ValuationFXRate, @ValuationNetPosition, @ValuationDeltaNetCostInstrumentCurrency, @ValuationPrice, @ValuationPriceToPositionFXRate, @ValuationMarketValue, @StartDt)

	SELECT	PortfolioId, StartDt, DataVersion
	FROM	Portfolio
	WHERE	PortfolioId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
