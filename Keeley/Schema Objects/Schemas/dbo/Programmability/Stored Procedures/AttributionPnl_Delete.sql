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
			AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, DataVersion, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, MarketDataStatus, BetaShortTermId, BetaLongTermId, NavFXRate, PricePnl, FXPnl, MaxExposure, ForwardFXRate, ForwardFXRateId, OriginalNotionalCost, CostPrice, AllinAccrual, AllInRate, SettledNotionalCost, SettledNetPosition, SettledExposure, SettledMarketValue, FinancingAccrual, BorrowAccrual, OverborrowNotional, OverborrowAccrual, MarginInterest, CashInterest, FinancingRate, BorrowRate, OverborrowRate, OverborrowUnits, Commission, Redemptions, Subscriptions, FuturesClearing, OtherExpense, ConsiderationBuy, ConsiderationSell, TradeCount, CounterpartyId, BookNav, FundNav, OpeningNav, KeeleyFundNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, VolumeId, Volume, SharesOutstandingId, SharesOutstanding, HedgeRatioId, HedgeRatio, MarketCapitalisationId, MarketCapitalisation, ADRUnderlyerVolumeId, ADRUnderlyerVolume, PercentageOfFund, KeeleyIsMaster, NavFXRateId, Expense, AllInAccrualOffset, CashInterestCredit, RehypothecationEarning, MarginRequirement, CashInterestDebit, Slippage, RehypothecationValue, RehypothecationUnits, LegalExposure, MarginRequirementRate, PositionSize, BetaSixMonth, BetaOneYear, BetaOneYearId, BetaSixMonthId, EndDt, LastActionUserID)
	SELECT	AttributionPnlId, PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, StartDt, UpdateUserID, DataVersion, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, MarketDataStatus, BetaShortTermId, BetaLongTermId, NavFXRate, PricePnl, FXPnl, MaxExposure, ForwardFXRate, ForwardFXRateId, OriginalNotionalCost, CostPrice, AllinAccrual, AllInRate, SettledNotionalCost, SettledNetPosition, SettledExposure, SettledMarketValue, FinancingAccrual, BorrowAccrual, OverborrowNotional, OverborrowAccrual, MarginInterest, CashInterest, FinancingRate, BorrowRate, OverborrowRate, OverborrowUnits, Commission, Redemptions, Subscriptions, FuturesClearing, OtherExpense, ConsiderationBuy, ConsiderationSell, TradeCount, CounterpartyId, BookNav, FundNav, OpeningNav, KeeleyFundNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, VolumeId, Volume, SharesOutstandingId, SharesOutstanding, HedgeRatioId, HedgeRatio, MarketCapitalisationId, MarketCapitalisation, ADRUnderlyerVolumeId, ADRUnderlyerVolume, PercentageOfFund, KeeleyIsMaster, NavFXRateId, Expense, AllInAccrualOffset, CashInterestCredit, RehypothecationEarning, MarginRequirement, CashInterestDebit, Slippage, RehypothecationValue, RehypothecationUnits, LegalExposure, MarginRequirementRate, PositionSize, BetaSixMonth, BetaOneYear, BetaOneYearId, BetaSixMonthId, @EndDt, @UpdateUserID
	FROM	AttributionPnl
	WHERE	AttributionPnlId = @AttributionPnlId

	DELETE	AttributionPnl
	WHERE	AttributionPnlId = @AttributionPnlId
	AND		DataVersion = @DataVersion
GO
