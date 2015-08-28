USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AdministratorPortfolio_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AdministratorPortfolio_Delete]
GO

CREATE PROCEDURE DBO.[AdministratorPortfolio_Delete]
		@AdministratorPortfolioID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AdministratorPortfolio_hst (
			AdministratorPortfolioID, FundId, ReferenceDate, InstrumentMarketId, MaturityDate, InstrumentName, IsAccrual, NetPosition, MarketValue, Price, FXRate, RealisedPricePNL, RealisedFXPNL, UnRealisedPricePNL, UnRealisedFXPNL, CarryPNL, StartDt, UpdateUserID, DataVersion, ManagementPerformanceFee, EndDt, LastActionUserID)
	SELECT	AdministratorPortfolioID, FundId, ReferenceDate, InstrumentMarketId, MaturityDate, InstrumentName, IsAccrual, NetPosition, MarketValue, Price, FXRate, RealisedPricePNL, RealisedFXPNL, UnRealisedPricePNL, UnRealisedFXPNL, CarryPNL, StartDt, UpdateUserID, DataVersion, ManagementPerformanceFee, @EndDt, @UpdateUserID
	FROM	AdministratorPortfolio
	WHERE	AdministratorPortfolioID = @AdministratorPortfolioID

	DELETE	AdministratorPortfolio
	WHERE	AdministratorPortfolioID = @AdministratorPortfolioID
	AND		DataVersion = @DataVersion
GO
