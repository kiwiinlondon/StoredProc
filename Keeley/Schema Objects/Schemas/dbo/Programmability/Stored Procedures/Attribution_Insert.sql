USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Attribution_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Attribution_Insert]
GO

CREATE PROCEDURE DBO.[Attribution_Insert]
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
		@PreviousAttributionId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Attribution
			(PortfolioId, PositionId, ReferenceDate, AttributionFundId, TodayAdministratorPricePNL, TodayAdministratorFundAdjustedPricePNL, TodayAdministratorFXPNL, TodayAdministratorFundAdjustedFXPNL, TodayAdministratorCarryPNL, TodayAdministratorFundAdjustedCarryPNL, TodayAdministratorOtherPNL, TodayAdministratorFundAdjustedOtherPNL, TodayPricePNL, TodayFundAdjustedPricePNL, TodayFXPNL, TodayFundAdjustedFXPNL, TodayCarryPNL, TodayFundAdjustedCarryPNL, TodayOtherPNL, TodayFundAdjustedOtherPNL, TodayKeeleyPricePNL, TodayKeeleyFundAdjustedPricePNL, TodayKeeleyFXPNL, TodayKeeleyFundAdjustedFXPNL, TodayKeeleyCarryPNL, TodayKeeleyFundAdjustedCarryPNL, TodayFactsetPricePNL, TodayFactsetFundAdjustedPricePNL, TodayFactsetFXPNL, TodayFactsetFundAdjustedFXPNL, TodayFactsetCarryPNL, TodayFactsetFundAdjustedCarryPNL, TodayFactsetOtherPNL, TodayFactsetFundAdjustedOtherPNL, TodayBookAdjustedPricePNL, TodayBookAdjustedFXPNL, TodayBookAdjustedCarryPNL, ITDAdministratorPricePNL, ITDAdministratorFundAdjustedPricePNL, ITDAdministratorFXPNL, ITDAdministratorFundAdjustedFXPNL, ITDAdministratorCarryPNL, ITDAdministratorFundAdjustedCarryPNL, ITDAdministratorOtherPNL, ITDAdministratorFundAdjustedOtherPNL, ITDPricePNL, ITDFundAdjustedPricePNL, ITDFXPNL, ITDFundAdjustedFXPNL, ITDCarryPNL, ITDFundAdjustedCarryPNL, ITDOtherPNL, ITDFundAdjustedOtherPNL, ITDKeeleyPricePNL, ITDKeeleyFundAdjustedPricePNL, ITDKeeleyFXPNL, ITDKeeleyFundAdjustedFXPNL, ITDKeeleyCarryPNL, ITDKeeleyFundAdjustedCarryPNL, ITDFactsetPricePNL, ITDFactsetFundAdjustedPricePNL, ITDFactsetFXPNL, ITDFactsetFundAdjustedFXPNL, ITDFactsetCarryPNL, ITDFactsetFundAdjustedCarryPNL, ITDFactsetOtherPNL, ITDFactsetFundAdjustedOtherPNL, ITDBookAdjustedPricePNL, ITDBookAdjustedFXPNL, ITDBookAdjustedCarryPNL, UpdateUserID, AdjustmentFactor, AdministratorAdjustmentFactor, KeeleyAdjustmentFactor, TodayValuationPricePNL, TodayValuationFundAdjustedPricePNL, TodayValuationFXPNL, TodayValuationFundAdjustedFXPNL, TodayValuationCarryPNL, TodayValuationFundAdjustedCarryPNL, ITDValuationPricePNL, ITDValuationFundAdjustedPricePNL, ITDValuationFXPNL, ITDValuationFundAdjustedFXPNL, ITDValuationCarryPNL, ITDValuationFundAdjustedCarryPNL, ValuationAdjustmentFactor, PercentageOfFund, KeeleyIsMaster, PreviousAttributionId, StartDt)
	VALUES
			(@PortfolioId, @PositionId, @ReferenceDate, @AttributionFundId, @TodayAdministratorPricePNL, @TodayAdministratorFundAdjustedPricePNL, @TodayAdministratorFXPNL, @TodayAdministratorFundAdjustedFXPNL, @TodayAdministratorCarryPNL, @TodayAdministratorFundAdjustedCarryPNL, @TodayAdministratorOtherPNL, @TodayAdministratorFundAdjustedOtherPNL, @TodayPricePNL, @TodayFundAdjustedPricePNL, @TodayFXPNL, @TodayFundAdjustedFXPNL, @TodayCarryPNL, @TodayFundAdjustedCarryPNL, @TodayOtherPNL, @TodayFundAdjustedOtherPNL, @TodayKeeleyPricePNL, @TodayKeeleyFundAdjustedPricePNL, @TodayKeeleyFXPNL, @TodayKeeleyFundAdjustedFXPNL, @TodayKeeleyCarryPNL, @TodayKeeleyFundAdjustedCarryPNL, @TodayFactsetPricePNL, @TodayFactsetFundAdjustedPricePNL, @TodayFactsetFXPNL, @TodayFactsetFundAdjustedFXPNL, @TodayFactsetCarryPNL, @TodayFactsetFundAdjustedCarryPNL, @TodayFactsetOtherPNL, @TodayFactsetFundAdjustedOtherPNL, @TodayBookAdjustedPricePNL, @TodayBookAdjustedFXPNL, @TodayBookAdjustedCarryPNL, @ITDAdministratorPricePNL, @ITDAdministratorFundAdjustedPricePNL, @ITDAdministratorFXPNL, @ITDAdministratorFundAdjustedFXPNL, @ITDAdministratorCarryPNL, @ITDAdministratorFundAdjustedCarryPNL, @ITDAdministratorOtherPNL, @ITDAdministratorFundAdjustedOtherPNL, @ITDPricePNL, @ITDFundAdjustedPricePNL, @ITDFXPNL, @ITDFundAdjustedFXPNL, @ITDCarryPNL, @ITDFundAdjustedCarryPNL, @ITDOtherPNL, @ITDFundAdjustedOtherPNL, @ITDKeeleyPricePNL, @ITDKeeleyFundAdjustedPricePNL, @ITDKeeleyFXPNL, @ITDKeeleyFundAdjustedFXPNL, @ITDKeeleyCarryPNL, @ITDKeeleyFundAdjustedCarryPNL, @ITDFactsetPricePNL, @ITDFactsetFundAdjustedPricePNL, @ITDFactsetFXPNL, @ITDFactsetFundAdjustedFXPNL, @ITDFactsetCarryPNL, @ITDFactsetFundAdjustedCarryPNL, @ITDFactsetOtherPNL, @ITDFactsetFundAdjustedOtherPNL, @ITDBookAdjustedPricePNL, @ITDBookAdjustedFXPNL, @ITDBookAdjustedCarryPNL, @UpdateUserID, @AdjustmentFactor, @AdministratorAdjustmentFactor, @KeeleyAdjustmentFactor, @TodayValuationPricePNL, @TodayValuationFundAdjustedPricePNL, @TodayValuationFXPNL, @TodayValuationFundAdjustedFXPNL, @TodayValuationCarryPNL, @TodayValuationFundAdjustedCarryPNL, @ITDValuationPricePNL, @ITDValuationFundAdjustedPricePNL, @ITDValuationFXPNL, @ITDValuationFundAdjustedFXPNL, @ITDValuationCarryPNL, @ITDValuationFundAdjustedCarryPNL, @ValuationAdjustmentFactor, @PercentageOfFund, @KeeleyIsMaster, @PreviousAttributionId, @StartDt)

	SELECT	PortfolioId, StartDt, DataVersion
	FROM	Attribution
	WHERE	PortfolioId = @PortfolioId
	AND		@@ROWCOUNT > 0

GO
