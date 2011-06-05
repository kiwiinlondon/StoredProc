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
		@TotalAccrual numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Portfolio_hst (
			PortfolioId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, CurrentPrice, CurrentPriceId, CurrentFXRate, CurrentFXRateId, NotionalMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, EndDt, LastActionUserID)
	SELECT	PortfolioId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, CurrentPrice, CurrentPriceId, CurrentFXRate, CurrentFXRateId, NotionalMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, @StartDt, @UpdateUserID
	FROM	Portfolio
	WHERE	PortfolioId = @PortfolioId

	UPDATE	Portfolio
	SET		PositionId = @PositionId, ReferenceDate = @ReferenceDate, NetPosition = @NetPosition, NetCostInstrumentCurrency = @NetCostInstrumentCurrency, NetCostBookCurrency = @NetCostBookCurrency, DeltaNetCostInstrumentCurrency = @DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency = @DeltaNetCostBookCurrency, TodayNetPostionChange = @TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency = @TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency = @TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency = @TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency = @TodayNetCostChangeBookCurrency, UpdateUserID = @UpdateUserID, CurrentPrice = @CurrentPrice, CurrentPriceId = @CurrentPriceId, CurrentFXRate = @CurrentFXRate, CurrentFXRateId = @CurrentFXRateId, NotionalMarketValue = @NotionalMarketValue, TodayCashBenefit = @TodayCashBenefit, TodayCashBenefitBookCurrency = @TodayCashBenefitBookCurrency, TodayAccrual = @TodayAccrual, TodayRealisedPricePnl = @TodayRealisedPricePnl, TodayRealisedFxPnl = @TodayRealisedFxPnl, TotalAccrual = @TotalAccrual,  StartDt = @StartDt
	WHERE	PortfolioId = @PortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Portfolio
	WHERE	PortfolioId = @PortfolioId
	AND		@@ROWCOUNT > 0

GO
