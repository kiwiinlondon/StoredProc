USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Attribution_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Attribution_Update]
GO

CREATE PROCEDURE DBO.[Attribution_Update]
		@PortfolioId int, 
		@PositionId int, 
		@ReferenceDate datetime, 
		@AttributionFundId int, 
		@TodayAdministratorPricePNL numeric(27,8), 
		@TodayAdministratorFundAdjustedPricePNL numeric(27,8), 
		@TodayAdministratorFXPNL numeric(27,8), 
		@TodayAdministratorFundAdjustedFXPNL numeric(27,8), 
		@TodayAdministratorCarryPNL numeric(27,8), 
		@TodayAdministratorFundAdjustedCarryPNL numeric(27,8), 
		@TodayAdministratorOtherPNL numeric(27,8), 
		@TodayAdministratorFundAdjustedOtherPNL numeric(27,8), 
		@TodayPricePNL numeric(27,8), 
		@TodayFundAdjustedPricePNL numeric(27,8), 
		@TodayFXPNL numeric(27,8), 
		@TodayFundAdjustedFXPNL numeric(27,8), 
		@TodayCarryPNL numeric(27,8), 
		@TodayFundAdjustedCarryPNL numeric(27,8), 
		@TodayOtherPNL numeric(27,8), 
		@TodayFundAdjustedOtherPNL numeric(27,8), 
		@TodayKeeleyPricePNL numeric(27,8), 
		@TodayKeeleyFundAdjustedPricePNL numeric(27,8), 
		@TodayKeeleyFXPNL numeric(27,8), 
		@TodayKeeleyFundAdjustedFXPNL numeric(27,8), 
		@TodayKeeleyCarryPNL numeric(27,8), 
		@TodayKeeleyFundAdjustedCarryPNL numeric(27,8), 
		@TodayFactsetPricePNL numeric(27,8), 
		@TodayFactsetFundAdjustedPricePNL numeric(27,8), 
		@TodayFactsetFXPNL numeric(27,8), 
		@TodayFactsetFundAdjustedFXPNL numeric(27,8), 
		@TodayFactsetCarryPNL numeric(27,8), 
		@TodayFactsetFundAdjustedCarryPNL numeric(27,8), 
		@TodayFactsetOtherPNL numeric(27,8), 
		@TodayFactsetFundAdjustedOtherPNL numeric(27,8), 
		@TodayBookAdjustedPricePNL numeric(27,8), 
		@TodayBookAdjustedFXPNL numeric(27,8), 
		@TodayBookAdjustedCarryPNL numeric(27,8), 
		@ITDAdministratorPricePNL numeric(27,8), 
		@ITDAdministratorFundAdjustedPricePNL numeric(27,8), 
		@ITDAdministratorFXPNL numeric(27,8), 
		@ITDAdministratorFundAdjustedFXPNL numeric(27,8), 
		@ITDAdministratorCarryPNL numeric(27,8), 
		@ITDAdministratorFundAdjustedCarryPNL numeric(27,8), 
		@ITDAdministratorOtherPNL numeric(27,8), 
		@ITDAdministratorFundAdjustedOtherPNL numeric(27,8), 
		@ITDPricePNL numeric(27,8), 
		@ITDFundAdjustedPricePNL numeric(27,8), 
		@ITDFXPNL numeric(27,8), 
		@ITDFundAdjustedFXPNL numeric(27,8), 
		@ITDCarryPNL numeric(27,8), 
		@ITDFundAdjustedCarryPNL numeric(27,8), 
		@ITDOtherPNL numeric(27,8), 
		@ITDFundAdjustedOtherPNL numeric(27,8), 
		@ITDKeeleyPricePNL numeric(27,8), 
		@ITDKeeleyFundAdjustedPricePNL numeric(27,8), 
		@ITDKeeleyFXPNL numeric(27,8), 
		@ITDKeeleyFundAdjustedFXPNL numeric(27,8), 
		@ITDKeeleyCarryPNL numeric(27,8), 
		@ITDKeeleyFundAdjustedCarryPNL numeric(27,8), 
		@ITDFactsetPricePNL numeric(27,8), 
		@ITDFactsetFundAdjustedPricePNL numeric(27,8), 
		@ITDFactsetFXPNL numeric(27,8), 
		@ITDFactsetFundAdjustedFXPNL numeric(27,8), 
		@ITDFactsetCarryPNL numeric(27,8), 
		@ITDFactsetFundAdjustedCarryPNL numeric(27,8), 
		@ITDFactsetOtherPNL numeric(27,8), 
		@ITDFactsetFundAdjustedOtherPNL numeric(27,8), 
		@ITDBookAdjustedPricePNL numeric(27,8), 
		@ITDBookAdjustedFXPNL numeric(27,8), 
		@ITDBookAdjustedCarryPNL numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@AdjustmentFactor numeric(27,8), 
		@AdministratorAdjustmentFactor numeric(27,8), 
		@KeeleyAdjustmentFactor numeric(27,8), 
		@TodayValuationPricePNL numeric(27,8), 
		@TodayValuationFundAdjustedPricePNL numeric(27,8), 
		@TodayValuationFXPNL numeric(27,8), 
		@TodayValuationFundAdjustedFXPNL numeric(27,8), 
		@TodayValuationCarryPNL numeric(27,8), 
		@TodayValuationFundAdjustedCarryPNL numeric(27,8), 
		@ITDValuationPricePNL numeric(27,8), 
		@ITDValuationFundAdjustedPricePNL numeric(27,8), 
		@ITDValuationFXPNL numeric(27,8), 
		@ITDValuationFundAdjustedFXPNL numeric(27,8), 
		@ITDValuationCarryPNL numeric(27,8), 
		@ITDValuationFundAdjustedCarryPNL numeric(27,8), 
		@ValuationAdjustmentFactor numeric(27,8), 
		@PercentageOfFund numeric(27,8), 
		@KeeleyIsMaster bit, 
		@PreviousAttributionId int, 
		@FactsetContribution numeric(27,8), 
		@FactsetIsMaster bit, 
		@AdministratorIsMaster bit, 
		@IsPrimary bit, 
		@NeedsRebuild bit, 
		@ITDOpeningAttributionFundId int, 
		@TodayPerformanceFee numeric(27,8), 
		@TodayFundAdjustedPerformanceFee numeric(27,8), 
		@ITDPerformanceFee numeric(27,8), 
		@ITDFundAdjustedPerformanceFee numeric(27,8), 
		@TodayManagementFee numeric(27,8), 
		@TodayFundAdjustedManagementFee numeric(27,8), 
		@ITDManagementFee numeric(27,8), 
		@ITDFundAdjustedManagementFee numeric(27,8), 
		@TodayUnmatchedInstrumentPNL numeric(27,8), 
		@TodayFundAdjustedUnmatchedInstrumentPNL numeric(27,8), 
		@ITDUnmatchedInstrumentPNL numeric(27,8), 
		@ITDFundAdjustedUnmatchedInstrumentPNL numeric(27,8), 
		@TodayFXPNLGBP numeric(27,8), 
		@TodayFXPNLEUR numeric(27,8), 
		@TodayFXPNLUSD numeric(27,8), 
		@TodayFundAdjustedFXPNLGBP numeric(27,8), 
		@TodayFundAdjustedFXPNLEUR numeric(27,8), 
		@TodayFundAdjustedFXPNLUSD numeric(27,8), 
		@ITDFundAdjustedFXPNLGBP numeric(27,8), 
		@ITDFundAdjustedFXPNLEUR numeric(27,8), 
		@ITDFundAdjustedFXPNLUSD numeric(27,8), 
		@ITDFXPNLGBP numeric(27,8), 
		@ITDFXPNLEUR numeric(27,8), 
		@ITDFXPNLUSD numeric(27,8), 
		@SumExposure numeric(27,0), 
		@SumMarketValue numeric(27,0), 
		@Exposure numeric(27,8), 
		@MarketValue numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Attribution_hst (
			PortfolioId, PositionId, ReferenceDate, AttributionFundId, TodayAdministratorPricePNL, TodayAdministratorFundAdjustedPricePNL, TodayAdministratorFXPNL, TodayAdministratorFundAdjustedFXPNL, TodayAdministratorCarryPNL, TodayAdministratorFundAdjustedCarryPNL, TodayAdministratorOtherPNL, TodayAdministratorFundAdjustedOtherPNL, TodayPricePNL, TodayFundAdjustedPricePNL, TodayFXPNL, TodayFundAdjustedFXPNL, TodayCarryPNL, TodayFundAdjustedCarryPNL, TodayOtherPNL, TodayFundAdjustedOtherPNL, TodayKeeleyPricePNL, TodayKeeleyFundAdjustedPricePNL, TodayKeeleyFXPNL, TodayKeeleyFundAdjustedFXPNL, TodayKeeleyCarryPNL, TodayKeeleyFundAdjustedCarryPNL, TodayFactsetPricePNL, TodayFactsetFundAdjustedPricePNL, TodayFactsetFXPNL, TodayFactsetFundAdjustedFXPNL, TodayFactsetCarryPNL, TodayFactsetFundAdjustedCarryPNL, TodayFactsetOtherPNL, TodayFactsetFundAdjustedOtherPNL, TodayBookAdjustedPricePNL, TodayBookAdjustedFXPNL, TodayBookAdjustedCarryPNL, ITDAdministratorPricePNL, ITDAdministratorFundAdjustedPricePNL, ITDAdministratorFXPNL, ITDAdministratorFundAdjustedFXPNL, ITDAdministratorCarryPNL, ITDAdministratorFundAdjustedCarryPNL, ITDAdministratorOtherPNL, ITDAdministratorFundAdjustedOtherPNL, ITDPricePNL, ITDFundAdjustedPricePNL, ITDFXPNL, ITDFundAdjustedFXPNL, ITDCarryPNL, ITDFundAdjustedCarryPNL, ITDOtherPNL, ITDFundAdjustedOtherPNL, ITDKeeleyPricePNL, ITDKeeleyFundAdjustedPricePNL, ITDKeeleyFXPNL, ITDKeeleyFundAdjustedFXPNL, ITDKeeleyCarryPNL, ITDKeeleyFundAdjustedCarryPNL, ITDFactsetPricePNL, ITDFactsetFundAdjustedPricePNL, ITDFactsetFXPNL, ITDFactsetFundAdjustedFXPNL, ITDFactsetCarryPNL, ITDFactsetFundAdjustedCarryPNL, ITDFactsetOtherPNL, ITDFactsetFundAdjustedOtherPNL, ITDBookAdjustedPricePNL, ITDBookAdjustedFXPNL, ITDBookAdjustedCarryPNL, StartDt, UpdateUserID, DataVersion, AdjustmentFactor, AdministratorAdjustmentFactor, KeeleyAdjustmentFactor, TodayValuationPricePNL, TodayValuationFundAdjustedPricePNL, TodayValuationFXPNL, TodayValuationFundAdjustedFXPNL, TodayValuationCarryPNL, TodayValuationFundAdjustedCarryPNL, ITDValuationPricePNL, ITDValuationFundAdjustedPricePNL, ITDValuationFXPNL, ITDValuationFundAdjustedFXPNL, ITDValuationCarryPNL, ITDValuationFundAdjustedCarryPNL, ValuationAdjustmentFactor, PercentageOfFund, KeeleyIsMaster, PreviousAttributionId, FactsetContribution, FactsetIsMaster, AdministratorIsMaster, IsPrimary, NeedsRebuild, ITDOpeningAttributionFundId, TodayPerformanceFee, TodayFundAdjustedPerformanceFee, ITDPerformanceFee, ITDFundAdjustedPerformanceFee, TodayManagementFee, TodayFundAdjustedManagementFee, ITDManagementFee, ITDFundAdjustedManagementFee, TodayUnmatchedInstrumentPNL, TodayFundAdjustedUnmatchedInstrumentPNL, ITDUnmatchedInstrumentPNL, ITDFundAdjustedUnmatchedInstrumentPNL, TodayFXPNLGBP, TodayFXPNLEUR, TodayFXPNLUSD, TodayFundAdjustedFXPNLGBP, TodayFundAdjustedFXPNLEUR, TodayFundAdjustedFXPNLUSD, ITDFundAdjustedFXPNLGBP, ITDFundAdjustedFXPNLEUR, ITDFundAdjustedFXPNLUSD, ITDFXPNLGBP, ITDFXPNLEUR, ITDFXPNLUSD, SumExposure, SumMarketValue, Exposure, MarketValue, EndDt, LastActionUserID)
	SELECT	PortfolioId, PositionId, ReferenceDate, AttributionFundId, TodayAdministratorPricePNL, TodayAdministratorFundAdjustedPricePNL, TodayAdministratorFXPNL, TodayAdministratorFundAdjustedFXPNL, TodayAdministratorCarryPNL, TodayAdministratorFundAdjustedCarryPNL, TodayAdministratorOtherPNL, TodayAdministratorFundAdjustedOtherPNL, TodayPricePNL, TodayFundAdjustedPricePNL, TodayFXPNL, TodayFundAdjustedFXPNL, TodayCarryPNL, TodayFundAdjustedCarryPNL, TodayOtherPNL, TodayFundAdjustedOtherPNL, TodayKeeleyPricePNL, TodayKeeleyFundAdjustedPricePNL, TodayKeeleyFXPNL, TodayKeeleyFundAdjustedFXPNL, TodayKeeleyCarryPNL, TodayKeeleyFundAdjustedCarryPNL, TodayFactsetPricePNL, TodayFactsetFundAdjustedPricePNL, TodayFactsetFXPNL, TodayFactsetFundAdjustedFXPNL, TodayFactsetCarryPNL, TodayFactsetFundAdjustedCarryPNL, TodayFactsetOtherPNL, TodayFactsetFundAdjustedOtherPNL, TodayBookAdjustedPricePNL, TodayBookAdjustedFXPNL, TodayBookAdjustedCarryPNL, ITDAdministratorPricePNL, ITDAdministratorFundAdjustedPricePNL, ITDAdministratorFXPNL, ITDAdministratorFundAdjustedFXPNL, ITDAdministratorCarryPNL, ITDAdministratorFundAdjustedCarryPNL, ITDAdministratorOtherPNL, ITDAdministratorFundAdjustedOtherPNL, ITDPricePNL, ITDFundAdjustedPricePNL, ITDFXPNL, ITDFundAdjustedFXPNL, ITDCarryPNL, ITDFundAdjustedCarryPNL, ITDOtherPNL, ITDFundAdjustedOtherPNL, ITDKeeleyPricePNL, ITDKeeleyFundAdjustedPricePNL, ITDKeeleyFXPNL, ITDKeeleyFundAdjustedFXPNL, ITDKeeleyCarryPNL, ITDKeeleyFundAdjustedCarryPNL, ITDFactsetPricePNL, ITDFactsetFundAdjustedPricePNL, ITDFactsetFXPNL, ITDFactsetFundAdjustedFXPNL, ITDFactsetCarryPNL, ITDFactsetFundAdjustedCarryPNL, ITDFactsetOtherPNL, ITDFactsetFundAdjustedOtherPNL, ITDBookAdjustedPricePNL, ITDBookAdjustedFXPNL, ITDBookAdjustedCarryPNL, StartDt, UpdateUserID, DataVersion, AdjustmentFactor, AdministratorAdjustmentFactor, KeeleyAdjustmentFactor, TodayValuationPricePNL, TodayValuationFundAdjustedPricePNL, TodayValuationFXPNL, TodayValuationFundAdjustedFXPNL, TodayValuationCarryPNL, TodayValuationFundAdjustedCarryPNL, ITDValuationPricePNL, ITDValuationFundAdjustedPricePNL, ITDValuationFXPNL, ITDValuationFundAdjustedFXPNL, ITDValuationCarryPNL, ITDValuationFundAdjustedCarryPNL, ValuationAdjustmentFactor, PercentageOfFund, KeeleyIsMaster, PreviousAttributionId, FactsetContribution, FactsetIsMaster, AdministratorIsMaster, IsPrimary, NeedsRebuild, ITDOpeningAttributionFundId, TodayPerformanceFee, TodayFundAdjustedPerformanceFee, ITDPerformanceFee, ITDFundAdjustedPerformanceFee, TodayManagementFee, TodayFundAdjustedManagementFee, ITDManagementFee, ITDFundAdjustedManagementFee, TodayUnmatchedInstrumentPNL, TodayFundAdjustedUnmatchedInstrumentPNL, ITDUnmatchedInstrumentPNL, ITDFundAdjustedUnmatchedInstrumentPNL, TodayFXPNLGBP, TodayFXPNLEUR, TodayFXPNLUSD, TodayFundAdjustedFXPNLGBP, TodayFundAdjustedFXPNLEUR, TodayFundAdjustedFXPNLUSD, ITDFundAdjustedFXPNLGBP, ITDFundAdjustedFXPNLEUR, ITDFundAdjustedFXPNLUSD, ITDFXPNLGBP, ITDFXPNLEUR, ITDFXPNLUSD, SumExposure, SumMarketValue, Exposure, MarketValue, @StartDt, @UpdateUserID
	FROM	Attribution
	WHERE	PortfolioId = @PortfolioId

	UPDATE	Attribution
	SET		PositionId = @PositionId, ReferenceDate = @ReferenceDate, AttributionFundId = @AttributionFundId, TodayAdministratorPricePNL = @TodayAdministratorPricePNL, TodayAdministratorFundAdjustedPricePNL = @TodayAdministratorFundAdjustedPricePNL, TodayAdministratorFXPNL = @TodayAdministratorFXPNL, TodayAdministratorFundAdjustedFXPNL = @TodayAdministratorFundAdjustedFXPNL, TodayAdministratorCarryPNL = @TodayAdministratorCarryPNL, TodayAdministratorFundAdjustedCarryPNL = @TodayAdministratorFundAdjustedCarryPNL, TodayAdministratorOtherPNL = @TodayAdministratorOtherPNL, TodayAdministratorFundAdjustedOtherPNL = @TodayAdministratorFundAdjustedOtherPNL, TodayPricePNL = @TodayPricePNL, TodayFundAdjustedPricePNL = @TodayFundAdjustedPricePNL, TodayFXPNL = @TodayFXPNL, TodayFundAdjustedFXPNL = @TodayFundAdjustedFXPNL, TodayCarryPNL = @TodayCarryPNL, TodayFundAdjustedCarryPNL = @TodayFundAdjustedCarryPNL, TodayOtherPNL = @TodayOtherPNL, TodayFundAdjustedOtherPNL = @TodayFundAdjustedOtherPNL, TodayKeeleyPricePNL = @TodayKeeleyPricePNL, TodayKeeleyFundAdjustedPricePNL = @TodayKeeleyFundAdjustedPricePNL, TodayKeeleyFXPNL = @TodayKeeleyFXPNL, TodayKeeleyFundAdjustedFXPNL = @TodayKeeleyFundAdjustedFXPNL, TodayKeeleyCarryPNL = @TodayKeeleyCarryPNL, TodayKeeleyFundAdjustedCarryPNL = @TodayKeeleyFundAdjustedCarryPNL, TodayFactsetPricePNL = @TodayFactsetPricePNL, TodayFactsetFundAdjustedPricePNL = @TodayFactsetFundAdjustedPricePNL, TodayFactsetFXPNL = @TodayFactsetFXPNL, TodayFactsetFundAdjustedFXPNL = @TodayFactsetFundAdjustedFXPNL, TodayFactsetCarryPNL = @TodayFactsetCarryPNL, TodayFactsetFundAdjustedCarryPNL = @TodayFactsetFundAdjustedCarryPNL, TodayFactsetOtherPNL = @TodayFactsetOtherPNL, TodayFactsetFundAdjustedOtherPNL = @TodayFactsetFundAdjustedOtherPNL, TodayBookAdjustedPricePNL = @TodayBookAdjustedPricePNL, TodayBookAdjustedFXPNL = @TodayBookAdjustedFXPNL, TodayBookAdjustedCarryPNL = @TodayBookAdjustedCarryPNL, ITDAdministratorPricePNL = @ITDAdministratorPricePNL, ITDAdministratorFundAdjustedPricePNL = @ITDAdministratorFundAdjustedPricePNL, ITDAdministratorFXPNL = @ITDAdministratorFXPNL, ITDAdministratorFundAdjustedFXPNL = @ITDAdministratorFundAdjustedFXPNL, ITDAdministratorCarryPNL = @ITDAdministratorCarryPNL, ITDAdministratorFundAdjustedCarryPNL = @ITDAdministratorFundAdjustedCarryPNL, ITDAdministratorOtherPNL = @ITDAdministratorOtherPNL, ITDAdministratorFundAdjustedOtherPNL = @ITDAdministratorFundAdjustedOtherPNL, ITDPricePNL = @ITDPricePNL, ITDFundAdjustedPricePNL = @ITDFundAdjustedPricePNL, ITDFXPNL = @ITDFXPNL, ITDFundAdjustedFXPNL = @ITDFundAdjustedFXPNL, ITDCarryPNL = @ITDCarryPNL, ITDFundAdjustedCarryPNL = @ITDFundAdjustedCarryPNL, ITDOtherPNL = @ITDOtherPNL, ITDFundAdjustedOtherPNL = @ITDFundAdjustedOtherPNL, ITDKeeleyPricePNL = @ITDKeeleyPricePNL, ITDKeeleyFundAdjustedPricePNL = @ITDKeeleyFundAdjustedPricePNL, ITDKeeleyFXPNL = @ITDKeeleyFXPNL, ITDKeeleyFundAdjustedFXPNL = @ITDKeeleyFundAdjustedFXPNL, ITDKeeleyCarryPNL = @ITDKeeleyCarryPNL, ITDKeeleyFundAdjustedCarryPNL = @ITDKeeleyFundAdjustedCarryPNL, ITDFactsetPricePNL = @ITDFactsetPricePNL, ITDFactsetFundAdjustedPricePNL = @ITDFactsetFundAdjustedPricePNL, ITDFactsetFXPNL = @ITDFactsetFXPNL, ITDFactsetFundAdjustedFXPNL = @ITDFactsetFundAdjustedFXPNL, ITDFactsetCarryPNL = @ITDFactsetCarryPNL, ITDFactsetFundAdjustedCarryPNL = @ITDFactsetFundAdjustedCarryPNL, ITDFactsetOtherPNL = @ITDFactsetOtherPNL, ITDFactsetFundAdjustedOtherPNL = @ITDFactsetFundAdjustedOtherPNL, ITDBookAdjustedPricePNL = @ITDBookAdjustedPricePNL, ITDBookAdjustedFXPNL = @ITDBookAdjustedFXPNL, ITDBookAdjustedCarryPNL = @ITDBookAdjustedCarryPNL, UpdateUserID = @UpdateUserID, AdjustmentFactor = @AdjustmentFactor, AdministratorAdjustmentFactor = @AdministratorAdjustmentFactor, KeeleyAdjustmentFactor = @KeeleyAdjustmentFactor, TodayValuationPricePNL = @TodayValuationPricePNL, TodayValuationFundAdjustedPricePNL = @TodayValuationFundAdjustedPricePNL, TodayValuationFXPNL = @TodayValuationFXPNL, TodayValuationFundAdjustedFXPNL = @TodayValuationFundAdjustedFXPNL, TodayValuationCarryPNL = @TodayValuationCarryPNL, TodayValuationFundAdjustedCarryPNL = @TodayValuationFundAdjustedCarryPNL, ITDValuationPricePNL = @ITDValuationPricePNL, ITDValuationFundAdjustedPricePNL = @ITDValuationFundAdjustedPricePNL, ITDValuationFXPNL = @ITDValuationFXPNL, ITDValuationFundAdjustedFXPNL = @ITDValuationFundAdjustedFXPNL, ITDValuationCarryPNL = @ITDValuationCarryPNL, ITDValuationFundAdjustedCarryPNL = @ITDValuationFundAdjustedCarryPNL, ValuationAdjustmentFactor = @ValuationAdjustmentFactor, PercentageOfFund = @PercentageOfFund, KeeleyIsMaster = @KeeleyIsMaster, PreviousAttributionId = @PreviousAttributionId, FactsetContribution = @FactsetContribution, FactsetIsMaster = @FactsetIsMaster, AdministratorIsMaster = @AdministratorIsMaster, IsPrimary = @IsPrimary, NeedsRebuild = @NeedsRebuild, ITDOpeningAttributionFundId = @ITDOpeningAttributionFundId, TodayPerformanceFee = @TodayPerformanceFee, TodayFundAdjustedPerformanceFee = @TodayFundAdjustedPerformanceFee, ITDPerformanceFee = @ITDPerformanceFee, ITDFundAdjustedPerformanceFee = @ITDFundAdjustedPerformanceFee, TodayManagementFee = @TodayManagementFee, TodayFundAdjustedManagementFee = @TodayFundAdjustedManagementFee, ITDManagementFee = @ITDManagementFee, ITDFundAdjustedManagementFee = @ITDFundAdjustedManagementFee, TodayUnmatchedInstrumentPNL = @TodayUnmatchedInstrumentPNL, TodayFundAdjustedUnmatchedInstrumentPNL = @TodayFundAdjustedUnmatchedInstrumentPNL, ITDUnmatchedInstrumentPNL = @ITDUnmatchedInstrumentPNL, ITDFundAdjustedUnmatchedInstrumentPNL = @ITDFundAdjustedUnmatchedInstrumentPNL, TodayFXPNLGBP = @TodayFXPNLGBP, TodayFXPNLEUR = @TodayFXPNLEUR, TodayFXPNLUSD = @TodayFXPNLUSD, TodayFundAdjustedFXPNLGBP = @TodayFundAdjustedFXPNLGBP, TodayFundAdjustedFXPNLEUR = @TodayFundAdjustedFXPNLEUR, TodayFundAdjustedFXPNLUSD = @TodayFundAdjustedFXPNLUSD, ITDFundAdjustedFXPNLGBP = @ITDFundAdjustedFXPNLGBP, ITDFundAdjustedFXPNLEUR = @ITDFundAdjustedFXPNLEUR, ITDFundAdjustedFXPNLUSD = @ITDFundAdjustedFXPNLUSD, ITDFXPNLGBP = @ITDFXPNLGBP, ITDFXPNLEUR = @ITDFXPNLEUR, ITDFXPNLUSD = @ITDFXPNLUSD, SumExposure = @SumExposure, SumMarketValue = @SumMarketValue, Exposure = @Exposure, MarketValue = @MarketValue,  StartDt = @StartDt
	WHERE	PortfolioId = @PortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Attribution
	WHERE	PortfolioId = @PortfolioId
	AND		@@ROWCOUNT > 0

GO
