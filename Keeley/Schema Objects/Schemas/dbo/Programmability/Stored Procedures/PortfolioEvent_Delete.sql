USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEvent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEvent_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioEvent_Delete]
		@PortfolioEventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioEvent_hst (
			PortfolioEventID, InternalAllocationId, PositionId, ReferenceDate, PortfolioAggregationLevelId, PortfolioEventTypeId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, InputDate, OrderingResolution, Accrual, TodayAccrual, CashBenefit, TodayCashBenefit, TodayCashBenefitBookCurrency, RealisedPricePnl, TodayRealisedPricePnl, RealisedFxPnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, RealisePnl, TradeInstrumentFXRate, ZeroOutAccrual, BondNominal, BondNominalChange, ValuationDeltaNetCostInstrumentCurrency, ValuationNetPosition, EndDt, LastActionUserID)
	SELECT	PortfolioEventID, InternalAllocationId, PositionId, ReferenceDate, PortfolioAggregationLevelId, PortfolioEventTypeId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, InputDate, OrderingResolution, Accrual, TodayAccrual, CashBenefit, TodayCashBenefit, TodayCashBenefitBookCurrency, RealisedPricePnl, TodayRealisedPricePnl, RealisedFxPnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, RealisePnl, TradeInstrumentFXRate, ZeroOutAccrual, BondNominal, BondNominalChange, ValuationDeltaNetCostInstrumentCurrency, ValuationNetPosition, @EndDt, @UpdateUserID
	FROM	PortfolioEvent
	WHERE	PortfolioEventID = @PortfolioEventID

	DELETE	PortfolioEvent
	WHERE	PortfolioEventID = @PortfolioEventID
	AND		DataVersion = @DataVersion
GO
