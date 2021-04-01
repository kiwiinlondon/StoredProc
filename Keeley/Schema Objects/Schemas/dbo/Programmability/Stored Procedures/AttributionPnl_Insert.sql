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
		@PositionSize numeric(27,8), 
		@BetaSixMonth numeric(27,8), 
		@BetaOneYear numeric(27,8), 
		@BetaOneYearId int, 
		@BetaSixMonthId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AttributionPnl
			(PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, UpdateUserID, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, MarketDataStatus, BetaShortTermId, BetaLongTermId, NavFXRate, PricePnl, FXPnl, MaxExposure, ForwardFXRate, ForwardFXRateId, OriginalNotionalCost, CostPrice, AllinAccrual, AllInRate, SettledNotionalCost, SettledNetPosition, SettledExposure, SettledMarketValue, FinancingAccrual, BorrowAccrual, OverborrowNotional, OverborrowAccrual, MarginInterest, CashInterest, FinancingRate, BorrowRate, OverborrowRate, OverborrowUnits, Commission, Redemptions, Subscriptions, FuturesClearing, OtherExpense, ConsiderationBuy, ConsiderationSell, TradeCount, CounterpartyId, BookNav, FundNav, OpeningNav, KeeleyFundNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, VolumeId, Volume, SharesOutstandingId, SharesOutstanding, HedgeRatioId, HedgeRatio, MarketCapitalisationId, MarketCapitalisation, ADRUnderlyerVolumeId, ADRUnderlyerVolume, PercentageOfFund, KeeleyIsMaster, NavFXRateId, Expense, AllInAccrualOffset, CashInterestCredit, RehypothecationEarning, MarginRequirement, CashInterestDebit, Slippage, RehypothecationValue, RehypothecationUnits, LegalExposure, MarginRequirementRate, PositionSize, BetaSixMonth, BetaOneYear, BetaOneYearId, BetaSixMonthId, StartDt)
	VALUES
			(@PortfolioId, @FundId, @PositionID, @ReferenceDate, @AttributionSourceId, @MarketValue, @NetPosition, @IsNetPositionLong, @IsExposureLong, @Exposure, @ExposureDelta, @TodayPricePnl, @TodayFxPnl, @TodayCarryPnl, @UpdateUserID, @CurrencyId, @TodayOtherPnl, @PnlTypeId, @Price, @PriceId, @PriceToPositionFXRate, @PriceToPositionFXRateId, @FXRate, @FXRateId, @BetaShortTerm, @BetaLongTerm, @TodayRealisedFXPnl, @TodayRealisedPricePnl, @TodayCashBenefit, @NotionalCost, @MarketDataStatus, @BetaShortTermId, @BetaLongTermId, @NavFXRate, @PricePnl, @FXPnl, @MaxExposure, @ForwardFXRate, @ForwardFXRateId, @OriginalNotionalCost, @CostPrice, @AllinAccrual, @AllInRate, @SettledNotionalCost, @SettledNetPosition, @SettledExposure, @SettledMarketValue, @FinancingAccrual, @BorrowAccrual, @OverborrowNotional, @OverborrowAccrual, @MarginInterest, @CashInterest, @FinancingRate, @BorrowRate, @OverborrowRate, @OverborrowUnits, @Commission, @Redemptions, @Subscriptions, @FuturesClearing, @OtherExpense, @ConsiderationBuy, @ConsiderationSell, @TradeCount, @CounterpartyId, @BookNav, @FundNav, @OpeningNav, @KeeleyFundNav, @EURFXRateId, @EURFXRate, @USDFXRateId, @USDFXRate, @GBPFXRateId, @GBPFXRate, @VolumeId, @Volume, @SharesOutstandingId, @SharesOutstanding, @HedgeRatioId, @HedgeRatio, @MarketCapitalisationId, @MarketCapitalisation, @ADRUnderlyerVolumeId, @ADRUnderlyerVolume, @PercentageOfFund, @KeeleyIsMaster, @NavFXRateId, @Expense, @AllInAccrualOffset, @CashInterestCredit, @RehypothecationEarning, @MarginRequirement, @CashInterestDebit, @Slippage, @RehypothecationValue, @RehypothecationUnits, @LegalExposure, @MarginRequirementRate, @PositionSize, @BetaSixMonth, @BetaOneYear, @BetaOneYearId, @BetaSixMonthId, @StartDt)

	SELECT	AttributionPnlId, StartDt, DataVersion
	FROM	AttributionPnl
	WHERE	AttributionPnlId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
