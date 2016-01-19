﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Attribution_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Attribution_Delete]
GO

CREATE PROCEDURE DBO.[Attribution_Delete]
		@PortfolioId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Attribution_hst (
			PortfolioId, PositionId, ReferenceDate, AttributionFundId, TodayAdministratorPricePNL, TodayAdministratorFundAdjustedPricePNL, TodayAdministratorFXPNL, TodayAdministratorFundAdjustedFXPNL, TodayAdministratorCarryPNL, TodayAdministratorFundAdjustedCarryPNL, TodayAdministratorOtherPNL, TodayAdministratorFundAdjustedOtherPNL, TodayPricePNL, TodayFundAdjustedPricePNL, TodayFXPNL, TodayFundAdjustedFXPNL, TodayCarryPNL, TodayFundAdjustedCarryPNL, TodayOtherPNL, TodayFundAdjustedOtherPNL, TodayKeeleyPricePNL, TodayKeeleyFundAdjustedPricePNL, TodayKeeleyFXPNL, TodayKeeleyFundAdjustedFXPNL, TodayKeeleyCarryPNL, TodayKeeleyFundAdjustedCarryPNL, TodayFactsetPricePNL, TodayFactsetFundAdjustedPricePNL, TodayFactsetFXPNL, TodayFactsetFundAdjustedFXPNL, TodayFactsetCarryPNL, TodayFactsetFundAdjustedCarryPNL, TodayFactsetOtherPNL, TodayFactsetFundAdjustedOtherPNL, TodayBookAdjustedPricePNL, TodayBookAdjustedFXPNL, TodayBookAdjustedCarryPNL, ITDAdministratorPricePNL, ITDAdministratorFundAdjustedPricePNL, ITDAdministratorFXPNL, ITDAdministratorFundAdjustedFXPNL, ITDAdministratorCarryPNL, ITDAdministratorFundAdjustedCarryPNL, ITDAdministratorOtherPNL, ITDAdministratorFundAdjustedOtherPNL, ITDPricePNL, ITDFundAdjustedPricePNL, ITDFXPNL, ITDFundAdjustedFXPNL, ITDCarryPNL, ITDFundAdjustedCarryPNL, ITDOtherPNL, ITDFundAdjustedOtherPNL, ITDKeeleyPricePNL, ITDKeeleyFundAdjustedPricePNL, ITDKeeleyFXPNL, ITDKeeleyFundAdjustedFXPNL, ITDKeeleyCarryPNL, ITDKeeleyFundAdjustedCarryPNL, ITDFactsetPricePNL, ITDFactsetFundAdjustedPricePNL, ITDFactsetFXPNL, ITDFactsetFundAdjustedFXPNL, ITDFactsetCarryPNL, ITDFactsetFundAdjustedCarryPNL, ITDFactsetOtherPNL, ITDFactsetFundAdjustedOtherPNL, ITDBookAdjustedPricePNL, ITDBookAdjustedFXPNL, ITDBookAdjustedCarryPNL, StartDt, UpdateUserID, DataVersion, AdjustmentFactor, AdministratorAdjustmentFactor, KeeleyAdjustmentFactor, TodayValuationPricePNL, TodayValuationFundAdjustedPricePNL, TodayValuationFXPNL, TodayValuationFundAdjustedFXPNL, TodayValuationCarryPNL, TodayValuationFundAdjustedCarryPNL, ITDValuationPricePNL, ITDValuationFundAdjustedPricePNL, ITDValuationFXPNL, ITDValuationFundAdjustedFXPNL, ITDValuationCarryPNL, ITDValuationFundAdjustedCarryPNL, ValuationAdjustmentFactor, PercentageOfFund, KeeleyIsMaster, EndDt, LastActionUserID)
	SELECT	PortfolioId, PositionId, ReferenceDate, AttributionFundId, TodayAdministratorPricePNL, TodayAdministratorFundAdjustedPricePNL, TodayAdministratorFXPNL, TodayAdministratorFundAdjustedFXPNL, TodayAdministratorCarryPNL, TodayAdministratorFundAdjustedCarryPNL, TodayAdministratorOtherPNL, TodayAdministratorFundAdjustedOtherPNL, TodayPricePNL, TodayFundAdjustedPricePNL, TodayFXPNL, TodayFundAdjustedFXPNL, TodayCarryPNL, TodayFundAdjustedCarryPNL, TodayOtherPNL, TodayFundAdjustedOtherPNL, TodayKeeleyPricePNL, TodayKeeleyFundAdjustedPricePNL, TodayKeeleyFXPNL, TodayKeeleyFundAdjustedFXPNL, TodayKeeleyCarryPNL, TodayKeeleyFundAdjustedCarryPNL, TodayFactsetPricePNL, TodayFactsetFundAdjustedPricePNL, TodayFactsetFXPNL, TodayFactsetFundAdjustedFXPNL, TodayFactsetCarryPNL, TodayFactsetFundAdjustedCarryPNL, TodayFactsetOtherPNL, TodayFactsetFundAdjustedOtherPNL, TodayBookAdjustedPricePNL, TodayBookAdjustedFXPNL, TodayBookAdjustedCarryPNL, ITDAdministratorPricePNL, ITDAdministratorFundAdjustedPricePNL, ITDAdministratorFXPNL, ITDAdministratorFundAdjustedFXPNL, ITDAdministratorCarryPNL, ITDAdministratorFundAdjustedCarryPNL, ITDAdministratorOtherPNL, ITDAdministratorFundAdjustedOtherPNL, ITDPricePNL, ITDFundAdjustedPricePNL, ITDFXPNL, ITDFundAdjustedFXPNL, ITDCarryPNL, ITDFundAdjustedCarryPNL, ITDOtherPNL, ITDFundAdjustedOtherPNL, ITDKeeleyPricePNL, ITDKeeleyFundAdjustedPricePNL, ITDKeeleyFXPNL, ITDKeeleyFundAdjustedFXPNL, ITDKeeleyCarryPNL, ITDKeeleyFundAdjustedCarryPNL, ITDFactsetPricePNL, ITDFactsetFundAdjustedPricePNL, ITDFactsetFXPNL, ITDFactsetFundAdjustedFXPNL, ITDFactsetCarryPNL, ITDFactsetFundAdjustedCarryPNL, ITDFactsetOtherPNL, ITDFactsetFundAdjustedOtherPNL, ITDBookAdjustedPricePNL, ITDBookAdjustedFXPNL, ITDBookAdjustedCarryPNL, StartDt, UpdateUserID, DataVersion, AdjustmentFactor, AdministratorAdjustmentFactor, KeeleyAdjustmentFactor, TodayValuationPricePNL, TodayValuationFundAdjustedPricePNL, TodayValuationFXPNL, TodayValuationFundAdjustedFXPNL, TodayValuationCarryPNL, TodayValuationFundAdjustedCarryPNL, ITDValuationPricePNL, ITDValuationFundAdjustedPricePNL, ITDValuationFXPNL, ITDValuationFundAdjustedFXPNL, ITDValuationCarryPNL, ITDValuationFundAdjustedCarryPNL, ValuationAdjustmentFactor, PercentageOfFund, KeeleyIsMaster, @EndDt, @UpdateUserID
	FROM	Attribution
	WHERE	PortfolioId = @PortfolioId

	DELETE	Attribution
	WHERE	PortfolioId = @PortfolioId
	AND		DataVersion = @DataVersion
GO
