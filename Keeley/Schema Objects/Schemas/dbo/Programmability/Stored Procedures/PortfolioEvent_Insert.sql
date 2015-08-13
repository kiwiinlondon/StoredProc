USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEvent_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioEvent_Insert]
		@InternalAllocationId int, 
		@PositionId int, 
		@ReferenceDate datetime, 
		@PortfolioAggregationLevelId int, 
		@PortfolioEventTypeId int, 
		@ChangeNumber int, 
		@Quantity numeric(27,8), 
		@FXRate numeric(35,16), 
		@Price numeric(35,16), 
		@NetCostChangeInstrumentCurrency numeric(27,8), 
		@NetCostChangeBookCurrency numeric(27,8), 
		@NetCostInstrumentCurrency numeric(27,8), 
		@NetCostBookCurrency numeric(27,8), 
		@DeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@DeltaNetCostChangeBookCurrency numeric(27,8), 
		@DeltaNetCostInstrumentCurrency numeric(27,8), 
		@DeltaNetCostBookCurrency numeric(27,8), 
		@TodayNetPositionChange numeric(27,8), 
		@TodayDeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayDeltaNetCostChangeBookCurrency numeric(27,8), 
		@TodayNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayNetCostChangeBookCurrency numeric(27,8), 
		@NetPosition numeric(27,8), 
		@UpdateUserID int, 
		@InputDate datetime, 
		@OrderingResolution int, 
		@Accrual numeric(27,8), 
		@TodayAccrual numeric(27,8), 
		@CashBenefit numeric(27,8), 
		@TodayCashBenefit numeric(27,8), 
		@TodayCashBenefitBookCurrency numeric(27,8), 
		@RealisedPricePnl numeric(27,8), 
		@TodayRealisedPricePnl numeric(27,8), 
		@RealisedFxPnl numeric(27,8), 
		@TodayRealisedFxPnl numeric(27,8), 
		@TotalAccrual numeric(27,8), 
		@TodayRealisedPricePnlBookCurrency numeric(27,8), 
		@RealisePnl bit, 
		@TradeInstrumentFXRate numeric(35,16), 
		@ZeroOutAccrual bit, 
		@BondNominal numeric(28,7), 
		@BondNominalChange numeric(28,7), 
		@CapitalChange numeric(27,8), 
		@TodayCapitalChange numeric(27,8), 
		@FXRateId int, 
		@UseFXRateForDay bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioEvent
			(InternalAllocationId, PositionId, ReferenceDate, PortfolioAggregationLevelId, PortfolioEventTypeId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, NetPosition, UpdateUserID, InputDate, OrderingResolution, Accrual, TodayAccrual, CashBenefit, TodayCashBenefit, TodayCashBenefitBookCurrency, RealisedPricePnl, TodayRealisedPricePnl, RealisedFxPnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, RealisePnl, TradeInstrumentFXRate, ZeroOutAccrual, BondNominal, BondNominalChange, CapitalChange, TodayCapitalChange, FXRateId, UseFXRateForDay, StartDt)
	VALUES
			(@InternalAllocationId, @PositionId, @ReferenceDate, @PortfolioAggregationLevelId, @PortfolioEventTypeId, @ChangeNumber, @Quantity, @FXRate, @Price, @NetCostChangeInstrumentCurrency, @NetCostChangeBookCurrency, @NetCostInstrumentCurrency, @NetCostBookCurrency, @DeltaNetCostChangeInstrumentCurrency, @DeltaNetCostChangeBookCurrency, @DeltaNetCostInstrumentCurrency, @DeltaNetCostBookCurrency, @TodayNetPositionChange, @TodayDeltaNetCostChangeInstrumentCurrency, @TodayDeltaNetCostChangeBookCurrency, @TodayNetCostChangeInstrumentCurrency, @TodayNetCostChangeBookCurrency, @NetPosition, @UpdateUserID, @InputDate, @OrderingResolution, @Accrual, @TodayAccrual, @CashBenefit, @TodayCashBenefit, @TodayCashBenefitBookCurrency, @RealisedPricePnl, @TodayRealisedPricePnl, @RealisedFxPnl, @TodayRealisedFxPnl, @TotalAccrual, @TodayRealisedPricePnlBookCurrency, @RealisePnl, @TradeInstrumentFXRate, @ZeroOutAccrual, @BondNominal, @BondNominalChange, @CapitalChange, @TodayCapitalChange, @FXRateId, @UseFXRateForDay, @StartDt)

	SELECT	PortfolioEventID, StartDt, DataVersion
	FROM	PortfolioEvent
	WHERE	PortfolioEventID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
