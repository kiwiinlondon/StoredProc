USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Portfolio_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Portfolio_Update]
GO

CREATE PROCEDURE DBO.[Portfolio_Update]
		@PortfolioId int, 
		@PositionId int, 
		@ReferenceDate datetime, 
		@NetPosition numeric(27,8), 
		@NetCostInstrumentCurrency numeric(27,8), 
		@NetCostBookCurrency numeric(27,8), 
		@DeltaNetCostInstrumentCurrency numeric(27,8), 
		@DeltaNetCostBookCurrency numeric(27,8), 
		@TodayNetPostionChange numeric(27,8), 
		@TodayDeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayDeltaNetCostChangeBookCurrency numeric(27,8), 
		@TodayNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayNetCostChangeBookCurrency numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@Price numeric(27,8), 
		@PriceId int, 
		@FXRate numeric(35,16), 
		@FXRateId int, 
		@DeltaMarketValue numeric(27,8), 
		@TodayCashBenefit numeric(27,8), 
		@TodayCashBenefitBookCurrency numeric(27,8), 
		@TodayAccrual numeric(27,8), 
		@TodayRealisedPricePnl numeric(27,8), 
		@TodayRealisedFxPnl numeric(27,8), 
		@TotalAccrual numeric(27,8), 
		@TodayRealisedPricePnlBookCurrency numeric(27,8), 
		@TodayUnrealisedFXPnl numeric(27,8), 
		@TodayUnrealisedPricePnl numeric(27,8), 
		@MarketValue numeric(27,8), 
		@PriceToPositionFXRate numeric(35,16), 
		@PriceToPositionFXRateId int, 
		@PriceIsLastTradePrice bit, 
		@PreviousPortfolioId int, 
		@BondNominal numeric(28,7), 
		@TodayCarryAccrual numeric(27,8), 
		@Delta numeric(27,8), 
		@UnderlyingPrice numeric(27,8), 
		@DeltaId int, 
		@UnderlyingPriceId int, 
		@UnderlyingPriceToPositionFXRate numeric(27,8), 
		@UnderlyingPriceToPositionFXRateId int, 
		@ValuationFXRate numeric(35,16), 
		@ValuationNetPosition numeric(27,8), 
		@ValuationDeltaNetCostInstrumentCurrency numeric(27,8), 
		@ValuationPrice numeric(27,8), 
		@ValuationPriceToPositionFXRate numeric(35,16), 
		@ValuationMarketValue numeric(27,8), 
		@HedgeRatio numeric(27,8), 
		@HedgeRatioId int, 
		@BetaShortTerm numeric(27,8), 
		@BetaShortTermId int, 
		@BetaLongTerm numeric(27,8), 
		@BetaLongTermId int, 
		@PreviousReferenceDate datetime, 
		@TodayCapitalChange numeric(27,8), 
		@IndexRatio numeric(27,8), 
		@IndexRatioID int, 
		@DisclosedNetPosition numeric(27,8), 
		@ValuationDeltaNetCostBookCurrency numeric(27,8), 
		@ValuationTodayDeltaNetCostChangeBookCurrency numeric(27,8), 
		@ValuationTodayDeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@ValuationTodayRealisedFxPnl numeric(27,8), 
		@ValuationTodayRealisedPricePnl numeric(27,8), 
		@ValuationTomorrowDeltaNetCostChangeBookCurrency numeric(27,8), 
		@ValuationTomorrowDeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@ValuationTomorrowRealisedFxPnl numeric(27,8), 
		@ValuationTomorrowRealisedPricePnl numeric(27,8), 
		@ValuationDeltaMarketValue numeric(27,8), 
		@ValuationTodayUnrealisedFxPnl numeric(27,8), 
		@ValuationTodayUnrealisedPricePnl numeric(27,8), 
		@ITDRealisedPricePnl numeric(27,8), 
		@ITDRealisedFXPnl numeric(27,8), 
		@OriginalDeltaNetCostBookCurrency numeric(27,8), 
		@OriginalDeltaNetCostInstrumentCurrency numeric(27,8), 
		@FundId int, 
		@IsNetPositionLong bit, 
		@IsExposureLong bit, 
		@IsFlat bit, 
		@ValuesExistToRollForward bit, 
		@TodayAmortisation numeric(27,8), 
		@TotalAmortisation numeric(27,8), 
		@Yield numeric(27,8), 
		@TodayCarryPNL numeric(27,8), 
		@AmortisationCost numeric(27,8), 
		@AmortisationQuantity numeric(27,8), 
		@TodayAmortisationBook numeric(27,8), 
		@InflationAssumption numeric(27,8), 
		@TodayRealisedAmortisation numeric(27,8), 
		@ValuationTomorrowNetPosition numeric(27,8), 
		@ValuationTomorrowDeltaNetCostBookCurrency numeric(27,8), 
		@ValuationTomorrowDeltaNetCostInstrumentCurrency numeric(27,8), 
		@AdministratorPrice numeric(27,8), 
		@AdministratorMarketValue numeric(27,8), 
		@AdministratorFXRate numeric(27,8), 
		@DeltaMarketValueInstrument numeric(27,8), 
		@MarketValueInstrument numeric(27,8), 
		@TodayUnrealisedPricePNLInstrument numeric(27,8), 
		@ValuationMarketValueInstrument numeric(27,8), 
		@OpeningTotalAmortisation numeric(27,8), 
		@ReValue bit, 
		@MarketDataStatus int, 
		@TodayMaxDeltaNetCostInstrumentCurrency numeric(27,8), 
		@ValuationTodayMaxDeltaNetCostInstrumentCurrency numeric(27,8), 
		@ValuationTomorrowMaxDeltaNetCostInstrumentCurrency numeric(27,8), 
		@TodayMaxNetPosition numeric(27,8), 
		@ForwardFXRate numeric(35,16), 
		@ForwardFXRateId int, 
		@ValuationOriginalDeltaNetCostBookCurrency numeric(27,8), 
		@IndicativeChange numeric(27,8), 
		@IndicativeChangeId int, 
		@IndicativePrice numeric(27,8), 
		@ValuationOriginalDeltaNetCostInstrumentCurrency numeric(27,8), 
		@PriceIsForDay bit, 
		@FinancingId int, 
		@AllInAccrualInstrument numeric(27,8), 
		@FinancingMustExist bit, 
		@SettledNetPosition numeric(27,8), 
		@SettledNotional numeric(27,8), 
		@SettledNotionalInstrument numeric(27,8), 
		@SettledCostNotional numeric(27,8), 
		@SettledCostNotionalInstrument numeric(27,8), 
		@SettledMarketValue numeric(27,8), 
		@SettledMarketValueInstrument numeric(27,8), 
		@PortfolioEventExistsOnDay bit, 
		@SettledNetPositionChange numeric(27,8), 
		@FinancingAccrualInstrument numeric(27,8), 
		@BorrowAccrualInstrument numeric(27,8), 
		@OverborrowNotionalInstrument numeric(27,8), 
		@OverborrowAccrualInstrument numeric(27,8), 
		@MarginInterestInstrument numeric(27,8), 
		@CashInterestInstrument numeric(27,8), 
		@FinancingProportion numeric(10,3), 
		@MarginRequirementInstrument numeric(27,8), 
		@CashInterestCreditInstrument numeric(27,8), 
		@RehypothecationEarningInstrument numeric(27,8), 
		@CashInterestDebitInstrument numeric(27,8), 
		@RehypothecationValueInstrument numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Portfolio_hst (
			PortfolioId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, Price, PriceId, FXRate, FXRateId, DeltaMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, TodayUnrealisedFXPnl, TodayUnrealisedPricePnl, MarketValue, PriceToPositionFXRate, PriceToPositionFXRateId, PriceIsLastTradePrice, PreviousPortfolioId, BondNominal, TodayCarryAccrual, Delta, UnderlyingPrice, DeltaId, UnderlyingPriceId, UnderlyingPriceToPositionFXRate, UnderlyingPriceToPositionFXRateId, ValuationFXRate, ValuationNetPosition, ValuationDeltaNetCostInstrumentCurrency, ValuationPrice, ValuationPriceToPositionFXRate, ValuationMarketValue, HedgeRatio, HedgeRatioId, BetaShortTerm, BetaShortTermId, BetaLongTerm, BetaLongTermId, PreviousReferenceDate, TodayCapitalChange, IndexRatio, IndexRatioID, DisclosedNetPosition, ValuationDeltaNetCostBookCurrency, ValuationTodayDeltaNetCostChangeBookCurrency, ValuationTodayDeltaNetCostChangeInstrumentCurrency, ValuationTodayRealisedFxPnl, ValuationTodayRealisedPricePnl, ValuationTomorrowDeltaNetCostChangeBookCurrency, ValuationTomorrowDeltaNetCostChangeInstrumentCurrency, ValuationTomorrowRealisedFxPnl, ValuationTomorrowRealisedPricePnl, ValuationDeltaMarketValue, ValuationTodayUnrealisedFxPnl, ValuationTodayUnrealisedPricePnl, ITDRealisedPricePnl, ITDRealisedFXPnl, OriginalDeltaNetCostBookCurrency, OriginalDeltaNetCostInstrumentCurrency, FundId, IsNetPositionLong, IsExposureLong, IsFlat, ValuesExistToRollForward, TodayAmortisation, TotalAmortisation, Yield, TodayCarryPNL, AmortisationCost, AmortisationQuantity, TodayAmortisationBook, InflationAssumption, TodayRealisedAmortisation, ValuationTomorrowNetPosition, ValuationTomorrowDeltaNetCostBookCurrency, ValuationTomorrowDeltaNetCostInstrumentCurrency, AdministratorPrice, AdministratorMarketValue, AdministratorFXRate, DeltaMarketValueInstrument, MarketValueInstrument, TodayUnrealisedPricePNLInstrument, ValuationMarketValueInstrument, OpeningTotalAmortisation, ReValue, MarketDataStatus, TodayMaxDeltaNetCostInstrumentCurrency, ValuationTodayMaxDeltaNetCostInstrumentCurrency, ValuationTomorrowMaxDeltaNetCostInstrumentCurrency, TodayMaxNetPosition, ForwardFXRate, ForwardFXRateId, ValuationOriginalDeltaNetCostBookCurrency, IndicativeChange, IndicativeChangeId, IndicativePrice, ValuationOriginalDeltaNetCostInstrumentCurrency, PriceIsForDay, FinancingId, AllInAccrualInstrument, FinancingMustExist, SettledNetPosition, SettledNotional, SettledNotionalInstrument, SettledCostNotional, SettledCostNotionalInstrument, SettledMarketValue, SettledMarketValueInstrument, PortfolioEventExistsOnDay, SettledNetPositionChange, FinancingAccrualInstrument, BorrowAccrualInstrument, OverborrowNotionalInstrument, OverborrowAccrualInstrument, MarginInterestInstrument, CashInterestInstrument, FinancingProportion, MarginRequirementInstrument, CashInterestCreditInstrument, RehypothecationEarningInstrument, CashInterestDebitInstrument, RehypothecationValueInstrument, EndDt, LastActionUserID)
	SELECT	PortfolioId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, Price, PriceId, FXRate, FXRateId, DeltaMarketValue, TodayCashBenefit, TodayCashBenefitBookCurrency, TodayAccrual, TodayRealisedPricePnl, TodayRealisedFxPnl, TotalAccrual, TodayRealisedPricePnlBookCurrency, TodayUnrealisedFXPnl, TodayUnrealisedPricePnl, MarketValue, PriceToPositionFXRate, PriceToPositionFXRateId, PriceIsLastTradePrice, PreviousPortfolioId, BondNominal, TodayCarryAccrual, Delta, UnderlyingPrice, DeltaId, UnderlyingPriceId, UnderlyingPriceToPositionFXRate, UnderlyingPriceToPositionFXRateId, ValuationFXRate, ValuationNetPosition, ValuationDeltaNetCostInstrumentCurrency, ValuationPrice, ValuationPriceToPositionFXRate, ValuationMarketValue, HedgeRatio, HedgeRatioId, BetaShortTerm, BetaShortTermId, BetaLongTerm, BetaLongTermId, PreviousReferenceDate, TodayCapitalChange, IndexRatio, IndexRatioID, DisclosedNetPosition, ValuationDeltaNetCostBookCurrency, ValuationTodayDeltaNetCostChangeBookCurrency, ValuationTodayDeltaNetCostChangeInstrumentCurrency, ValuationTodayRealisedFxPnl, ValuationTodayRealisedPricePnl, ValuationTomorrowDeltaNetCostChangeBookCurrency, ValuationTomorrowDeltaNetCostChangeInstrumentCurrency, ValuationTomorrowRealisedFxPnl, ValuationTomorrowRealisedPricePnl, ValuationDeltaMarketValue, ValuationTodayUnrealisedFxPnl, ValuationTodayUnrealisedPricePnl, ITDRealisedPricePnl, ITDRealisedFXPnl, OriginalDeltaNetCostBookCurrency, OriginalDeltaNetCostInstrumentCurrency, FundId, IsNetPositionLong, IsExposureLong, IsFlat, ValuesExistToRollForward, TodayAmortisation, TotalAmortisation, Yield, TodayCarryPNL, AmortisationCost, AmortisationQuantity, TodayAmortisationBook, InflationAssumption, TodayRealisedAmortisation, ValuationTomorrowNetPosition, ValuationTomorrowDeltaNetCostBookCurrency, ValuationTomorrowDeltaNetCostInstrumentCurrency, AdministratorPrice, AdministratorMarketValue, AdministratorFXRate, DeltaMarketValueInstrument, MarketValueInstrument, TodayUnrealisedPricePNLInstrument, ValuationMarketValueInstrument, OpeningTotalAmortisation, ReValue, MarketDataStatus, TodayMaxDeltaNetCostInstrumentCurrency, ValuationTodayMaxDeltaNetCostInstrumentCurrency, ValuationTomorrowMaxDeltaNetCostInstrumentCurrency, TodayMaxNetPosition, ForwardFXRate, ForwardFXRateId, ValuationOriginalDeltaNetCostBookCurrency, IndicativeChange, IndicativeChangeId, IndicativePrice, ValuationOriginalDeltaNetCostInstrumentCurrency, PriceIsForDay, FinancingId, AllInAccrualInstrument, FinancingMustExist, SettledNetPosition, SettledNotional, SettledNotionalInstrument, SettledCostNotional, SettledCostNotionalInstrument, SettledMarketValue, SettledMarketValueInstrument, PortfolioEventExistsOnDay, SettledNetPositionChange, FinancingAccrualInstrument, BorrowAccrualInstrument, OverborrowNotionalInstrument, OverborrowAccrualInstrument, MarginInterestInstrument, CashInterestInstrument, FinancingProportion, MarginRequirementInstrument, CashInterestCreditInstrument, RehypothecationEarningInstrument, CashInterestDebitInstrument, RehypothecationValueInstrument, @StartDt, @UpdateUserID
	FROM	Portfolio
	WHERE	PortfolioId = @PortfolioId

	UPDATE	Portfolio
	SET		PositionId = @PositionId, ReferenceDate = @ReferenceDate, NetPosition = @NetPosition, NetCostInstrumentCurrency = @NetCostInstrumentCurrency, NetCostBookCurrency = @NetCostBookCurrency, DeltaNetCostInstrumentCurrency = @DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency = @DeltaNetCostBookCurrency, TodayNetPostionChange = @TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency = @TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency = @TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency = @TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency = @TodayNetCostChangeBookCurrency, UpdateUserID = @UpdateUserID, Price = @Price, PriceId = @PriceId, FXRate = @FXRate, FXRateId = @FXRateId, DeltaMarketValue = @DeltaMarketValue, TodayCashBenefit = @TodayCashBenefit, TodayCashBenefitBookCurrency = @TodayCashBenefitBookCurrency, TodayAccrual = @TodayAccrual, TodayRealisedPricePnl = @TodayRealisedPricePnl, TodayRealisedFxPnl = @TodayRealisedFxPnl, TotalAccrual = @TotalAccrual, TodayRealisedPricePnlBookCurrency = @TodayRealisedPricePnlBookCurrency, TodayUnrealisedFXPnl = @TodayUnrealisedFXPnl, TodayUnrealisedPricePnl = @TodayUnrealisedPricePnl, MarketValue = @MarketValue, PriceToPositionFXRate = @PriceToPositionFXRate, PriceToPositionFXRateId = @PriceToPositionFXRateId, PriceIsLastTradePrice = @PriceIsLastTradePrice, PreviousPortfolioId = @PreviousPortfolioId, BondNominal = @BondNominal, TodayCarryAccrual = @TodayCarryAccrual, Delta = @Delta, UnderlyingPrice = @UnderlyingPrice, DeltaId = @DeltaId, UnderlyingPriceId = @UnderlyingPriceId, UnderlyingPriceToPositionFXRate = @UnderlyingPriceToPositionFXRate, UnderlyingPriceToPositionFXRateId = @UnderlyingPriceToPositionFXRateId, ValuationFXRate = @ValuationFXRate, ValuationNetPosition = @ValuationNetPosition, ValuationDeltaNetCostInstrumentCurrency = @ValuationDeltaNetCostInstrumentCurrency, ValuationPrice = @ValuationPrice, ValuationPriceToPositionFXRate = @ValuationPriceToPositionFXRate, ValuationMarketValue = @ValuationMarketValue, HedgeRatio = @HedgeRatio, HedgeRatioId = @HedgeRatioId, BetaShortTerm = @BetaShortTerm, BetaShortTermId = @BetaShortTermId, BetaLongTerm = @BetaLongTerm, BetaLongTermId = @BetaLongTermId, PreviousReferenceDate = @PreviousReferenceDate, TodayCapitalChange = @TodayCapitalChange, IndexRatio = @IndexRatio, IndexRatioID = @IndexRatioID, DisclosedNetPosition = @DisclosedNetPosition, ValuationDeltaNetCostBookCurrency = @ValuationDeltaNetCostBookCurrency, ValuationTodayDeltaNetCostChangeBookCurrency = @ValuationTodayDeltaNetCostChangeBookCurrency, ValuationTodayDeltaNetCostChangeInstrumentCurrency = @ValuationTodayDeltaNetCostChangeInstrumentCurrency, ValuationTodayRealisedFxPnl = @ValuationTodayRealisedFxPnl, ValuationTodayRealisedPricePnl = @ValuationTodayRealisedPricePnl, ValuationTomorrowDeltaNetCostChangeBookCurrency = @ValuationTomorrowDeltaNetCostChangeBookCurrency, ValuationTomorrowDeltaNetCostChangeInstrumentCurrency = @ValuationTomorrowDeltaNetCostChangeInstrumentCurrency, ValuationTomorrowRealisedFxPnl = @ValuationTomorrowRealisedFxPnl, ValuationTomorrowRealisedPricePnl = @ValuationTomorrowRealisedPricePnl, ValuationDeltaMarketValue = @ValuationDeltaMarketValue, ValuationTodayUnrealisedFxPnl = @ValuationTodayUnrealisedFxPnl, ValuationTodayUnrealisedPricePnl = @ValuationTodayUnrealisedPricePnl, ITDRealisedPricePnl = @ITDRealisedPricePnl, ITDRealisedFXPnl = @ITDRealisedFXPnl, OriginalDeltaNetCostBookCurrency = @OriginalDeltaNetCostBookCurrency, OriginalDeltaNetCostInstrumentCurrency = @OriginalDeltaNetCostInstrumentCurrency, FundId = @FundId, IsNetPositionLong = @IsNetPositionLong, IsExposureLong = @IsExposureLong, IsFlat = @IsFlat, ValuesExistToRollForward = @ValuesExistToRollForward, TodayAmortisation = @TodayAmortisation, TotalAmortisation = @TotalAmortisation, Yield = @Yield, TodayCarryPNL = @TodayCarryPNL, AmortisationCost = @AmortisationCost, AmortisationQuantity = @AmortisationQuantity, TodayAmortisationBook = @TodayAmortisationBook, InflationAssumption = @InflationAssumption, TodayRealisedAmortisation = @TodayRealisedAmortisation, ValuationTomorrowNetPosition = @ValuationTomorrowNetPosition, ValuationTomorrowDeltaNetCostBookCurrency = @ValuationTomorrowDeltaNetCostBookCurrency, ValuationTomorrowDeltaNetCostInstrumentCurrency = @ValuationTomorrowDeltaNetCostInstrumentCurrency, AdministratorPrice = @AdministratorPrice, AdministratorMarketValue = @AdministratorMarketValue, AdministratorFXRate = @AdministratorFXRate, DeltaMarketValueInstrument = @DeltaMarketValueInstrument, MarketValueInstrument = @MarketValueInstrument, TodayUnrealisedPricePNLInstrument = @TodayUnrealisedPricePNLInstrument, ValuationMarketValueInstrument = @ValuationMarketValueInstrument, OpeningTotalAmortisation = @OpeningTotalAmortisation, ReValue = @ReValue, MarketDataStatus = @MarketDataStatus, TodayMaxDeltaNetCostInstrumentCurrency = @TodayMaxDeltaNetCostInstrumentCurrency, ValuationTodayMaxDeltaNetCostInstrumentCurrency = @ValuationTodayMaxDeltaNetCostInstrumentCurrency, ValuationTomorrowMaxDeltaNetCostInstrumentCurrency = @ValuationTomorrowMaxDeltaNetCostInstrumentCurrency, TodayMaxNetPosition = @TodayMaxNetPosition, ForwardFXRate = @ForwardFXRate, ForwardFXRateId = @ForwardFXRateId, ValuationOriginalDeltaNetCostBookCurrency = @ValuationOriginalDeltaNetCostBookCurrency, IndicativeChange = @IndicativeChange, IndicativeChangeId = @IndicativeChangeId, IndicativePrice = @IndicativePrice, ValuationOriginalDeltaNetCostInstrumentCurrency = @ValuationOriginalDeltaNetCostInstrumentCurrency, PriceIsForDay = @PriceIsForDay, FinancingId = @FinancingId, AllInAccrualInstrument = @AllInAccrualInstrument, FinancingMustExist = @FinancingMustExist, SettledNetPosition = @SettledNetPosition, SettledNotional = @SettledNotional, SettledNotionalInstrument = @SettledNotionalInstrument, SettledCostNotional = @SettledCostNotional, SettledCostNotionalInstrument = @SettledCostNotionalInstrument, SettledMarketValue = @SettledMarketValue, SettledMarketValueInstrument = @SettledMarketValueInstrument, PortfolioEventExistsOnDay = @PortfolioEventExistsOnDay, SettledNetPositionChange = @SettledNetPositionChange, FinancingAccrualInstrument = @FinancingAccrualInstrument, BorrowAccrualInstrument = @BorrowAccrualInstrument, OverborrowNotionalInstrument = @OverborrowNotionalInstrument, OverborrowAccrualInstrument = @OverborrowAccrualInstrument, MarginInterestInstrument = @MarginInterestInstrument, CashInterestInstrument = @CashInterestInstrument, FinancingProportion = @FinancingProportion, MarginRequirementInstrument = @MarginRequirementInstrument, CashInterestCreditInstrument = @CashInterestCreditInstrument, RehypothecationEarningInstrument = @RehypothecationEarningInstrument, CashInterestDebitInstrument = @CashInterestDebitInstrument, RehypothecationValueInstrument = @RehypothecationValueInstrument,  StartDt = @StartDt
	WHERE	PortfolioId = @PortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Portfolio
	WHERE	PortfolioId = @PortfolioId
	AND		@@ROWCOUNT > 0

GO
