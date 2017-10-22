USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionPnl_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionPnl_Insert]
GO

CREATE PROCEDURE DBO.[AttributionPnl_Insert]
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

	INSERT into AttributionPnl
			(PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, UpdateUserID, AttributionNavId, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, StartDt)
	VALUES
			(@PortfolioId, @FundId, @PositionID, @ReferenceDate, @AttributionSourceId, @MarketValue, @NetPosition, @IsNetPositionLong, @IsExposureLong, @Exposure, @ExposureDelta, @TodayPricePnl, @TodayFxPnl, @TodayCarryPnl, @UpdateUserID, @AttributionNavId, @CurrencyId, @TodayOtherPnl, @PnlTypeId, @Price, @PriceId, @PriceToPositionFXRate, @PriceToPositionFXRateId, @FXRate, @FXRateId, @BetaShortTerm, @BetaLongTerm, @TodayRealisedFXPnl, @TodayRealisedPricePnl, @TodayCashBenefit, @NotionalCost, @StartDt)

	SELECT	AttributionPnlId, StartDt, DataVersion
	FROM	AttributionPnl
	WHERE	AttributionPnlId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
