USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Portfolio_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Portfolio_Delete]
GO

CREATE PROCEDURE DBO.[Portfolio_Delete]
		@PortfolioId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Portfolio_hst (
			PortfolioId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, Price, PriceId, FXRate, FXRateId, DeltaMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, TodayUnrealisedFXPnl, TodayUnrealisedPricePnl, MarketValue, PriceToPositionFXRate, PriceToPositionFXRateId, PriceIsLastTradePrice, PreviousPortfolioId, BondNominal, TodayCarryAccrual, Delta, UnderlyingPrice, DeltaId, UnderlyingPriceId, UnderlyingPriceToPositionFXRate, UnderlyingPriceToPositionFXRateId, ValuationFXRate, ValuationNetPosition, ValuationDeltaNetCostInstrumentCurrency, ValuationPrice, ValuationPriceToPositionFXRate, ValuationMarketValue, EndDt, LastActionUserID)
	SELECT	PortfolioId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, Price, PriceId, FXRate, FXRateId, DeltaMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, TodayUnrealisedFXPnl, TodayUnrealisedPricePnl, MarketValue, PriceToPositionFXRate, PriceToPositionFXRateId, PriceIsLastTradePrice, PreviousPortfolioId, BondNominal, TodayCarryAccrual, Delta, UnderlyingPrice, DeltaId, UnderlyingPriceId, UnderlyingPriceToPositionFXRate, UnderlyingPriceToPositionFXRateId, ValuationFXRate, ValuationNetPosition, ValuationDeltaNetCostInstrumentCurrency, ValuationPrice, ValuationPriceToPositionFXRate, ValuationMarketValue, @EndDt, @UpdateUserID
	FROM	Portfolio
	WHERE	PortfolioId = @PortfolioId

	DELETE	Portfolio
	WHERE	PortfolioId = @PortfolioId
	AND		DataVersion = @DataVersion
GO
