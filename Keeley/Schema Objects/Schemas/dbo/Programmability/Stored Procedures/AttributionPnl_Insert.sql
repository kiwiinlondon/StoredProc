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
		@FundNav numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AttributionPnl
			(PortfolioId, FundId, PositionID, ReferenceDate, AttributionSourceId, MarketValue, NetPosition, IsNetPositionLong, IsExposureLong, Exposure, ExposureDelta, TodayPricePnl, TodayFxPnl, TodayCarryPnl, UpdateUserID, AttributionNavId, CurrencyId, TodayOtherPnl, PnlTypeId, Price, PriceId, PriceToPositionFXRate, PriceToPositionFXRateId, FXRate, FXRateId, BetaShortTerm, BetaLongTerm, TodayRealisedFXPnl, TodayRealisedPricePnl, TodayCashBenefit, NotionalCost, MarketDataStatus, BetaShortTermId, BetaLongTermId, NavFXRate, PricePnl, FXPnl, MaxExposure, ForwardFXRate, ForwardFXRateId, OriginalNotionalCost, CostPrice, AllinAccrual, AllInRate, SettledNotionalCost, SettledNetPosition, SettledExposure, SettledMarketValue, FinancingAccrual, BorrowAccrual, OverborrowNotional, OverborrowAccrual, MarginInterest, CashInterest, FinancingRate, BorrowRate, OverborrowRate, OverborrowUnits, Commission, Redemptions, Subscriptions, FuturesClearing, OtherExpense, ConsiderationBuy, ConsiderationSell, TradeCount, CounterpartyId, BookNav, FundNav, StartDt)
	VALUES
			(@PortfolioId, @FundId, @PositionID, @ReferenceDate, @AttributionSourceId, @MarketValue, @NetPosition, @IsNetPositionLong, @IsExposureLong, @Exposure, @ExposureDelta, @TodayPricePnl, @TodayFxPnl, @TodayCarryPnl, @UpdateUserID, @AttributionNavId, @CurrencyId, @TodayOtherPnl, @PnlTypeId, @Price, @PriceId, @PriceToPositionFXRate, @PriceToPositionFXRateId, @FXRate, @FXRateId, @BetaShortTerm, @BetaLongTerm, @TodayRealisedFXPnl, @TodayRealisedPricePnl, @TodayCashBenefit, @NotionalCost, @MarketDataStatus, @BetaShortTermId, @BetaLongTermId, @NavFXRate, @PricePnl, @FXPnl, @MaxExposure, @ForwardFXRate, @ForwardFXRateId, @OriginalNotionalCost, @CostPrice, @AllinAccrual, @AllInRate, @SettledNotionalCost, @SettledNetPosition, @SettledExposure, @SettledMarketValue, @FinancingAccrual, @BorrowAccrual, @OverborrowNotional, @OverborrowAccrual, @MarginInterest, @CashInterest, @FinancingRate, @BorrowRate, @OverborrowRate, @OverborrowUnits, @Commission, @Redemptions, @Subscriptions, @FuturesClearing, @OtherExpense, @ConsiderationBuy, @ConsiderationSell, @TradeCount, @CounterpartyId, @BookNav, @FundNav, @StartDt)

	SELECT	AttributionPnlId, StartDt, DataVersion
	FROM	AttributionPnl
	WHERE	AttributionPnlId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
