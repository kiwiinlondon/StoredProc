USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AdministratorPortfolio_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AdministratorPortfolio_Update]
GO

CREATE PROCEDURE DBO.[AdministratorPortfolio_Update]
		@AdministratorPortfolioID int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@InstrumentMarketId int, 
		@InstrumentName varchar(100), 
		@IsAccrual bit, 
		@NetPosition numeric(27,8), 
		@MarketValue numeric(27,8), 
		@Price numeric(27,8), 
		@FXRate numeric(27,8), 
		@RealisedPricePNL numeric(27,8), 
		@RealisedFXPNL numeric(27,8), 
		@UnRealisedPricePNL numeric(27,8), 
		@UnRealisedFXPNL numeric(27,8), 
		@CarryPNL numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ManagementPerformanceFee numeric(27,8), 
		@CurrencyId int, 
		@Cost numeric(27,8), 
		@IsShareClassSpecific bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AdministratorPortfolio_hst (
			AdministratorPortfolioID, FundId, ReferenceDate, InstrumentMarketId, InstrumentName, IsAccrual, NetPosition, MarketValue, Price, FXRate, RealisedPricePNL, RealisedFXPNL, UnRealisedPricePNL, UnRealisedFXPNL, CarryPNL, StartDt, UpdateUserID, DataVersion, ManagementPerformanceFee, CurrencyId, Cost, IsShareClassSpecific, EndDt, LastActionUserID)
	SELECT	AdministratorPortfolioID, FundId, ReferenceDate, InstrumentMarketId, InstrumentName, IsAccrual, NetPosition, MarketValue, Price, FXRate, RealisedPricePNL, RealisedFXPNL, UnRealisedPricePNL, UnRealisedFXPNL, CarryPNL, StartDt, UpdateUserID, DataVersion, ManagementPerformanceFee, CurrencyId, Cost, IsShareClassSpecific, @StartDt, @UpdateUserID
	FROM	AdministratorPortfolio
	WHERE	AdministratorPortfolioID = @AdministratorPortfolioID

	UPDATE	AdministratorPortfolio
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, InstrumentMarketId = @InstrumentMarketId, InstrumentName = @InstrumentName, IsAccrual = @IsAccrual, NetPosition = @NetPosition, MarketValue = @MarketValue, Price = @Price, FXRate = @FXRate, RealisedPricePNL = @RealisedPricePNL, RealisedFXPNL = @RealisedFXPNL, UnRealisedPricePNL = @UnRealisedPricePNL, UnRealisedFXPNL = @UnRealisedFXPNL, CarryPNL = @CarryPNL, UpdateUserID = @UpdateUserID, ManagementPerformanceFee = @ManagementPerformanceFee, CurrencyId = @CurrencyId, Cost = @Cost, IsShareClassSpecific = @IsShareClassSpecific,  StartDt = @StartDt
	WHERE	AdministratorPortfolioID = @AdministratorPortfolioID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AdministratorPortfolio
	WHERE	AdministratorPortfolioID = @AdministratorPortfolioID
	AND		@@ROWCOUNT > 0

GO
