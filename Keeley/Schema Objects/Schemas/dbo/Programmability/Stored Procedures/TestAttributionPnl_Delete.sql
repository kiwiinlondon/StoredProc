USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TestAttributionPnl_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TestAttributionPnl_Delete]
GO

CREATE PROCEDURE DBO.[TestAttributionPnl_Delete]
		@ ,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO TestAttributionPnl_hst (
			AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, AttributionNavId, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, MarketDataStatus, BetaShortTermId, BetaLongTermId, NavFXRate, PricePnl, FXPnl, MaxExposure, ForwardFXRate, ForwardFXRateId, EndDt, LastActionUserID)
	SELECT	AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, AttributionNavId, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, MarketDataStatus, BetaShortTermId, BetaLongTermId, NavFXRate, PricePnl, FXPnl, MaxExposure, ForwardFXRate, ForwardFXRateId, @EndDt, @UpdateUserID
	FROM	TestAttributionPnl
	WHERE	 = @

	DELETE	TestAttributionPnl
	WHERE	 = @
	AND		DataVersion = @DataVersion
GO
