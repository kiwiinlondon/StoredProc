USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AdministratorPortfolio_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AdministratorPortfolio_Insert]
GO

CREATE PROCEDURE DBO.[AdministratorPortfolio_Insert]
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
		@ManagementPerformanceFee numeric(27,8), 
		@CurrencyId int, 
		@Cost numeric(27,8), 
		@IsShareClassSpecific bit, 
		@IsFeeder bit, 
		@TotalAmortisationBook numeric(27,8), 
		@TotalAmortisationLocal numeric(27,8), 
		@TodayAmortisationBook numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AdministratorPortfolio
			(FundId, ReferenceDate, InstrumentMarketId, InstrumentName, IsAccrual, NetPosition, MarketValue, Price, FXRate, RealisedPricePNL, RealisedFXPNL, UnRealisedPricePNL, UnRealisedFXPNL, CarryPNL, UpdateUserID, ManagementPerformanceFee, CurrencyId, Cost, IsShareClassSpecific, IsFeeder, TotalAmortisationBook, TotalAmortisationLocal, TodayAmortisationBook, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @InstrumentMarketId, @InstrumentName, @IsAccrual, @NetPosition, @MarketValue, @Price, @FXRate, @RealisedPricePNL, @RealisedFXPNL, @UnRealisedPricePNL, @UnRealisedFXPNL, @CarryPNL, @UpdateUserID, @ManagementPerformanceFee, @CurrencyId, @Cost, @IsShareClassSpecific, @IsFeeder, @TotalAmortisationBook, @TotalAmortisationLocal, @TodayAmortisationBook, @StartDt)

	SELECT	AdministratorPortfolioID, StartDt, DataVersion
	FROM	AdministratorPortfolio
	WHERE	AdministratorPortfolioID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
