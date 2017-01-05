USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEvent_Update]
GO

CREATE PROCEDURE DBO.[PortfolioEvent_Update]
		@PortfolioEventID int, 
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
		@DataVersion rowversion, 
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
		@UseFXRateForDay bit, 
		@RealisedCash numeric(27,8), 
		@ExternalRealisedPnl numeric(27,8), 
		@OriginalDeltaNetCostBookCurrency numeric(27,8), 
		@OriginalDeltaNetCostInstrumentCurrency numeric(27,8), 
		@ITDRealisedPricePnl numeric(27,8), 
		@ITDRealisedFXPnl numeric(27,8), 
		@ResetCost bit, 
		@Yield numeric(27,8), 
		@BlendedYield numeric(27,8), 
		@AmortisationCost numeric(27,8), 
		@AmortisationQuantity numeric(27,8), 
		@TotalAmortisationQuantity numeric(27,8), 
		@InflationAssumption numeric(27,8), 
		@BlendedInflationAssumption numeric(27,8), 
		@AssociatedPositionId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioEvent_hst (
			PortfolioEventID, InternalAllocationId, PositionId, ReferenceDate, PortfolioAggregationLevelId, PortfolioEventTypeId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, InputDate, OrderingResolution, Accrual, TodayAccrual, CashBenefit, TodayCashBenefit, TodayCashBenefitBookCurrency, RealisedPricePnl, TodayRealisedPricePnl, RealisedFxPnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, RealisePnl, TradeInstrumentFXRate, ZeroOutAccrual, BondNominal, BondNominalChange, CapitalChange, TodayCapitalChange, FXRateId, UseFXRateForDay, RealisedCash, ExternalRealisedPnl, OriginalDeltaNetCostBookCurrency, OriginalDeltaNetCostInstrumentCurrency, ITDRealisedPricePnl, ITDRealisedFXPnl, ResetCost, Yield, BlendedYield, AmortisationCost, AmortisationQuantity, TotalAmortisationQuantity, InflationAssumption, BlendedInflationAssumption, AssociatedPositionId, EndDt, LastActionUserID)
	SELECT	PortfolioEventID, InternalAllocationId, PositionId, ReferenceDate, PortfolioAggregationLevelId, PortfolioEventTypeId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, InputDate, OrderingResolution, Accrual, TodayAccrual, CashBenefit, TodayCashBenefit, TodayCashBenefitBookCurrency, RealisedPricePnl, TodayRealisedPricePnl, RealisedFxPnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, RealisePnl, TradeInstrumentFXRate, ZeroOutAccrual, BondNominal, BondNominalChange, CapitalChange, TodayCapitalChange, FXRateId, UseFXRateForDay, RealisedCash, ExternalRealisedPnl, OriginalDeltaNetCostBookCurrency, OriginalDeltaNetCostInstrumentCurrency, ITDRealisedPricePnl, ITDRealisedFXPnl, ResetCost, Yield, BlendedYield, AmortisationCost, AmortisationQuantity, TotalAmortisationQuantity, InflationAssumption, BlendedInflationAssumption, AssociatedPositionId, @StartDt, @UpdateUserID
	FROM	PortfolioEvent
	WHERE	PortfolioEventID = @PortfolioEventID

	UPDATE	PortfolioEvent
	SET		InternalAllocationId = @InternalAllocationId, PositionId = @PositionId, ReferenceDate = @ReferenceDate, PortfolioAggregationLevelId = @PortfolioAggregationLevelId, PortfolioEventTypeId = @PortfolioEventTypeId, ChangeNumber = @ChangeNumber, Quantity = @Quantity, FXRate = @FXRate, Price = @Price, NetCostChangeInstrumentCurrency = @NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency = @NetCostChangeBookCurrency, NetCostInstrumentCurrency = @NetCostInstrumentCurrency, NetCostBookCurrency = @NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency = @DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency = @DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency = @DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency = @DeltaNetCostBookCurrency, TodayNetPositionChange = @TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency = @TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency = @TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency = @TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency = @TodayNetCostChangeBookCurrency, NetPosition = @NetPosition, UpdateUserID = @UpdateUserID, InputDate = @InputDate, OrderingResolution = @OrderingResolution, Accrual = @Accrual, TodayAccrual = @TodayAccrual, CashBenefit = @CashBenefit, TodayCashBenefit = @TodayCashBenefit, TodayCashBenefitBookCurrency = @TodayCashBenefitBookCurrency, RealisedPricePnl = @RealisedPricePnl, TodayRealisedPricePnl = @TodayRealisedPricePnl, RealisedFxPnl = @RealisedFxPnl, TodayRealisedFxPnl = @TodayRealisedFxPnl, TotalAccrual = @TotalAccrual, TodayRealisedPricePnlBookCurrency = @TodayRealisedPricePnlBookCurrency, RealisePnl = @RealisePnl, TradeInstrumentFXRate = @TradeInstrumentFXRate, ZeroOutAccrual = @ZeroOutAccrual, BondNominal = @BondNominal, BondNominalChange = @BondNominalChange, CapitalChange = @CapitalChange, TodayCapitalChange = @TodayCapitalChange, FXRateId = @FXRateId, UseFXRateForDay = @UseFXRateForDay, RealisedCash = @RealisedCash, ExternalRealisedPnl = @ExternalRealisedPnl, OriginalDeltaNetCostBookCurrency = @OriginalDeltaNetCostBookCurrency, OriginalDeltaNetCostInstrumentCurrency = @OriginalDeltaNetCostInstrumentCurrency, ITDRealisedPricePnl = @ITDRealisedPricePnl, ITDRealisedFXPnl = @ITDRealisedFXPnl, ResetCost = @ResetCost, Yield = @Yield, BlendedYield = @BlendedYield, AmortisationCost = @AmortisationCost, AmortisationQuantity = @AmortisationQuantity, TotalAmortisationQuantity = @TotalAmortisationQuantity, InflationAssumption = @InflationAssumption, BlendedInflationAssumption = @BlendedInflationAssumption, AssociatedPositionId = @AssociatedPositionId,  StartDt = @StartDt
	WHERE	PortfolioEventID = @PortfolioEventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioEvent
	WHERE	PortfolioEventID = @PortfolioEventID
	AND		@@ROWCOUNT > 0

GO
