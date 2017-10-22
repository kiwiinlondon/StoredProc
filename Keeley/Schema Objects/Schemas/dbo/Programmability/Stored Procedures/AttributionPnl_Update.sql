USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionPnl_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionPnl_Update]
GO

CREATE PROCEDURE DBO.[AttributionPnl_Update]
		@AttributionPnlId int, 
		@PortfolioId int, 
		@FundId int, 
		@PositionID int, 
		@ReferenceDate datetime, 
		@AttributionSourceId int, 
		@MarketValue numeric(15,2), 
		@NetPosition numeric(15,2), 
		@IsNetPositionLong bit, 
		@IsExposureLong bit, 
		@Exposure numeric(15,2), 
		@ExposureDelta numeric(15,2), 
		@TodayPricePnl numeric(15,2), 
		@TodayFxPnl numeric(15,2), 
		@TodayCarryPnl numeric(15,2), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@AttributionNavId int, 
		@CurrencyId int, 
		@TodayOtherPnl numeric(15,2), 
		@PnlTypeId int, 
		@Price numeric(27,8), 
		@PriceId int, 
		@PriceToPositionFXRate numeric(27,8), 
		@PriceToPositionFXRateId int, 
		@FXRate numeric(27,8), 
		@FXRateId int, 
		@BetaShortTerm numeric(27,8), 
		@BetaLongTerm numeric(27,8), 
		@TodayRealisedFXPnl numeric(27,8), 
		@TodayRealisedPricePnl numeric(27,8), 
		@TodayCashBenefit numeric(27,8), 
		@NotionalCost numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionPnl_hst (
			AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, DataVersion, AttributionNavId, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, EndDt, LastActionUserID)
	SELECT	AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, DataVersion, AttributionNavId, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, @StartDt, @UpdateUserID
	FROM	AttributionPnl
	WHERE	AttributionPnlId = @AttributionPnlId

	UPDATE	AttributionPnl
	SET		PortfolioId = @PortfolioId, FundId = @FundId, PositionID = @PositionID, ReferenceDate = @ReferenceDate, AttributionSourceId = @AttributionSourceId, MarketValue = @MarketValue, NetPosition = @NetPosition, IsNetPositionLong = @IsNetPositionLong, IsExposureLong = @IsExposureLong, Exposure = @Exposure, ExposureDelta = @ExposureDelta, TodayPricePnl = @TodayPricePnl, TodayFxPnl = @TodayFxPnl, TodayCarryPnl = @TodayCarryPnl, UpdateUserID = @UpdateUserID, AttributionNavId = @AttributionNavId, CurrencyId = @CurrencyId, TodayOtherPnl = @TodayOtherPnl, PnlTypeId = @PnlTypeId, Price = @Price, PriceId = @PriceId, PriceToPositionFXRate = @PriceToPositionFXRate, PriceToPositionFXRateId = @PriceToPositionFXRateId, FXRate = @FXRate, FXRateId = @FXRateId, BetaShortTerm = @BetaShortTerm, BetaLongTerm = @BetaLongTerm, TodayRealisedFXPnl = @TodayRealisedFXPnl, TodayRealisedPricePnl = @TodayRealisedPricePnl, TodayCashBenefit = @TodayCashBenefit, NotionalCost = @NotionalCost,  StartDt = @StartDt
	WHERE	AttributionPnlId = @AttributionPnlId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionPnl
	WHERE	AttributionPnlId = @AttributionPnlId
	AND		@@ROWCOUNT > 0

GO
