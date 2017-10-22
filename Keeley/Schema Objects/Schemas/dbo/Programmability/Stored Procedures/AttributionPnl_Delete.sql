USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionPnl_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionPnl_Delete]
GO

CREATE PROCEDURE DBO.[AttributionPnl_Delete]
		@AttributionPnlId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AttributionPnl_hst (
			AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, DataVersion, AttributionNavId, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, EndDt, LastActionUserID)
	SELECT	AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, DataVersion, AttributionNavId, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, @EndDt, @UpdateUserID
	FROM	AttributionPnl
	WHERE	AttributionPnlId = @AttributionPnlId

	DELETE	AttributionPnl
	WHERE	AttributionPnlId = @AttributionPnlId
	AND		DataVersion = @DataVersion
GO
