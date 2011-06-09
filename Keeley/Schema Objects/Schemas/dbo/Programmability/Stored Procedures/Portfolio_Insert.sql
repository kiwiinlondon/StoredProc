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
		@CurrentPrice numeric(27,8), 
		@CurrentPriceId int, 
		@CurrentFXRate numeric(27,8), 
		@CurrentFXRateId int, 
		@NotionalMarketValue numeric(27,8), 
		@TodayCashBenefit numeric(27,8), 
		@TodayCashBenefitBookCurrency numeric(27,8), 
		@TodayAccrual numeric(27,8), 
		@TodayRealisedPricePnl numeric(27,8), 
		@TodayRealisedFxPnl numeric(27,8), 
		@TotalAccrual numeric(27,8), 
		@TodayRealisedPricePnlBookCurrency numeric(27,8), 
		@UnrealisedFXPnl numeric(27,8), 
		@UnrealisedPricePnl numeric(27,8), 
		@MarketValue numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Portfolio
			(PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, UpdateUserID, CurrentPrice, CurrentPriceId, CurrentFXRate, CurrentFXRateId, NotionalMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, UnrealisedFXPnl, UnrealisedPricePnl, MarketValue, StartDt)
	VALUES
			(@PositionId, @ReferenceDate, @NetPosition, @NetCostInstrumentCurrency, @NetCostBookCurrency, @DeltaNetCostInstrumentCurrency, @DeltaNetCostBookCurrency, @TodayNetPostionChange, @TodayDeltaNetCostChangeInstrumentCurrency, @TodayDeltaNetCostChangeBookCurrency, @TodayNetCostChangeInstrumentCurrency, @TodayNetCostChangeBookCurrency, @UpdateUserID, @CurrentPrice, @CurrentPriceId, @CurrentFXRate, @CurrentFXRateId, @NotionalMarketValue, @TodayCashBenefit, @TodayCashBenefitBookCurrency, @TodayAccrual, @TodayRealisedPricePnl, @TodayRealisedFxPnl, @TotalAccrual, @TodayRealisedPricePnlBookCurrency, @UnrealisedFXPnl, @UnrealisedPricePnl, @MarketValue, @StartDt)

	SELECT	PortfolioId, StartDt, DataVersion
	FROM	Portfolio
	WHERE	PortfolioId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
