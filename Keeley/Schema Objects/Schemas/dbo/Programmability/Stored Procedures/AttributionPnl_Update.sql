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
		@CurrencyId int, 
		@TodayOtherPnl numeric(15,2), 
		@PnlTypeId int, 
		@Price numeric(27,8), 
		@PriceId int, 
		@PriceToPositionFXRate numeric(35,16), 
		@PriceToPositionFXRateId int, 
		@FXRate numeric(35,16), 
		@FXRateId int, 
		@BetaShortTerm numeric(27,8), 
		@BetaLongTerm numeric(27,8), 
		@TodayRealisedFXPnl numeric(27,8), 
		@TodayRealisedPricePnl numeric(27,8), 
		@TodayCashBenefit numeric(27,8), 
		@NotionalCost numeric(27,8), 
		@MarketDataStatus int, 
		@BetaShortTermId int, 
		@BetaLongTermId int, 
		@NavFXRate numeric(35,16), 
		@PricePnl numeric(27,8), 
		@FXPnl numeric(27,8), 
		@MaxExposure numeric(27,8), 
		@ForwardFXRate numeric(35,16), 
		@ForwardFXRateId int, 
		@OriginalNotionalCost numeric(27,8), 
		@CostPrice numeric(27,8), 
		@AllinAccrual numeric(27,8), 
		@AllInRate numeric(27,8), 
		@SettledNotionalCost numeric(27,8), 
		@SettledNetPosition numeric(27,8), 
		@SettledExposure numeric(27,8), 
		@SettledMarketValue numeric(27,8), 
		@FinancingAccrual numeric(27,8), 
		@BorrowAccrual numeric(27,8), 
		@OverborrowNotional numeric(27,8), 
		@OverborrowAccrual numeric(27,8), 
		@MarginInterest numeric(27,8), 
		@CashInterest numeric(27,8), 
		@FinancingRate numeric(27,8), 
		@BorrowRate numeric(27,8), 
		@OverborrowRate numeric(27,8), 
		@OverborrowUnits numeric(27,8), 
		@Commission numeric(27,8), 
		@Redemptions numeric(27,8), 
		@Subscriptions numeric(27,8), 
		@FuturesClearing numeric(27,8), 
		@OtherExpense numeric(27,8), 
		@ConsiderationBuy numeric(27,8), 
		@ConsiderationSell numeric(27,8), 
		@TradeCount int, 
		@CounterpartyId int, 
		@BookNav numeric(27,8), 
		@FundNav numeric(27,8), 
		@OpeningNav numeric(27,8), 
		@KeeleyFundNav numeric(27,8), 
		@EURFXRateId int, 
		@EURFXRate numeric(27,8), 
		@USDFXRateId int, 
		@USDFXRate numeric(27,8), 
		@GBPFXRateId int, 
		@GBPFXRate numeric(27,8), 
		@VolumeId int, 
		@Volume numeric(27,8), 
		@SharesOutstandingId int, 
		@SharesOutstanding numeric(27,8), 
		@HedgeRatioId int, 
		@HedgeRatio numeric(27,8), 
		@MarketCapitalisationId int, 
		@MarketCapitalisation numeric(27,8), 
		@ADRUnderlyerVolumeId int, 
		@ADRUnderlyerVolume numeric(27,8), 
		@PercentageOfFund numeric(9,8), 
		@KeeleyIsMaster bit, 
		@NavFXRateId int, 
		@Expense numeric(27,8), 
		@AllInAccrualOffset numeric(27,8), 
		@CashInterestCredit numeric(27,8), 
		@RehypothecationEarning numeric(27,8), 
		@MarginRequirement numeric(27,8), 
		@CashInterestDebit numeric(27,8), 
		@Slippage numeric(27,8), 
		@RehypothecationValue numeric(27,8), 
		@RehypothecationUnits numeric(27,8), 
		@LegalExposure numeric(27,8), 
		@MarginRequirementRate numeric(27,8), 
		@PositionSize numeric(27,8)=null
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionPnl_hst (
			AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, DataVersion, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, MarketDataStatus, BetaShortTermId, BetaLongTermId, NavFXRate, PricePnl, FXPnl, MaxExposure, ForwardFXRate, ForwardFXRateId, OriginalNotionalCost, CostPrice, AllinAccrual, AllInRate, SettledNotionalCost, SettledNetPosition, SettledExposure, SettledMarketValue, FinancingAccrual, BorrowAccrual, OverborrowNotional, OverborrowAccrual, MarginInterest, CashInterest, FinancingRate, BorrowRate, OverborrowRate, OverborrowUnits, Commission, Redemptions, Subscriptions, FuturesClearing, OtherExpense, ConsiderationBuy, ConsiderationSell, TradeCount, CounterpartyId, BookNav, FundNav, OpeningNav, KeeleyFundNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, VolumeId, Volume, SharesOutstandingId, SharesOutstanding, HedgeRatioId, HedgeRatio, MarketCapitalisationId, MarketCapitalisation, ADRUnderlyerVolumeId, ADRUnderlyerVolume, PercentageOfFund, KeeleyIsMaster, NavFXRateId, Expense, AllInAccrualOffset, CashInterestCredit, RehypothecationEarning, MarginRequirement, CashInterestDebit, Slippage, RehypothecationValue, RehypothecationUnits, LegalExposure, MarginRequirementRate, PositionSize, EndDt, LastActionUserID)
	SELECT	AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, DataVersion, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, MarketDataStatus, BetaShortTermId, BetaLongTermId, NavFXRate, PricePnl, FXPnl, MaxExposure, ForwardFXRate, ForwardFXRateId, OriginalNotionalCost, CostPrice, AllinAccrual, AllInRate, SettledNotionalCost, SettledNetPosition, SettledExposure, SettledMarketValue, FinancingAccrual, BorrowAccrual, OverborrowNotional, OverborrowAccrual, MarginInterest, CashInterest, FinancingRate, BorrowRate, OverborrowRate, OverborrowUnits, Commission, Redemptions, Subscriptions, FuturesClearing, OtherExpense, ConsiderationBuy, ConsiderationSell, TradeCount, CounterpartyId, BookNav, FundNav, OpeningNav, KeeleyFundNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, VolumeId, Volume, SharesOutstandingId, SharesOutstanding, HedgeRatioId, HedgeRatio, MarketCapitalisationId, MarketCapitalisation, ADRUnderlyerVolumeId, ADRUnderlyerVolume, PercentageOfFund, KeeleyIsMaster, NavFXRateId, Expense, AllInAccrualOffset, CashInterestCredit, RehypothecationEarning, MarginRequirement, CashInterestDebit, Slippage, RehypothecationValue, RehypothecationUnits, LegalExposure, MarginRequirementRate, PositionSize, @StartDt, @UpdateUserID
	FROM	AttributionPnl
	WHERE	AttributionPnlId = @AttributionPnlId

	UPDATE	AttributionPnl
	SET		PortfolioId = @PortfolioId, FundId = @FundId, PositionID = @PositionID, ReferenceDate = @ReferenceDate, AttributionSourceId = @AttributionSourceId, MarketValue = @MarketValue, NetPosition = @NetPosition, IsNetPositionLong = @IsNetPositionLong, IsExposureLong = @IsExposureLong, Exposure = @Exposure, ExposureDelta = @ExposureDelta, TodayPricePnl = @TodayPricePnl, TodayFxPnl = @TodayFxPnl, TodayCarryPnl = @TodayCarryPnl, UpdateUserID = @UpdateUserID, CurrencyId = @CurrencyId, TodayOtherPnl = @TodayOtherPnl, PnlTypeId = @PnlTypeId, Price = @Price, PriceId = @PriceId, PriceToPositionFXRate = @PriceToPositionFXRate, PriceToPositionFXRateId = @PriceToPositionFXRateId, FXRate = @FXRate, FXRateId = @FXRateId, BetaShortTerm = @BetaShortTerm, BetaLongTerm = @BetaLongTerm, TodayRealisedFXPnl = @TodayRealisedFXPnl, TodayRealisedPricePnl = @TodayRealisedPricePnl, TodayCashBenefit = @TodayCashBenefit, NotionalCost = @NotionalCost, MarketDataStatus = @MarketDataStatus, BetaShortTermId = @BetaShortTermId, BetaLongTermId = @BetaLongTermId, NavFXRate = @NavFXRate, PricePnl = @PricePnl, FXPnl = @FXPnl, MaxExposure = @MaxExposure, ForwardFXRate = @ForwardFXRate, ForwardFXRateId = @ForwardFXRateId, OriginalNotionalCost = @OriginalNotionalCost, CostPrice = @CostPrice, AllinAccrual = @AllinAccrual, AllInRate = @AllInRate, SettledNotionalCost = @SettledNotionalCost, SettledNetPosition = @SettledNetPosition, SettledExposure = @SettledExposure, SettledMarketValue = @SettledMarketValue, FinancingAccrual = @FinancingAccrual, BorrowAccrual = @BorrowAccrual, OverborrowNotional = @OverborrowNotional, OverborrowAccrual = @OverborrowAccrual, MarginInterest = @MarginInterest, CashInterest = @CashInterest, FinancingRate = @FinancingRate, BorrowRate = @BorrowRate, OverborrowRate = @OverborrowRate, OverborrowUnits = @OverborrowUnits, Commission = @Commission, Redemptions = @Redemptions, Subscriptions = @Subscriptions, FuturesClearing = @FuturesClearing, OtherExpense = @OtherExpense, ConsiderationBuy = @ConsiderationBuy, ConsiderationSell = @ConsiderationSell, TradeCount = @TradeCount, CounterpartyId = @CounterpartyId, BookNav = @BookNav, FundNav = @FundNav, OpeningNav = @OpeningNav, KeeleyFundNav = @KeeleyFundNav, EURFXRateId = @EURFXRateId, EURFXRate = @EURFXRate, USDFXRateId = @USDFXRateId, USDFXRate = @USDFXRate, GBPFXRateId = @GBPFXRateId, GBPFXRate = @GBPFXRate, VolumeId = @VolumeId, Volume = @Volume, SharesOutstandingId = @SharesOutstandingId, SharesOutstanding = @SharesOutstanding, HedgeRatioId = @HedgeRatioId, HedgeRatio = @HedgeRatio, MarketCapitalisationId = @MarketCapitalisationId, MarketCapitalisation = @MarketCapitalisation, ADRUnderlyerVolumeId = @ADRUnderlyerVolumeId, ADRUnderlyerVolume = @ADRUnderlyerVolume, PercentageOfFund = @PercentageOfFund, KeeleyIsMaster = @KeeleyIsMaster, NavFXRateId = @NavFXRateId, Expense = @Expense, AllInAccrualOffset = @AllInAccrualOffset, CashInterestCredit = @CashInterestCredit, RehypothecationEarning = @RehypothecationEarning, MarginRequirement = @MarginRequirement, CashInterestDebit = @CashInterestDebit, Slippage = @Slippage, RehypothecationValue = @RehypothecationValue, RehypothecationUnits = @RehypothecationUnits, LegalExposure = @LegalExposure, MarginRequirementRate = @MarginRequirementRate, PositionSize = @PositionSize,  StartDt = @StartDt
	WHERE	AttributionPnlId = @AttributionPnlId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionPnl
	WHERE	AttributionPnlId = @AttributionPnlId
	AND		@@ROWCOUNT > 0

GO
