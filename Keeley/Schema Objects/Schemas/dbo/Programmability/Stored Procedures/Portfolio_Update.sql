USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Portfolio_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Portfolio_Update]
GO

CREATE PROCEDURE DBO.[Portfolio_Update]
		@PortfolioId int, 
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
		@DataVersion rowversion, 
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
		@ValuationMarketValue numeric(27,8), 
		@HedgeRatio numeric(27,8), 
		@HedgeRatioId int, 
		@BetaShortTerm numeric(27,8), 
		@BetaShortTermId int, 
		@BetaLongTerm numeric(27,8), 
		@BetaLongTermId int, 
		@PreviousReferenceDate datetime, 
		@TodayCapitalChange numeric(27,8), 
		@IndexRatio numeric(27,8), 
		@IndexRatioID int, 
		@DisclosedNetPosition numeric(27,8), 
		@ValuationDeltaNetCostBookCurrency numeric(27,8), 
		@ValuationTodayDeltaNetCostChangeBookCurrency numeric(27,8), 
		@ValuationTodayDeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@ValuationTodayRealisedFxPnl numeric(27,8), 
		@ValuationTodayRealisedPricePnl numeric(27,8), 
		@ValuationTomorrowDeltaNetCostChangeBookCurrency numeric(27,8), 
		@ValuationTomorrowDeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@ValuationTomorrowRealisedFxPnl numeric(27,8), 
		@ValuationTomorrowRealisedPricePnl numeric(27,8), 
		@ValuationDeltaMarketValue numeric(27,8), 
		@ValuationTodayUnrealisedFxPnl numeric(27,8), 
		@ValuationTodayUnrealisedPricePnl numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Portfolio_hst (
			PortfolioId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, Price, PriceId, FXRate, FXRateId, DeltaMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, TodayUnrealisedFXPnl, TodayUnrealisedPricePnl, MarketValue, PriceToPositionFXRate, PriceToPositionFXRateId, PriceIsLastTradePrice, PreviousPortfolioId, BondNominal, TodayCarryAccrual, Delta, UnderlyingPrice, DeltaId, UnderlyingPriceId, UnderlyingPriceToPositionFXRate, UnderlyingPriceToPositionFXRateId, ValuationFXRate, ValuationNetPosition, ValuationDeltaNetCostInstrumentCurrency, ValuationPrice, ValuationPriceToPositionFXRate, ValuationMarketValue, HedgeRatio, HedgeRatioId, BetaShortTerm, BetaShortTermId, BetaLongTerm, BetaLongTermId, PreviousReferenceDate, TodayCapitalChange, IndexRatio, IndexRatioID, DisclosedNetPosition, ValuationDeltaNetCostBookCurrency, ValuationTodayDeltaNetCostChangeBookCurrency, ValuationTodayDeltaNetCostChangeInstrumentCurrency, ValuationTodayRealisedFxPnl, ValuationTodayRealisedPricePnl, ValuationTomorrowDeltaNetCostChangeBookCurrency, ValuationTomorrowDeltaNetCostChangeInstrumentCurrency, ValuationTomorrowRealisedFxPnl, ValuationTomorrowRealisedPricePnl, ValuationDeltaMarketValue, ValuationTodayUnrealisedFxPnl, ValuationTodayUnrealisedPricePnl, EndDt, LastActionUserID)
	SELECT	PortfolioId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, Price, PriceId, FXRate, FXRateId, DeltaMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, TodayUnrealisedFXPnl, TodayUnrealisedPricePnl, MarketValue, PriceToPositionFXRate, PriceToPositionFXRateId, PriceIsLastTradePrice, PreviousPortfolioId, BondNominal, TodayCarryAccrual, Delta, UnderlyingPrice, DeltaId, UnderlyingPriceId, UnderlyingPriceToPositionFXRate, UnderlyingPriceToPositionFXRateId, ValuationFXRate, ValuationNetPosition, ValuationDeltaNetCostInstrumentCurrency, ValuationPrice, ValuationPriceToPositionFXRate, ValuationMarketValue, HedgeRatio, HedgeRatioId, BetaShortTerm, BetaShortTermId, BetaLongTerm, BetaLongTermId, PreviousReferenceDate, TodayCapitalChange, IndexRatio, IndexRatioID, DisclosedNetPosition, ValuationDeltaNetCostBookCurrency, ValuationTodayDeltaNetCostChangeBookCurrency, ValuationTodayDeltaNetCostChangeInstrumentCurrency, ValuationTodayRealisedFxPnl, ValuationTodayRealisedPricePnl, ValuationTomorrowDeltaNetCostChangeBookCurrency, ValuationTomorrowDeltaNetCostChangeInstrumentCurrency, ValuationTomorrowRealisedFxPnl, ValuationTomorrowRealisedPricePnl, ValuationDeltaMarketValue, ValuationTodayUnrealisedFxPnl, ValuationTodayUnrealisedPricePnl, @StartDt, @UpdateUserID
	FROM	Portfolio
	WHERE	PortfolioId = @PortfolioId

	UPDATE	Portfolio
	SET		PositionId = @PositionId, ReferenceDate = @ReferenceDate, NetPosition = @NetPosition, NetCostInstrumentCurrency = @NetCostInstrumentCurrency, NetCostBookCurrency = @NetCostBookCurrency, DeltaNetCostInstrumentCurrency = @DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency = @DeltaNetCostBookCurrency, TodayNetPostionChange = @TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency = @TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency = @TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency = @TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency = @TodayNetCostChangeBookCurrency, UpdateUserID = @UpdateUserID, Price = @Price, PriceId = @PriceId, FXRate = @FXRate, FXRateId = @FXRateId, DeltaMarketValue = @DeltaMarketValue, TodayCashBenefit = @TodayCashBenefit, TodayCashBenefitBookCurrency = @TodayCashBenefitBookCurrency, TodayAccrual = @TodayAccrual, TodayRealisedPricePnl = @TodayRealisedPricePnl, TodayRealisedFxPnl = @TodayRealisedFxPnl, TotalAccrual = @TotalAccrual, TodayRealisedPricePnlBookCurrency = @TodayRealisedPricePnlBookCurrency, TodayUnrealisedFXPnl = @TodayUnrealisedFXPnl, TodayUnrealisedPricePnl = @TodayUnrealisedPricePnl, MarketValue = @MarketValue, PriceToPositionFXRate = @PriceToPositionFXRate, PriceToPositionFXRateId = @PriceToPositionFXRateId, PriceIsLastTradePrice = @PriceIsLastTradePrice, PreviousPortfolioId = @PreviousPortfolioId, BondNominal = @BondNominal, TodayCarryAccrual = @TodayCarryAccrual, Delta = @Delta, UnderlyingPrice = @UnderlyingPrice, DeltaId = @DeltaId, UnderlyingPriceId = @UnderlyingPriceId, UnderlyingPriceToPositionFXRate = @UnderlyingPriceToPositionFXRate, UnderlyingPriceToPositionFXRateId = @UnderlyingPriceToPositionFXRateId, ValuationFXRate = @ValuationFXRate, ValuationNetPosition = @ValuationNetPosition, ValuationDeltaNetCostInstrumentCurrency = @ValuationDeltaNetCostInstrumentCurrency, ValuationPrice = @ValuationPrice, ValuationPriceToPositionFXRate = @ValuationPriceToPositionFXRate, ValuationMarketValue = @ValuationMarketValue, HedgeRatio = @HedgeRatio, HedgeRatioId = @HedgeRatioId, BetaShortTerm = @BetaShortTerm, BetaShortTermId = @BetaShortTermId, BetaLongTerm = @BetaLongTerm, BetaLongTermId = @BetaLongTermId, PreviousReferenceDate = @PreviousReferenceDate, TodayCapitalChange = @TodayCapitalChange, IndexRatio = @IndexRatio, IndexRatioID = @IndexRatioID, DisclosedNetPosition = @DisclosedNetPosition, ValuationDeltaNetCostBookCurrency = @ValuationDeltaNetCostBookCurrency, ValuationTodayDeltaNetCostChangeBookCurrency = @ValuationTodayDeltaNetCostChangeBookCurrency, ValuationTodayDeltaNetCostChangeInstrumentCurrency = @ValuationTodayDeltaNetCostChangeInstrumentCurrency, ValuationTodayRealisedFxPnl = @ValuationTodayRealisedFxPnl, ValuationTodayRealisedPricePnl = @ValuationTodayRealisedPricePnl, ValuationTomorrowDeltaNetCostChangeBookCurrency = @ValuationTomorrowDeltaNetCostChangeBookCurrency, ValuationTomorrowDeltaNetCostChangeInstrumentCurrency = @ValuationTomorrowDeltaNetCostChangeInstrumentCurrency, ValuationTomorrowRealisedFxPnl = @ValuationTomorrowRealisedFxPnl, ValuationTomorrowRealisedPricePnl = @ValuationTomorrowRealisedPricePnl, ValuationDeltaMarketValue = @ValuationDeltaMarketValue, ValuationTodayUnrealisedFxPnl = @ValuationTodayUnrealisedFxPnl, ValuationTodayUnrealisedPricePnl = @ValuationTodayUnrealisedPricePnl,  StartDt = @StartDt
	WHERE	PortfolioId = @PortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Portfolio
	WHERE	PortfolioId = @PortfolioId
	AND		@@ROWCOUNT > 0

GO
